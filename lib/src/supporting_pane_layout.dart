import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

/// Represents a side, either left or right.
enum Side {
  /// Left side.
  left,

  /// Right side.
  right,
}

/// Canonical supporting-pane layout
///
/// https://m3.material.io/foundations/layout/canonical-layouts/supporting-pane
class SupportingPaneLayout extends StatelessWidget {
  /// Focuse pane.
  ///
  /// Widget that is shown in the focus pane.
  final Widget focusPane;

  /// Vertical supporting pane.
  ///
  /// Widget that is shown in a vertical supporting pane.
  /// Usually a [ListView] with [Axis.vertical] scroll direction.
  final Widget verticalSupportingPane;

  /// Horizontal supporting pane.
  ///
  /// Widget that is shown in a vertical supporting pane.
  /// Usually a [ListView] with [Axis.horizontal] scroll direction.
  final Widget horizontalSupportingPane;

  /// See [AdaptiveLayout.internalAnimations]
  final bool internalAnimations;

  /// See [AdaptiveLayout.transitionDuration]
  final Duration transitionDuration;

  /// Side of the supporting pane.
  ///
  /// Choose between [Side.left] and [Side.right].
  final Side supportingPaneSide;

  /// Width for supporting pane.
  ///
  /// Sets the width for the supporting pane
  /// when on the side defined by [supportingPaneSide].
  final double sideSupportingPaneWidth;

  /// Supporting pane body ratio.
  ///
  /// Sets the body ratio between [focusPane] and [horizontalSupportingPane]
  /// when supporting pane is placed below the focus pane.
  final double bottomSupportingPaneRatio;

  /// Supporting pane as bottom sheet.
  ///
  /// Widget that implements the supporting pane
  /// in the compact layout as [DraggableScrollableSheet].
  final DraggableScrollableSheet bottomSheetSupportingPane;

  const SupportingPaneLayout({
    super.key,
    required this.focusPane,
    required this.horizontalSupportingPane,
    required this.verticalSupportingPane,
    required this.bottomSheetSupportingPane,
    this.supportingPaneSide = Side.right,
    this.internalAnimations = true,
    this.transitionDuration = const Duration(seconds: 1),
    this.sideSupportingPaneWidth = 360,
    this.bottomSupportingPaneRatio = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: fast resizing causes exception

    return Scaffold(
      bottomSheet: Breakpoints.small.isActive(context)
          ? bottomSheetSupportingPane
          : null,
      body: AdaptiveLayout(
        primaryNavigation: supportingPaneSide == Side.left
            ? SlotLayout(
                config: <Breakpoint, SlotLayoutConfig>{
                  Breakpoints.standard: SlotLayout.from(
                    key: const Key('Supporting Pane Left'),
                    builder: null,
                  ),
                  Breakpoints.mediumLargeAndUp: SlotLayout.from(
                    key: const Key('Supporting Pane Left Large'),
                    builder: (_) => SizedBox(
                        width: sideSupportingPaneWidth,
                        child: verticalSupportingPane),
                  )
                },
              )
            : null,
        secondaryNavigation: supportingPaneSide == Side.right
            ? SlotLayout(
                config: <Breakpoint, SlotLayoutConfig>{
                  Breakpoints.standard: SlotLayout.from(
                    key: const Key('Supporting Pane Right'),
                    builder: null,
                  ),
                  Breakpoints.mediumLargeAndUp: SlotLayout.from(
                    key: const Key('Supporting Pane Right Large'),
                    builder: (_) => SizedBox(
                        width: sideSupportingPaneWidth,
                        child: verticalSupportingPane),
                  )
                },
              )
            : null,
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.standard: SlotLayout.from(
              key: const Key('Focus Pane'),
              builder: (_) => focusPane,
            )
          },
        ),
        secondaryBody: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.standard: SlotLayout.from(
              key: const Key('Supporting Pane'),
              builder: null,
            ),
            Breakpoints.medium: SlotLayout.from(
              key: const Key('Supporting Pane Medium'),
              builder: (_) => horizontalSupportingPane,
            )
          },
        ),
        bodyRatio: 1 - bottomSupportingPaneRatio,
        transitionDuration: transitionDuration,
        internalAnimations: internalAnimations,
        bodyOrientation: Breakpoints.medium.isActive(context)
            ? Axis.vertical
            : Axis.horizontal,
      ),
    );
  }
}
