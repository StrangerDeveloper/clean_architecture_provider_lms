import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    this.message,
  });

  ///
  /// Error message to be displayed
  ///
  final String? message;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
