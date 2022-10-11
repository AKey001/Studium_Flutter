import 'package:flutter/material.dart';
import 'package:studium/models/models.dart';
import 'package:studium/widgets/list_items.dart';

Widget buildEntryListWidget(List<Entry> entries, BuildContext context) {
  return ListView.builder(
    itemCount: entries.length,
    itemBuilder: (context, index) {
      final entry = entries[index];
      switch (entry.getType()) {
        case EntryType.titleDay:
          TitleEntry titleEntry = entry as TitleEntry;
          return listTitleWidget(titleEntry.title, context);
        case EntryType.tableEntry:
          TableEntry tableEntry = entry as TableEntry;
          return listTableEntryWidget(tableEntry);
        case EntryType.infoEntry:
          InfoEntry infoEntry = entry as InfoEntry;
          return listInfoWidget(infoEntry.info);
      }
    },
  );
}