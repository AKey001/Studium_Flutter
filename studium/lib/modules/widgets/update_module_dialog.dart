import 'package:flutter/material.dart';
import 'package:studium/commons/db/database.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/modules/models/models.dart';

class UpdateModuleDialog extends StatefulWidget {
  Module module;
  
  UpdateModuleDialog({super.key, required this.module});

  @override
  State<UpdateModuleDialog> createState() => _UpdateModuleDialogState();
}

class _UpdateModuleDialogState extends State<UpdateModuleDialog> {
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
        title: const Text('Modul bearbeiten'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
                onPressed: () async {
                  widget.module.name = moduleController.value.text;
                  widget.module.grade = double.parse(gradeController.value.text);
                  widget.module.weighting = int.parse(weightingController.value.text);
                  widget.module.semester = int.parse(semesterController.value.text);

                  await AppDatabase.updateModule(widget.module);
                  Navigator.pop(context);
                },
                child: const Text('Speichern')
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFieldWidget(
                initalValue: widget.module.name,
                label: 'Modul',
                controller: moduleController),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextFieldWidget(
                    initalValue: widget.module.semester.toString(),
                    label: 'Semester',
                    controller: semesterController,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFieldWidget(
                    initalValue: widget.module.grade.toString(),
                    label: 'Note',
                    controller: gradeController,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFieldWidget(
                    initalValue: widget.module.weighting.toString(),
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