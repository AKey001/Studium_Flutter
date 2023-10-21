import 'package:flutter/material.dart';
import 'package:studium/commons/db/database.dart';
import 'package:studium/modules/models/models.dart';

class ModulesListProvider with ChangeNotifier {
  List<Module> _modules = [];

  int get modulesCount => _modules.length;

  int get modulesWeighted {
    return _modules.where((module) => module.weighting > 0).toList().length;
  }

  int get modulesGraded {
    return _modules.where((module) => module.grade != null).toList().length;
  }

  List<Module> get modules => _modules;


  ModulesListProvider(this._modules);

  void insert(Module module) async {
    await AppDatabase.insertModule(module);
    _modules = await AppDatabase.loadAllModules();
    notifyListeners();
  }

  void insertAll(List<Module> modules) async {
    await AppDatabase.insertModules(modules);
    _modules = await AppDatabase.loadAllModules();
    notifyListeners();
  }
  
  void delete(Module module) async {
    await AppDatabase.deleteModule(module);
    _modules.remove(module);
    notifyListeners();
  }

  void update(Module module) async {
    await AppDatabase.updateModule(module);
    notifyListeners();
  }
}