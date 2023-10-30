enum EntryType {
  titleDay,
  tableEntry
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
