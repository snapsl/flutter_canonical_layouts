import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';
import 'widgets/edit_button.dart';

void main() {
  runApp(const MaterialUiApp());
}

class MaterialUiApp extends StatelessWidget {
  const MaterialUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorschme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.green,
    );
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: colorschme),
      darkTheme: ThemeData(colorScheme: colorschme),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      leadingExtendedNavRail: const EditButton(),
      leadingUnextendedNavRail: const EditButton(),
      useDrawer: false,
      selectedIndex: navigationShell.currentIndex,
      onSelectedIndexChange: onNavigationEvent,
      body: (_) => navigationShell,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.view_list), label: 'List-detail'),
        NavigationDestination(
            icon: Icon(Icons.support), label: 'Supporting pane'),
        NavigationDestination(icon: Icon(Icons.feed), label: 'Feed'),
      ],
    );
  }

  void onNavigationEvent(int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
}
