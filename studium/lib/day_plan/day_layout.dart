import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/day_plan/widgets/day_list.dart';

class DayLayout extends StatelessWidget {
  const DayLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget('Auswahl', showSettingsItem: false),
      body: DayList(),
    );
  }
}