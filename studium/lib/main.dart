import 'package:flutter/material.dart';
import 'package:studium/theme/theme.dart';
import 'layouts/main_layout.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      home: const HomeLayout(),
    );
  }
}

