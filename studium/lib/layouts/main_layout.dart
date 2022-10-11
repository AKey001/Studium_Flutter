import 'package:flutter/material.dart';
import 'package:studium/layouts/dashboard_layout.dart';
import 'package:studium/layouts/plan_layout.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _selectedIndex = 0;
  static const List<Widget> _fragments = <Widget>[Plan(), Dashboard(), Dashboard()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _fragments.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          buildBottomNavigationBarItem(Icons.home, 'Home'),
          buildBottomNavigationBarItem(Icons.dashboard, 'Dashboard'),
          buildBottomNavigationBarItem(Icons.list, 'Module'),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}