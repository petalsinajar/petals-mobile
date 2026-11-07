import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/entrance.dart';

/// Shared layout of empty and error states: centered, width-capped,
/// scrollable on tiny screens, with a gentle entrance.
class StateLayout extends StatelessWidget {
  const StateLayout({
    required this.illustration,
    required this.title,
    this.message,
    this.action,
    super.key,
  });

  final Widget illustration;
  final String title;
  final String? message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSizes.maxContentWidth,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              illustration,
              const SizedBox(height: AppSpacing.lg),
              Text(title, style: text.titleLarge, textAlign: TextAlign.center),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  message!,
                  style: text.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: AppSpacing.xl),
                action!,
              ],
            ],
          ).entrance(),
        ),
      ),
    );
  }
}
