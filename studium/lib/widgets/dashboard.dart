import 'package:flutter/material.dart';

Widget buildDashboardWidget() {
  return ListView.builder(
    itemCount: 50,
    itemBuilder: (context, index) {
      return Container (
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('Gesamteturteil'),
              Text('vorläufig'),
              Text('1.024'),
            ],
          ),
        ),
      );
    },
  );
}