import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/settings/widgets/settings_list.dart';

class SettingsLayout extends StatelessWidget {
  const SettingsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget('Einstellungen', showSettingsItem: false),
      body: SettingsList(),
    );
  }
}
