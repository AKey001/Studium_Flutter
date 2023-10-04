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
