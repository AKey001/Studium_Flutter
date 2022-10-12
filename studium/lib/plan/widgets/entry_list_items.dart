import 'package:flutter/material.dart';
import 'package:studium/plan/models/models.dart';

class EntryListTitleWidget extends StatelessWidget {
  final String _title;

  const EntryListTitleWidget(this._title, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 15.0
      ),
      child: Text(
        _title,
        style: Theme.of(context).textTheme.headline5,
        // style: const TextStyle(
        //     fontSize: 20.0,
        //     fontWeight: FontWeight.w400
        // ),
      ),
    );
  }
}

class EntryListTableWidget extends StatelessWidget {
  final TableEntry _tableEntry;

  const EntryListTableWidget(this._tableEntry, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_tableEntry.type),
      subtitle: Text('${_tableEntry.module}\n${_tableEntry.teacher}'),
      isThreeLine: true,
      leading: Text(_tableEntry.time),
      trailing: Text(_tableEntry.room),
    );
  }
}

class EntryListInfoWidget extends StatelessWidget {
  final String _info;

  const EntryListInfoWidget(this._info, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Text(
        _info,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
