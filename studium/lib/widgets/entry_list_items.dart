import 'package:flutter/material.dart';
import 'package:studium/models/models.dart';

Widget listTitleWidget(String title, BuildContext context) {
  return Container(
    height: 45.0,
    padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 15.0
    ),
    child: Text(
      title,
      style: Theme.of(context).textTheme.headline5,
      // style: const TextStyle(
      //     fontSize: 20.0,
      //     fontWeight: FontWeight.w400
      // ),
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