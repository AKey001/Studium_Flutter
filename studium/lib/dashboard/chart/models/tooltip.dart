
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineTouchData buildTooltip(BuildContext context, List<FlSpot> result, List<FlSpot> average) {
  return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Theme.of(context).colorScheme.secondaryContainer,
        tooltipRoundedRadius: 20.0,
        showOnTopOfTheChartBoxArea: true,
        fitInsideHorizontally: true,
        tooltipMargin: 8,
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map(
                (LineBarSpot touchedSpot) {
              const textStyle = TextStyle();

              List<FlSpot> spots = [];
              touchedSpot.bar.color == Theme.of(context).colorScheme.primary ? spots = result : spots = average;
              return LineTooltipItem(
                spots[touchedSpot.spotIndex].y.toString().substring(0,3),
                Theme.of(context).textTheme.labelSmall ?? textStyle,
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
