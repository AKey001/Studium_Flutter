import 'package:flutter/material.dart';
import 'package:studium/widgets/dashboard/average_card.dart';
import 'package:studium/widgets/dashboard/modules_card.dart';
import 'package:studium/widgets/dashboard/progress_card.dart';
import 'package:studium/widgets/dashboard/result_card.dart';


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











