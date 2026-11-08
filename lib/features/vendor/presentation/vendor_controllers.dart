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
