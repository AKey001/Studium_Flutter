
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studium/commons/db/database.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/modules/models/models.dart';
import 'package:studium/modules/widgets/modules_list_layout.dart';

class ModulesList extends StatefulWidget {
  const ModulesList({Key? key}) : super(key: key);

  @override
  State<ModulesList> createState() => _ModulesListState();
}

class _ModulesListState extends State<ModulesList> {
  List<Module> _modules = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Module>>(
      future: loadAllModules(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          log("db loaded");
          _modules = snapshot.data!;
          log('$_modules');

          if (_modules.isEmpty) {
            return Center(child: Text('Keine Module gespeichert'));
          } else {
            return ModulesListWidget(modules: _modules);
          }
        } else if (snapshot.hasError) {
          log('error: ${snapshot.error}');
          return ErrorWidget('${snapshot.error}');
        } else {
          log("db in Progress");
          return const ProgressWidget();
        }
      },
    );
  }

  Future<List<Module>> loadAllModules() async {
    AppDatabase appDB = AppDatabase();
    Database db = await appDB.init();
    return await appDB.modules(db);
  }
}




