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

  /// Records a booking made outside the app and adds it to Upcoming.
  /// Throws without changes if the server refuses (e.g. dates taken).
  Future<VendorBooking> record(RecordedBooking booking) async {
    final saved = await ref
        .read(vendorRepositoryProvider)
        .recordBooking(vendorId, booking);
    final current = state.value;
    if (ref.mounted && current != null) {
      state = AsyncData((
        needsAnswer: current.needsAnswer,
        upcoming: [...current.upcoming, saved]
          ..sort((a, b) => a.startsAt.compareTo(b.startsAt)),
      ));
    }
    return saved;
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

/// The Today tab: jobs going out or coming back today and tomorrow, and
/// returns that are late.
typedef TodayView = ({
  List<VendorBooking> overdue,
  List<VendorBooking> today,
  List<VendorBooking> tomorrow,
});

/// Statuses with work left to do on the day.
const List<VendorBookingStatus> _activeStatuses = [
  VendorBookingStatus.confirmed,
  VendorBookingStatus.outForDelivery,
  VendorBookingStatus.delivered,
];

@riverpod
class VendorToday extends _$VendorToday {
  @override
  Future<TodayView> build(String vendorId, DateTime day) async {
    final start = DateTime(day.year, day.month, day.day);
    final after = start.add(const Duration(days: 2));
    // Back a fortnight, to catch returns that are late.
    final bookings = await ref
        .watch(vendorRepositoryProvider)
        .bookings(
          vendorId,
          statuses: _activeStatuses,
          from: start.subtract(const Duration(days: 14)),
          to: after,
        );
    return group(bookings, start);
  }

  /// Sorts [bookings] into the tab's sections, each by the time of its job.
  static TodayView group(List<VendorBooking> bookings, DateTime start) {
    final tomorrow = start.add(const Duration(days: 1));
    final after = start.add(const Duration(days: 2));
    bool within(DateTime t, DateTime from, DateTime to) =>
        !t.isBefore(from) && t.isBefore(to);

    // The job's time on a day: going out if not out yet, else coming back.
    DateTime? jobOn(VendorBooking b, DateTime from, DateTime to) {
      final out = b.status == VendorBookingStatus.confirmed;
      if (out && within(b.startsAt, from, to)) return b.startsAt;
      if (!out && within(b.endsAt, from, to)) return b.endsAt;
      // Out and back the same day, still to go out: one job.
      return null;
    }

    final overdue = <VendorBooking>[];
    final today = <(DateTime, VendorBooking)>[];
    final tmrw = <(DateTime, VendorBooking)>[];
    for (final b in bookings) {
      final late = b.status == VendorBookingStatus.confirmed
          ? b.startsAt.isBefore(start)
          : b.endsAt.isBefore(start);
      if (late) {
        overdue.add(b);
      } else if (jobOn(b, start, tomorrow) case final at?) {
        today.add((at, b));
      } else if (jobOn(b, tomorrow, after) case final at?) {
        tmrw.add((at, b));
      }
    }
    List<VendorBooking> byTime(List<(DateTime, VendorBooking)> jobs) => [
      for (final (_, b) in jobs..sort((x, y) => x.$1.compareTo(y.$1))) b,
    ];
    return (
      overdue: overdue..sort((a, b) => a.endsAt.compareTo(b.endsAt)),
      today: byTime(today),
      tomorrow: byTime(tmrw),
    );
  }

  Future<void> refresh() async {
    final fresh = await build(vendorId, day);
    if (ref.mounted) state = AsyncData(fresh);
  }

  /// Marks [step] and regroups with the updated booking. Throws without
  /// changes if the server refuses (e.g. it was cancelled meanwhile).
  Future<VendorBooking> advance(String bookingId, BookingStep step) async {
    final updated = await ref
        .read(vendorRepositoryProvider)
        .advance(bookingId, step);
    final current = state.value;
    if (ref.mounted && current != null) {
      final all = [
        for (final b in [
          ...current.overdue,
          ...current.today,
          ...current.tomorrow,
        ])
          if (b.id == bookingId) updated else b,
      ];
      state = AsyncData(
        group(
          [
            for (final b in all)
              if (_activeStatuses.contains(b.status)) b,
          ],
          DateTime(day.year, day.month, day.day),
        ),
      );
    }
    return updated;
  }
}

/// One month on the Calendar tab: bookings out during it and blocked days.
typedef CalendarMonth = ({
  List<VendorBooking> bookings,
  List<Blackout> blackouts,
});

@riverpod
class VendorCalendar extends _$VendorCalendar {
  @override
  Future<CalendarMonth> build(String vendorId, DateTime month) async {
    final repo = ref.watch(vendorRepositoryProvider);
    final first = DateTime(month.year, month.month);
    final next = DateTime(month.year, month.month + 1);
    final (bookings, blackouts) = await (
      repo.bookings(
        vendorId,
        statuses: CalendarStatuses.all,
        from: first,
        to: next,
      ),
      repo.blackouts(
        vendorId,
        from: first,
        to: next.subtract(const Duration(days: 1)),
      ),
    ).wait;
    return (bookings: bookings, blackouts: blackouts);
  }

  /// Blocks [from]–[to]; every month it touches reloads.
  Future<void> block(DateTime from, DateTime to, {String? reason}) async {
    await ref
        .read(vendorRepositoryProvider)
        .addBlackout(vendorId, from: from, to: to, reason: reason);
    _reloadMonths(from, to);
  }

  Future<void> unblock(Blackout blackout) async {
    await ref
        .read(vendorRepositoryProvider)
        .removeBlackout(vendorId, blackout.id);
    _reloadMonths(blackout.startsOn, blackout.endsOn);
  }

  void _reloadMonths(DateTime from, DateTime to) {
    for (
      var m = DateTime(from.year, from.month);
      !m.isAfter(to);
      m = DateTime(m.year, m.month + 1)
    ) {
      // Riverpod won't let a provider invalidate itself by name.
      if (m == month) {
        ref.invalidateSelf();
      } else {
        ref.invalidate(vendorCalendarProvider(vendorId, m));
      }
    }
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
    final saved = await ref.read(vendorRepositoryProvider).setItemPhotos(
      vendorId,
      itemId,
      [for (final m in media) m.id],
    );
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
