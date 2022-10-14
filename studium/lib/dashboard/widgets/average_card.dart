import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:studium/commons/db/database.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/dashboard/mapper/result_calculator.dart';
import 'package:studium/modules/models/models.dart';

class AverageCardWidget extends StatelessWidget {
  const AverageCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ListTile(
            title: Text('Durchschnitt'),
            subtitle: Text('vorläufig'),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 8.0
            ),
            child: average()
          ),
        ],
      ),
    );
  }

  Widget average() {
    return FutureBuilder<List<Module>>(
      future: AppDatabase.loadAllModules(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
              calculateAverage(snapshot.data ?? []),
              style: Theme.of(context).textTheme.headline2
          );
        } else if (snapshot.hasError) {
          return ErrorWidget(error: '${snapshot.error}');
        } else {
          return Text(
              '-.-',
              style: Theme.of(context).textTheme.headline2
          );
        }
      },
    );
  }
}