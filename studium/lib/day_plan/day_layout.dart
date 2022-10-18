import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';
import 'package:studium/day_plan/widgets/day_list.dart';

class DayLayout extends StatefulWidget {
  DateTime? initialDate;

  DayLayout({Key? key, this.initialDate}) : super(key: key);

  @override
  State<DayLayout> createState() => _DayLayoutState();
}

class _DayLayoutState extends State<DayLayout> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    date = widget.initialDate ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        'Auswahl',
        showSettingsItem: true,
        btnActions: [
          IconButton(
            onPressed: () {
              _selectDate(context, DateTime.now());
            },
            icon: const Icon(Icons.search))
        ],
      ),
      body: DayList(dateTime: date),
    );
  }

  void _selectDate(BuildContext context, DateTime initial) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(initial.year - 1, 1),
      lastDate: DateTime(initial.year + 1, 7),
      helpText: 'Tag wählen',
    );
    if (newDate != null) {
      setState(() {
        widget.initialDate == null;
        date = newDate;
      });
    }
  }
}