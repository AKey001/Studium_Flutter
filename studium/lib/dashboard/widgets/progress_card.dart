import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
import 'package:studium/dashboard/chart/methods/reverse_mapper.dart';
import 'package:studium/dashboard/chart/models/axis_titles.dart';
import 'package:studium/dashboard/chart/models/border.dart';
import 'package:studium/dashboard/chart/models/grid.dart';
import 'package:studium/dashboard/chart/models/lines.dart';
import 'package:studium/dashboard/chart/models/tooltip.dart';
import 'package:studium/dashboard/mapper/result_calculator.dart';
import 'package:studium/modules/models/models.dart';
import 'package:studium/theme/custom_color.g.dart';

class ProgressCardWidget extends StatelessWidget {
  const ProgressCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color1 = Theme.of(context).extension<CustomColors>()!.chartbrown ?? Colors.brown;
    final Color color2 = Theme.of(context).colorScheme.primary;

    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: const Text('Verlauf'),
              subtitle: Row(
               children: [
                 Text(
                   'Urteil',
                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
                         color: color2,
                     )
                 ),
                 const Text(' | '),
                 Text(
                     'Durschnitt',
                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
                       color: color1,
                     )
                 ),
               ],
              ),
            ),
            Chart(color1, color2),
        ],
      ),
    );
  }
}

class Chart extends StatelessWidget {
  final Color color1;
  final Color color2;

  const Chart(this.color1, this.color2, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Module> modules = context.watch<ModulesListProvider>().modules;
    Map<int, List<Module>> grouped = groupBy(modules, (module) => module.semester);

    List<FlSpot> average = [];
    List<FlSpot> result = [];
    for (int i in grouped.keys) {
      average.add(FlSpot(i.toDouble(), double.parse(calculateAverageString(grouped[i] ?? []))));
      result.add(FlSpot(i.toDouble(), double.parse(calculateResult(grouped[i] ?? []).substring(0, 3))));
    }

    return ChartWidget(
      average: average,
      color1: color1,
      result: result,
      color2: color2,
    );
  }
}

class ChartWidget extends StatelessWidget {
  final List<FlSpot> result;
  final List<FlSpot> average;
  double _minX = 1;
  double _maxX = 6;
  final double _minY = 1;
  final double _maxY = 5;
  final Color color1;
  final Color color2;

  ChartWidget({super.key, required this.result, required this.average, required this.color1, required this.color2}) {
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
            lineTouchData: buildTooltip(context, result, average, color1, color2),
            lineBarsData: buildLines(context, reverseSpots(average, _minY, _maxY), reverseSpots(result, _minY, _maxY), color1, color2),
            titlesData: buildTitles(_minX, _maxX, _minY, _maxY),
            gridData: buildGrid(_minY, _maxY),
            borderData: buildBorder(context),
          ),
        ),
      ),
    );
  }
}