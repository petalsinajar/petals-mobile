import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/inline_error.dart';
import 'package:petalsinajar/core/widgets/skeleton.dart';
import 'package:petalsinajar/features/events/domain/event_plan.dart';
import 'package:petalsinajar/features/events/presentation/event_labels.dart';
import 'package:petalsinajar/features/events/presentation/events_controllers.dart';

/// "Plan & rent": this event's bookings and what's still in its cart.
class PlanSection extends ConsumerWidget {
  const PlanSection({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = eventPlanProvider(eventId);
    return ref
        .watch(provider)
        .when(
          loading: () => const SkeletonList(itemCount: 2),
          error: (e, _) =>
              InlineError(error: e, onRetry: () => ref.invalidate(provider)),
          data: (plan) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final b in plan.bookings) ...[
                _BookingTile(booking: b),
                const SizedBox(height: AppSpacing.sm),
              ],
              _CartCard(
                lines: plan.cart,
                hasBookings: plan.bookings.isNotEmpty,
              ),
            ],
          ),
        );
  }
}

class _BookingTile extends StatelessWidget {
  const _BookingTile({required this.booking});

  final EventBooking booking;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final colors = context.colors;
    final palette = context.palette;
    final status = booking.status;
    final statusColor = status.isProblem
        ? colors.error
        : status == BookingStatus.pendingVendor
        ? palette.warning
        : palette.success;
    final items = booking.itemTitles.join(', ');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Avatar(
              name: booking.vendor.name,
              imageUrl: booking.vendor.avatar?.url,
              blurhash: booking.vendor.avatar?.blurhash,
              isVendor: true,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.vendor.name, style: text.titleSmall),
                  Text(
                    '${booking.itemQuantity} items · $items',
                    style: text.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    status.label,
                    style: text.labelMedium?.copyWith(color: statusColor),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  MoneyFormat.format(booking.totalMinor, booking.currency),
                  style: text.titleSmall,
                ),
                Text(
                  EventDates.range(booking.startsOn, booking.endsOn),
                  style: text.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CartCard extends StatelessWidget {
  const _CartCard({required this.lines, required this.hasBookings});

  final List<EventCartLine> lines;
  final bool hasBookings;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final colors = context.colors;
    final total = lines.fold(0, (sum, l) => sum + l.lineTotalMinor);

    return Card(
      color: colors.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_bag_outlined, color: colors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text('Cart', style: text.titleSmall)),
                if (lines.isNotEmpty)
                  Text(
                    MoneyFormat.format(total, lines.first.currency),
                    style: text.titleSmall,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (lines.isEmpty)
              Text(
                hasBookings
                    ? 'Need anything else? Chairs, tents, decor and sound '
                          'are a tap away.'
                    : 'Nothing rented yet. Find chairs, tents, decor and '
                          'sound for your event.',
                style: text.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              )
            else
              for (final l in lines)
                Text(
                  '${l.quantity} × ${l.title} · ${l.vendorName}',
                  style: text.bodyMedium,
                ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: 'Browse rentals',
              icon: Icons.storefront_rounded,
              variant: AppButtonVariant.secondary,
              size: AppButtonSize.small,
              onPressed: () => context.go(Routes.discover),
            ),
          ],
        ),
      ),
    );
  }
}
