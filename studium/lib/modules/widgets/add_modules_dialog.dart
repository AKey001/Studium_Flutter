import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';

class AddModuleDialog extends StatelessWidget {
  const AddModuleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Modul'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: TextButton(onPressed: () {

            },
                child: Text('Speichern')
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
            TextFieldWidget(initalValue: '', label: 'Modul'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextFieldWidget(
                    initalValue: '1',
                    label: 'Semester',
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFieldWidget(
                    initalValue: '',
                    label: 'Note',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFieldWidget(
                    initalValue: '5',
                    label: 'Wichtung',
                  ),
                ),
              ],
            ),
            Row(
              children: [

              ],
            )
          ],
        ),
      ),
    );
  }
}




// >>>>>>>>>>>> Modul <<<<<<<<<<<<<<
// >> Sem << >> Note << >> Weight <<


// wo löschen -> long click