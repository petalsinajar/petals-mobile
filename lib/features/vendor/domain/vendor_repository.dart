import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';

/// Running a business from the app. Talks to the live API only.
abstract interface class VendorRepository {
  /// Rental categories to pick from when starting a business.
  Future<List<BusinessCategory>> categories();

  /// Whether [handle] is free. People and businesses share one namespace.
  Future<bool> isHandleAvailable(String handle);

  /// Creates the business with the signed-in user as its owner. A taken or
  /// invalid handle is an `ApiException` with a `handle` field error.
  Future<CreatedBusiness> startBusiness(NewBusiness business);

  /// The business's bookings in [statuses], soonest first (every page).
  Future<List<VendorBooking>> bookings(
    String vendorId, {
    required List<VendorBookingStatus> statuses,
  });

  /// Owners and managers only.
  Future<VendorBooking> accept(String bookingId);

  /// Owners and managers only. [reason] is shown to the customer.
  Future<VendorBooking> decline(String bookingId, {String? reason});
}
