import 'package:flutter/material.dart';

/// Canonical feed layout
///
/// https://m3.material.io/foundations/layout/canonical-layouts/feed
class FeedLayout {
  /// The box constraints for feed layout
  ///
  /// Place the [ListView] or [GridView] of the feed layout inside a [ConstrainedBox]
  /// using [boxConstraints].
  ///
  /// https://docs.flutter.dev/ui/adaptive-responsive/large-screens#other-solutions
  static const boxConstraints = BoxConstraints(maxWidth: 840);
}
