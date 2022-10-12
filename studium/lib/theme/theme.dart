import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme() {
  ThemeData base = ThemeData.dark();
  return base.copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromRGBO(50, 50, 50, 1.0),
    colorScheme: _buildColorScheme(base),
    textTheme: _buildTextTheme(base.textTheme),
  );
}

ColorScheme _buildColorScheme(ThemeData base) {
  return base.colorScheme.copyWith(
    primary: const Color(0xff1565c0),
    secondary: const Color(0xff90caf9),
    surface: const Color.fromRGBO(50, 50, 50, 1),
    surfaceTint: const Color.fromRGBO(21, 101, 192, 1.0),
    onSurface: Colors.white,
    onSurfaceVariant: Colors.grey.shade300,
    secondaryContainer: const Color(0xff1565c0),
    onSecondaryContainer: Colors.white,
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    headline5: base.headline5!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    headline6: base.headline6!.copyWith(
      fontSize: 18.0,
    ),
    caption: base.caption!.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    bodyText1: base.bodyText1!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: Colors.grey.shade400,
    bodyColor: Colors.grey.shade300,
  );
}
