import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studium/modules/models/models.dart';

class AppDatabase {

  static Future<Database> _init() async {
    String dbPath = join(await getDatabasesPath(), "ResultCalculator");
    return openDatabase(dbPath,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Module(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, grade FLOAT, weighting INTEGER, semester INTEGER)',
        );
      },
      version: 4);
  }

  static Future<void> _close(Database db) async {
    await db.close();
  }

  static void _insert(Module module, Database db) async {
    await db.insert(
        'Module',
        module.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Module>> _modules(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('Module', orderBy: 'semester, weighting desc, name');

    return List.generate(maps.length, (i) {
      return Module(
        id: maps[i]['id'],
        name: maps[i]['name'],
        grade: maps[i]['grade'],
        weighting: maps[i]['weighting'],
        semester: maps[i]['semester'],
      );
    });
  }

  static Future<void> _update(Module module, Database db) async {
    await db.update(
      'Module',
      module.toMap(),
      where: 'id = ?',
      whereArgs: [module.id],
    );
  }

  static Future<void> _delete(Module module, Database db) async {
    await db.delete(
      'Module',
      where: 'id = ?',
      whereArgs: [module.id],
    );
  }

  static Future<List<Module>> loadAllModules() async {
    Database db = await _init();
    List<Module> modules = await _modules(db);
    _close(db);
    return modules;
  }

  static Future<void> insertModule(Module module) async {
    Database db = await _init();
    _insert(module, db);
    _close(db);
  }

  static Future<void> updateModule(Module module) async {
    Database db = await _init();
    _update(module, db);
    _close(db);
  }

  static Future<void> deleteModule(Module module) async {
    Database db = await _init();
    _delete(module, db);
    _close(db);
  }
}
