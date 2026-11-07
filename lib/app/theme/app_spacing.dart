import 'package:flutter/widgets.dart';

/// 4-pt spacing scale.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  /// Horizontal padding of screens and full-bleed lists.
  static const double screen = lg;
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screen,
  );
}

/// Corner radii. Cards are generous on purpose — part of the social feel.
abstract final class AppRadii {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double card = 20;
  static const double xl = 28;
  static const double pill = 999;

  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius cardAll = BorderRadius.all(Radius.circular(card));
  static const BorderRadius xlTop = BorderRadius.vertical(
    top: Radius.circular(xl),
  );
}

/// Fixed component sizes.
abstract final class AppSizes {
  static const double avatarXs = 24;
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 56;
  static const double avatarXl = 88;

  static const double iconSm = 16;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double illustration = 160;

  static const double buttonSm = 36;
  static const double buttonMd = 48;
  static const double buttonLg = 56;
  static const double minTouchTarget = 48;
  static const double navigationBar = 68;

  /// Readable width cap for empty/error states on tablets.
  static const double maxContentWidth = 420;
}
