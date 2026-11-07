import 'package:flutter/painting.dart';

/// Raw color tokens. The only place in the app with hex values — feature code
/// reads colors from `Theme.of(context).colorScheme` or `context.palette`.
abstract final class AppColors {
  // Brand: hibiscus (primary), marigold (secondary), kente green (tertiary).
  static const hibiscus = Color(0xFFD63A50);
  static const hibiscusLight = Color(0xFFFF8A98);
  static const onHibiscusDark = Color(0xFF4D0716);
  static const marigold = Color(0xFFF5A623);
  static const marigoldLight = Color(0xFFFFC56B);
  static const kenteGreen = Color(0xFF1F8A70);
  static const kenteGreenLight = Color(0xFF5CC9A7);

  // Warm neutrals.
  static const white = Color(0xFFFFFFFF);
  static const ink = Color(0xFF221A1F);
  static const cocoa = Color(0xFF5E4E54);
  static const mist = Color(0xFFCDBFC4);
  static const cream = Color(0xFFFFF8F3);
  static const creamLow = Color(0xFFFCF1EA);
  static const creamMid = Color(0xFFF7EAE2);
  static const creamHigh = Color(0xFFF2E3DA);
  static const creamHighest = Color(0xFFECDCD2);
  static const night = Color(0xFF16121A);
  static const nightLow = Color(0xFF1E1922);
  static const nightMid = Color(0xFF241E29);
  static const nightHigh = Color(0xFF2D2633);
  static const nightHighest = Color(0xFF372F3D);

  // Event-type accents (bold on light, lifted for dark).
  static const wedding = Color(0xFFB5446E);
  static const weddingLight = Color(0xFFF08BB3);
  static const birthday = Color(0xFFE8771A);
  static const birthdayLight = Color(0xFFFFB066);
  static const corporate = Color(0xFF2F5BEA);
  static const corporateLight = Color(0xFF8AA5FF);

  // Vendor mode.
  static const vendor = Color(0xFF0E7F73);
  static const vendorLight = Color(0xFF4FD1C0);

  // Feedback.
  static const like = Color(0xFFFF3B5C);
  static const success = Color(0xFF1F9D55);
  static const successLight = Color(0xFF5FD38D);
  static const warning = Color(0xFFC98A06);
  static const warningLight = Color(0xFFFFC94D);
}
