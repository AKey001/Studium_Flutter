import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/prefs_provider.dart';
import 'package:studium/settings/widgets/display_mode_dialog.dart';
import 'package:studium/settings/widgets/matrikel_dialog.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({Key? key}) : super(key: key);

  final List<String> _displayModes = const ['Systemstandard', 'Darkmode', 'Lightmode'];
  final List<String> _displayTypes = const ['Heutiger und morgiger Tag werden angezeigt.', 'Gesamte Woche wird angezeigt.'];

  @override
  Widget build(BuildContext context) {
    String matrikel = context.watch<SharedPrefsProvider>().matrikel;
    bool displayTypeWeek = context.watch<SharedPrefsProvider>().displayTypeWeek;
    int displayMode = context.watch<SharedPrefsProvider>().displayMode;
    bool dynamicMode = context.watch<SharedPrefsProvider>().dynamicMode;

    return ListView(
      children: <Widget>[
        const ListTile(
          subtitle: Text('Erscheinungsbild'),
        ),
        ListTile(
          title: const Text('Designstil'),
          subtitle: Text(_displayModes[displayMode]),
          onTap: () {
            showDialog(context: context,
              builder: (BuildContext context) {
                return const DisplayModeAlert();
              });
          },
        ),
        Platform.isAndroid
            ? SwitchListTile(
                title: const Text('Dynamische Farben'),
                subtitle: const Text("Dynamische Farben werden ab Android 12 unterstützt und passen das App-Theme an das Android Theme an."),
                onChanged: (value) => context.read<SharedPrefsProvider>().saveDynamicMode(value),
                value: dynamicMode,
              )
            : const SizedBox(),
        const ListTile(
          subtitle: Text('Stundenplan'),
        ),
        ListTile(
          title: const Text('Matrikel'),
          subtitle: Text(matrikel),
          onTap: () {
            showDialog(context: context,
              builder: (BuildContext context) {
                return const MatrikelAlert();
              });
          },
        ),
        SwitchListTile(
          title: const Text('Darstellung: Gesamte Woche'),
          subtitle: Text(_displayTypes[displayTypeWeek == true ? 1 : 0]),
          onChanged: (value) => context.read<SharedPrefsProvider>().saveDisplayTypeWeek(value),
          value: displayTypeWeek,
        ),
      ],
    );
  }
}