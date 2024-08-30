import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

/// Canonical list-detail layout
///
/// https://m3.material.io/foundations/layout/canonical-layouts/list-detail
class ListDetailLayout extends StatelessWidget {
  /// Pane for list.
  ///
  /// Usually a [ListView].
  /// The details of the selected item are shown in the [detailPane].
  final Widget listPane;

  /// Pane for details.
  ///
  /// Use this widget to show details information.
  final Widget? detailPane;

  /// Placeholder for [detailPane].
  ///
  /// This widget is shown when no item is selected in the [listPane].
  /// Defaults to [SizedBox].
  final Widget? detailPlaceholder;

  /// See [AdaptiveLayout.transitionDuration]
  final Duration transitionDuration;

  /// See [AdaptiveLayout.internalAnimations]
  final bool internalAnimations;

  const ListDetailLayout({
    required this.listPane,
    this.detailPane,
    this.detailPlaceholder,
    this.transitionDuration = const Duration(seconds: 1),
    this.internalAnimations = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.standard: SlotLayout.from(
            key: const Key('Body'),
            inAnimation: (p0, p1) => p0,
            outAnimation: (p0, p1) => p0,
            builder: null,
          ),
          Breakpoints.small: SlotLayout.from(
            key: const Key('Body Small'),
            inAnimation: (p0, p1) => p0,
            outAnimation: (p0, p1) => p0,
            builder: (_) => detailPane ?? listPane,
          ),
          Breakpoints.medium: SlotLayout.from(
            key: const Key('Body Medium'),
            builder: (_) => detailPane ?? listPane,
          ),
          Breakpoints.mediumLargeAndUp: SlotLayout.from(
            key: const Key('Body Large'),
            builder: (_) => listPane,
          )
        },
      ),
      secondaryBody: Breakpoints.mediumLargeAndUp.isActive(context)
          ? SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.standard: SlotLayout.from(
                  key: const Key('Secondary Body Large'),
                  builder: (_) =>
                      detailPane ?? detailPlaceholder ?? const SizedBox(),
                )
              },
            )
          : null,
      transitionDuration: transitionDuration,
      internalAnimations: internalAnimations,
    );
  }
}
