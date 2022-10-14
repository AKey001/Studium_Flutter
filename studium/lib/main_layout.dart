import 'package:flutter/material.dart';
import 'package:studium/dashboard/dashboard_layout.dart';
import 'package:studium/modules/modules_layout.dart';
import 'package:studium/plan/plan_layout.dart';

class HomeLayout extends StatefulWidget {
  final String? restorationId = 'home';

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();

}

class _HomeLayoutState extends State<HomeLayout> with RestorationMixin {
  final RestorableInt _selectedIndex = RestorableInt(0);

  List<Widget> _fragments = <Widget>[Plan(), Dashboard(), Modules()];

  final RestorableInt i = RestorableInt(0);

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        _fragments.removeAt(1);
        _fragments.insert(1, Dashboard(key: GlobalKey()));
      } else if (index == 2) {
        _fragments.removeAt(2);
        _fragments.insert(2, Modules(key: GlobalKey()));
      }
      _selectedIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _fragments[_selectedIndex.value],
      body: IndexedStack(
        index: _selectedIndex.value,
        children: _fragments,
      ),
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 800),
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex.value,
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

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedIndex, 'nav_bar_index');
  }


  Widget buildDashboard() {
    return new Dashboard();
  }
  Widget buildModules() {
    return new Modules();
  }
}
