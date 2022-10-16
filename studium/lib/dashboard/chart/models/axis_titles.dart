import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:studium/dashboard/chart/widgetes/titles.dart';

FlTitlesData buildTitles(double minX, double maxX, double minY, double maxY) {
  return FlTitlesData(
    leftTitles: AxisTitles(
      axisNameSize: 25,
      axisNameWidget: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: Text('Note'),
      ),
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (double value, TitleMeta meta) {
          return leftTitleWidgets(value, meta, minX, maxX, minY, maxY);
        },
        reservedSize: 38,
      ),
    ),
    topTitles: hideAxisTitle(),
    rightTitles: hideAxisTitle(),
    bottomTitles: AxisTitles(
      axisNameSize: 25,
      axisNameWidget: const Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text('Semester'),
      ),
      sideTitles: SideTitles(showTitles: true,
          reservedSize: 25,
          getTitlesWidget: bottomTitleWidgets),
    ),
  );
}

AxisTitles hideAxisTitle() {
  return AxisTitles(
      sideTitles: SideTitles(showTitles: false)
  );
}


