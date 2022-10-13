import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/plan/mapper/plan_mapper.dart';
import 'package:studium/plan/models/models.dart';
import 'package:studium/plan/widgets/entry_list.dart';
import 'package:week_of_year/week_of_year.dart';


Future<http.Response> fetchData(int week) async {

  Uri uri = Uri.https(
      "service.hszg.de", "/stundenplan/index.php",
      {
        'fsel': '1',
        'sel': 'Stundenplan',
        'id': '',
        'kalview': '',
        'booking': '',
        'ActiveCollege': 'Wintersemester 2022/23',
        'SemWeek': '$week',
        'ViewType': '0',
        'StudentSets': 'IIBb20',
      });
  log('start fetching for week $week...');
  log(uri.toString());

  final response = await http.get(uri);
  return response;
}

class EntryList extends StatefulWidget {
  const EntryList({Key? key}) : super(key: key);

  @override
  State<EntryList> createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  int _week = DateTime.now().weekOfYear;

  setWeek(int week) {
    _week = week;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: fetchData(_week),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          if (snapshot.hasData) {
            String? html = snapshot.data!.body;
            List<Entry> entries = htmlToList(html);

            return Stack(
              children: <Widget>[
                EntryListRefreshIndicatorIntegrated(initialEntries: entries),
                const Material(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  child: ProgressWidget(),
                )
              ],
            );
          } else {
            return const ProgressWidget();
          }
        }
        if (snapshot.hasData) {
          log("data already here");
          String? html = snapshot.data!.body;
          List<Entry> entries = htmlToList(html);

          return EntryListRefreshIndicatorIntegrated(initialEntries: entries);
        } else if (snapshot.hasError) {
          log('error: ${snapshot.error}');
          return ErrorWidget('${snapshot.error}');
        } else {
          log("In Progress");
          return const ProgressWidget();
        }
      },
    );
  }
}

// ==========

class EntryListRefreshIndicatorIntegrated extends StatefulWidget {
  final List<Entry>? initialEntries;

  const EntryListRefreshIndicatorIntegrated({super.key, this.initialEntries = const []});

  @override
  State<EntryListRefreshIndicatorIntegrated> createState() => _EntryListRefreshIndicatorIntegratedState();
}

class _EntryListRefreshIndicatorIntegratedState extends State<EntryListRefreshIndicatorIntegrated> {
  final int _week = DateTime.now().weekOfYear;
  List<Entry> entries = [];

  @override
  void initState() {
    entries = widget.initialEntries ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: EntryListWidget(entries),
      onRefresh: () async {
        http.Response response = await fetchData(_week);
        setState(() {
          String html = response.body;
          entries = htmlToList(html);
        });
      },
    );
  }



}


List<Entry> htmlToList(String html) {
  PlanModel plan = mapRawHtml(html);
  List<Entry> entries = mapToEntries(plan);
  return entries;
}