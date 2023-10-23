import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:studium/dashboard/widgets/amount_card.dart';
import 'package:studium/dashboard/widgets/average_card.dart';
import 'package:studium/dashboard/widgets/modules_card.dart';
import 'package:studium/dashboard/widgets/progress_card.dart';
import 'package:studium/dashboard/widgets/result_card.dart';

class DashboardListWidget extends StatelessWidget {
  const DashboardListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResponsiveBreakpointsData responsiveData = ResponsiveBreakpoints.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 12, top: 8),
        children: <Widget>[
          ResponsiveRowColumn(
            layout: responsiveData.isMobile ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
            children: const [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: ResultCardWidget(),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: AverageCardWidget(),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const ModulesCardWidget(),
          const SizedBox(height: 4),
          const ProgressCardWidget(),
          const SizedBox(height: 4),
          const AmountCardWidget(),
        ],
      ),
    );
  }
}











