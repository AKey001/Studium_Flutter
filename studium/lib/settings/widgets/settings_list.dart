
import 'package:flutter/material.dart';
import 'package:studium/settings/widgets/alert_dialog.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({Key? key}) : super(key: key);

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  int _displayMode = 0;
  String _matrikel = 'IIBb20';
  bool _displayTypeWeek = false;

  // todo shared_preferences

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const ListTile(
          subtitle: Text('Allgemein'),
        ),
        ListTile(
          title: const Text('Erscheinungsbild'),
          subtitle: const Text('Systemstandard'),
          onTap: () {
            showDialog(context: context,
                builder: (BuildContext context) {
                  return DisplayModeAlert(onValueChange: _onDisplayModeChanges, initialValue: _displayMode);
                });
          },
        ),
        const ListTile(
          subtitle: Text('Stundenplan'),
        ),
        const ListTile(
          title: Text('Matrikel'),
          subtitle: Text('IIBb20'),
        ),
        ListTile(
          title: const Text('Darstellung: Gesamte Woche'),
          subtitle: Text('Heutiger und morgiger Tag werden angezeigt.'),
          isThreeLine: false,
          trailing: Switch(value: _displayTypeWeek, onChanged: onSwitchChanged),
        ),
      ],
    );
  }

  void onSwitchChanged(bool value) {
    setState(() {
      _displayTypeWeek = value;
    });
  }

  void _onDisplayModeChanges(int? value) {
    setState(() {
      _displayMode = value ?? 0;
    });
  }

}
