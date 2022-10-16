import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/prefs_provider.dart';

class MatrikelAlert extends StatefulWidget {
  const MatrikelAlert({super.key});

  @override
  State<MatrikelAlert> createState() => _MatrikelAlertState();
}

class _MatrikelAlertState extends State<MatrikelAlert> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textController.text = context.watch<SharedPrefsProvider>().matrikel;

    return AlertDialog(
      scrollable: true,
      title: const Text("Matrikel"),
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Matrikel',
              border: const OutlineInputBorder(),
              // suffixIcon: Icon(
              //     Icons.check_circle
              // ),
              labelStyle: Theme.of(context).textTheme.bodySmall,
            ),
            controller: textController,
            // validator: validator,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () {
            context.read<SharedPrefsProvider>().saveMatrikel(textController.value.text);
            Navigator.pop(context);
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}