import 'package:flutter/material.dart';

class ModulesCardWidget extends StatelessWidget {
  const ModulesCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataTable(
              columns: <DataColumn>[
                _buildDataColumn('Module', context),
                _buildDataColumn('Anzahl', context),
              ],
              rows: <DataRow>[
                _buildDataCell("Gesamt", "40"),
                _buildDataCell("Benotet", "28"),
                _buildDataCell("Gewichtet", "26"),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
