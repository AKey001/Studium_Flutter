import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';

class ModulesCardWidget extends StatelessWidget {
  const ModulesCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: DataTableWidget(),
    );
  }
}

class DataTableWidget extends StatelessWidget {
  const DataTableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int all = context.watch<ModulesListProvider>().modulesCount;
    int graded = context.watch<ModulesListProvider>().modulesGraded;
    int weighted = context.watch<ModulesListProvider>().modulesWeighted;

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
