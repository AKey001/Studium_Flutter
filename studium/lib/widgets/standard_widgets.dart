import 'package:flutter/material.dart';
import 'package:studium/theme/theme.dart';

PreferredSizeWidget AppBarWidget(String title, {List<Widget> actions = const []}) {
  return AppBar(
      systemOverlayStyle: appbarTheme(),
      backgroundColor: Colors.grey[900],
      title: Text(title),
      actions: actions
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