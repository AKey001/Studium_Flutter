import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/settings/widgets/settings_list.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget('Einstellungen', showSettingsItem: false),
      body: SettingsList(),
    );
  }
}
