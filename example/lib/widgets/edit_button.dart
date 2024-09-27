import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class EditButton extends StatelessWidget {
  final bool _isExtended;

  const EditButton({super.key}) : _isExtended = false;

  const EditButton.extended({super.key}) : _isExtended = true;

  @override
  Widget build(BuildContext context) {
    // TODO SnackBar in front of BottomNavigation
    void onPressed() => ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          margin: EdgeInsetsDirectional.only(
            start: 16,
            top: 14,
            end: Breakpoints.largeAndUp.isActive(context)
                ? (360 - MediaQuery.sizeOf(context).width).abs() - 16
                : 16,
            bottom: 14,
          ),
          content: const Text('Yay! A SnackBar!'),
          behavior: SnackBarBehavior.floating,
        ),
      );

    return _isExtended
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
