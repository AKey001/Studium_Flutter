import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
import 'package:studium/dashboard/chart/bar.dart';
import 'package:studium/dashboard/chart/models/border.dart';
import 'package:studium/dashboard/chart/models/grid.dart';
import 'package:studium/dashboard/chart/models/tooltip.dart';
import 'package:studium/modules/models/models.dart';
import 'package:tuple/tuple.dart';

class AmountCardWidget extends StatelessWidget {
  const AmountCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color1 = Theme.of(context).colorScheme.primary;
    final Color color2 = Theme.of(context).colorScheme.tertiary;

    List<Module> globalModules = context.watch<ModulesListProvider>().modules;

    List<Module> modules = globalModules.toList();
    List<Module> noGrade = modules.where((element) => element.grade == null).toList();
    modules.removeWhere((element) => element.grade == null);

    Tuple2<int, int> noGradeValues = Tuple2(
        noGrade.where((element) => element.weighting != 0).length,
        noGrade.where((element) => element.weighting == 0).length);

    List<Module> m1 = modules.where((module) => module.grade! < 1.5).toList();
    Tuple2<int, int> values1 = Tuple2(
        m1.where((element) => element.weighting != 0).length,
        m1.where((element) => element.weighting == 0).length);

    Iterable<Module> m2 = modules.where((module) => module.grade! >= 1.5 && module.grade! < 2.5);
    Tuple2<int, int> values2 = Tuple2(
        m2.where((element) => element.weighting != 0).length,
        m2.where((element) => element.weighting == 0).length);

    Iterable<Module> m3 = modules.where((module) => module.grade! >= 2.5 && module.grade! < 3.5);
    Tuple2<int, int> values3 = Tuple2(
        m3.where((element) => element.weighting != 0).length,
        m3.where((element) => element.weighting == 0).length);

    Iterable<Module> m4 = modules.where((module) => module.grade! >= 3.5 && module.grade! < 4.5);
    Tuple2<int, int> values4 = Tuple2(
        m4.where((element) => element.weighting != 0).length,
        m4.where((element) => element.weighting == 0).length);

    Iterable<Module> m5 = modules.where((module) => module.grade! >= 4.5);
    Tuple2<int, int> values5 = Tuple2(
        m5.where((element) => element.weighting != 0).length,
        m5.where((element) => element.weighting == 0).length);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Anzahl Noten'),
            subtitle: Row(
              children: [
                Text(
                    'gewichtet',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: color1,
                    )
                ),
                const Text(' | '),
                Text(
                    'ohne',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: color2,
                    )
                ),
              ],
            ),
          ),
          BarChartWidget(
            color: Theme.of(context).colorScheme.primary,
            secondColor: Theme.of(context).colorScheme.tertiary,
            borderColor: Theme.of(context).colorScheme.onSurface,
            data: [values1, values2, values3, values4, values5, noGradeValues],
          )
        ],
      ),
    );
  }
}
