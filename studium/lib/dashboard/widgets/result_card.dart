import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:studium/commons/db/database.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/dashboard/mapper/result_calculator.dart';
import 'package:studium/modules/models/models.dart';

class ResultCardWidget extends StatelessWidget {
  const ResultCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ListTile(
            title: Text('Gesamturteil'),
            subtitle: Text('vorläufig'),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 8.0
            ),
            child: result()
          ),
        ],
      ),
    );
  }

  Widget result() {
    return FutureBuilder<List<Module>>(
      future: AppDatabase.loadAllModules(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String result = calculateResult(snapshot.data ?? []);
          String officialResult = result.substring(0, 3);
          String additional = result.substring(3);

          return Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(
                officialResult,
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                additional,
                style: Theme.of(context).textTheme.headline3,
              )
            ],
          );
        } else if (snapshot.hasError) {
          return ErrorWidget(error: '${snapshot.error}');
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(
                '-.-',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                '-',
                style: Theme.of(context).textTheme.headline3,
              )
            ],
          );
        }
      },
    );
  }

}