
import 'package:flutter/material.dart';

class DisplayModeAlert extends StatefulWidget {
  const DisplayModeAlert({super.key, required this.onValueChange, required this.initialValue});

  final int initialValue;
  final void Function(int?) onValueChange;

  @override
  State<DisplayModeAlert> createState() => _DisplayModeAlertState();
}

class _DisplayModeAlertState extends State<DisplayModeAlert> {
  int _displayMode = 0;

  @override
  void initState() {
    _displayMode = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text("Erscheinungsbild"),
      content: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Systemstandard'),
            leading: Radio<int>(
              value: 0,
              groupValue: _displayMode,
              onChanged: widget.onValueChange,
            ),
          ),
          ListTile(
            title: const Text('Darkmode'),
            leading: Radio<int>(
              value: 1,
              groupValue: _displayMode,
              onChanged: widget.onValueChange,
            ),
          ),
          ListTile(
            title: const Text('Lightmode'),
            leading: Radio<int>(
              value: 2,
              groupValue: _displayMode,
              onChanged: widget.onValueChange,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Abbrechen'),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Speichern'),
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}