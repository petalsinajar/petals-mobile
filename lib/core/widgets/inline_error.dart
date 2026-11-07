import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';

/// A one-line [ErrorState] for sections inside a scrolling page, where a
/// full-screen error would be too much (and can't size itself).
class InlineError extends StatelessWidget {
  const InlineError({required this.error, this.onRetry, super.key});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final (icon, title, _) = ErrorState.describe(error);
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: AppSizes.iconSm, color: colors.error),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(title, style: context.textTheme.bodyMedium)),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
