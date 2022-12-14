import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studium/commons/keys/prefs.dart';

class SharedPrefsProvider with ChangeNotifier {
  int _displayMode = 0;
  bool _displayTypeWeek = false;
  bool _dynamicMode = true;
  String _matrikel = 'IIBb20';

  int get displayMode => _displayMode;

  bool get displayTypeWeek => _displayTypeWeek;

  bool get dynamicMode => _dynamicMode;

  String get matrikel => _matrikel;

  SharedPrefsProvider(this._displayMode, this._displayTypeWeek,
      this._dynamicMode, this._matrikel);

  void saveDisplayTypeWeek(bool type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PrefKeys.displayTypeWeek.name, type);
    _displayTypeWeek = type;
    notifyListeners();
  }

  void saveDynamicMode(bool type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PrefKeys.dynamicMode.name, type);
    _dynamicMode = type;
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