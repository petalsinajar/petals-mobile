import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/features/discover/data/device_locator.dart';
import 'package:petalsinajar/features/discover/data/discover_repository_impl.dart';
import 'package:petalsinajar/features/discover/domain/areas.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/domain/discover_repository.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discover_controllers.freezed.dart';
part 'discover_controllers.g.dart';

enum PlaceStatus {
  /// Working out where to look.
  locating,
  ready,

  /// No venue, no permission: the viewer has to choose.
  needsChoice,
}

/// Where Discover is looking and for which kind of event. Every section
/// reloads when either changes.
@freezed
abstract class DiscoverFilter with _$DiscoverFilter {
  const factory DiscoverFilter({
    DiscoverPlace? place,

    /// Null for "All".
    EventType? eventType,
    @Default(PlaceStatus.locating) PlaceStatus status,
  }) = _DiscoverFilter;

  const DiscoverFilter._();

  LatLng? get near => switch (place) {
    final DiscoverPlace p => (lat: p.lat, lng: p.lng),
    null => null,
  };
}

/// The viewer's upcoming events (empty signed out). Kept alive: the
/// Discover controller reads it to find the next venue.
@Riverpod(keepAlive: true)
Future<List<UpcomingEvent>> myUpcomingEvents(Ref ref) async {
  if (ref.watch(viewerIdProvider) == null) return const [];
  return ref.watch(discoverRepositoryProvider).upcomingEvents();
}

@Riverpod(keepAlive: true)
class DiscoverController extends _$DiscoverController {
  /// The area the viewer picked, remembered across launches.
  static const pickedAreaKey = 'discover.picked_area';

  @override
  DiscoverFilter build() {
    unawaited(Future.microtask(_resolve));
    return const DiscoverFilter();
  }

  /// A picked area, else the next hosted event's venue, else the phone's
  /// location if already allowed. Never prompts: asking is the viewer's
  /// tap on "Use my location".
  Future<void> _resolve() async {
    final prefs = ref.read(sharedPreferencesProvider);
    final picked = prefs.getString(pickedAreaKey);
    final area = launchAreas.where((a) => a.name == picked).firstOrNull;
    if (area != null) return _set(placeFromArea(area));

    final venue = await _nextVenue();
    if (venue != null) return _set(venue);

    final locator = ref.read(deviceLocatorProvider);
    if (await locator.hasPermission()) {
      final fix = await locator.locate();
      if (fix != null) return _set(placeFromDevice(fix.lat, fix.lng));
    }
    if (ref.mounted && state.place == null) {
      state = state.copyWith(status: PlaceStatus.needsChoice);
    }
  }

  Future<DiscoverPlace?> _nextVenue() async {
    try {
      final events = await ref.read(myUpcomingEventsProvider.future);
      final next = events
          .where((e) => e.isHost && e.hasVenueLocation)
          .firstOrNull;
      if (next == null) return null;
      return DiscoverPlace(
        label: next.venueName ?? next.venueCity ?? next.title,
        lat: next.lat!,
        lng: next.lng!,
        source: PlaceSource.eventVenue,
      );
    } on Object {
      return null;
    }
  }

  void _set(DiscoverPlace place) {
    if (ref.mounted) {
      state = state.copyWith(place: place, status: PlaceStatus.ready);
    }
  }

  /// Asks for location permission. False when refused or unavailable.
  Future<bool> useMyLocation() async {
    final fix = await ref.read(deviceLocatorProvider).locate();
    if (fix == null) return false;
    await ref.read(sharedPreferencesProvider).remove(pickedAreaKey);
    _set(placeFromDevice(fix.lat, fix.lng));
    return true;
  }

  Future<void> pickArea(Area area) async {
    await ref
        .read(sharedPreferencesProvider)
        .setString(pickedAreaKey, area.name);
    _set(placeFromArea(area));
  }

  void setEventType(EventType? type) {
    if (type != state.eventType) state = state.copyWith(eventType: type);
  }
}

/// What the sections key on, so unrelated state changes don't reload them.
typedef DiscoverQuery = ({LatLng? near, EventType? eventType});

DiscoverQuery _query(Ref ref) => ref.watch(
  discoverControllerProvider.select(
    (f) => (near: f.near, eventType: f.eventType),
  ),
);

/// "For your event": the next event the viewer hosts (of the chosen type)
/// and what it still needs. Null when there's nothing to suggest.
@riverpod
Future<EventPlanGap?> forYourEvent(Ref ref) async {
  final type = _query(ref).eventType;
  final events = await ref.watch(myUpcomingEventsProvider.future);
  final event = events
      .where((e) => e.isHost && (type == null || e.type == type))
      .firstOrNull;
  if (event == null) return null;

  final needs = await ref.watch(discoverRepositoryProvider).needs(event.id);
  final open = needs.where((n) => n.vendors.isNotEmpty).toList();
  return open.isEmpty ? null : EventPlanGap(event: event, needs: open);
}

@riverpod
Future<List<LookPost>> trendingLooks(Ref ref) => ref
    .watch(discoverRepositoryProvider)
    .trendingLooks(eventType: _query(ref).eventType);

@riverpod
Future<List<CatalogCategory>> discoverCategories(Ref ref) =>
    ref.watch(discoverRepositoryProvider).categories();

/// Vendors serving the place, with optimistic follow.
@riverpod
class NearbyVendors extends _$NearbyVendors {
  @override
  Future<List<VendorCard>> build() async {
    ref.watch(viewerIdProvider); // follow state is personal
    final q = _query(ref);
    final near = q.near;
    if (near == null) return const [];
    return ref
        .watch(discoverRepositoryProvider)
        .vendors(near: near, eventType: q.eventType);
  }

  void _update(String vendorId, VendorCard Function(VendorCard) change) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData([
      for (final v in current) v.id == vendorId ? change(v) : v,
    ]);
  }

  /// Flips at once; rolls back and rethrows if the server refuses.
  Future<void> toggleFollow(String vendorId) async {
    final before = state.value?.where((v) => v.id == vendorId).firstOrNull;
    if (before == null) return;
    final following = !before.isFollowing;

    _update(
      vendorId,
      (v) => v.copyWith(
        isFollowing: following,
        followers: (v.followers + (following ? 1 : -1)).clamp(0, 1 << 31),
      ),
    );
    try {
      final followers = await ref
          .read(discoverRepositoryProvider)
          .setFollowing(vendorId, following: following);
      if (ref.mounted) {
        _update(vendorId, (v) => v.copyWith(followers: followers));
      }
    } on Object {
      if (ref.mounted) _update(vendorId, (_) => before);
      rethrow;
    }
  }
}

@riverpod
Future<List<PackageCard>> nearbyPackages(Ref ref) async {
  final q = _query(ref);
  final near = q.near;
  if (near == null) return const [];
  return ref
      .watch(discoverRepositoryProvider)
      .packagesNear(near, eventType: q.eventType);
}

/// Popular items near the place (everywhere without one), with infinite
/// scroll.
@riverpod
class PopularItems extends _$PopularItems {
  var _loadingMore = false;

  /// The filter this list was built for; later pages must match it.
  late DiscoverQuery _built;

  Future<Paginated<ItemCard>> _page(String? cursor) => ref
      .read(discoverRepositoryProvider)
      .items(
        near: _built.near,
        eventType: _built.eventType,
        cursor: cursor,
      );

  @override
  Future<Paginated<ItemCard>> build() {
    _built = _query(ref);
    ref.watch(discoverRepositoryProvider);
    return _page(null);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || _loadingMore) return;
    _loadingMore = true;
    try {
      final next = await _page(current.nextCursor);
      if (ref.mounted) state = AsyncData(current.append(next));
    } finally {
      _loadingMore = false;
    }
  }
}

/// True once every area-dependent section has loaded and come back empty,
/// so the page can say so once instead of showing nothing. Categories
/// don't count: they're the same everywhere.
@riverpod
bool discoverPageEmpty(Ref ref) {
  if (ref.watch(discoverControllerProvider).place == null) return false;
  bool empty<T>(AsyncValue<T> v, bool Function(T) isEmpty) =>
      v.hasValue && !v.isLoading && isEmpty(v.requireValue);

  return empty(ref.watch(forYourEventProvider), (g) => g == null) &&
      empty(ref.watch(trendingLooksProvider), (l) => l.isEmpty) &&
      empty(ref.watch(nearbyVendorsProvider), (l) => l.isEmpty) &&
      empty(ref.watch(nearbyPackagesProvider), (l) => l.isEmpty) &&
      empty(ref.watch(popularItemsProvider), (p) => p.isEmpty);
}
