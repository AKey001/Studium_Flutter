import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/prefs_provider.dart';
import 'package:studium/settings/widgets/display_mode_dialog.dart';
import 'package:studium/settings/widgets/matrikel_dialog.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({Key? key}) : super(key: key);

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  final List<String> _displayModes = ['Systemstandard', 'Darkmode', 'Lightmode'];
  final List<String> _displayTypes = ['Heutiger und morgiger Tag werden angezeigt.', 'Gesamte Woche wird angezeigt.'];

  @override
  Widget build(BuildContext context) {
    String matrikel = context.watch<SharedPrefsProvider>().matrikel;
    bool displayTypeWeek = context.watch<SharedPrefsProvider>().displayTypeWeek;
    int displayMode = context.watch<SharedPrefsProvider>().displayMode;

    return ListView(
      children: <Widget>[
        const ListTile(
          subtitle: Text('Allgemein'),
        ),
        ListTile(
          title: const Text('Erscheinungsbild'),
          subtitle: Text(_displayModes[displayMode]),
          onTap: () {
            showDialog(context: context,
              builder: (BuildContext context) {
                return const DisplayModeAlert();
              });
          },
        ),
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
