import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/core/widgets/async_value_view.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/entrance.dart';
import 'package:petalsinajar/features/bookings/domain/booking.dart';
import 'package:petalsinajar/features/bookings/presentation/booking_status_view.dart';
import 'package:petalsinajar/features/bookings/presentation/bookings_controllers.dart';

/// Everything the viewer has asked vendors for, newest first.
class MyBookingsScreen extends ConsumerWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(myBookingsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('My bookings')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(myBookingsProvider.future),
        child: AsyncValueView(
          value: value,
          onRetry: () => ref.invalidate(myBookingsProvider),
          isEmpty: (page) => page.isEmpty,
          empty: EmptyState(
            title: 'No bookings yet',
            message:
                'Find chairs, tents, sound and more on Discover, then '
                'request them for your event.',
            actionLabel: 'Go to Discover',
            onAction: () => context.go(Routes.discover),
          ),
          data: (page) => NotificationListener<ScrollNotification>(
            onNotification: (n) {
              if (n.metrics.extentAfter < 400) {
                unawaited(ref.read(myBookingsProvider.notifier).loadMore());
              }
              return false;
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              itemCount: page.items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) =>
                  BookingTile(booking: page.items[i]).entrance(i),
            ),
          ),
        ),
      ),
    );
  }
}

class BookingTile extends StatelessWidget {
  const BookingTile({required this.booking, super.key});

  final CustomerBooking booking;

  @override
  Widget build(BuildContext context) {
    final vendor = booking.vendor;
    final items = booking.lines.map((l) => '${l.qty} × ${l.title}').join(', ');
    final day = DateFormat('EEE d MMM').format(booking.startsAt);
    final total = MoneyFormat.format(booking.totalMinor, booking.currency);
    return Semantics(
      button: true,
      label:
          'Booking ${booking.number} with ${vendor?.name ?? 'a vendor'}, '
          '${booking.status.label}, $day',
      excludeSemantics: true,
      child: ListTile(
        onTap: () => context.push(Routes.booking(booking.id)),
        leading: Avatar(
          name: vendor?.name ?? '?',
          imageUrl: vendor?.logoUrl,
          isVendor: true,
        ),
        title: Text(vendor?.name ?? 'Vendor'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(items, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.sm,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                BookingStatusPill(status: booking.status),
                Text(
                  '$day · $total',
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
