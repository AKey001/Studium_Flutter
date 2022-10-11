import 'package:flutter/material.dart';

Widget buildDashboardWidget() {
  return ListView.builder(
    itemCount: 4,
    itemBuilder: (context, index) {
      return Container (
        padding: EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('Gesamturteil'),
              Text('vorläufig'),
              Text('1.024'),
            ],
          ),
        ),
      );
    },
  );
}