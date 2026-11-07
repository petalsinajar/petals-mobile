import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Fraunces (a warm, characterful serif) for display and headlines,
/// Plus Jakarta Sans for everything people read and tap.
abstract final class AppTypography {
  static TextTheme textTheme(TextTheme base, {required bool googleFonts}) {
    final tuned = base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -1,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      displaySmall: base.displaySmall?.copyWith(fontWeight: FontWeight.w600),
      headlineLarge: base.headlineLarge?.copyWith(fontWeight: FontWeight.w600),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
      titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      titleSmall: base.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      labelMedium: base.labelMedium?.copyWith(fontWeight: FontWeight.w600),
    );
    // Tests and offline builds skip runtime font fetching.
    if (!googleFonts) return tuned;

    final sans = GoogleFonts.plusJakartaSansTextTheme(tuned);
    TextStyle? serif(TextStyle? style) =>
        GoogleFonts.fraunces(textStyle: style);
    return sans.copyWith(
      displayLarge: serif(sans.displayLarge),
      displayMedium: serif(sans.displayMedium),
      displaySmall: serif(sans.displaySmall),
      headlineLarge: serif(sans.headlineLarge),
      headlineMedium: serif(sans.headlineMedium),
      headlineSmall: serif(sans.headlineSmall),
    );
  }
}
