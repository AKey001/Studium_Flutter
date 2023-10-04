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

class DayList extends StatelessWidget {
  final DateTime dateTime;

  const DayList({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String matrikel = context.watch<SharedPrefsProvider>().matrikel;

    return FutureBuilder<http.Response>(
      future: fetchActivities(dateTime, dateTime, matrikel),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          if (snapshot.hasData) {
            String json = utf8.decode(snapshot.data!.bodyBytes);
            final ActivityCollection activities = ActivityCollection.fromJson(jsonDecode(json));
            List<Entry> entries = mapToEntries(activities, date: dateTime);

            return Stack(
              children: <Widget>[
                EntryListWidget(entries),
                const DisabledBackground(),
              ],
            );
          } else {
            return const ProgressWidget();
          }
        }
        if (snapshot.hasData) {
          String json = utf8.decode(snapshot.data!.bodyBytes);
          final ActivityCollection activities = ActivityCollection.fromJson(jsonDecode(json));
          List<Entry> entries = mapToEntries(activities, date: dateTime);

          return EntryListWidget(entries);
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
