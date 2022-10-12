
import 'package:fl_chart/fl_chart.dart';

double reverseY(double y, double minX, double maxX) {
  return (maxX + minX) - y - 1;
}

List<FlSpot> reverseSpots(List<FlSpot> inputSpots, double minY, double maxY) {
  return inputSpots.map((spot) {
    return spot.copyWith(y: (maxY + minY) - spot.y);
  }).toList();
}