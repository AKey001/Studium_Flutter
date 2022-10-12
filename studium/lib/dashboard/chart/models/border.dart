import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

FlBorderData buildBorder(BuildContext context) {
  return FlBorderData(
    show: true,
    border: Border(
      left: BorderSide(color: Theme.of(context).colorScheme.onSurface),
      top: const BorderSide(color: Colors.transparent),
      bottom: BorderSide(color: Theme.of(context).colorScheme.onSurface),
      right: const BorderSide(color: Colors.transparent),
    ),
  );
}