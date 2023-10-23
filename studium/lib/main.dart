import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studium/commons/db/database.dart';
import 'package:studium/commons/keys/prefs.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
import 'package:studium/commons/providers/prefs_provider.dart';
import 'package:studium/main_layout.dart';
import 'package:studium/modules/models/models.dart';
import 'package:studium/theme/color_schemes.g.dart';
import 'package:studium/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String matrikel = prefs.getString(PrefKeys.matrikel.name) ?? 'IIm23';
  bool displayTypeWeek = prefs.getBool(PrefKeys.displayTypeWeek.name) ?? false;
  bool dynamicMode = prefs.getBool(PrefKeys.dynamicMode.name) ?? true;
  int displayMode = prefs.getInt(PrefKeys.displayMode.name) ?? 0;

  List<Module> modules = await AppDatabase.loadAllModules();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModulesListProvider(modules)),
        ChangeNotifierProvider(create: (_) => SharedPrefsProvider(displayMode, displayTypeWeek, dynamicMode, matrikel)),
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
     int themeMode = context.watch<SharedPrefsProvider>().displayMode;
    bool dynamicMode = context.watch<SharedPrefsProvider>().dynamicMode;

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null && dynamicMode) {
          lightScheme = lightDynamic.harmonized();
          darkScheme = darkDynamic.harmonized();
        } else {
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        ThemeData lightThemedata = ThemeData(
          useMaterial3: true,
          colorScheme: lightScheme,
        );
        ThemeData darkThemedata = ThemeData(
          useMaterial3: true,
          colorScheme: darkScheme,
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('de_DE')
          ],
          themeMode: thememodes[themeMode],
          theme: lightThemedata.copyWith(
            textTheme: buildTextTheme(lightThemedata.textTheme),
            scaffoldBackgroundColor: lightThemedata.colorScheme.background,
          ),
          darkTheme: darkThemedata.copyWith(
            textTheme: buildTextTheme(darkThemedata.textTheme),
            scaffoldBackgroundColor: darkThemedata.colorScheme.background,
          ),
          home: const HomeLayout(),
          builder: (context, child) => ResponsiveWrapper.builder(
            child,
            minWidth: 300,
            defaultName: MOBILE,
            breakpoints: const [
              ResponsiveBreakpoint.resize(450, name: MOBILE),
              ResponsiveBreakpoint.resize(600, name: TABLET),
            ]
          ),
        );
      },
    );
  }
}



