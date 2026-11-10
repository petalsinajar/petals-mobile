import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/features/discover/data/discover_repository_impl.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/discover_controllers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_controllers.g.dart';

@riverpod
Future<ItemCard> itemDetail(Ref ref, String itemId) =>
    ref.watch(discoverRepositoryProvider).item(itemId);

@riverpod
Future<LookPost> lookDetail(Ref ref, String postId) =>
    ref.watch(discoverRepositoryProvider).look(postId);

@riverpod
Future<List<PackageCard>> vendorPackages(Ref ref, String vendorId) =>
    ref.watch(discoverRepositoryProvider).vendorPackages(vendorId);

@riverpod
Future<Paginated<ItemCard>> vendorItems(Ref ref, String vendorId) =>
    ref.watch(discoverRepositoryProvider).items(vendorId: vendorId);

/// A vendor's profile, with optimistic follow.
@riverpod
class VendorDetail extends _$VendorDetail {
  @override
  Future<VendorCard> build(String vendorId) {
    ref.watch(viewerIdProvider);
    return ref.watch(discoverRepositoryProvider).vendor(vendorId);
  }

  /// Flips at once; rolls back and rethrows if the server refuses.
  Future<void> toggleFollow() async {
    final before = state.value;
    if (before == null) return;
    final following = !before.isFollowing;
    state = AsyncData(
      before.copyWith(
        isFollowing: following,
        followers: (before.followers + (following ? 1 : -1)).clamp(0, 1 << 31),
      ),
    );
    try {
      final followers = await ref
          .read(discoverRepositoryProvider)
          .setFollowing(vendorId, following: following);
      if (!ref.mounted) return;
      state = AsyncData(state.requireValue.copyWith(followers: followers));
      // Discover's vendor cards show follow state too.
      ref.invalidate(nearbyVendorsProvider);
    } on Object {
      if (ref.mounted) state = AsyncData(before);
      rethrow;
    }
  }
}

// ---- Search ----------------------------------------------------------------

@riverpod
Future<Paginated<ItemCard>> searchItems(
  Ref ref,
  String query,
  String? categoryId,
) => ref
    .watch(discoverRepositoryProvider)
    .items(query: query.isEmpty ? null : query, categoryId: categoryId);

/// By name; within a category, the ones serving the Discover area.
@riverpod
Future<List<VendorCard>> searchVendors(
  Ref ref,
  String query,
  String? categoryId,
) async {
  ref.watch(viewerIdProvider);
  final near = ref.watch(discoverControllerProvider.select((f) => f.near));
  if (query.isEmpty && near == null) return const [];
  return ref
      .watch(discoverRepositoryProvider)
      .vendors(
        query: query.isEmpty ? null : query,
        near: query.isEmpty ? near : null,
        categoryId: categoryId,
      );
}

@riverpod
Future<List<UpcomingEvent>> searchEvents(Ref ref, String query) async {
  if (query.length < 2 || ref.watch(viewerIdProvider) == null) return const [];
  return ref.watch(discoverRepositoryProvider).searchEvents(query);
}

/// The last few searches, newest first, kept on the phone.
@riverpod
class RecentSearches extends _$RecentSearches {
  static const storageKey = 'discover.recent_searches';
  static const _max = 8;

  @override
  List<String> build() =>
      ref.read(sharedPreferencesProvider).getStringList(storageKey) ?? const [];

  Future<void> _save(List<String> searches) async {
    state = searches;
    await ref
        .read(sharedPreferencesProvider)
        .setStringList(storageKey, searches);
  }

  Future<void> add(String query) {
    final q = query.trim();
    if (q.isEmpty) return Future.value();
    final lower = q.toLowerCase();
    return _save(
      [q, ...state.where((s) => s.toLowerCase() != lower)].take(_max).toList(),
    );
  }

  Future<void> remove(String query) => _save([
    for (final s in state)
      if (s != query) s,
  ]);

  Future<void> clear() => _save(const []);
}
