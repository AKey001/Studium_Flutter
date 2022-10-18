import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
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
        title: const Text('Neues Modul'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Module module = Module(
                      name: moduleController.value.text.trim(),
                      grade: gradeController.value.text != '' ? double.parse(gradeController.value.text) : null,
                      weighting: int.parse(weightingController.value.text.trim()),
                      semester: int.parse(semesterController.value.text.trim()),
                    );
                    context.read<ModulesListProvider>().insert(module);
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
                initalValue: '',
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
                      keyboardType: TextInputType.number,
                      initalValue: '',
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
                      keyboardType: TextInputType.number,
                      initalValue: '',
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
                      keyboardType: TextInputType.number,
                      initalValue: '',
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
