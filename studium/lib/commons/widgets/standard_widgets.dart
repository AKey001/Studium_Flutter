import 'dart:developer';

import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final List<Widget> btnActions;
  final List<PopupMenuEntry> popupActions;

  const AppBarWidget(this._title, {this.btnActions = const [], this.popupActions = const [], super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    List<Widget> actions = [];
    actions.addAll(btnActions);
    actions.add(
      PopupMenuButton(
          onSelected: (value) {
            log('clicked $value');
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            ...popupActions,
            const PopupMenuItem(
              value: 1,
              child: Text('Einstellungen'),
            ),
          ]),
    );
    return AppBar(
      title: Text(_title),
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
