import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:studium/plan/models/models.dart';
import 'package:studium/plan/widgets/entry_list_items.dart';

class EntryListWidget extends StatelessWidget {
  final List<Entry> _entries;

  const EntryListWidget(this._entries, {super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveBreakpointsData responsiveData =
        ResponsiveBreakpoints.of(context);

    if (_entries.isEmpty) {
      return const Center(
          child: Text("Keine Enträge im gesuchten Zeitraum")
      );
    }

    if (responsiveData.isMobile) {
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
          }
        },
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: buildTables(_entries, context),
      );
    }
  }

  Column buildTables(List<Entry> entries, BuildContext context) {
    Map<String, List<TableEntry>> grouped = {};
    String dayName = "";
    for (Entry entry in entries) {
      if (entry.getType() == EntryType.titleDay) {
        TitleEntry titleEntry = entry as TitleEntry;
        dayName = titleEntry.title;
      } else {
        TableEntry tableEntry = entry as TableEntry;
        if (grouped.containsKey(dayName)) {
          grouped[dayName]?.add(tableEntry);
        } else {
          grouped.putIfAbsent(dayName, () => [tableEntry]);
        }
      }
    }

    List<Widget> content = [];
    for (String day in grouped.keys) {
      content.add(Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
        child: Text(day, style: Theme.of(context).textTheme.headline5),
      ));
      content.add(Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text("Zeit")),
              DataColumn(label: Text("Veranstaltung")),
              DataColumn(label: Text("Modul")),
              DataColumn(label: Text("Dozent")),
              DataColumn(label: Text("Raum")),
            ],
            rows: buildRows(grouped[day] ?? []),
          ),
        ],
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }

  List<DataRow> buildRows(List<TableEntry> entries) {
    List<DataRow> rows = [];

    for (TableEntry entry in entries) {
      rows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 100),
              child: Text(entry.time.replaceAll("\n", ""), maxLines: 2),
            )),
            DataCell(Text(entry.type)),
            DataCell(Text(entry.module)),
            DataCell(Text(entry.teacher)),
            DataCell(Text(entry.room)),
          ],
        ),
      );
    }

    return rows;
  }
}
