import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studium/modules/models/models.dart';

class AppDatabase {

  Future<Database> init() async {
    String dbPath = join(await getDatabasesPath(), "ResultCalculator");
    return openDatabase(dbPath,
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE Module(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, grade FLOAT, weighting INTEGER, semester INTEGER)',
          );
        },
        version: 4);
  }

  void insert(Module module, Database db) async {
    await db.insert(
        'Module',
        module.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Module>> modules(Database db) async {
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('Module', orderBy: 'semester, name');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
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


}
