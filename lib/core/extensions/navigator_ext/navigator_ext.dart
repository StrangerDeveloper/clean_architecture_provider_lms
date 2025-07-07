import 'package:flutter/material.dart';

/// Extension on BuildContext to provide easy access to the NavigatorState.
extension NavigatorExt on BuildContext {
  /// Retrieves the NavigatorState associated with the current BuildContext.
  ///
  /// This extension property allows for a more concise way to access the
  /// NavigatorState, which is useful for performing navigation operations.
  ///
  /// Example usage:
  /// ```dart
  /// context.navigator.pushNamed('/nextPage');
  /// ```
  NavigatorState get navigator => Navigator.of(this);
}
