import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

/// A point to search around.
typedef LatLng = ({double lat, double lng});

/// Everything the Discover tab reads. Lists that take `near` only return
/// vendors whose service area covers it.
abstract interface class DiscoverRepository {
  /// Top-level categories, in the catalog's order.
  Future<List<CatalogCategory>> categories();

  /// The most engaging public looks.
  Future<List<LookPost>> trendingLooks({EventType? eventType});

  Future<LookPost> look(String postId);

  /// Vendors serving [near] (nearest first), or matching [query].
  Future<List<VendorCard>> vendors({
    LatLng? near,
    String? query,
    String? categoryId,
    EventType? eventType,
  });

  Future<VendorCard> vendor(String vendorId);

  Future<List<PackageCard>> packagesNear(
    LatLng near, {
    EventType? eventType,
  });

  Future<List<PackageCard>> vendorPackages(String vendorId);

  Future<Paginated<ItemCard>> items({
    LatLng? near,
    String? query,
    String? categoryId,
    String? vendorId,
    EventType? eventType,
    String? cursor,
  });

  Future<ItemCard> item(String itemId);

  /// The viewer's upcoming events, soonest first. Signed in only.
  Future<List<UpcomingEvent>> upcomingEvents();

  /// Categories [eventId] still needs, with vendors free on its dates.
  /// Hosts only.
  Future<List<EventNeed>> needs(String eventId);

  /// Upcoming events by title: public ones and the viewer's own.
  Future<List<UpcomingEvent>> searchEvents(String query);

  /// Follows or unfollows a vendor; returns the new follower count.
  Future<int> setFollowing(String vendorId, {required bool following});
}

/// The phone's location, behind a seam so tests needn't touch the plugin.
abstract interface class DeviceLocator {
  /// Whether the user already let the app use location.
  Future<bool> hasPermission();

  /// Asks for permission if needed; null when refused or unavailable.
  Future<LatLng?> locate();
}
