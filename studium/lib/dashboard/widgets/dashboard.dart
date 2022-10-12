import 'package:flutter/material.dart';
import 'package:studium/dashboard/widgets/average_card.dart';
import 'package:studium/dashboard/widgets/modules_card.dart';
import 'package:studium/dashboard/widgets/progress_card.dart';
import 'package:studium/dashboard/widgets/result_card.dart';


class DashboardListWidget extends StatelessWidget {
  const DashboardListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        ResultCardWidget(),
        AverageCardWidget(),
        ModulesCardWidget(),
        ProgressCardWidget()
      ],
    );
  }
}











