
enum ModuleEntryType {
  module,
  section
}

abstract class ModuleEntry {
  ModuleEntryType getType();
}

class Module {
  final int? id;

  String name;

  num? grade;

  int weighting;

  int semester;

  Module(
      {required this.name, required this.grade, required this.weighting, required this.semester, this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'grade': grade,
      'weighting': weighting,
      'semester': semester,
    };
  }

  @override
  String toString() {
    return 'Module{id: $id, name: $name, grade: $grade, weighting: $weighting, semester: $semester';
  }

}