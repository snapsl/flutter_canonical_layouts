import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'widgets/edit_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: const Center(
          child: Text(
            'This is an exemplary app for implementing material canonical layouts in Flutter.',
          ),
        ),
      ),
      // Note: show FAB on small screens.
      floatingActionButton:
          Breakpoints.small.isActive(context) ? const EditButton() : null,
    );
  }
}
