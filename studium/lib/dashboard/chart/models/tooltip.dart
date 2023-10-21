import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineTouchData buildLineTooltip(BuildContext context, List<FlSpot> result, List<FlSpot> average, Color color1, Color color2) {
  return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Theme.of(context).colorScheme.secondaryContainer,
        tooltipRoundedRadius: 20.0,
        showOnTopOfTheChartBoxArea: true,
        fitInsideHorizontally: true,
        tooltipMargin: 8,
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((LineBarSpot touchedSpot) {
            String tooltip;
            touchedSpot.bar.color == color2? tooltip = result[touchedSpot.spotIndex].y.toStringAsFixed(1) : tooltip = average[touchedSpot.spotIndex].y.toStringAsFixed(2);
            return LineTooltipItem(
              tooltip,
              Theme.of(context).textTheme.labelSmall ?? const TextStyle(),
            );
          },
          ).toList();
        },
      ),
      getTouchedSpotIndicator: _getTouchSpotIndicator,
      getTouchLineEnd: (_, __) => double.infinity
  );
}

List<TouchedSpotIndicatorData> _getTouchSpotIndicator(LineChartBarData barData, List<int> indicators) {
  return indicators.map(
        (int index) {
      final line = FlLine(
          color: Colors.grey,
          strokeWidth: 1,
          dashArray: [3, 5]);
      return TouchedSpotIndicatorData(
        line,
        FlDotData(show: false),
      );
    },
  ).toList();
}

BarTouchData buildBarTooltip(BuildContext context, Color color) {
  return BarTouchData(
    enabled: true,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      fitInsideHorizontally: true,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 0,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
            Theme.of(context).textTheme.labelSmall ?? const TextStyle(),
        );
      },
    ),
  );
}

