import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studium/commons/keys/prefs.dart';

class SharedPrefsProvider with ChangeNotifier {
  int _displayMode = 0;
  bool _displayTypeWeek = false;
  String _matrikel = 'IIBb20';

  int get displayMode => _displayMode;

  bool get displayTypeWeek => _displayTypeWeek;

  String get matrikel => _matrikel;

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _matrikel = prefs.getString(PrefKeys.matrikel.name) ?? 'IIBb20';
    _displayTypeWeek = prefs.getBool(PrefKeys.displayTypeWeek.name) ?? false;
    _displayMode = prefs.getInt(PrefKeys.displayMode.name) ?? 0;
  }

  void saveDisplayTypeWeek(bool type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PrefKeys.displayTypeWeek.name, type);
    _displayTypeWeek = type;
    notifyListeners();
  }

  void saveDisplayMode(int mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PrefKeys.displayMode.name, mode);
    _displayMode = mode;
    notifyListeners();
  }

  void saveMatrikel(String matrikel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefKeys.matrikel.name, matrikel);
    _matrikel = matrikel;
    notifyListeners();
  }


}