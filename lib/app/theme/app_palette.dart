import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_colors.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

/// A bold accent with readable foregrounds, e.g. for an event-type chip.
@immutable
class Accent {
  const Accent({
    required this.color,
    required this.onColor,
    required this.container,
    required this.onContainer,
  });

  /// Derives a tinted container from [color] over [surface].
  factory Accent.of(Color color, {required Color surface, required Color on}) {
    return Accent(
      color: color,
      onColor: on,
      container: Color.alphaBlend(color.withValues(alpha: 0.16), surface),
      onContainer: color,
    );
  }

  final Color color;
  final Color onColor;
  final Color container;
  final Color onContainer;

  Accent lerp(Accent other, double t) => Accent(
    color: Color.lerp(color, other.color, t)!,
    onColor: Color.lerp(onColor, other.onColor, t)!,
    container: Color.lerp(container, other.container, t)!,
    onContainer: Color.lerp(onContainer, other.onContainer, t)!,
  );
}

/// App-specific colors that Material's [ColorScheme] has no slot for.
/// Read with `context.palette`.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.wedding,
    required this.birthday,
    required this.corporate,
    required this.vendor,
    required this.like,
    required this.success,
    required this.warning,
    required this.skeletonBase,
    required this.skeletonHighlight,
    required this.celebration,
  });

  factory AppPalette.light() {
    const surface = AppColors.cream;
    const on = AppColors.white;
    return AppPalette(
      wedding: Accent.of(AppColors.wedding, surface: surface, on: on),
      birthday: Accent.of(AppColors.birthday, surface: surface, on: on),
      corporate: Accent.of(AppColors.corporate, surface: surface, on: on),
      vendor: Accent.of(AppColors.vendor, surface: surface, on: on),
      like: AppColors.like,
      success: AppColors.success,
      warning: AppColors.warning,
      skeletonBase: AppColors.creamHigh,
      skeletonHighlight: AppColors.creamLow,
      celebration: const [
        AppColors.hibiscus,
        AppColors.marigold,
        AppColors.kenteGreen,
        AppColors.corporate,
        AppColors.weddingLight,
      ],
    );
  }

  factory AppPalette.dark() {
    const surface = AppColors.night;
    const on = AppColors.ink;
    return AppPalette(
      wedding: Accent.of(AppColors.weddingLight, surface: surface, on: on),
      birthday: Accent.of(AppColors.birthdayLight, surface: surface, on: on),
      corporate: Accent.of(AppColors.corporateLight, surface: surface, on: on),
      vendor: Accent.of(AppColors.vendorLight, surface: surface, on: on),
      like: AppColors.like,
      success: AppColors.successLight,
      warning: AppColors.warningLight,
      skeletonBase: AppColors.nightHigh,
      skeletonHighlight: AppColors.nightHighest,
      celebration: const [
        AppColors.hibiscusLight,
        AppColors.marigoldLight,
        AppColors.kenteGreenLight,
        AppColors.corporateLight,
        AppColors.weddingLight,
      ],
    );
  }

  final Accent wedding;
  final Accent birthday;
  final Accent corporate;
  final Accent vendor;
  final Color like;
  final Color success;
  final Color warning;
  final Color skeletonBase;
  final Color skeletonHighlight;

  /// Confetti and other celebratory moments.
  final List<Color> celebration;

  Accent accentFor(EventType type) => switch (type) {
    EventType.wedding => wedding,
    EventType.birthday => birthday,
    EventType.corporate => corporate,
  };

  @override
  AppPalette copyWith({
    Accent? wedding,
    Accent? birthday,
    Accent? corporate,
    Accent? vendor,
    Color? like,
    Color? success,
    Color? warning,
    Color? skeletonBase,
    Color? skeletonHighlight,
    List<Color>? celebration,
  }) => AppPalette(
    wedding: wedding ?? this.wedding,
    birthday: birthday ?? this.birthday,
    corporate: corporate ?? this.corporate,
    vendor: vendor ?? this.vendor,
    like: like ?? this.like,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    skeletonBase: skeletonBase ?? this.skeletonBase,
    skeletonHighlight: skeletonHighlight ?? this.skeletonHighlight,
    celebration: celebration ?? this.celebration,
  );

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      wedding: wedding.lerp(other.wedding, t),
      birthday: birthday.lerp(other.birthday, t),
      corporate: corporate.lerp(other.corporate, t),
      vendor: vendor.lerp(other.vendor, t),
      like: Color.lerp(like, other.like, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      skeletonBase: Color.lerp(skeletonBase, other.skeletonBase, t)!,
      skeletonHighlight: Color.lerp(
        skeletonHighlight,
        other.skeletonHighlight,
        t,
      )!,
      celebration: t < 0.5 ? celebration : other.celebration,
    );
  }
}
