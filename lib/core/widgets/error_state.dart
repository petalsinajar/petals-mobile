import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/state_layout.dart';

/// Friendly error with a retry button. Understands [ApiException] types so
/// "you're offline" reads differently from "our server hiccupped".
class ErrorState extends StatelessWidget {
  const ErrorState({required this.error, this.onRetry, super.key});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final (icon, title, message) = describe(error);
    final colors = context.colors;
    return StateLayout(
      illustration: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.errorContainer,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Icon(
            icon,
            size: AppSizes.iconLg,
            color: colors.onErrorContainer,
          ),
        ),
      ),
      title: title,
      message: message,
      action: onRetry == null
          ? null
          : AppButton(
              label: 'Try again',
              icon: Icons.refresh_rounded,
              variant: AppButtonVariant.secondary,
              onPressed: onRetry,
            ),
    );
  }

  /// Icon, title and message for [error].
  static (IconData, String, String) describe(Object error) {
    if (error is! ApiException) {
      return (
        Icons.sentiment_dissatisfied_rounded,
        'Something went wrong',
        'Please try again.',
      );
    }
    return switch (error.type) {
      ApiErrorType.network => (
        Icons.wifi_off_rounded,
        "You're offline",
        'Check your connection and try again.',
      ),
      ApiErrorType.timeout => (
        Icons.hourglass_bottom_rounded,
        'That took too long',
        'The connection is slow. Try again in a moment.',
      ),
      ApiErrorType.unauthorized => (
        Icons.lock_outline_rounded,
        'Please sign in again',
        'Your session has ended.',
      ),
      ApiErrorType.forbidden => (
        Icons.block_rounded,
        "You can't do that",
        error.message,
      ),
      ApiErrorType.notFound => (
        Icons.search_off_rounded,
        "We couldn't find that",
        'It may have been removed.',
      ),
      ApiErrorType.validation || ApiErrorType.conflict => (
        Icons.error_outline_rounded,
        "Something's not right",
        error.message,
      ),
      ApiErrorType.rateLimited => (
        Icons.speed_rounded,
        'Slow down a little',
        'Too many requests. Try again shortly.',
      ),
      ApiErrorType.server => (
        Icons.cloud_off_rounded,
        'Our side hiccupped',
        "We're on it. Try again in a moment.",
      ),
      ApiErrorType.cancelled || ApiErrorType.unknown => (
        Icons.sentiment_dissatisfied_rounded,
        'Something went wrong',
        'Please try again.',
      ),
    };
  }
}
