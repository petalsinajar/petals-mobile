import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';

part 'event_plan.freezed.dart';

/// The backend booking lifecycle (`pending_vendor → … → completed`).
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
  disputed,
}

@freezed
abstract class EventBooking with _$EventBooking {
  const factory EventBooking({
    required String id,
    required EventPerson vendor,
    required BookingStatus status,
    required DateTime startsOn,
    required DateTime endsOn,
    required int totalMinor,
    required String currency,
    @Default(<String>[]) List<String> itemTitles,
    @Default(0) int itemQuantity,
  }) = _EventBooking;
}

@freezed
abstract class EventCartLine with _$EventCartLine {
  const factory EventCartLine({
    required String itemId,
    required String title,
    required String vendorName,
    required int quantity,
    required int lineTotalMinor,
    required String currency,
  }) = _EventCartLine;
}

/// "Plan & rent": what's booked for the event and what's still in its cart.
@freezed
abstract class EventPlan with _$EventPlan {
  const factory EventPlan({
    @Default(<EventBooking>[]) List<EventBooking> bookings,
    @Default(<EventCartLine>[]) List<EventCartLine> cart,
  }) = _EventPlan;

  const EventPlan._();

  bool get isEmpty => bookings.isEmpty && cart.isEmpty;
}
