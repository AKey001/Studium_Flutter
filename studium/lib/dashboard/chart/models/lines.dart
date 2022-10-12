
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<LineChartBarData> buildLines(BuildContext context, List<FlSpot> reversedAverage, List<FlSpot> reversedResult) {
  return <LineChartBarData>[
    LineChartBarData(
      color: Theme.of(context).colorScheme.secondary,
      spots: reversedAverage,
      isCurved: false,
      isStrokeCapRound: true,
      barWidth: 3,
      belowBarData: BarAreaData(
        show: false,
      ),
      dotData: FlDotData(
        show: true,
      ),
    ),
    LineChartBarData(
      color: Theme.of(context).colorScheme.primary,
      spots: reversedResult,
      isCurved: false,
      isStrokeCapRound: true,
      barWidth: 3,
      belowBarData: BarAreaData(
        show: false,
      ),
      dotData: FlDotData(
        show: true,
      ),
    )
  ];
}


