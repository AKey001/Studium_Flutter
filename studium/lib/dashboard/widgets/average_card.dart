import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studium/commons/providers/modules_list_provider.dart';
import 'package:studium/dashboard/mapper/result_calculator.dart';
import 'package:studium/modules/models/models.dart';

class AverageCardWidget extends StatelessWidget {
  const AverageCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        // mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          ListTile(
            title: Text('Durchschnitt'),
            subtitle: Text('vorläufig'),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 4,
                  bottom: 16.0
              ),
              child: AverageText(),
          ),
        ],
      ),
    );
  }
}

class AverageText extends StatelessWidget {
  const AverageText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Module> modules = context.watch<ModulesListProvider>().modules;

    if (modules.isEmpty) {
      return Text(
          '-.-',
          style: Theme.of(context).textTheme.headline2
      );
    } else {
      return Text(
          calculateAverageString(modules),
          style: Theme.of(context).textTheme.headline2
      );
    }
  }
}
