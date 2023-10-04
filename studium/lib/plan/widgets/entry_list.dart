import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:studium/commons/network/data_fetcher.dart';
import 'package:studium/commons/providers/prefs_provider.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/modules/entities/models.dart';
import 'package:studium/plan/mapper/plan_mapper.dart';
import 'package:studium/plan/models/models.dart';
import 'package:studium/plan/widgets/entry_list_layout.dart';

class EntryList extends StatelessWidget {
  const EntryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String matrikel = context.watch<SharedPrefsProvider>().matrikel;
    bool displayTypeWeek = context.watch<SharedPrefsProvider>().displayTypeWeek;

    return FutureBuilder<http.Response>(
      future: fetchActivities(DateTime.now(), DateTime.now().add(Duration(days: displayTypeWeek ? 6 : 1)), matrikel),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          if (snapshot.hasData) {
            // String? html = snapshot.data!.body;
            String json = utf8.decode(snapshot.data!.bodyBytes);
            final ActivityCollection activities = ActivityCollection.fromJson(jsonDecode(json));

            return Stack(
              children: <Widget>[
                EntryListRefreshIndicatorIntegrated(initialActivities: activities, matrikel: matrikel),
                const DisabledBackground(),
              ],
            );
          } else {
            return const ProgressWidget();
          }
        }
        if (snapshot.hasData) {
          // String? html = snapshot.data!.body;
          String json = utf8.decode(snapshot.data!.bodyBytes);
          final ActivityCollection activities = ActivityCollection.fromJson(jsonDecode(json));
          return EntryListRefreshIndicatorIntegrated(initialActivities: activities, matrikel: matrikel);
        } else if (snapshot.hasError) {
          log('error: ${snapshot.error}');
          return CustomErrorWidget(error: '${snapshot.error}');
        } else {
          return const ProgressWidget();
        }
      },
    );
  }
}

// ==================================================

class EntryListRefreshIndicatorIntegrated extends StatefulWidget {
  // final String? initialHtml;
  final ActivityCollection initialActivities;
  final int? week;
  final String? matrikel;

  const EntryListRefreshIndicatorIntegrated({super.key, required this.initialActivities, this.week, required this.matrikel});

  @override
  State<EntryListRefreshIndicatorIntegrated> createState() => _EntryListRefreshIndicatorIntegratedState();
}

class _EntryListRefreshIndicatorIntegratedState extends State<EntryListRefreshIndicatorIntegrated> {
  // int _week = DateTime.now().weekOfYear;
  // String _html = '';
  // String _json = '';
  ActivityCollection _activities = ActivityCollection(days: List.empty());
  String _matrikel = '';

  @override
  void initState() {
    // _html = widget.initialHtml ?? '';
    // _week = widget.week ?? DateTime.now().weekOfYear;
    _activities = widget.initialActivities;
    _matrikel = widget.matrikel ?? 'IIm23';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool displayTypeWeek = context.watch<SharedPrefsProvider>().displayTypeWeek;
    // List<Entry> entries = mapToEntries(plan, null, displayTypeWeek ? DisplayType.week : DisplayType.two_days);
    List<Entry> entries = mapToEntries(_activities, date: DateTime.now());

    return RefreshIndicator(
      child: EntryListWidget(entries),
      onRefresh: () async {
        http.Response response = await fetchActivities(DateTime.now(), DateTime.now().add(Duration(days: displayTypeWeek ? 6 : 1)), _matrikel);
        setState(() {
          String json = utf8.decode(response.bodyBytes);
          _activities = ActivityCollection.fromJson(jsonDecode(json));
        });
      },
    );
  }
}