import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
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
        children: const <Widget>[
          ListTile(
            title: Text('Gesamturteil'),
            subtitle: Text('vorläufig'),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 8.0
            ),
            child: ResultTextRow(),
          ),
        ],
      ),
    );
  }
}

class ResultTextRow extends StatelessWidget {
  const ResultTextRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Module> value = context.watch<ModulesListProvider>().modules;

    String officialResult = '-.-';
    String additional = '';
    if (value.isNotEmpty && calculateResult(value) != "${double.nan}") {
      String result = calculateResult(value);
      officialResult = result.substring(0, 3);
      additional = result.substring(3);
    }

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
  }
}
