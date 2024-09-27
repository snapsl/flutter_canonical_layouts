import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

/// Canonical supporting pane layout
///
/// https://m3.material.io/foundations/layout/canonical-layouts/supporting-pane
class SupportingPaneLayout extends StatefulWidget {
  /// Breakpoint for displaying the supporting pane as bottom sheet.
  static const Breakpoint bottomSheetBreakpoint = Breakpoints.small;

  /// Breakpoint for displaying the supporting pane below the focus pane.
  static const Breakpoint bottomPaneBreakpoint = Breakpoints.medium;

  /// Breakpoint for displaying the supporting pane at the side of the focus pane.
  static const Breakpoint sidePaneBreakpoint = Breakpoints.mediumLargeAndUp;

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
  /// Choose between [TextDirection.ltr] and [TextDirection.rtl].
  /// Defaults to [Directionality.of].
  final TextDirection? supportingPaneSide;

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
  /// Widget that implements the supporting pane in the compact layout.
  /// Usually a [DraggableScrollableSheet].
  final Widget bottomSheetSupportingPane;

  const SupportingPaneLayout({
    super.key,
    required this.focusPane,
    required this.horizontalSupportingPane,
    required this.verticalSupportingPane,
    required this.bottomSheetSupportingPane,
    this.supportingPaneSide,
    this.internalAnimations = false,
    this.transitionDuration = const Duration(seconds: 1),
    this.sideSupportingPaneWidth = 360,
    this.bottomSupportingPaneRatio = 0.3,
  });

  @override
  State<SupportingPaneLayout> createState() => _SupportingPaneLayoutState();
}

class _SupportingPaneLayoutState extends State<SupportingPaneLayout> {
  PersistentBottomSheetController? controller;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (SupportingPaneLayout.bottomSheetBreakpoint.isActive(context)) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => controller ??= _scaffoldKey.currentState?.showBottomSheet(
          (context) => widget.bottomSheetSupportingPane,
        ),
      );
    } else {
      controller?.close();
      controller = null;
    }

    final supportingPaneSide =
        widget.supportingPaneSide ?? Directionality.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: AdaptiveLayout(
        primaryNavigation: supportingPaneSide == TextDirection.ltr
            ? SlotLayout(
                config: <Breakpoint, SlotLayoutConfig>{
                  Breakpoints.standard: SlotLayout.from(
                    key: const Key('Supporting Pane Left'),
                    builder: null,
                  ),
                  SupportingPaneLayout.sidePaneBreakpoint: SlotLayout.from(
                    key: const Key('Supporting Pane Left Large'),
                    builder: (_) => SizedBox(
                      width: widget.sideSupportingPaneWidth,
                      child: widget.verticalSupportingPane,
                    ),
                  )
                },
              )
            : null,
        secondaryNavigation: supportingPaneSide == TextDirection.ltr
            ? SlotLayout(
                config: <Breakpoint, SlotLayoutConfig>{
                  Breakpoints.standard: SlotLayout.from(
                    key: const Key('Supporting Pane Right'),
                    builder: null,
                  ),
                  SupportingPaneLayout.sidePaneBreakpoint: SlotLayout.from(
                    key: const Key('Supporting Pane Right Large'),
                    builder: (_) => SizedBox(
                      width: widget.sideSupportingPaneWidth,
                      child: widget.verticalSupportingPane,
                    ),
                  )
                },
              )
            : null,
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.standard: SlotLayout.from(
              key: const Key('Focus Pane'),
              builder: (_) => widget.focusPane,
            )
          },
        ),
        secondaryBody: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.standard: SlotLayout.from(
              key: const Key('Supporting Pane'),
              builder: null,
            ),
            SupportingPaneLayout.bottomPaneBreakpoint: SlotLayout.from(
              key: const Key('Supporting Pane Medium'),
              builder: (_) => widget.horizontalSupportingPane,
            )
          },
        ),
        bodyRatio: 1 - widget.bottomSupportingPaneRatio,
        transitionDuration: widget.transitionDuration,
        internalAnimations: widget.internalAnimations,
        bodyOrientation:
            SupportingPaneLayout.bottomPaneBreakpoint.isActive(context)
                ? Axis.vertical
                : Axis.horizontal,
      ),
      primary: false,
    );
  }
}
