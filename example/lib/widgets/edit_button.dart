import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final bool extended;

  const EditButton({super.key}) : extended = false;

  const EditButton.extended({super.key}) : extended = true;

  @override
  Widget build(BuildContext context) {
    void onPressed() => ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Yay! A SnackBar!'),
        ),
      );

    return extended
        ? FloatingActionButton.extended(
            onPressed: onPressed,
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
          )
        : FloatingActionButton(
            onPressed: onPressed,
            child: const Icon(Icons.edit),
          );
  }
}
