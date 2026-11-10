import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/media_uploader.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:petalsinajar/features/vendor/data/vendor_repository_impl.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vendor_controllers.g.dart';

/// Categories to choose from when starting a business.
@riverpod
Future<List<BusinessCategory>> businessCategories(Ref ref) =>
    ref.watch(vendorRepositoryProvider).categories();

/// The Requests tab: what needs an answer, and what's coming up.
typedef VendorRequestsView = ({
  List<VendorBooking> needsAnswer,
  List<VendorBooking> upcoming,
});

@riverpod
class VendorRequests extends _$VendorRequests {
  @override
  Future<VendorRequestsView> build(String vendorId) async {
    final repo = ref.watch(vendorRepositoryProvider);
    final [needsAnswer, upcoming] = await Future.wait<List<VendorBooking>>([
      repo.bookings(vendorId, statuses: RequestStatuses.needsAnswer),
      repo.bookings(vendorId, statuses: RequestStatuses.upcoming),
    ]);
    return (needsAnswer: needsAnswer, upcoming: upcoming);
  }

  /// Reloads, keeping the current lists on screen meanwhile.
  Future<void> refresh() async {
    final fresh = await build(vendorId);
    if (ref.mounted) state = AsyncData(fresh);
  }

  /// Accepts and moves the booking to Upcoming. Throws without changes if
  /// the server refuses (e.g. it expired meanwhile).
  Future<void> accept(String bookingId) async {
    final accepted = await ref.read(vendorRepositoryProvider).accept(bookingId);
    final current = state.value;
    if (!ref.mounted || current == null) return;
    state = AsyncData((
      needsAnswer: [
        for (final b in current.needsAnswer)
          if (b.id != bookingId) b,
      ],
      upcoming: [...current.upcoming, accepted]
        ..sort((a, b) => a.startsAt.compareTo(b.startsAt)),
    ));
  }

  /// Declines and drops the booking from the list. Throws without changes
  /// if the server refuses.
  Future<void> decline(String bookingId, {String? reason}) async {
    await ref.read(vendorRepositoryProvider).decline(bookingId, reason: reason);
    final current = state.value;
    if (!ref.mounted || current == null) return;
    state = AsyncData((
      needsAnswer: [
        for (final b in current.needsAnswer)
          if (b.id != bookingId) b,
      ],
      upcoming: current.upcoming,
    ));
  }
}

/// The Inventory tab's list. Only photos are changed here; everything else
/// is edited on the web dashboard.
@riverpod
class VendorInventory extends _$VendorInventory {
  @override
  Future<List<VendorItem>> build(String vendorId) =>
      ref.watch(vendorRepositoryProvider).items(vendorId);

  /// Saves [media] as the item's photos and swaps in the saved item.
  Future<void> setPhotos(String itemId, List<Media> media) async {
    final saved = await ref
        .read(vendorRepositoryProvider)
        .setItemPhotos(vendorId, itemId, [for (final m in media) m.id]);
    final current = state.value;
    if (!ref.mounted || current == null) return;
    state = AsyncData([
      for (final i in current) i.id == itemId ? saved : i,
    ]);
  }

  /// Uploads [path] and adds it, as the cover when [asCover].
  Future<void> addPhoto(
    String itemId,
    String path, {
    bool asCover = false,
  }) async {
    final item = state.value?.where((i) => i.id == itemId).firstOrNull;
    if (item == null) return;
    final photo = await ref
        .read(mediaUploaderProvider)
        .upload(path, purpose: MediaPurpose.item, vendorId: vendorId);
    await setPhotos(
      itemId,
      asCover ? [photo, ...item.media] : [...item.media, photo],
    );
  }
}

/// The Business tab: the profile, with saving and a quick logo change.
@riverpod
class Business extends _$Business {
  @override
  Future<BusinessProfile> build(String vendorId) =>
      ref.watch(vendorRepositoryProvider).business(vendorId);

  /// Uploads any new [logoPath] / [coverPath] first, then saves. The session
  /// and vendor mode pick up a new name or logo too.
  Future<void> save(
    Map<String, Object?> changes, {
    String? logoPath,
    String? coverPath,
  }) async {
    final repo = ref.read(vendorRepositoryProvider);
    final uploader = ref.read(mediaUploaderProvider);
    Future<String> upload(String path, MediaPurpose purpose) async =>
        (await uploader.upload(path, purpose: purpose, vendorId: vendorId)).id;
    final patch = {
      ...changes,
      if (logoPath != null)
        'logo_media_id': await upload(logoPath, MediaPurpose.avatar),
      if (coverPath != null)
        'cover_media_id': await upload(coverPath, MediaPurpose.cover),
    };
    if (patch.isEmpty) return;
    final saved = await repo.updateBusiness(vendorId, patch);
    if (!ref.mounted) return;
    state = AsyncData(saved);

    // Me.vendors (switcher, posting-as) and the vendor-mode name.
    await ref.read(authSessionProvider.notifier).refresh();
    final actor = ref.read(activeActorProvider);
    if (actor is VendorActor && actor.vendorId == vendorId) {
      ref
          .read(activeActorProvider.notifier)
          .actAsVendor(
            vendorId: vendorId,
            name: saved.name,
            logoUrl: saved.logoUrl,
          );
    }
  }
}
