import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:studium/mapper/plan_mapper.dart';
import 'package:studium/models/models.dart';
import 'package:studium/widgets/list.dart';
import 'package:week_of_year/week_of_year.dart';

import 'package:studium/widgets/standard_widgets.dart';


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
            return Stack(
              children: <Widget>[
                _buildDefaultWidget(snapshot),
                Material(
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  child: ProgressWidget(),
                )
              ],
            );
          } else {
            return ProgressWidget();
          }
        }
        if (snapshot.hasData) {
          log("data already here");
          return _buildDefaultWidget(snapshot);
        } else if (snapshot.hasError) {
          log('error: ${snapshot.error}');
          return ErrorWidget('${snapshot.error}');
        } else {
          log("In Progress");
          return ProgressWidget();
        }
      },
    );
  }
}

Widget _buildDefaultWidget(AsyncSnapshot<http.Response> snapshot) {
  String? html = snapshot.data!.body;
  PlanModel plan = mapRawHtml(html);
  List<Entry> entries = mapToEntries(plan);
  return buildEntryListWidget(entries);
}
