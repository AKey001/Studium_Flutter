import 'package:flutter/material.dart';
import 'package:studium/commons/widgets/standard_widgets.dart';

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
      appBar: const AppBarWidget(
        'Module',
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: const Placeholder(),
    );
  }
}
