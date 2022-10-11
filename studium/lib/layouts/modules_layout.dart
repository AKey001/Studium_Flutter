import 'package:flutter/material.dart';
import 'package:studium/widgets/dashboard.dart';
import 'package:studium/widgets/standard_widgets.dart';

class Modules extends StatefulWidget {
  const Modules({Key? key}) : super(key: key);

  @override
  State<Modules> createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context,
        'Module',
      ),
      body: buildDashboardWidget(),
    );
  }
}
