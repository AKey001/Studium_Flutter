
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/modules/widgets/add_modules_dialog.dart';
import 'package:studium/modules/widgets/modules_list.dart';

class Modules extends StatefulWidget {
  const Modules({Key? key}) : super(key: key);

  @override
  State<Modules> createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        'Module'
      ),
      body: ModulesList(showDeleteDialog: (){},),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddModuleDialog(),
              fullscreenDialog: true,
            ),
          ).then(onReturned);
        },
        tooltip: 'Hinzufügen',
        child: const Icon(Icons.add),
      ),
    );
  }

  FutureOr onReturned(dynamic value) {
    setState(() {
      log('reload');
    });
  }
}
