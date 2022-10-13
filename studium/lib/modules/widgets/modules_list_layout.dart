
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:studium/modules/models/models.dart';
import 'package:studium/modules/widgets/add_modules_dialog.dart';


class ModulesListWidget extends StatelessWidget {
  List<Module> modules = const [];
  List entries = [];
  
  ModulesListWidget({required this.modules, super.key});

  @override
  Widget build(BuildContext context) {

    Map<int, List<Module>> grouped = groupBy(modules, (p0) => p0.semester);

    for (int i in grouped.keys) {
      entries.add(i);
      entries.addAll(grouped[i]!);
    }

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {

        if (entries[index] is Module) {
          Module module = entries[index];
          return ListTile(
            title: Text(
              module.name,
            ),
            leading: Text(
                module.grade.toString(),
                style: Theme.of(context).textTheme.headlineSmall),
            trailing: Text(module.weighting.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => AddModuleDialog(),
                  fullscreenDialog: true,
                ),
              );
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
