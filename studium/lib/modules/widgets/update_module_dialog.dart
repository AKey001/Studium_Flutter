import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/modules/models/models.dart';

class UpdateModuleDialog extends StatefulWidget {
  final Module module;
  
  const UpdateModuleDialog({super.key, required this.module});

  @override
  State<UpdateModuleDialog> createState() => _UpdateModuleDialogState();
}

class _UpdateModuleDialogState extends State<UpdateModuleDialog> {
  final TextEditingController moduleController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController weightingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  if (_formKey.currentState!.validate()) {
                    widget.module.name = moduleController.value.text;
                    widget.module.grade = double.parse(gradeController.value.text);
                    widget.module.weighting = int.parse(weightingController.value.text);
                    widget.module.semester = int.parse(semesterController.value.text);

                    context.read<ModulesListProvider>().update(widget.module);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Speichern')
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFieldWidget(
                initalValue: widget.module.name,
                label: 'Modul',
                textInputAction: TextInputAction.next,
                controller: moduleController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bitte ausfüllen';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                      initalValue: widget.module.semester.toString(),
                      label: 'Semester',
                      textInputAction: TextInputAction.next,
                      controller: semesterController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte ausfüllen';
                        }
                        int? testedAsInt = int.tryParse(value);
                        if (testedAsInt == null || testedAsInt < 1 || testedAsInt > 30) {
                          return 'ungültig';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFieldWidget(
                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                      initalValue: widget.module.weighting.toString(),
                      label: 'Wichtung',
                      textInputAction: TextInputAction.next,
                      controller: weightingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte ausfüllen';
                        }
                        int? testedAsInt = int.tryParse(value);
                        if (testedAsInt == null || testedAsInt < 0) {
                          return 'ungültig';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      initalValue: widget.module.grade.toString(),
                      label: 'Note',
                      textInputAction: TextInputAction.done,
                      controller: gradeController,
                      validator: (value) {
                        if (value != null && value.isNotEmpty){
                          double? testedAsDouble = double.tryParse(value);
                          if (testedAsDouble == null || testedAsDouble.toString().length > 3 || testedAsDouble > 5 || testedAsDouble < 1) {
                            return 'ungültig';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}