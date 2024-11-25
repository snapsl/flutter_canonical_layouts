import 'dart:math' as math;

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
    final seedColor =
        Colors.primaries[math.Random().nextInt(Colors.primaries.length)];

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

class ScaffoldShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldShell({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      // Note: Show extended FAB on extended screens.
      leadingExtendedNavRail: const EditButton.extended(),
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
