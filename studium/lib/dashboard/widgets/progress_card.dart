import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:studium/dashboard/chart/methods/reverse_mapper.dart';
import 'package:studium/dashboard/chart/models/axis_titles.dart';
import 'package:studium/dashboard/chart/models/border.dart';
import 'package:studium/dashboard/chart/models/grid.dart';
import 'package:studium/dashboard/chart/models/lines.dart';
import 'package:studium/dashboard/chart/models/tooltip.dart';


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
              ListTile(
                title: const Text('Verlauf'),
                subtitle: Row(
                 children: [
                   Text(
                     'Durschnitt',
                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
                       color: Theme.of(context).colorScheme.secondary
                     )
                   ),
                   const Text(' | '),
                   Text(
                     'Urteil',
                       style: Theme.of(context).textTheme.titleSmall?.copyWith(
                           color: Theme.of(context).colorScheme.primary
                       )
                   ),
                 ],
                ),
              ),
              Chart(
                average: const [
                  FlSpot(1, 3.2),
                  FlSpot(2, 3.1),
                  FlSpot(3, 2.4),
                  FlSpot(4, 3.0),
                  FlSpot(5, 2),
                  FlSpot(6, 1.8),
                ],
                result: const [
                  FlSpot(1, 1.2),
                  FlSpot(2, 1.0),
                  FlSpot(3, 1.8),
                  FlSpot(4, 2.0),
                  FlSpot(5, 2.0),
                  FlSpot(6, 3.89),
                ],
              ),
          ]
        ),
      ),
    );
  }
}



class Chart extends StatelessWidget {
  final List<FlSpot> result;
  final List<FlSpot> average;
  double _minX = 1;
  double _maxX = 6;
  final double _minY = 1;
  final double _maxY = 5;

  Chart({super.key, required this.result, required this.average}) {
    _minX = 1;
    _maxX = 6;
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25, bottom: 20, top: 12),
      child: AspectRatio(
        aspectRatio: 12/9,
        child: LineChart(
          LineChartData(
            minY: _minY,
            maxY: _maxY,
            lineTouchData: buildTooltip(context, result, average),
            lineBarsData: buildLines(context, reverseSpots(average, _minY, _maxY), reverseSpots(result, _minY, _maxY)),
            titlesData: buildTitles(_minX, _maxX, _minY, _maxY),
            gridData: buildGrid(_minY, _maxY),
            borderData: buildBorder(context),
          ),
        ),
      ),
    );
  }




}