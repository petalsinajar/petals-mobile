import 'package:flutter/services.dart';

/// Named haptics so feature code expresses intent, not intensity.
abstract final class Haptics {
  /// Likes, toggles, small confirmations.
  static Future<void> light() => HapticFeedback.lightImpact();

  /// Picking a chip, tab or option.
  static Future<void> selection() => HapticFeedback.selectionClick();

  /// Booking confirmed, event created.
  static Future<void> success() => HapticFeedback.mediumImpact();

  /// Something failed or was rejected.
  static Future<void> warning() => HapticFeedback.heavyImpact();
}
