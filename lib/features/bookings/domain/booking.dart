import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking.freezed.dart';

/// The backend lifecycle. At launch there's no in-app payment, so a request
/// goes `pendingVendor → confirmed` (or declined / expired / cancelled),
/// then the vendor delivers and collects.
enum BookingStatus {
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
  disputed
  ;

  /// `pending_vendor` → [pendingVendor].
  static BookingStatus parse(String raw) => values.firstWhere(
    (s) => s.wire == raw,
    orElse: () => BookingStatus.pendingVendor,
  );

  String get wire =>
      name.replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]!.toLowerCase()}');

  bool get isFinal => const {
    completed,
    declined,
    expired,
    cancelled,
  }.contains(this);

  /// The customer may still call it off.
  bool get customerCanCancel => const {
    pendingVendor,
    accepted,
    confirmed,
  }.contains(this);
}

@freezed
abstract class BookingVendor with _$BookingVendor {
  const factory BookingVendor({
    required String id,
    required String name,
    String? handle,
    String? logoUrl,
  }) = _BookingVendor;
}

@freezed
abstract class BookingItemLine with _$BookingItemLine {
  const factory BookingItemLine({
    required String title,
    required int qty,
    @Default(0) int lineTotalMinor,
  }) = _BookingItemLine;
}

/// One step in the booking's history.
@freezed
abstract class BookingStep with _$BookingStep {
  const factory BookingStep({
    required BookingStatus to,
    required DateTime at,
    String? note,
  }) = _BookingStep;
}

/// A booking as the customer sees it.
@freezed
abstract class CustomerBooking with _$CustomerBooking {
  const factory CustomerBooking({
    required String id,
    required String number,
    required BookingStatus status,
    required DateTime startsAt,
    required DateTime endsAt,
    required int totalMinor,
    required String currency,
    String? eventId,
    BookingVendor? vendor,
    @Default(<BookingItemLine>[]) List<BookingItemLine> lines,

    /// `delivery` or `pickup`.
    String? fulfilment,
    DateTime? respondBy,
    String? customerNote,

    /// Oldest first. Only on the booking's own page.
    @Default(<BookingStep>[]) List<BookingStep> timeline,
  }) = _CustomerBooking;
}

enum Fulfilment { delivery, pickup }

/// What the customer asks a vendor for.
@freezed
abstract class BookingRequest with _$BookingRequest {
  const factory BookingRequest({
    required String eventId,
    required String vendorId,
    required String itemId,
    required String variantId,
    required int qty,
    @Default(Fulfilment.delivery) Fulfilment fulfilment,
    String? note,
  }) = _BookingRequest;
}
