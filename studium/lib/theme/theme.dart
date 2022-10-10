import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Colors.blue[800],
    canvasColor: const Color.fromRGBO(18, 18, 18, 1),
    brightness: Brightness.dark,
    colorScheme: ThemeData().colorScheme.copyWith(
      surface: const Color.fromRGBO(18, 18, 18, 1),
      secondary: Colors.blue[800],
      brightness: Brightness.dark,
      onSurface: Colors.white,
      // brightness: Brightness.dark,
    )
  );
}

SystemUiOverlayStyle appbarTheme() {
  return const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  );
}