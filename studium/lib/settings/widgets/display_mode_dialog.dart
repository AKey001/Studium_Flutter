import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/prefs_provider.dart';

class DisplayModeAlert extends StatefulWidget {
  const DisplayModeAlert({super.key});

  @override
  State<DisplayModeAlert> createState() => _DisplayModeAlertState();
}

class _DisplayModeAlertState extends State<DisplayModeAlert> {

  @override
  Widget build(BuildContext context) {
    int displayMode = context.watch<SharedPrefsProvider>().displayMode;

    return AlertDialog(
      scrollable: true,
      title: const Text("Erscheinungsbild"),
      content: Column(
        children: <Widget>[
          RadioListTile(
            title: const Text('Systemstandard'),
            value: 0,
            groupValue: displayMode,
            onChanged: (value) {
              _onDisplayModeChanges(value, context);
            },
          ),
          RadioListTile(
            title: const Text('Darkmode'),
            value: 1,
            groupValue: displayMode,
            onChanged: (value) {
              _onDisplayModeChanges(value, context);
            },
          ),
          RadioListTile(
            title: const Text('Lightmode'),
            value: 2,
            groupValue: displayMode,
            onChanged: (value) {
              _onDisplayModeChanges(value, context);
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Speichern'),
        ),
      ],
    );
  }

  void _onDisplayModeChanges(int? value, BuildContext context) {
    context.read<SharedPrefsProvider>().saveDisplayMode(value ?? 0);
  }

}