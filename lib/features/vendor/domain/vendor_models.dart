import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_models.freezed.dart';

/// Where a booking is in its life (`BookingStatus` on the backend).
enum VendorBookingStatus {
  pendingVendor,
  accepted,
  confirmed,
  outForDelivery,
  delivered,
  returned,
  completed,
  declined,
  expired,
  cancelled,
  disputed,
}

/// The statuses on the Requests tab, by section.
abstract final class RequestStatuses {
  /// Waiting for the vendor to accept or decline.
  static const List<VendorBookingStatus> needsAnswer = [
    VendorBookingStatus.pendingVendor,
  ];

  /// Agreed and still to happen.
  static const List<VendorBookingStatus> upcoming = [
    VendorBookingStatus.accepted,
    VendorBookingStatus.confirmed,
    VendorBookingStatus.outForDelivery,
    VendorBookingStatus.delivered,
  ];
}

@freezed
abstract class VendorBookingLine with _$VendorBookingLine {
  const factory VendorBookingLine({required String title, required int qty}) =
      _VendorBookingLine;
}

/// A booking as the vendor sees it.
@freezed
abstract class VendorBooking with _$VendorBooking {
  const factory VendorBooking({
    required String id,
    required String number,
    required VendorBookingStatus status,
    required DateTime startsAt,
    required DateTime endsAt,
    required int totalMinor,
    required String currency,
    @Default('A customer') String customerName,
    String? customerAvatarUrl,
    @Default(<VendorBookingLine>[]) List<VendorBookingLine> lines,

    /// After this, an unanswered request expires.
    DateTime? respondBy,

    /// `delivery` or `pickup`.
    String? fulfilment,
    String? customerNote,
  }) = _VendorBooking;
}

/// A rental category a business can offer (chairs, tents, sound…).
@freezed
abstract class BusinessCategory with _$BusinessCategory {
  const factory BusinessCategory({required String id, required String name}) =
      _BusinessCategory;
}

/// What "Start a business" sends.
@freezed
abstract class NewBusiness with _$NewBusiness {
  const factory NewBusiness({
    required String name,
    required String handle,
    String? city,
    @Default(<String>[]) List<String> categoryIds,

    /// wedding, birthday, corporate, other.
    @Default(<String>[]) List<String> eventTypes,
  }) = _NewBusiness;
}

/// The business just created.
@freezed
abstract class CreatedBusiness with _$CreatedBusiness {
  const factory CreatedBusiness({
    required String id,
    required String handle,
    required String name,
    String? logoUrl,
  }) = _CreatedBusiness;
}
