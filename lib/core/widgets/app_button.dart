import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/core/widgets/press_scale.dart';

enum AppButtonVariant { primary, secondary, outline, ghost }

enum AppButtonSize {
  small(AppSizes.buttonSm, AppSpacing.lg, AppSizes.iconSm),
  medium(AppSizes.buttonMd, AppSpacing.xl, 20),
  large(AppSizes.buttonLg, AppSpacing.xxl, AppSizes.iconMd)
  ;

  const AppButtonSize(this.height, this.horizontalPadding, this.iconSize);

  final double height;
  final double horizontalPadding;
  final double iconSize;
}

/// The app's button. Pill-shaped, springy on press, and keeps its width
/// while [isLoading] shows a spinner.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.expand = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;

  /// Stretch to the available width.
  final bool expand;

  bool get _enabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(0, size.height)),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: size.horizontalPadding),
      ),
      iconSize: WidgetStatePropertyAll(size.iconSize),
    );
    final callback = _enabled ? onPressed : null;
    final child = _ButtonContent(
      label: label,
      icon: icon,
      isLoading: isLoading,
      spinnerSize: size.iconSize,
    );

    final button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: callback,
        style: style,
        child: child,
      ),
      AppButtonVariant.secondary => FilledButton.tonal(
        onPressed: callback,
        style: style,
        child: child,
      ),
      AppButtonVariant.outline => OutlinedButton(
        onPressed: callback,
        style: style,
        child: child,
      ),
      AppButtonVariant.ghost => TextButton(
        onPressed: callback,
        style: style,
        child: child,
      ),
    };

    return Semantics(
      label: isLoading ? '$label, loading' : null,
      child: PressScale(
        enabled: _enabled,
        child: expand
            ? SizedBox(width: double.infinity, child: button)
            : button,
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.icon,
    required this.isLoading,
    required this.spinnerSize,
  });

  final String label;
  final IconData? icon;
  final bool isLoading;
  final double spinnerSize;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon), const SizedBox(width: AppSpacing.sm)],
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
    if (!isLoading) return content;

    // Keep the label in the layout (invisible) so the width doesn't jump.
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(opacity: 0, child: content),
        SizedBox.square(
          dimension: spinnerSize,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: DefaultTextStyle.of(context).style.color,
          ),
        ),
      ],
    );
  }
}
