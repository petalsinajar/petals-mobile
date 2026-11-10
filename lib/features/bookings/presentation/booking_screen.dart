import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/async_value_view.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/features/bookings/domain/booking.dart';
import 'package:petalsinajar/features/bookings/presentation/booking_status_view.dart';
import 'package:petalsinajar/features/bookings/presentation/bookings_controllers.dart';

/// One booking: where it stands, what's in it, and its history.
class BookingScreen extends ConsumerWidget {
  const BookingScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = bookingDetailProvider(bookingId);
    return Scaffold(
      appBar: AppBar(title: const Text('Booking')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(provider.future),
        child: AsyncValueView(
          value: ref.watch(provider),
          onRetry: () => ref.invalidate(provider),
          data: (b) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.screen),
            children: [
              _StatusCard(booking: b),
              const SizedBox(height: AppSpacing.xl),
              _Details(booking: b),
              const SizedBox(height: AppSpacing.xl),
              Text('History', style: context.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              _Timeline(steps: b.timeline),
              if (b.status.customerCanCancel) ...[
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label: b.status == BookingStatus.pendingVendor
                      ? 'Withdraw request'
                      : 'Cancel booking',
                  variant: AppButtonVariant.outline,
                  expand: true,
                  onPressed: () => _cancel(context, ref),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final sure = await showDialog<bool>(
      context: context,
      builder: (dialog) => AlertDialog(
        title: const Text('Cancel this booking?'),
        content: const Text('The vendor will be told straight away.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialog).pop(false),
            child: const Text('Keep it'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialog).pop(true),
            child: const Text('Cancel booking'),
          ),
        ],
      ),
    );
    if (sure != true) return;
    try {
      await ref.read(bookingDetailProvider(bookingId).notifier).cancel();
      unawaited(Haptics.light());
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
      ref.invalidate(bookingDetailProvider(bookingId));
    }
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.booking});

  final CustomerBooking booking;

  @override
  Widget build(BuildContext context) {
    final status = booking.status;
    final respondBy = booking.respondBy;
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.cardAll),
      color: status.color(context).withValues(alpha: 0.10),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(status.icon, color: status.color(context)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    status.label,
                    style: context.textTheme.titleLarge,
                  ),
                ),
                Text(
                  '#${booking.number}',
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(status.explanation, style: context.textTheme.bodyMedium),
            if (status == BookingStatus.pendingVendor && respondBy != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Text(
                  'They have until '
                  '${DateFormat('EEE d MMM, h:mm a').format(respondBy)} '
                  'to answer.',
                  style: context.textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.booking});

  final CustomerBooking booking;

  @override
  Widget build(BuildContext context) {
    final vendor = booking.vendor;
    final when = DateFormat('EEE d MMM, h:mm a');
    const money = MoneyFormat.format;
    final muted = context.textTheme.bodyMedium?.copyWith(
      color: context.colors.onSurfaceVariant,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (vendor != null)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Avatar(
              name: vendor.name,
              imageUrl: vendor.logoUrl,
              isVendor: true,
            ),
            title: Text(vendor.name),
            subtitle: const Text('Vendor'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(Routes.vendor(vendor.id)),
          ),
        if (booking.eventId case final String eventId)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.celebration_rounded),
            title: const Text('For your event'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(Routes.event(eventId)),
          ),
        const Divider(),
        for (final line in booking.lines)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Expanded(child: Text('${line.qty} × ${line.title}')),
                Text(money(line.lineTotalMinor, booking.currency)),
              ],
            ),
          ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: Text('Total', style: context.textTheme.titleMedium),
            ),
            Text(
              money(booking.totalMinor, booking.currency),
              style: context.textTheme.titleMedium,
            ),
          ],
        ),
        Text(
          'Includes delivery and fees. Pay the vendor directly.',
          style: muted,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          '${booking.fulfilment == 'pickup' ? 'Pickup' : 'Delivery'}: '
          '${when.format(booking.startsAt)} → ${when.format(booking.endsAt)}',
          style: muted,
        ),
        if (booking.customerNote case final String note
            when note.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text('Your note: $note', style: muted),
        ],
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.steps});

  final List<BookingStep> steps;

  @override
  Widget build(BuildContext context) {
    final when = DateFormat('d MMM, h:mm a');
    return Column(
      children: [
        for (final (i, step) in steps.reversed.indexed)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              step.to.icon,
              color: i == 0
                  ? step.to.color(context)
                  : context.colors.onSurfaceVariant,
            ),
            title: Text(
              step.to == BookingStatus.pendingVendor
                  ? 'Requested'
                  : step.to.label,
            ),
            subtitle: Text(
              [when.format(step.at), ?step.note].join(' · '),
            ),
          ),
      ],
    );
  }
}
