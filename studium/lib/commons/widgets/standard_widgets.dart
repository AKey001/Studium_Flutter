import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studium/settings/settings_screen.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final List<Widget> btnActions;
  final List<PopupMenuEntry> popupActions;
  final bool showSettingsItem;

  const AppBarWidget(this._title, {this.btnActions = const [], this.popupActions = const [], this.showSettingsItem = true, super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    List<Widget> actions = [];
    actions.addAll(btnActions);

    List<PopupMenuEntry> allPopupActions = [];
    allPopupActions.addAll(popupActions);
    if (showSettingsItem) {
      allPopupActions.add(
        const PopupMenuItem(
          value: 1,
          child: Text('Einstellungen'),
        ),
      );
    }

    if (allPopupActions.isNotEmpty) {
      actions.add(
        PopupMenuButton(
            onSelected: (value) {
              log('clicked');
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              ...allPopupActions,
            ]
        ),
      );
    }

    return AppBar(
      title: Text(_title),
      // elevation: 2,
      // scrolledUnderElevation: 0,
      shadowColor: Theme.of(context).colorScheme.shadow,
      actions: actions
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;

}

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String initalValue;
  final String label;
  IconData? icon;
  String? errorText;

  TextFieldWidget({super.key, required this.initalValue, required this.label, this.icon, this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        initialValue: initalValue,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          border: const OutlineInputBorder(),
          suffixIcon: Icon(
            icon
          ),
          labelStyle: Theme.of(context).textTheme.bodySmall
        ),
      ),
    );
  }
}

