import 'package:flutter/material.dart';

PreferredSizeWidget AppBarWidget(BuildContext context, String title, {List<Widget> actions = const []}) {
  return AppBar(
    title: Text(title),
    // scrolledUnderElevation: 0,
    // backgroundColor: Colors.grey[900],
    shadowColor: Theme.of(context).colorScheme.shadow,
    actions: actions,
  );
}

Widget ErrorTextWidget([String? msg]) {
  return Center(
    child: Text(
      'Fehler: $msg',
      style: const TextStyle(
        color: Colors.red,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

Widget ProgressWidget() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}