import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

/// Canonical list-detail layout
///
/// https://m3.material.io/foundations/layout/canonical-layouts/list-detail
class ListDetailLayout extends StatelessWidget {
  /// Material Breakpoint.
  ///
  /// Breakpoint for the list detail layout to show [listPane] and [detailPane]
  /// side by side.
  static const Breakpoint breakpoint = Breakpoints.mediumLargeAndUp;

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

  ///See [AdaptiveLayout.bodyRatio]
  final double? bodyRatio;

  /// See [AdaptiveLayout.transitionDuration]
  final Duration transitionDuration;

  /// See [AdaptiveLayout.internalAnimations]
  final bool internalAnimations;

  const ListDetailLayout({
    super.key,
    required this.listPane,
    this.detailPane,
    this.detailPlaceholder,
    this.bodyRatio,
    this.transitionDuration = const Duration(seconds: 1),
    this.internalAnimations = false,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: SlotLayout(
        key: const Key('SLot'),
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.standard: SlotLayout.from(
            key: const Key('Body'),
            builder: null,
          ),
          Breakpoints.small: SlotLayout.from(
            key: const Key('Body Small'),
            builder: (_) => detailPane ?? listPane,
          ),
          Breakpoints.medium: SlotLayout.from(
            key: const Key('Body Medium'),
            builder: (_) => detailPane ?? listPane,
          ),
          breakpoint: SlotLayout.from(
            key: const Key('Body Large'),
            builder: (_) => listPane,
          )
        },
      ),
      secondaryBody: breakpoint.isActive(context)
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
      bodyRatio: bodyRatio,
    );
  }
}
