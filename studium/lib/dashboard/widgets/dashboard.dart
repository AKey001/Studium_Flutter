import 'package:flutter/material.dart';
import 'package:studium/dashboard/widgets/average_card.dart';
import 'package:studium/dashboard/widgets/modules_card.dart';
import 'package:studium/dashboard/widgets/progress_card.dart';
import 'package:studium/dashboard/widgets/result_card.dart';


class DashboardListWidget extends StatelessWidget {
  const DashboardListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 12, top: 8),
        children: const <Widget>[
          ResultCardWidget(),
          SizedBox(height: 4),
          AverageCardWidget(),
          SizedBox(height: 4),
          ModulesCardWidget(),
          SizedBox(height: 4),
          ProgressCardWidget(),
        ],
      ),
    );
  }
}











