import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressCardWidget extends StatelessWidget {
  const ProgressCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const ListTile(
                title: Text('Verlauf'),
                subtitle: Text('Durschnitt und Urteil'),
              ),
              Chart(),
          ]
        ),
      ),
    );
  }
}





class Chart extends StatelessWidget {
  Chart({super.key}) {
    minSpotX = 1;
    maxSpotX = 5;
    minSpotY = 1;
    maxSpotY = 5;
  }

  final spots = const [
    FlSpot(1, 3.2),
    FlSpot(2, 3.1),
    FlSpot(3, 2.4),
    FlSpot(4, 3.0),
    FlSpot(5, 2),
    FlSpot(6, 1.8),
  ];

  final spots2 = const [
    FlSpot(1, 1.2),
    FlSpot(2, 1.0),
    FlSpot(3, 1.8),
    FlSpot(4, 2.0),
    FlSpot(5, 2.0),
    FlSpot(6, 3.2),
  ];

  late double minSpotX;
  late double maxSpotX;
  late double minSpotY;
  late double maxSpotY;

  Widget leftTitleWidgets(double value, TitleMeta meta) {

    final intValue = reverseY(value, 1, 5).toInt();

    if (intValue == (maxSpotY + minSpotY) || intValue == 0) {
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

  Widget topTitleWidgets(double value, TitleMeta meta) {
    if (value % 1 == 0) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(value.toInt().toString()),
      );
    } else {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(''),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25, bottom: 20, top: 12),
      child: AspectRatio(
        aspectRatio: 12/9,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Theme.of(context).colorScheme.secondaryContainer,
                  tooltipRoundedRadius: 20.0,
                  showOnTopOfTheChartBoxArea: true,
                  fitInsideHorizontally: true,
                  tooltipMargin: 0,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map(
                          (LineBarSpot touchedSpot) {
                        const textStyle = TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        );
                        return LineTooltipItem(
                          spots[touchedSpot.spotIndex].y.toStringAsFixed(2),
                          Theme.of(context).textTheme.labelSmall ?? textStyle,
                        );
                      },
                    ).toList();
                  },
                ),
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> indicators) {
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
                },
                getTouchLineEnd: (_, __) => double.infinity
            ),
            lineBarsData: [
              LineChartBarData(
                color: Theme.of(context).colorScheme.secondaryContainer,
                spots: reverseSpots(spots, minSpotY, maxSpotY),
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
                color: Theme.of(context).colorScheme.tertiaryContainer,
                spots: reverseSpots(spots2, minSpotY, maxSpotY),
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
            ],
            minY: 1,
            maxY: 6,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                axisNameSize: 25,
                axisNameWidget: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('Note'),
                ),
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: leftTitleWidgets,
                  reservedSize: 38,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              bottomTitles: AxisTitles(
                axisNameSize: 25,
                axisNameWidget: const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('Semester'),
                ),
                sideTitles: SideTitles(showTitles: true,
                reservedSize: 25,
                getTitlesWidget: topTitleWidgets),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1,
              verticalInterval: 1,
              checkToShowHorizontalLine: (value) {
                final intValue =
                reverseY(value, minSpotY, maxSpotY).toInt();

                if (intValue == (maxSpotY + minSpotY).toInt()) {
                  return false;
                }

                return true;
              },
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                left: BorderSide(color: Theme.of(context).colorScheme.onSurface),
                top: const BorderSide(color: Colors.transparent),
                bottom: BorderSide(color: Theme.of(context).colorScheme.onSurface),
                right: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double reverseY(double y, double minX, double maxX) {
    return (maxX + minX) - y;
  }

  List<FlSpot> reverseSpots(List<FlSpot> inputSpots, double minY, double maxY) {
    return inputSpots.map((spot) {
      return spot.copyWith(y: (maxY + minY) - spot.y);
    }).toList();
  }
}