import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petalsinajar/core/media/media.dart';

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

/// The statuses on the Calendar: everything that is or was going ahead.
abstract final class CalendarStatuses {
  static const List<VendorBookingStatus> all = [
    VendorBookingStatus.pendingVendor,
    VendorBookingStatus.accepted,
    VendorBookingStatus.confirmed,
    VendorBookingStatus.outForDelivery,
    VendorBookingStatus.delivered,
    VendorBookingStatus.returned,
    VendorBookingStatus.completed,
    VendorBookingStatus.disputed,
  ];
}

/// Days (inclusive, local dates) the business takes no new bookings.
/// Bookings already made are kept.
@freezed
abstract class Blackout with _$Blackout {
  const factory Blackout({
    required String id,
    required DateTime startsOn,
    required DateTime endsOn,
    String? reason,
  }) = _Blackout;

  const Blackout._();

  bool covers(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    return !d.isBefore(startsOn) && !d.isAfter(endsOn);
  }
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

    /// Recorded by the vendor for a booking made outside the app.
    @Default(false) bool recorded,

    /// Only on recorded bookings: the number the vendor took down.
    String? customerPhone,

    /// Where to deliver (delivery bookings).
    String? address,

    /// Who to call on the day: the customer's phone on recorded bookings,
    /// else the contact given at checkout.
    String? contactPhone,
  }) = _VendorBooking;
}

/// The next step a vendor marks on a booking that's going ahead.
enum BookingStep {
  /// Confirmed delivery → out for delivery.
  dispatch,

  /// Out for delivery, or a confirmed pickup → with the customer.
  deliver,

  /// With the customer → back in stock.
  markReturned
  ;

  /// What comes next for [b], if anything.
  static BookingStep? next(VendorBooking b) => switch (b.status) {
    VendorBookingStatus.confirmed =>
      b.fulfilment == 'pickup' ? deliver : dispatch,
    VendorBookingStatus.outForDelivery => deliver,
    VendorBookingStatus.delivered => markReturned,
    _ => null,
  };
}

/// One item on a booking the vendor records.
@freezed
abstract class RecordedLine with _$RecordedLine {
  const factory RecordedLine({
    required String itemId,
    required String variantId,
    required int qty,
  }) = _RecordedLine;
}

/// A booking agreed outside the app (phone, walk-in), recorded so its stock
/// comes off the calendar. Saved as confirmed; nothing is paid in the app.
@freezed
abstract class RecordedBooking with _$RecordedBooking {
  const factory RecordedBooking({
    required String customerName,
    required String customerPhone,
    required DateTime startsAt,
    required DateTime endsAt,
    required List<RecordedLine> lines,
    @Default(false) bool delivery,
    String? address,
    @Default(0) int deliveryFeeMinor,

    /// Already received from the customer, outside the app.
    @Default(0) int paidMinor,

    /// Only the business's team sees it.
    String? note,
  }) = _RecordedBooking;
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

/// `draft` items aren't listed yet; `paused` are hidden from customers.
enum VendorItemStatus { active, draft, paused, archived }

@freezed
abstract class VendorItemVariant with _$VendorItemVariant {
  const factory VendorItemVariant({
    required String id,
    required String name,
    required int quantity,
    @Default(true) bool active,
  }) = _VendorItemVariant;
}

/// One item in the business's inventory, as the web dashboard edits it.
@freezed
abstract class VendorItem with _$VendorItem {
  const factory VendorItem({
    required String id,
    required String title,
    required VendorItemStatus status,
    required int fromPriceMinor,
    required String currency,

    /// `per_event`, `per_day` or `per_hour`.
    @Default('per_event') String unit,
    String? categoryId,
    String? photoUrl,
    String? blurhash,
    @Default(1) int minQty,
    @Default(false) bool instantBook,
    @Default(<VendorItemVariant>[]) List<VendorItemVariant> variants,

    /// In order; the first photo is the cover customers see.
    @Default(<Media>[]) List<Media> media,
  }) = _VendorItem;

  const VendorItem._();

  /// Units owned across active variants.
  int get stock =>
      variants.where((v) => v.active).fold(0, (sum, v) => sum + v.quantity);
}

/// How the business delivers. Fees are minor units.
@freezed
abstract class BusinessDelivery with _$BusinessDelivery {
  const factory BusinessDelivery({
    @Default(true) bool offered,
    @Default(0) int baseFeeMinor,
    @Default(false) bool setupOffered,
    @Default(0) int setupFeeMinor,

    /// Set on the web; kept as-is when the app saves delivery.
    @Default(0) int perKmMinor,
  }) = _BusinessDelivery;
}

/// The business's public profile, plus what its team needs to run it.
@freezed
abstract class BusinessProfile with _$BusinessProfile {
  const factory BusinessProfile({
    required String id,
    required String handle,
    required String name,
    String? bio,
    String? logoUrl,
    String? coverUrl,
    String? city,
    @Default(<String>[]) List<String> categories,
    @Default(<String>[]) List<String> eventTypes,
    String? phone,
    String? whatsapp,
    String? email,
    @Default(false) bool isVerified,
    double? ratingAverage,
    @Default(0) int ratingCount,
    @Default(0) int followers,
    @Default(0) int posts,
    @Default(0) int completedBookings,
    int? serviceRadiusKm,
    @Default(BusinessDelivery()) BusinessDelivery delivery,
    int? depositPercent,
    int? leadTimeHours,

    /// `owner`, `manager` or `staff`; null if not on the team.
    String? myRole,
  }) = _BusinessProfile;

  const BusinessProfile._();

  bool get canEdit => myRole == 'owner' || myRole == 'manager';
}
