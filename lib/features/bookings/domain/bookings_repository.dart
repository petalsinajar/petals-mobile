import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/bookings/domain/booking.dart';

abstract interface class BookingsRepository {
  /// Sends [request] to the vendor; returns the new booking
  /// (`pendingVendor`). Hosts only.
  Future<CustomerBooking> request(BookingRequest request);

  /// The viewer's bookings, newest first.
  Future<Paginated<CustomerBooking>> mine({String? cursor});

  /// With its timeline.
  Future<CustomerBooking> booking(String id);

  Future<CustomerBooking> cancel(String id, {String? reason});

  /// How many of a variant are still free on every day from [from] to
  /// [to] (inclusive).
  Future<int> available({
    required String itemId,
    required String variantId,
    required DateTime from,
    required DateTime to,
  });
}
