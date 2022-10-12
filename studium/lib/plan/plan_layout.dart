
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/plan/network/data_fetcher.dart';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  Widget? _list;
  int i = 0;

  @override
  void initState() {
    _list = EntryList();
    super.initState();
  }

  void loadList() {
    setState(() {
      _list = null;
    });
  }

  // todo calendar popup -> + loading
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          'Stundenplan',
          btnActions: <Widget>[
            IconButton(onPressed: (){
              i++;
              log('$i');
            }, icon: const Icon(Icons.calendar_month)),
            IconButton(onPressed: loadList, icon: const Icon(Icons.refresh))
          ]
      ),
      body: (_list != null) ? _list! : EntryList(),
    );
  }
}
