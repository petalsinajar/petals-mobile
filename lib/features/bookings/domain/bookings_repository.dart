import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/bookings/domain/booking.dart';

/// Free units on the tightest day; `closed` when the vendor blocked a day.
typedef Availability = ({int left, bool closed});

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
  /// [to] (inclusive), and whether the vendor has closed any of those days
  /// to bookings.
  Future<Availability> available({
    required String itemId,
    required String variantId,
    required DateTime from,
    required DateTime to,
  });
}
