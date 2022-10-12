import 'package:fl_chart/fl_chart.dart';
import 'package:studium/dashboard/chart/methods/reverse_mapper.dart';

FlGridData buildGrid(double minY, double maxY) {
  return FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      checkToShowHorizontalLine: (value) {
        final intValue = reverseY(value, minY, maxY).toInt();

        if (intValue == (maxY + minY).toInt()) {
          return false;
        }

        return true;
      }
  );
}