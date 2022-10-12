import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:studium/dashboard/chart/methods/reverse_mapper.dart';


Widget leftTitleWidgets(double value, TitleMeta meta, double minX, double maxX, double minY, double maxY) {
  final intValue = reverseY(value, minX, maxX).toInt();

  if (intValue == (maxY + minY)) {
    log('$intValue == ${maxY + minY}');
    return const Text('');
  }

  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: Text(
      intValue.toString(),
      textAlign: TextAlign.center,
    ),
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  if (value % 1 == 0) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(value.toInt().toString()),
    );
  } else {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: const Text(''),
    );
  }
}
