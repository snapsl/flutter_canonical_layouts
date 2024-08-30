import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'This is an exemplary app for implementing material canonical layouts in Flutter.',
        ),
      ),
    );
  }
}
