
enum ModuleEntryType {
  module,
  section
}

abstract class ModuleEntry {
  ModuleEntryType getType();
}

class Module {
  final int? id;

  final String name;

  final num grade;

  final int weighting;

  final int semester;

  const Module(
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