import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/core/widgets/async_value_view.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_controllers.dart';

/// Vendor mode → Requests: booking requests to accept or decline, and the
/// bookings already agreed. Staff see the list; owners and managers answer.
class VendorRequestsScreen extends ConsumerWidget {
  const VendorRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actor = ref.watch(activeActorProvider);
    if (actor is! VendorActor) return const Scaffold();

    final role = ref
        .watch(authSessionProvider)
        .value
        ?.vendors
        .where((v) => v.id == actor.vendorId)
        .firstOrNull
        ?.role;
    final canAnswer = role == 'owner' || role == 'manager';
    final provider = vendorRequestsProvider(actor.vendorId);

    return Scaffold(
      appBar: AppBar(title: const Text('Requests')),
      body: AsyncValueView(
        value: ref.watch(provider),
        onRetry: () => ref.invalidate(provider),
        isEmpty: (view) => view.needsAnswer.isEmpty && view.upcoming.isEmpty,
        empty: EmptyState(
          title: 'No booking requests yet',
          message:
              "When a customer books your items, you'll get a notification "
              'and can accept or decline here.',
          icon: Icons.inbox_rounded,
          actionLabel: 'Refresh',
          onAction: () => ref.invalidate(provider),
        ),
        data: (view) => RefreshIndicator(
          onRefresh: ref.read(provider.notifier).refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.screen),
            children: [
              if (!canAnswer)
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.info_outline_rounded),
                    title: Text(
                      'Only owners and managers can accept or decline '
                      'requests.',
                    ),
                  ),
                ),
              _Section(
                title: 'Needs your answer',
                count: view.needsAnswer.length,
                emptyText: "You're all caught up.",
              ),
              for (final b in view.needsAnswer)
                _BookingCard(
                  key: ValueKey(b.id),
                  booking: b,
                  vendorId: actor.vendorId,
                  canAnswer: canAnswer,
                ),
              const SizedBox(height: AppSpacing.lg),
              _Section(
                title: 'Upcoming',
                count: view.upcoming.length,
                emptyText: 'Accepted bookings show up here.',
              ),
              for (final b in view.upcoming)
                _BookingCard(
                  key: ValueKey(b.id),
                  booking: b,
                  vendorId: actor.vendorId,
                  canAnswer: false,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.count,
    required this.emptyText,
  });

  final String title;
  final int count;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title · $count', style: text.titleMedium),
          if (count == 0)
            Text(
              emptyText,
              style: text.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}

/// Asks for an optional reason. Pops it (possibly empty) to decline, or
/// null to keep the request. Owns its controller, which must outlive the
/// closing animation.
class _DeclineDialog extends StatefulWidget {
  const _DeclineDialog({required this.number});

  final String number;

  @override
  State<_DeclineDialog> createState() => _DeclineDialogState();
}

class _DeclineDialogState extends State<_DeclineDialog> {
  final _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Decline #${widget.number}?'),
      content: TextField(
        controller: _reason,
        maxLength: 500,
        maxLines: 3,
        decoration: const InputDecoration(
          labelText: 'Reason for the customer (optional)',
          hintText: 'Fully booked that weekend',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Keep'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_reason.text),
          child: const Text('Decline'),
        ),
      ],
    );
  }
}

String _statusLabel(VendorBookingStatus status) => switch (status) {
  VendorBookingStatus.pendingVendor => 'New request',
  VendorBookingStatus.accepted => 'Awaiting deposit',
  VendorBookingStatus.confirmed => 'Confirmed',
  VendorBookingStatus.outForDelivery => 'Out for delivery',
  VendorBookingStatus.delivered => 'At the event',
  VendorBookingStatus.returned => 'Returned',
  VendorBookingStatus.completed => 'Completed',
  VendorBookingStatus.declined => 'Declined',
  VendorBookingStatus.expired => 'Expired',
  VendorBookingStatus.cancelled => 'Cancelled',
  VendorBookingStatus.disputed => 'Disputed',
};

class _BookingCard extends ConsumerStatefulWidget {
  const _BookingCard({
    required this.booking,
    required this.vendorId,
    required this.canAnswer,
    super.key,
  });

  final VendorBooking booking;
  final String vendorId;

  /// Shows Accept / Decline (pending requests, owners and managers).
  final bool canAnswer;

  @override
  ConsumerState<_BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends ConsumerState<_BookingCard> {
  var _busy = false;

  VendorRequests get _requests =>
      ref.read(vendorRequestsProvider(widget.vendorId).notifier);

  Future<void> _run(Future<void> Function() action, String done) async {
    setState(() => _busy = true);
    // Grab before the await: the card may be gone afterwards.
    final messenger = ScaffoldMessenger.of(context);
    final requests = _requests;
    try {
      await action();
      messenger.showSnackBar(SnackBar(content: Text(done)));
    } on Object catch (e) {
      final message = e is ApiException && e.fieldError('status') != null
          ? e.fieldError('status')!
          : ErrorState.describe(e).$2;
      messenger.showSnackBar(SnackBar(content: Text(message)));
      // It may have changed elsewhere (expired, cancelled): reload.
      await requests.refresh();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _decline() async {
    // The reason, or null if they kept the request.
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => _DeclineDialog(number: widget.booking.number),
    );
    if (reason == null || !mounted) return;
    await _run(
      () => _requests.decline(widget.booking.id, reason: reason),
      'Request declined',
    );
  }

  @override
  Widget build(BuildContext context) {
    final b = widget.booking;
    final text = context.textTheme;
    final colors = context.colors;
    final muted = text.bodySmall?.copyWith(color: colors.onSurfaceVariant);
    final day = DateFormat('EEE d MMM');
    final at = DateFormat('EEE d MMM, h:mm a');
    final isPending = b.status == VendorBookingStatus.pendingVendor;
    final respondBy = b.respondBy;
    final urgent =
        respondBy != null &&
        respondBy.difference(DateTime.now()) < const Duration(hours: 6);
    final fulfilment = switch (b.fulfilment) {
      'delivery' => ' · Delivery',
      'pickup' => ' · Pickup',
      _ => '',
    };

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Avatar(
                  name: b.customerName,
                  imageUrl: b.customerAvatarUrl,
                  size: AvatarSize.sm,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(b.customerName, style: text.titleSmall),
                      Text('#${b.number}', style: muted),
                    ],
                  ),
                ),
                Chip(label: Text(_statusLabel(b.status))),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              [for (final l in b.lines) '${l.qty} × ${l.title}'].join(', '),
              style: text.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Icon(
                  Icons.event_rounded,
                  size: AppSizes.iconSm,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    '${day.format(b.startsAt)} → ${day.format(b.endsAt)}'
                    '$fulfilment',
                    style: muted,
                  ),
                ),
                Text(
                  MoneyFormat.format(b.totalMinor, b.currency),
                  style: text.titleSmall,
                ),
              ],
            ),
            if (b.customerNote case final note? when note.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text('“$note”', style: muted),
            ],
            if (isPending && respondBy != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Respond by ${at.format(respondBy)}',
                style: text.labelMedium?.copyWith(
                  color: urgent ? colors.error : colors.onSurfaceVariant,
                ),
              ),
            ],
            if (isPending && widget.canAnswer) ...[
              const SizedBox(height: AppSpacing.md),
              if (_busy)
                const Center(child: CircularProgressIndicator())
              else
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _decline,
                        child: const Text('Decline'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => _run(
                          () => _requests.accept(b.id),
                          'Accepted. The customer will be asked for the '
                          'deposit.',
                        ),
                        child: const Text('Accept'),
                      ),
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }
}
