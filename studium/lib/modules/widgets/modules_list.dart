import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      List entries =  processModules(modules);
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
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => UpdateModuleDialog(module: module),
                    fullscreenDialog: true,
                  ),
                );
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
                          context.read<ModulesListProvider>().delete(module);
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
}
