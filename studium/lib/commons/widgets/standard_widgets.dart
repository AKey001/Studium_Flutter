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
  final IconData? icon;
  TextEditingController? controller;
  final String? Function(String?)? validator;

  TextFieldWidget({super.key, required this.initalValue, required this.label, this.icon, this.validator, this.controller});

  @override
  Widget build(BuildContext context) {
    controller == null ? controller = TextEditingController() : null;
    controller?.value =  TextEditingValue(text: initalValue);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        initialValue: null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: Icon(
            icon
          ),
          labelStyle: Theme.of(context).textTheme.bodySmall,
        ),
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  final String error;

  const CustomErrorWidget({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(padding: EdgeInsets.all(24),
        child: Text(
          'Fehler: $error',
          style: TextStyle(
            color:  Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
