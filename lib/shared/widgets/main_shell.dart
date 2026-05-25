import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  static const _tabs = [
    _TabInfo(path: '/', icon: Icons.restaurant_menu, label: 'Journal'),
    _TabInfo(path: '/history', icon: Icons.bar_chart, label: 'Historique'),
    _TabInfo(path: '/profile', icon: Icons.person, label: 'Profil'),
  ];

  int _currentIndex(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    for (int i = 0; i < _tabs.length; i++) {
      if (loc == _tabs[i].path) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _currentIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.go(_tabs[i].path),
        destinations: _tabs
            .map((t) => NavigationDestination(
                  icon: Icon(t.icon),
                  label: t.label,
                ))
            .toList(),
      ),
    );
  }
}

class _TabInfo {
  final String path;
  final IconData icon;
  final String label;
  const _TabInfo({
    required this.path,
    required this.icon,
    required this.label,
  });
}
