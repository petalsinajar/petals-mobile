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

  Future<BusinessProfile> business(String vendorId);

  /// Saves [changes] (API field names, only what changed). Owners and
  /// managers only; returns the saved profile.
  Future<BusinessProfile> updateBusiness(
    String vendorId,
    Map<String, Object?> changes,
  );

  /// Every item the business has, by title (archived ones included).
  Future<List<VendorItem>> items(String vendorId);

  /// Replaces only the item's photos, as uploaded media ids in display
  /// order (the first is the cover). Owners and managers only.
  Future<VendorItem> setItemPhotos(
    String vendorId,
    String itemId,
    List<String> mediaIds,
  );

  /// Owners and managers only. [reason] is shown to the customer.
  Future<VendorBooking> decline(String bookingId, {String? reason});
}
