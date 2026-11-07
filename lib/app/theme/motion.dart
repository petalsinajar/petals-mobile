import 'package:flutter/animation.dart';

/// Motion tokens. Motion is part of the brand: quick, springy, never sluggish.
abstract final class AppMotion {
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration medium = Duration(milliseconds: 280);
  static const Duration slow = Duration(milliseconds: 420);
  static const Duration celebrate = Duration(milliseconds: 900);
  static const Duration shimmer = Duration(milliseconds: 1400);

  /// Delay between consecutive items of a staggered list entrance.
  static const Duration stagger = Duration(milliseconds: 55);

  /// Items beyond this index enter together, so long lists don't crawl in.
  static const int maxStaggeredItems = 8;

  /// Default for most transitions.
  static const Curve standard = Curves.easeOutCubic;

  /// Material 3 "emphasized" — for entrances and hero-ish moves.
  static const Curve emphasized = Cubic(0.2, 0, 0, 1);

  /// Spring-like overshoot for taps, likes and pops.
  static const Curve spring = Curves.easeOutBack;

  /// Bigger overshoot for celebratory moments (heart burst, success badges).
  static const Curve bouncy = ElasticOutCurve(0.7);

  /// Fraction of its height a list item slides up while fading in.
  static const double entranceOffset = 0.08;

  /// Scale applied to buttons/cards while pressed.
  static const double pressedScale = 0.96;
}
