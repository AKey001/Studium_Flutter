import 'package:flutter/material.dart';
import 'package:studium/dashboard/dashboard_screen.dart';
import 'package:studium/plan/modules/modules_layout.dart';
import 'package:studium/plan/plan_layout.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _selectedIndex = 0;
  static const List<Widget> _fragments = <Widget>[Plan(), Dashboard(), Modules()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _fragments.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 800),
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        destinations: <Widget>[
          buildBottomNavigationBarItem(Icons.home, 'Home'),
          buildBottomNavigationBarItem(Icons.dashboard, 'Dashboard'),
          buildBottomNavigationBarItem(Icons.list, 'Module')
        ],
      ),
    );
  }

  Widget buildBottomNavigationBarItem(IconData icon, String label) {
    return NavigationDestination(
        icon: Icon(icon),
        label: label
    );
  }
}