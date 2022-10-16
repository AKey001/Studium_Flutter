
import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/plan/widgets/entry_list.dart';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {

  // todo day chooser
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          'Stundenplan',
          btnActions: <Widget>[
            IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month)),
          ]
      ),
      // body: (_list != null) ? _list! : getEntryList(),
      body: const EntryList(),
    );
  }
}
