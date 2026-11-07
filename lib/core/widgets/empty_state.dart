import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petalsinajar/app/config/app_assets.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/state_layout.dart';

/// Playful "nothing here yet" state with a Lottie animation and an optional
/// call to action. Pass [icon] instead of an animation for compact spots.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.title,
    this.message,
    this.animation = AppAssets.balloonsAnimation,
    this.icon,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String? message;
  final String animation;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final fallbackIcon = Icon(
      icon ?? Icons.celebration_rounded,
      size: AppSizes.iconLg * 2,
      color: context.colors.primary,
    );
    return StateLayout(
      illustration: icon != null
          ? fallbackIcon
          : SizedBox.square(
              dimension: AppSizes.illustration,
              child: Lottie.asset(
                animation,
                animate: !context.reduceMotion,
                errorBuilder: (context, _, _) => fallbackIcon,
              ),
            ),
      title: title,
      message: message,
      action: actionLabel != null && onAction != null
          ? AppButton(label: actionLabel!, onPressed: onAction)
          : null,
    );
  }
}
