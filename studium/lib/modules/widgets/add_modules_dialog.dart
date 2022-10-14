import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studium/commons/db/database.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/modules/models/models.dart';

class AddModuleDialog extends StatefulWidget {
  const AddModuleDialog({super.key});

  @override
  State<AddModuleDialog> createState() => _AddModuleDialogState();
}

class _AddModuleDialogState extends State<AddModuleDialog> {
  final TextEditingController moduleController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController weightingController = TextEditingController();

  @override
  void dispose() {
    moduleController.dispose();
    semesterController.dispose();
    gradeController.dispose();
    weightingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Modul'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
                onPressed: () async {
                  Module module = Module(
                      name: moduleController.value.text,
                      grade: double.parse(gradeController.value.text),
                      weighting: int.parse(weightingController.value.text),
                      semester: int.parse(semesterController.value.text),
                  );
                  log(module.toString());
                  await AppDatabase.insertModule(module);
                  Navigator.pop(context);
                },
                child: const Text('Speichern')
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFieldWidget(
                initalValue: '',
                label: 'Modul',
                controller: moduleController),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextFieldWidget(
                    initalValue: '1',
                    label: 'Semester',
                    controller: semesterController,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFieldWidget(
                    initalValue: '',
                    label: 'Note',
                    controller: gradeController,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFieldWidget(
                    initalValue: '5',
                    label: 'Wichtung',
                    controller: weightingController,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




// >>>>>>>>>>>> Modul <<<<<<<<<<<<<<
// >> Sem << >> Note << >> Weight <<


// wo löschen -> long click