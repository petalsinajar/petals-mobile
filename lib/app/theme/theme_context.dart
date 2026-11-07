import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_palette.dart';

/// Short-hands for reading the design system from widgets.
extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;

  /// True when the user asked the OS to reduce motion (and in tests that
  /// set `MediaQueryData.disableAnimations`).
  bool get reduceMotion => MediaQuery.maybeDisableAnimationsOf(this) ?? false;
}
