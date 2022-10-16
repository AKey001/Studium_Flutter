enum EntryType {
  titleDay,
  tableEntry,
  infoEntry
}

abstract class Entry {
  EntryType getType();
}

class TitleEntry extends Entry {
  final String _title;

  TitleEntry(this._title);

  @override
  EntryType getType() {
    return EntryType.titleDay;
  }

  String get title => _title;
}

class TableEntry extends Entry {
  String time = '';
  String module = '';
  String room = '';
  String teacher = '';
  String type = '';

  @override
  EntryType getType() {
    return EntryType.tableEntry;
  }
}

class InfoEntry extends Entry {
  final String _info;

  InfoEntry(this._info);

  String get info => _info;

  @override
  EntryType getType() {
    return EntryType.infoEntry;
  }
}

class PlanModel {
  List<TableEntry> monday = [];
  List<TableEntry> tuesday = [];
  List<TableEntry> wednesday = [];
  List<TableEntry> thursday = [];
  List<TableEntry> friday = [];
  List<TableEntry> saturday = [];
  List<TableEntry> sunday = [];
  bool hasError = false;
  String message = '';

  List<TableEntry> today() {
    int weekday = DateTime.now().weekday;
    switch (weekday) {
      case 1:
        return monday;
      case 2:
        return tuesday;
      case 3:
        return wednesday;
      case 4:
        return thursday;
      case 5:
        return friday;
      case 6:
        return saturday;
      case 7:
        return sunday;
      default:
        return List.empty();
    }
  }

  List<TableEntry> tomorrow() {
    int weekday = DateTime.now().weekday;
    switch (weekday) {
      case 7:
        return monday;
      case 1:
        return tuesday;
      case 2:
        return wednesday;
      case 3:
        return thursday;
      case 4:
        return friday;
      case 5:
        return saturday;
      case 6:
        return sunday;
      default:
        return List.empty();
    }
  }
}