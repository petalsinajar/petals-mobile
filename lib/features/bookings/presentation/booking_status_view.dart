import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/features/bookings/domain/booking.dart';

/// Words and colours for a booking's status, from the customer's side.
extension BookingStatusText on BookingStatus {
  String get label => switch (this) {
    BookingStatus.pendingVendor => 'Waiting for vendor',
    BookingStatus.accepted => 'Accepted',
    BookingStatus.confirmed => 'Confirmed',
    BookingStatus.outForDelivery => 'On the way',
    BookingStatus.delivered => 'Delivered',
    BookingStatus.returned => 'Returned',
    BookingStatus.completed => 'Completed',
    BookingStatus.declined => 'Declined',
    BookingStatus.expired => 'Expired',
    BookingStatus.cancelled => 'Cancelled',
    BookingStatus.disputed => 'Under review',
  };

  /// What happens next, in a sentence.
  String get explanation => switch (this) {
    BookingStatus.pendingVendor =>
      'Your request is with the vendor. You’ll get a notification when they '
          'answer.',
    BookingStatus.accepted || BookingStatus.confirmed =>
      'The vendor has accepted. Arrange payment with them directly.',
    BookingStatus.outForDelivery => 'The vendor is on the way.',
    BookingStatus.delivered => 'Your rentals have arrived. Enjoy the event!',
    BookingStatus.returned ||
    BookingStatus.completed => 'All done. Thanks for renting.',
    BookingStatus.declined =>
      'The vendor can’t take this one. Try another vendor nearby.',
    BookingStatus.expired =>
      'The vendor didn’t answer in time. Try another vendor nearby.',
    BookingStatus.cancelled => 'This booking was cancelled.',
    BookingStatus.disputed => 'There’s an issue being sorted out.',
  };

  IconData get icon => switch (this) {
    BookingStatus.pendingVendor => Icons.hourglass_top_rounded,
    BookingStatus.accepted ||
    BookingStatus.confirmed => Icons.check_circle_rounded,
    BookingStatus.outForDelivery => Icons.local_shipping_rounded,
    BookingStatus.delivered => Icons.celebration_rounded,
    BookingStatus.returned || BookingStatus.completed => Icons.done_all_rounded,
    BookingStatus.declined ||
    BookingStatus.expired ||
    BookingStatus.cancelled => Icons.cancel_rounded,
    BookingStatus.disputed => Icons.report_rounded,
  };

  Color color(BuildContext context) => switch (this) {
    BookingStatus.pendingVendor => context.palette.warning,
    BookingStatus.declined ||
    BookingStatus.expired ||
    BookingStatus.cancelled ||
    BookingStatus.disputed => context.colors.error,
    _ => context.palette.success,
  };
}

/// A small coloured pill with the status.
class BookingStatusPill extends StatelessWidget {
  const BookingStatusPill({required this.status, super.key});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(status.icon, size: AppSizes.iconSm, color: color),
            const SizedBox(width: AppSpacing.xs),
            Text(
              status.label,
              style: context.textTheme.labelMedium?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
