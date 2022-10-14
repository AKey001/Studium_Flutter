import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:studium/commons/db/database.dart';
import 'package:studium/modules/models/models.dart';
import 'package:studium/modules/widgets/update_module_dialog.dart';

class ModulesListWidget extends StatefulWidget {
  List<Module> modules;

  ModulesListWidget({required this.modules, super.key});

  @override
  State<ModulesListWidget> createState() => _ModulesListWidgetState();
}

class _ModulesListWidgetState extends State<ModulesListWidget> {
  List entries = [];

  @override
  Widget build(BuildContext context) {
    List<Module> modules = widget.modules;

    entries = processModules(modules);

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
            ),
            leading: Text(
                grade,
                style: Theme.of(context).textTheme.headlineSmall),
            trailing: Text(module.weighting.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => UpdateModuleDialog(module: module),
                  fullscreenDialog: true,
                ),
              ).then((value) async {
                await updateList();
              });
            },
            onLongPress: () {
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
                        await AppDatabase.deleteModule(module);
                        await updateList();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
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
  }

  List processModules(List<Module> modules) {
    List processed = [];
    Map<int, List<Module>> grouped = groupBy(modules, (p0) => p0.semester);

    for (int i in grouped.keys) {
      processed.add(i);
      processed.addAll(grouped[i]!);
    }
    return processed;
  }

  Future<void> updateList() async {
    List<Module> modules = await AppDatabase.loadAllModules();
    widget.modules = modules;
    setState(() {
      entries = processModules(modules);
    });
  }
}
