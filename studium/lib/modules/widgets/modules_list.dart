import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
import 'package:studium/modules/models/models.dart';
import 'package:studium/modules/widgets/update_module_dialog.dart';

class ModulesList extends StatelessWidget {
  const ModulesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Module> modules = context.watch<ModulesListProvider>().modules;

    if (modules.isEmpty) {
      return const Center(
        child: Text(
            'Keine Module gespeichert'
        ),
      );
    } else {
      final ResponsiveWrapperData responsiveData = ResponsiveWrapper.of(context);

      List entries =  processModules(modules);
      if (responsiveData.isSmallerThan(TABLET)) {
        return ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            if (entries[index] is Module) {
              Module module = entries[index];
              String grade = '';
              module.grade == null ? grade = '-.-' : grade = module.grade.toString();

              return ListTile(
                title: Text(
                  module.name,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
                leading: Text(
                    grade,
                    style: Theme.of(context).textTheme.headlineSmall),
                trailing: Text(module.weighting.toString()),
                onTap: () {
                  onClick(context, module);
                },
                onLongPress: () {
                  onLongPress(context, module);
                },
              );
            } else {
              return ListTile(
                subtitle: Text('${entries[index]}. Semester'),
              );
            }
          },
          padding: const EdgeInsets.only(bottom: 75),
        );
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: buildTables(entries, context),
        );
      }
    }
  }

  List processModules(List<Module> modules) {
    List processed = [];
    Map<int, List<Module>> grouped = groupBy(modules, (module) => module.semester);
    List<int> semester = grouped.keys.toList();
    semester.sort();
    semester = semester.reversed.toList();

    for (int i in semester) {
      processed.add(i);
      processed.addAll(grouped[i]!);
    }
    return processed;
  }

  void onLongPress(BuildContext context, Module module) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Löschen?'),
        content: const Text('Das Modul wird unwiderruflich gelöscht.'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Abbrechen'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Löschen'),
            onPressed: () async {
              context.read<ModulesListProvider>().delete(module);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }

  void onClick(BuildContext context, Module module) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => UpdateModuleDialog(module: module),
        fullscreenDialog: true,
      ),
    );
  }

  // start of Datatable
  Widget buildTables(List entries, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DataTable(
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(label: Text("Semester")),
            DataColumn(label: Text("Modul")),
            DataColumn(label: Text("Wichtung")),
            DataColumn(label: Text("Note")),
          ],
          rows: buildRows(entries, context),
        ),
      ],
    );
  }

  List<DataRow> buildRows(List entries, BuildContext context) {
    List<DataRow> rows = [];

    for (dynamic entry in entries) {
      if (entry is Module) {
        rows.add(
          DataRow(
            onSelectChanged: (_) => onClick(context, entry),
            onLongPress: () => onLongPress(context, entry),
            cells: <DataCell>[
              DataCell(Text(entry.semester.toString())),
              DataCell(Text(entry.name)),
              DataCell(Text(entry.weighting.toString())),
              DataCell(Text(entry.grade.toString())),
            ],
          ),
        );
      }
    }

    return rows;
  }
}
