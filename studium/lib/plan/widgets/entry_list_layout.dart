import 'package:flutter/material.dart';
import 'package:studium/plan/models/models.dart';
import 'package:studium/plan/widgets/entry_list_items.dart';

class EntryListWidget extends StatelessWidget {
  final List<Entry> _entries;

  const EntryListWidget(this._entries, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _entries.length,
      itemBuilder: (context, index) {
        final entry = _entries[index];
        switch (entry.getType()) {
          case EntryType.titleDay:
            TitleEntry titleEntry = entry as TitleEntry;
            return EntryListTitleWidget(titleEntry.title);
          case EntryType.tableEntry:
            TableEntry tableEntry = entry as TableEntry;
            return EntryListTableWidget(tableEntry);
          case EntryType.infoEntry:
            InfoEntry infoEntry = entry as InfoEntry;
            return EntryListInfoWidget(infoEntry.info);
        }
      },
    );
  }
}



