import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
import 'package:studium/theme/color_schemes.dart';
import 'package:studium/theme/custom_color.g.dart';
import 'package:studium/theme/theme.dart';

import 'main_layout.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModulesListProvider()),
      ],
      child: const Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ModulesListProvider>().init();

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);

          // Repeat for the dark color scheme.
          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          // Otherwise, use fallback schemes.
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        ThemeData lightThemedata = ThemeData(
          useMaterial3: true,
          colorScheme: lightScheme,
          extensions: [lightCustomColors],
        );
        ThemeData darkThemedata = ThemeData(
          useMaterial3: true,
          colorScheme: darkScheme,
          extensions: [darkCustomColors],
        );

        return MaterialApp(
          theme: lightThemedata.copyWith(
            textTheme: buildTextTheme(lightThemedata.textTheme),
          ),
          darkTheme: darkThemedata.copyWith(
            textTheme: buildTextTheme(darkThemedata.textTheme),
            scaffoldBackgroundColor: darkThemedata.colorScheme.background,
          ),
          home: const HomeLayout(),
        );
      },
    );
  }
}



