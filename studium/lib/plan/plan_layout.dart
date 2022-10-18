import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/day_plan/day_layout.dart';
import 'package:studium/plan/widgets/entry_list.dart';

class Plan extends StatelessWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        'Stundenplan',
        btnActions: <Widget>[
        IconButton(onPressed: () {
          _selectDate(context);
        },
        icon: const Icon(Icons.calendar_month)),
        ],
      ),
      // body: (_list != null) ? _list! : getEntryList(),
      body: const EntryList(),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime initial = DateTime.now();
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(initial.year - 1, 1),
      lastDate: DateTime(initial.year + 1, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DayLayout(initialDate: newDate)),
      );
    }
  }
}
