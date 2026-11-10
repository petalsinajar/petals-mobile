import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';

/// What a card hands its detail screen: what it already knows (shown at
/// once, then refreshed) and its Hero tag, unique per card so the same
/// vendor in two sections doesn't collide.
@immutable
class DetailArgs<T> {
  const DetailArgs({this.initial, this.heroTag});

  final T? initial;
  final String? heroTag;

  /// The args from a route's `extra`, if they're for a [T].
  static DetailArgs<T> of<T>(Object? extra) =>
      extra is DetailArgs<T> ? extra : DetailArgs<T>();
}

extension DiscoverNavigation on BuildContext {
  void openItem(ItemCard item, {String? heroTag}) => push(
    Routes.item(item.id),
    extra: DetailArgs<ItemCard>(initial: item, heroTag: heroTag),
  );

  void openVendor(String vendorId, {VendorCard? initial, String? heroTag}) =>
      push(
        Routes.vendor(vendorId),
        extra: DetailArgs<VendorCard>(initial: initial, heroTag: heroTag),
      );

  void openLook(LookPost look, {String? heroTag}) => push(
    Routes.post(look.id),
    extra: DetailArgs<LookPost>(initial: look, heroTag: heroTag),
  );
}
