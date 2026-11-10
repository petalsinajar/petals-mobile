import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/inline_error.dart';
import 'package:petalsinajar/features/bookings/domain/booking.dart';
import 'package:petalsinajar/features/bookings/presentation/bookings_controllers.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/discover_controllers.dart';

/// "Request to book": opens the sheet, or sign-in when signed out.
Future<void> requestToBook(BuildContext context, WidgetRef ref, ItemCard item) {
  if (ref.read(viewerIdProvider) == null) {
    return context.push(Routes.signInFrom(Routes.item(item.id)));
  }
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => RequestBookingSheet(item: item, host: context),
  );
}

/// Pick the event, variant, quantity and delivery, then send the request.
/// Nothing is paid in the app: the vendor accepts or declines.
class RequestBookingSheet extends ConsumerStatefulWidget {
  const RequestBookingSheet({
    required this.item,
    required this.host,
    super.key,
  });

  final ItemCard item;

  /// The page under the sheet, which outlives it for the follow-up.
  final BuildContext host;

  @override
  ConsumerState<RequestBookingSheet> createState() =>
      _RequestBookingSheetState();
}

class _RequestBookingSheetState extends ConsumerState<RequestBookingSheet> {
  UpcomingEvent? _event;
  ItemVariant? _variant;
  late int _qty = widget.item.minQty;
  Fulfilment _fulfilment = Fulfilment.delivery;
  final _note = TextEditingController();
  var _sending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _variant = widget.item.variants.firstOrNull;
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final event = _event;
    final variant = _variant;
    final vendorId = widget.item.vendorId ?? widget.item.vendor?.id;
    if (event == null || variant == null || vendorId == null) return;

    setState(() {
      _sending = true;
      _error = null;
    });
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(widget.host);
    final router = GoRouter.of(widget.host);
    try {
      final booking = await ref
          .read(bookingRequesterProvider.notifier)
          .send(
            BookingRequest(
              eventId: event.id,
              vendorId: vendorId,
              itemId: widget.item.id,
              variantId: variant.id,
              qty: _qty,
              fulfilment: _fulfilment,
              note: _note.text,
            ),
          );
      unawaited(Haptics.success());
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Request sent to ${widget.item.vendor?.name ?? 'the vendor'}',
          ),
        ),
      );
      unawaited(router.push(Routes.booking(booking.id)));
    } on ApiException catch (e) {
      unawaited(Haptics.warning());
      if (mounted) {
        setState(() {
          _sending = false;
          // Field errors (lead time, minimum quantity) say it best.
          _error =
              e.fieldErrors.values.expand((m) => m).firstOrNull ?? e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(myUpcomingEventsProvider);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        child: events.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.xxl),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Padding(
            padding: AppSpacing.screenPadding,
            child: InlineError(
              error: e,
              onRetry: () => ref.invalidate(myUpcomingEventsProvider),
            ),
          ),
          data: (all) {
            final hosting = all.where((e) => e.isHost).toList();
            if (hosting.isEmpty) {
              return EmptyState(
                title: 'Plan an event first',
                message:
                    'Bookings are made for an event you host, so the vendor '
                    'knows when and where.',
                icon: Icons.celebration_rounded,
                actionLabel: 'Create an event',
                onAction: () {
                  Navigator.of(context).pop();
                  unawaited(widget.host.push(Routes.createEvent));
                },
              );
            }
            _event ??= hosting.first;
            return _form(context, hosting);
          },
        ),
      ),
    );
  }

  Widget _form(BuildContext context, List<UpcomingEvent> hosting) {
    final item = widget.item;
    final event = _event!;
    final variant = _variant;
    final text = context.textTheme;
    final day = DateFormat('EEE d MMM');
    final unit = item.fromPriceMinor + (variant?.priceDeltaMinor ?? 0);

    return ListView(
      shrinkWrap: true,
      padding: AppSpacing.screenPadding,
      children: [
        Text('Request to book', style: text.titleLarge),
        Text(item.title, style: text.bodyMedium),
        const SizedBox(height: AppSpacing.lg),
        DropdownButtonFormField<UpcomingEvent>(
          initialValue: event,
          decoration: const InputDecoration(labelText: 'For which event?'),
          items: [
            for (final e in hosting)
              DropdownMenuItem(
                value: e,
                child: Text(
                  '${e.title} · ${day.format(e.startsAt)}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
          onChanged: (e) => setState(() => _event = e),
        ),
        if (item.variants.length > 1) ...[
          const SizedBox(height: AppSpacing.lg),
          Text('Option', style: text.labelLarge),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final v in item.variants)
                ChoiceChip(
                  label: Text(v.name),
                  selected: v == variant,
                  onSelected: (_) {
                    unawaited(Haptics.selection());
                    setState(() => _variant = v);
                  },
                ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        _Quantity(
          qty: _qty,
          min: item.minQty,
          onChanged: (q) => setState(() => _qty = q),
        ),
        if (variant != null)
          _Availability(
            itemId: item.id,
            variantId: variant.id,
            day: event.startsAt,
            qty: _qty,
          ),
        const SizedBox(height: AppSpacing.lg),
        SegmentedButton<Fulfilment>(
          segments: const [
            ButtonSegment(
              value: Fulfilment.delivery,
              label: Text('Delivery'),
              icon: Icon(Icons.local_shipping_rounded),
            ),
            ButtonSegment(
              value: Fulfilment.pickup,
              label: Text('Pickup'),
              icon: Icon(Icons.storefront_rounded),
            ),
          ],
          selected: {_fulfilment},
          onSelectionChanged: (s) => setState(() => _fulfilment = s.first),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: _note,
          maxLength: 500,
          minLines: 1,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Note for the vendor (optional)',
            hintText: 'Gate code, colours, setup time…',
          ),
        ),
        Text(
          'About ${MoneyFormat.format(unit * _qty, item.currency)} before '
          'delivery and fees. Nothing is paid now: the vendor accepts or '
          'declines, and you arrange payment with them.',
          style: text.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        if (_error case final String error) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            error,
            style: text.bodyMedium?.copyWith(
              color: context.colors.error,
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: 'Send request',
          icon: Icons.send_rounded,
          expand: true,
          isLoading: _sending,
          onPressed: variant == null ? null : _send,
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

class _Quantity extends StatelessWidget {
  const _Quantity({
    required this.qty,
    required this.min,
    required this.onChanged,
  });

  final int qty;
  final int min;
  final ValueChanged<int> onChanged;

  /// Bigger steps for big orders: nobody taps + 120 times for chairs.
  int get _step => qty >= 50 ? 10 : 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text('Quantity', style: context.textTheme.labelLarge),
        ),
        IconButton.outlined(
          tooltip: 'Fewer',
          onPressed: qty > min
              ? () => onChanged((qty - _step).clamp(min, qty))
              : null,
          icon: const Icon(Icons.remove_rounded),
        ),
        SizedBox(
          width: 56,
          child: Text(
            '$qty',
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium,
          ),
        ),
        IconButton.outlined(
          tooltip: 'More',
          onPressed: () => onChanged(qty + _step),
          icon: const Icon(Icons.add_rounded),
        ),
      ],
    );
  }
}

class _Availability extends ConsumerWidget {
  const _Availability({
    required this.itemId,
    required this.variantId,
    required this.day,
    required this.qty,
  });

  final String itemId;
  final String variantId;
  final DateTime day;
  final int qty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final when = DateFormat('d MMM').format(day);
    final value = ref.watch(
      variantAvailabilityProvider(itemId, variantId, day),
    );
    final style = context.textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: value.when(
        loading: () => Text('Checking availability…', style: style),
        error: (_, _) => Text(
          'Couldn’t check availability. The vendor will confirm.',
          style: style,
        ),
        data: (left) => Text(
          left >= qty
              ? '$left available on $when'
              : 'Only $left available on $when',
          style: style?.copyWith(
            color: left >= qty ? context.palette.success : context.colors.error,
          ),
        ),
      ),
    );
  }
}
