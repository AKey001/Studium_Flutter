import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
import 'package:studium/commons/providers/prefs_provider.dart';
import 'package:studium/main_layout.dart';
import 'package:studium/theme/color_schemes.g.dart';
import 'package:studium/theme/custom_color.g.dart';
import 'package:studium/theme/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModulesListProvider()),
        ChangeNotifierProvider(create: (_) => SharedPrefsProvider()),
      ],
      child: const Main(),
    ),
  );
}

class Main extends StatelessWidget {
  final List<ThemeMode> thememodes = const [ThemeMode.system, ThemeMode.dark, ThemeMode.light];

  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ModulesListProvider>().init();
    context.read<SharedPrefsProvider>().init();
    int themeMode = context.watch<SharedPrefsProvider>().displayMode;

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);

          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
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
          themeMode: thememodes[themeMode],
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



