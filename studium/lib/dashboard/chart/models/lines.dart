
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<LineChartBarData> buildLines(BuildContext context, List<FlSpot> reversedAverage, List<FlSpot> reversedResult, Color color1, Color color2) {
  return <LineChartBarData>[
    LineChartBarData(
      color: color1,
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
      color: color2,
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


