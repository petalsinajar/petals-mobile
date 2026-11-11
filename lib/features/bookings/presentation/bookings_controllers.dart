import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/bookings/data/bookings_repository_impl.dart';
import 'package:petalsinajar/features/bookings/domain/booking.dart';
import 'package:petalsinajar/features/bookings/domain/bookings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookings_controllers.g.dart';

/// "My bookings", newest first, with load more.
@riverpod
class MyBookings extends _$MyBookings {
  var _loadingMore = false;

  @override
  Future<Paginated<CustomerBooking>> build() {
    ref.watch(viewerIdProvider);
    return ref.watch(bookingsRepositoryProvider).mine();
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || _loadingMore) return;
    _loadingMore = true;
    try {
      final next = await ref
          .read(bookingsRepositoryProvider)
          .mine(cursor: current.nextCursor);
      if (ref.mounted) state = AsyncData(current.append(next));
    } finally {
      _loadingMore = false;
    }
  }
}

/// One booking with its timeline.
@riverpod
class BookingDetail extends _$BookingDetail {
  @override
  Future<CustomerBooking> build(String bookingId) =>
      ref.watch(bookingsRepositoryProvider).booking(bookingId);

  Future<void> cancel({String? reason}) async {
    await ref
        .read(bookingsRepositoryProvider)
        .cancel(bookingId, reason: reason);
    if (!ref.mounted) return;
    // The cancel response has no timeline; re-read for the full picture.
    ref
      ..invalidateSelf()
      ..invalidate(myBookingsProvider);
  }
}

/// Sends booking requests and keeps "My bookings" current.
///
/// Kept alive: the request sheet only reads it, so an auto-disposed one
/// would be gone by the time the server answers.
@Riverpod(keepAlive: true)
class BookingRequester extends _$BookingRequester {
  @override
  void build() {}

  Future<CustomerBooking> send(BookingRequest request) async {
    final booking = await ref.read(bookingsRepositoryProvider).request(request);
    ref.invalidate(myBookingsProvider);
    return booking;
  }
}

/// How many of a variant are free on [day], and whether it's closed.
@riverpod
Future<Availability> variantAvailability(
  Ref ref,
  String itemId,
  String variantId,
  DateTime day,
) => ref
    .watch(bookingsRepositoryProvider)
    .available(itemId: itemId, variantId: variantId, from: day, to: day);
