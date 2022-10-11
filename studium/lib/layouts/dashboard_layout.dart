import 'package:flutter/material.dart';
import 'package:studium/widgets/dashboard.dart';
import 'package:studium/widgets/standard_widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context,
        'Dashboard',
      ),
      body: buildDashboardWidget(),
    );
  }
}
