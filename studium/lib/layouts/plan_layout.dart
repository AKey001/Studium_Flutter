import 'package:flutter/material.dart';
import 'package:studium/network/data_fetcher.dart';
import 'package:studium/widgets/standard_widgets.dart';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {

  void refresh() {
    setState(() {});
  }

  // todo calendar popup -> + loading
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          context,
          'Stundenplan',
          actions: <Widget>[
            IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month)),
            IconButton(onPressed: refresh, icon: const Icon(Icons.refresh))
          ]
      ),
      body: EntryList(),
    );
  }
}
