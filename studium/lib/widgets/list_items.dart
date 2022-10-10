import 'package:flutter/material.dart';
import 'package:studium/models/models.dart';

Widget listTitleWidget(String title) {
  return Container(
    height: 45.0,
    padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 18.0
    ),
    child: Text(
      title,
      style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w400
      ),
    ),
  );
}

// todo table entry widget more beautiful
Widget listTableEntryWidget(TableEntry tableEntry) {
  return ListTile(
    title: Text(tableEntry.type),
    subtitle: Text('${tableEntry.module}\n${tableEntry.teacher}'),
    isThreeLine: true,
    leading: Text(tableEntry.time),
    trailing: Text(tableEntry.room),
  );
  return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(tableEntry.type),
          Text(tableEntry.module),
          Text(tableEntry.teacher),
          Text(tableEntry.room),
          Text(tableEntry.time),
        ],
      )
  );
}

Widget listInfoWidget(String info) {
  return Container(
    padding: const EdgeInsets.only(
      left: 16.0,
      top: 8.0,
      bottom: 8.0,
    ),
    child: Text(
      info,
      style: const TextStyle(
        color: Colors.grey,
      ),
    ),
  );
}