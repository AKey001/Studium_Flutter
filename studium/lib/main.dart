import 'package:flutter/material.dart';
import 'package:studium/theme/color_schemes.dart';
import 'package:studium/theme/theme.dart';

import 'main_screen.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  Main({Key? key}) : super(key: key);

  ThemeData lightTheme = ThemeData(useMaterial3: true, colorScheme: lightColorScheme);
  ThemeData darkTheme = ThemeData(useMaterial3: true, colorScheme: darkColorScheme);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'root',
      // theme: appTheme(),
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme).copyWith(
        textTheme: buildTextTheme(lightTheme.textTheme),
      ),
      darkTheme: darkTheme.copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1B1E),
        textTheme: buildTextTheme(darkTheme.textTheme),
      ),
      home: const HomeLayout(),
    );
  }
}

