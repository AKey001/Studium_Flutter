import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/modules/widgets/add_modules_dialog.dart';
import 'package:studium/modules/widgets/modules_list.dart';

class Modules extends StatelessWidget {
  const Modules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        'Module'
      ),
      body: const ModulesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddModuleDialog(),
              fullscreenDialog: true,
            ),
          );
        },
        tooltip: 'Hinzufügen',
        child: const Icon(Icons.add),
      ),
    );
  }
}
