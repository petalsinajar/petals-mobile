import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_colors.dart';
import 'package:petalsinajar/app/theme/app_palette.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/app_typography.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

/// The light and dark [ThemeData] pair.
@immutable
class AppThemes {
  const AppThemes({required this.light, required this.dark});

  /// [googleFonts] is `false` in tests, where fonts can't be fetched.
  factory AppThemes.build({bool googleFonts = true}) => AppThemes(
    light: _theme(_lightScheme, AppPalette.light(), googleFonts: googleFonts),
    dark: _theme(_darkScheme, AppPalette.dark(), googleFonts: googleFonts),
  );

  final ThemeData light;
  final ThemeData dark;
}

@Riverpod(keepAlive: true)
AppThemes appThemes(Ref ref) => AppThemes.build();

final ColorScheme _lightScheme =
    ColorScheme.fromSeed(
      seedColor: AppColors.hibiscus,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
    ).copyWith(
      primary: AppColors.hibiscus,
      onPrimary: AppColors.white,
      secondary: AppColors.marigold,
      onSecondary: AppColors.ink,
      tertiary: AppColors.kenteGreen,
      onTertiary: AppColors.white,
      surface: AppColors.cream,
      onSurface: AppColors.ink,
      onSurfaceVariant: AppColors.cocoa,
      surfaceContainerLowest: AppColors.white,
      surfaceContainerLow: AppColors.creamLow,
      surfaceContainer: AppColors.creamMid,
      surfaceContainerHigh: AppColors.creamHigh,
      surfaceContainerHighest: AppColors.creamHighest,
      outlineVariant: AppColors.creamHighest,
    );

final ColorScheme _darkScheme =
    ColorScheme.fromSeed(
      seedColor: AppColors.hibiscus,
      brightness: Brightness.dark,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
    ).copyWith(
      primary: AppColors.hibiscusLight,
      onPrimary: AppColors.onHibiscusDark,
      secondary: AppColors.marigoldLight,
      onSecondary: AppColors.ink,
      tertiary: AppColors.kenteGreenLight,
      onTertiary: AppColors.ink,
      surface: AppColors.night,
      onSurface: AppColors.cream,
      onSurfaceVariant: AppColors.mist,
      surfaceContainerLowest: AppColors.night,
      surfaceContainerLow: AppColors.nightLow,
      surfaceContainer: AppColors.nightMid,
      surfaceContainerHigh: AppColors.nightHigh,
      surfaceContainerHighest: AppColors.nightHighest,
      outlineVariant: AppColors.nightHighest,
    );

ThemeData _theme(
  ColorScheme scheme,
  AppPalette palette, {
  required bool googleFonts,
}) {
  final base = ThemeData(colorScheme: scheme);
  final text = AppTypography.textTheme(
    base.textTheme,
    googleFonts: googleFonts,
  ).apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

  const stadium = StadiumBorder();
  ButtonStyle buttonStyle() => ButtonStyle(
    minimumSize: const WidgetStatePropertyAll(Size(0, AppSizes.buttonMd)),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: AppSpacing.xl),
    ),
    shape: const WidgetStatePropertyAll(stadium),
    textStyle: WidgetStatePropertyAll(text.labelLarge),
  );

  return base.copyWith(
    textTheme: text,
    scaffoldBackgroundColor: scheme.surface,
    extensions: [palette],
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: text.titleLarge,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.cardAll),
    ),
    filledButtonTheme: FilledButtonThemeData(style: buttonStyle()),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: buttonStyle().copyWith(
        side: WidgetStatePropertyAll(BorderSide(color: scheme.outline)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(style: buttonStyle()),
    chipTheme: ChipThemeData(
      shape: stadium,
      side: BorderSide.none,
      backgroundColor: scheme.surfaceContainerHigh,
      labelStyle: text.labelLarge,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerHigh,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      border: const OutlineInputBorder(
        borderRadius: AppRadii.lgAll,
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadii.lgAll,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadii.lgAll,
        borderSide: BorderSide(color: scheme.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadii.lgAll,
        borderSide: BorderSide(color: scheme.error, width: 1.5),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: AppSizes.navigationBar,
      elevation: 0,
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: scheme.primaryContainer,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: WidgetStatePropertyAll(text.labelSmall),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.xlTop),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
    ),
    dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1),
  );
}
