import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveWrapperData responsiveData = ResponsiveWrapper.of(context);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            responsiveData.isSmallerThan(TABLET)
            ? const SizedBox(width: 0, height: 0,)
            : NavigationRail(
              backgroundColor: Theme.of(context).colorScheme.background,
              leading: const SizedBox(),
                groupAlignment: -1,
                labelType: NavigationRailLabelType.all,
                destinations: <NavigationRailDestination>[
                  buildNavigationRailDestination(Icons.home, 'Home'),
                  buildNavigationRailDestination(Icons.dashboard, 'Dashboard'),
                  buildNavigationRailDestination(Icons.list, 'Module')
                ],
                selectedIndex: _selectedIndex.value,
                onDestinationSelected: _onItemTapped,
              ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex.value,
                children: const [
                  Plan(),
                  Dashboard(),
                  Modules(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: responsiveData.isSmallerThan(TABLET)
        ? NavigationBar(
            onDestinationSelected: _onItemTapped,
            selectedIndex: _selectedIndex.value,
            destinations: <Widget>[
              buildBottomNavigationBarItem(Icons.home, 'Home'),
              buildBottomNavigationBarItem(Icons.dashboard, 'Dashboard'),
              buildBottomNavigationBarItem(Icons.list, 'Module')
            ],
          )
        : null,

    );
  }

  Widget buildBottomNavigationBarItem(IconData icon, String label) {
    return NavigationDestination(
        icon: Icon(icon),
        label: label
    );
  }

  NavigationRailDestination buildNavigationRailDestination(IconData icon, String label) {
    return NavigationRailDestination(
        icon: Icon(icon),
        label: Text(label)
    );
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedIndex, 'nav_bar_index');
  }
}
