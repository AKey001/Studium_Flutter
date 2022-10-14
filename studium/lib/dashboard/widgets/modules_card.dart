import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:studium/commons/db/database.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/modules/models/models.dart';

class ModulesCardWidget extends StatelessWidget {
  const ModulesCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder<List<Module>>(
            future: AppDatabase.loadAllModules(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Module> modules = snapshot.data ?? [];
                int all = modules.length;
                int graded = modules.where((e) => e.grade != null).length;
                int weighted = modules.where((e) => e.weighting > 0).length;

                return DataTable(
                  columns: <DataColumn>[
                    _buildDataColumn('Module', context),
                    _buildDataColumn('Anzahl', context),
                  ],
                  rows: <DataRow>[
                    _buildDataCell("Gesamt", all.toString()),
                    _buildDataCell("Benotet", graded.toString()),
                    _buildDataCell("Gewichtet", weighted.toString()),
                  ],
                );
              } else if (snapshot.hasError) {
              return ErrorWidget(error: '${snapshot.error}');
              } else {
              return DataTable(
                columns: <DataColumn>[
                  _buildDataColumn('Module', context),
                  _buildDataColumn('Anzahl', context),
                ],
                rows: <DataRow>[
                  _buildDataCell("Gesamt", '0'),
                  _buildDataCell("Benotet", '0'),
                  _buildDataCell("Gewichtet", '0'),
                ],
              );;
              }
            },
          )
        ],
      ),
    );
  }
  DataRow _buildDataCell(String identifier, String content) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(identifier)),
        DataCell(Text(content)),
      ],
    );
  }

  DataColumn _buildDataColumn(String title, BuildContext context) {
    return DataColumn(
      label: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}


