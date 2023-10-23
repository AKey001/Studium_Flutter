import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:studium/plan/models/models.dart';
import 'package:studium/plan/widgets/entry_list_items.dart';

class EntryListWidget extends StatelessWidget {
  final List<Entry> _entries;

  const EntryListWidget(this._entries, {super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveBreakpointsData responsiveData = ResponsiveBreakpoints.of(context);

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
                case EntryType.infoEntry:
                  InfoEntry infoEntry = entry as InfoEntry;
                  return EntryListInfoWidget(infoEntry.info);
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
    Map<String, List<Entry>> grouped = {};
    String day = "";
    for (Entry entry in entries) {
      switch (entry.getType()) {
        case EntryType.titleDay:
          TitleEntry titleEntry = entry as TitleEntry;
          day = titleEntry.title;
          break;
        case EntryType.tableEntry:
          TableEntry tableEntry = entry as TableEntry;
          grouped.putIfAbsent(day, () => [tableEntry]);
          if (grouped.containsKey(day)) {
            grouped[day]?.add(tableEntry);
          }
          break;
        case EntryType.infoEntry:
          InfoEntry infoEntry = entry as InfoEntry;
          grouped.putIfAbsent(day, () => [infoEntry]);
          if (grouped.containsKey(day)) {
            grouped[day]?.add(infoEntry);
          }
          break;
      }
    }

    List<Widget> content = [];
    for (String day in grouped.keys) {
      content.add(
          Padding(
            padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 24
            ),
            child: Text(
              day,
              style: Theme.of(context).textTheme.headline5
            ),
          )
      );
       content.add(
           Column(
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
           )
       );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: content,
    );
  }

  List<DataRow> buildRows(List<Entry> entries) {
    List<DataRow> rows = [];

    for (Entry entry in entries) {
      switch (entry.getType()) {
        case EntryType.tableEntry:
          TableEntry tableEntry = entry as TableEntry;
          rows.add(
            DataRow(
              cells: <DataCell>[
                DataCell(ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 100
                  ),
                  child: Text(tableEntry.time.replaceAll("\n", ""),
                      maxLines: 2),
                )),
                DataCell(Text(tableEntry.type)),
                DataCell(Text(tableEntry.module)),
                DataCell(Text(tableEntry.teacher)),
                DataCell(Text(tableEntry.room)),
              ],
            ),
          );
          break;
        case EntryType.infoEntry:
          InfoEntry infoEntry = entry as InfoEntry;
          rows.add(
            DataRow(
              cells: <DataCell>[
                DataCell(Text(infoEntry.info)),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
              ],
            ),
          );
          break;
        case EntryType.titleDay:
          // should not be called
          TitleEntry titleEntry = entry as TitleEntry;
          rows.add(
            DataRow(
              cells: <DataCell>[
                DataCell(Text(titleEntry.title)),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
              ],
            ),
          );
          break;
      }
    }

    return rows;
  }
}
