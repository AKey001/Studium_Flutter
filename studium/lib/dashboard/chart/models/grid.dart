import 'package:fl_chart/fl_chart.dart';

FlGridData buildGrid(double minY, double maxY) {
  return FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      // checkToShowHorizontalLine: (value) {
      //   final intValue = reverseY(value, minY, maxY).toInt();
      //   if (intValue == (maxY + minY).toInt()) {
      //     return false;
      //   }
      //   return true;
      // }
  );
}