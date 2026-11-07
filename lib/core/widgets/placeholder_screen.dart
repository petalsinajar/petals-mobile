import 'package:flutter/material.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';

/// Temporary screen for tabs whose feature hasn't been built yet.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    required this.title,
    required this.headline,
    required this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String headline;
  final String message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: EmptyState(
        title: headline,
        message: message,
        icon: icon,
        actionLabel: actionLabel,
        onAction: onAction,
      ),
    );
  }
}
