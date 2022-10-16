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

class EntryList extends StatelessWidget {
  const EntryList({Key? key, this.initialWeek}) : super(key: key);

  final int? initialWeek;

  @override
  Widget build(BuildContext context) {
    String matrikel = context.watch<SharedPrefsProvider>().matrikel;
    int week = DateTime.now().weekOfYear;

    if (initialWeek != null) {
      week = initialWeek ?? 40;
    }

    return FutureBuilder<http.Response>(
      future: fetchData(week, matrikel),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          if (snapshot.hasData) {
            String? html = snapshot.data!.body;

            return Stack(
              children: <Widget>[
                EntryListRefreshIndicatorIntegrated(initialHtml: html, matrikel: matrikel),
                buildDisabledBackground(),
              ],
            );
          } else {
            return const ProgressWidget();
          }
        }
        if (snapshot.hasData) {
          String? html = snapshot.data!.body;
          return EntryListRefreshIndicatorIntegrated(initialHtml: html, matrikel: matrikel);
        } else if (snapshot.hasError) {
          log('error: ${snapshot.error}');
          return CustomErrorWidget(error: '${snapshot.error}');
        } else {
          return const ProgressWidget();
        }
      },
    );
  }

  Material buildDisabledBackground() {
    return const Material(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      child: ProgressWidget(),
    );
  }
}

// ==================================================

class EntryListRefreshIndicatorIntegrated extends StatefulWidget {
  final String? initialHtml;
  final int? week;
  final String? matrikel;

  const EntryListRefreshIndicatorIntegrated({super.key, this.initialHtml = '', this.week, required this.matrikel});

  @override
  State<EntryListRefreshIndicatorIntegrated> createState() => _EntryListRefreshIndicatorIntegratedState();
}

class _EntryListRefreshIndicatorIntegratedState extends State<EntryListRefreshIndicatorIntegrated> {
  int _week = DateTime.now().weekOfYear;
  String _html = '';
  String _matrikel = '';

  @override
  void initState() {
    _html = widget.initialHtml ?? '';
    _week = widget.week ?? DateTime.now().weekOfYear;
    _matrikel = widget.matrikel ?? 'IIBb20';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PlanModel plan = mapRawHtml(_html);
    bool displayTypeWeek = context.watch<SharedPrefsProvider>().displayTypeWeek;
    List<Entry> entries = mapToEntries(plan, displayTypeWeek);

    return RefreshIndicator(
      child: EntryListWidget(entries),
      onRefresh: () async {
        http.Response response = await fetchData(_week, _matrikel);
        setState(() {
          _html = response.body;
        });
      },
    );
  }
}