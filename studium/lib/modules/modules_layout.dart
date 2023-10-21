import 'dart:io';

import 'package:csvloader/csvloader.dart';
import 'package:csvwriter/csvwriter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/modules/models/models.dart';
import 'package:studium/modules/widgets/add_modules_dialog.dart';
import 'package:studium/modules/widgets/modules_list.dart';

class Modules extends StatelessWidget {
  const Modules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;

    return Scaffold(
      appBar: AppBarWidget(
        'Module',
        popupActions: [
          PopupMenuItem(
            child: const Text("Import"),
            onTap: () async {

              try {
                FilePickerResult? result = await FilePicker.platform
                    .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);

                if (result == null) {
                  return;
                }

                PlatformFile file1 = result.files.single;
                File file = File(file1.path ?? '');
                String csv = await file.readAsString();

                final modulesCSV =
                CsvLoader.withHeaders(Stream.value(csv), separator: ",");

                List<Module> modules = [];
                await for (var row in modulesCSV.rows) {
                  Module module = Module(
                      name: row['name'].toString(),
                      grade: num.tryParse(row['grade'].toString()),
                      weighting: int.tryParse(row['weighting'].toString()) ?? 0,
                      semester: int.tryParse(row['semester'].toString()) ?? 0);
                  modules.add(module);
                }

                if (context.mounted) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Import'),
                          content: Text('${modules.length} Module importieren?'),
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
                              child: const Text('Importieren'),
                              onPressed: () async {
                                Provider.of<ModulesListProvider>(context,
                                    listen: false)
                                    .insertAll(modules);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                }

              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Fehler beim Laden")
                      )
                  );

                }
              }




            },
          ),
          PopupMenuItem(
            child: const Text("Export"),
            onTap: () async {
              List<Module> modules =
                  Provider.of<ModulesListProvider>(context, listen: false)
                      .modules;

              final fileInfo = await FilePickerWritable().openFileForCreate(
                fileName: 'export.csv',
                writer: (file) async {
                  var csv = CsvWriter.withHeaders(
                      file.openWrite(), Module.attributes());

                  try {
                    for (Module module in modules) {
                      csv.writeData(data: {
                        'name': module.name,
                        'grade': module.grade,
                        'weighting': module.weighting,
                        'semester': module.semester,
                      });
                    }
                  } finally {
                    await csv.close();
                  }
                },
              );
              if (fileInfo == null) {
                return;
              }
            },
          ),
        ],
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
