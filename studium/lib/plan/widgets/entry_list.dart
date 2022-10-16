import 'dart:developer';

import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:studium/commons/network/data_fetcher.dart';
import 'package:studium/commons/providers/prefs_provider.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/plan/mapper/plan_mapper.dart';
import 'package:studium/plan/models/models.dart';
import 'package:studium/plan/widgets/entry_list_layout.dart';
import 'package:week_of_year/date_week_extensions.dart';

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
    String matrikel = context.watch<SharedPrefsProvider>().matrikel;

    return FutureBuilder<http.Response>(
      future: fetchData(_week, matrikel),
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
          return Center(
            child: Container(padding: EdgeInsets.all(24),
              child: Text(
                'Fehler: ${snapshot.error}',
                style: TextStyle(
                  color:  Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          );
        } else {
          log("In Progress");
          return const ProgressWidget();
        }
      },
    );
  }
}


// Zwischenschritt für RefreshIndicator

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
    String matrikel = context.watch<SharedPrefsProvider>().matrikel;

    return RefreshIndicator(
      child: EntryListWidget(entries),
      onRefresh: () async {
        http.Response response = await fetchData(_week, matrikel);
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