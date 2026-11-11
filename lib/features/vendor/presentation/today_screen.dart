import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/async_value_view.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_controllers.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens the phone's dialler; swapped in tests.
typedef Dialer = Future<void> Function(String phone);

Future<void> _dial(String phone) async {
  await launchUrl(Uri(scheme: 'tel', path: phone));
}

/// Vendor mode → Today: what goes out and comes back today and tomorrow,
/// late returns, and requests waiting for an answer. Any team member marks
/// each step; the customer hears about it.
class VendorTodayScreen extends ConsumerWidget {
  const VendorTodayScreen({this.today, this.dial = _dial, super.key});

  /// Fixed in tests; the real date otherwise.
  final DateTime? today;
  final Dialer dial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actor = ref.watch(activeActorProvider);
    if (actor is! VendorActor) return const Scaffold();
    final now = today ?? DateTime.now();
    final day = DateTime(now.year, now.month, now.day);
    final provider = vendorTodayProvider(actor.vendorId, day);
    final waiting =
        ref
            .watch(vendorRequestsProvider(actor.vendorId))
            .value
            ?.needsAnswer
            .length ??
        0;

    return Scaffold(
      appBar: AppBar(title: const Text('Today')),
      body: AsyncValueView(
        value: ref.watch(provider),
        onRetry: () => ref.invalidate(provider),
        data: (view) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(vendorRequestsProvider(actor.vendorId));
            await ref.read(provider.notifier).refresh();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.screen),
            children: [
              Text(
                DateFormat('EEEE d MMMM').format(day),
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (waiting > 0)
                Card(
                  color: context.colors.secondaryContainer,
                  margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: ListTile(
                    leading: const Icon(Icons.inbox_rounded),
                    title: Text(
                      waiting == 1
                          ? '1 request waiting for your answer'
                          : '$waiting requests waiting for your answer',
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => context.go(Routes.vendorRequests),
                  ),
                ),
              if (view.overdue.isNotEmpty) ...[
                _Heading('Late', count: view.overdue.length, alert: true),
                for (final b in view.overdue)
                  _JobCard(
                    key: ValueKey('late-${b.id}'),
                    booking: b,
                    vendorId: actor.vendorId,
                    day: day,
                    dial: dial,
                    late: true,
                  ),
                const SizedBox(height: AppSpacing.lg),
              ],
              _Heading('Today', count: view.today.length),
              if (view.today.isEmpty)
                const EmptyState(
                  title: 'Nothing going out or coming back today',
                  message: 'Confirmed bookings show up here on the day.',
                  icon: Icons.local_shipping_rounded,
                )
              else
                for (final b in view.today)
                  _JobCard(
                    key: ValueKey('today-${b.id}'),
                    booking: b,
                    vendorId: actor.vendorId,
                    day: day,
                    dial: dial,
                  ),
              const SizedBox(height: AppSpacing.lg),
              _Heading('Tomorrow', count: view.tomorrow.length),
              if (view.tomorrow.isEmpty)
                Text(
                  'Nothing planned for tomorrow yet.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                )
              else
                for (final b in view.tomorrow)
                  _JobCard(
                    key: ValueKey('tomorrow-${b.id}'),
                    booking: b,
                    vendorId: actor.vendorId,
                    day: day,
                    dial: dial,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.title, {required this.count, this.alert = false});

  final String title;
  final int count;
  final bool alert;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        '$title · $count',
        style: context.textTheme.titleMedium?.copyWith(
          color: alert ? context.colors.error : null,
        ),
      ),
    );
  }
}

/// The step's button label and the snackbar once done.
(String, String) _stepText(BookingStep step, VendorBooking b) => switch (step) {
  BookingStep.dispatch => ('Mark out for delivery', 'Out for delivery'),
  BookingStep.deliver =>
    b.fulfilment == 'pickup'
        ? ('Mark picked up', 'Picked up')
        : ('Mark delivered', 'Delivered'),
  BookingStep.markReturned => ('Mark returned', 'Returned. Stock is back'),
};

class _JobCard extends ConsumerStatefulWidget {
  const _JobCard({
    required this.booking,
    required this.vendorId,
    required this.day,
    required this.dial,
    this.late = false,
    super.key,
  });

  final VendorBooking booking;
  final String vendorId;
  final DateTime day;
  final Dialer dial;
  final bool late;

  @override
  ConsumerState<_JobCard> createState() => _JobCardState();
}

class _JobCardState extends ConsumerState<_JobCard> {
  var _busy = false;

  Future<void> _advance(BookingStep step) async {
    setState(() => _busy = true);
    // Grab before the await: the card may move or go once it's done.
    final messenger = ScaffoldMessenger.of(context);
    final today = ref.read(
      vendorTodayProvider(widget.vendorId, widget.day).notifier,
    );
    try {
      await today.advance(widget.booking.id, step);
      unawaited(Haptics.success());
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            '#${widget.booking.number}: '
            '${_stepText(step, widget.booking).$2}',
          ),
        ),
      );
    } on Object catch (e) {
      unawaited(Haptics.warning());
      final message = e is ApiException && e.fieldError('status') != null
          ? e.fieldError('status')!
          : ErrorState.describe(e).$2;
      messenger.showSnackBar(SnackBar(content: Text(message)));
      // It may have changed elsewhere (cancelled, marked by a teammate).
      await today.refresh();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final b = widget.booking;
    final text = context.textTheme;
    final colors = context.colors;
    final muted = text.bodySmall?.copyWith(color: colors.onSurfaceVariant);
    final time = DateFormat('h:mm a');
    final date = DateFormat('EEE d MMM, h:mm a');
    final goingOut = b.status == VendorBookingStatus.confirmed;
    final pickup = b.fulfilment == 'pickup';
    final at = goingOut ? b.startsAt : b.endsAt;
    final when =
        DateUtils.isSameDay(at, widget.day) ||
            DateUtils.isSameDay(at, widget.day.add(const Duration(days: 1)))
        ? time.format(at)
        : date.format(at);
    final what = switch ((goingOut, pickup, b.status)) {
      (true, true, _) => 'Customer collects',
      (true, false, _) => 'Deliver',
      (false, _, VendorBookingStatus.outForDelivery) => 'On the way',
      (false, true, _) => 'Customer brings back',
      (false, false, _) => 'Collect',
    };
    final step = BookingStep.next(b);
    final address = pickup ? null : b.address;
    final phone = b.contactPhone;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  goingOut ? Icons.outbox_rounded : Icons.move_to_inbox_rounded,
                  color: widget.late ? colors.error : colors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    '$what · ${widget.late ? 'was due $when' : when}',
                    style: text.titleSmall?.copyWith(
                      color: widget.late ? colors.error : null,
                    ),
                  ),
                ),
                Text('#${b.number}', style: muted),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(b.customerName, style: text.bodyLarge),
            Text(
              [for (final l in b.lines) '${l.qty} × ${l.title}'].join(', '),
              style: text.bodyMedium,
            ),
            if (address != null && address.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.place_outlined,
                    size: AppSizes.iconSm,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(child: Text(address, style: muted)),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                if (phone != null && phone.isNotEmpty)
                  IconButton.outlined(
                    tooltip: 'Call ${b.customerName}',
                    onPressed: () => widget.dial(phone),
                    icon: const Icon(Icons.call_rounded),
                  ),
                const SizedBox(width: AppSpacing.sm),
                if (step != null)
                  Expanded(
                    child: _busy
                        ? const Center(child: CircularProgressIndicator())
                        : FilledButton(
                            onPressed: () => _advance(step),
                            child: Text(_stepText(step, b).$1),
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
