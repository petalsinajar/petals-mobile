import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_controllers.dart';

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Whether [b] is out (delivered to collected) at some point on [day].
bool _outOn(VendorBooking b, DateTime day) {
  final start = _dateOnly(day);
  final end = start.add(const Duration(days: 1));
  return b.startsAt.isBefore(end) && b.endsAt.isAfter(start);
}

String _rangeLabel(DateTime start, DateTime end) {
  final day = DateFormat('d MMM');
  return DateUtils.isSameDay(start, end)
      ? day.format(start)
      : '${day.format(start)} – ${day.format(end)}';
}

/// Vendor mode → Calendar: the month's bookings and blocked days. Owners
/// and managers block days so customers can't book them.
class VendorCalendarScreen extends ConsumerStatefulWidget {
  const VendorCalendarScreen({this.today, super.key});

  /// Fixed in tests; the real date otherwise.
  final DateTime? today;

  @override
  ConsumerState<VendorCalendarScreen> createState() =>
      _VendorCalendarScreenState();
}

class _VendorCalendarScreenState extends ConsumerState<VendorCalendarScreen> {
  late final DateTime _today = _dateOnly(widget.today ?? DateTime.now());
  late DateTime _month = DateTime(_today.year, _today.month);
  late DateTime _selected = _today;

  void _moveMonth(int by) => setState(() {
    _month = DateTime(_month.year, _month.month + by);
    _selected = _month.year == _today.year && _month.month == _today.month
        ? _today
        : _month;
  });

  Future<void> _block(String vendorId, {DateTimeRange? initial}) async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: _today,
      lastDate: _today.add(const Duration(days: 730)),
      initialDateRange: initial,
      helpText: 'Days to block',
      saveText: 'Next',
    );
    if (range == null || !mounted) return;
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => _BlockDialog(start: range.start, end: range.end),
    );
    if (reason == null || !mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(vendorCalendarProvider(vendorId, _month).notifier)
          .block(range.start, range.end, reason: reason);
      unawaited(Haptics.success());
      messenger.showSnackBar(
        SnackBar(
          content: Text('Blocked ${_rangeLabel(range.start, range.end)}'),
        ),
      );
    } on Object catch (e) {
      final field = e is ApiException
          ? e.fieldError('starts_on') ?? e.fieldError('ends_on')
          : null;
      messenger.showSnackBar(
        SnackBar(content: Text(field ?? ErrorState.describe(e).$2)),
      );
    }
  }

  Future<void> _unblock(String vendorId, Blackout blackout) async {
    final label = _rangeLabel(blackout.startsOn, blackout.endsOn);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Open $label again?'),
        content: const Text('Customers will be able to book these days.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep blocked'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Open'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(vendorCalendarProvider(vendorId, _month).notifier)
          .unblock(blackout);
      messenger.showSnackBar(SnackBar(content: Text('$label is open again')));
    } on Object catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text(ErrorState.describe(e).$2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final actor = ref.watch(activeActorProvider);
    if (actor is! VendorActor) return const Scaffold();
    final vendorId = actor.vendorId;
    final role = ref
        .watch(authSessionProvider)
        .value
        ?.vendors
        .where((v) => v.id == vendorId)
        .firstOrNull
        ?.role;
    final canBlock = role == 'owner' || role == 'manager';
    final provider = vendorCalendarProvider(vendorId, _month);
    final value = ref.watch(provider);
    final data = value.value;

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      floatingActionButton: canBlock
          ? FloatingActionButton.extended(
              onPressed: () => _block(vendorId),
              icon: const Icon(Icons.event_busy_rounded),
              label: const Text('Block dates'),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(provider.future),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          // Room at the bottom so the button never covers the agenda.
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            0,
            AppSpacing.screen,
            AppSpacing.screen + AppSizes.buttonLg + AppSpacing.lg,
          ),
          children: [
            _MonthHeader(
              month: _month,
              loading: value.isLoading,
              onPrevious: () => _moveMonth(-1),
              onNext: () => _moveMonth(1),
            ),
            if (value.hasError && data == null)
              ErrorState(
                error: value.error!,
                onRetry: () => ref.invalidate(provider),
              )
            else ...[
              _MonthGrid(
                month: _month,
                today: _today,
                selected: _selected,
                data: data,
                onSelect: (d) => setState(() => _selected = d),
              ),
              const SizedBox(height: AppSpacing.sm),
              const _Legend(),
              const SizedBox(height: AppSpacing.lg),
              if (data != null)
                _DayAgenda(
                  day: _selected,
                  today: _today,
                  data: data,
                  canBlock: canBlock,
                  onBlock: () => _block(
                    vendorId,
                    initial: DateTimeRange(start: _selected, end: _selected),
                  ),
                  onUnblock: (b) => _unblock(vendorId, b),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({
    required this.month,
    required this.loading,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime month;
  final bool loading;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Previous month',
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                DateFormat('MMMM y').format(month),
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
              ),
              SizedBox(
                height: 2,
                child: loading ? const LinearProgressIndicator() : null,
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Next month',
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.today,
    required this.selected,
    required this.data,
    required this.onSelect,
  });

  final DateTime month;
  final DateTime today;
  final DateTime selected;
  final CalendarMonth? data;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Weeks start on Monday.
    final lead = DateTime(month.year, month.month).weekday - 1;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final cells = ((lead + daysInMonth) / 7).ceil() * 7;
    final weekday = DateFormat.E();

    return Column(
      children: [
        Row(
          children: [
            // 1 Jan 2024 was a Monday.
            for (var i = 0; i < 7; i++)
              Expanded(
                child: Text(
                  weekday.format(DateTime(2024, 1, 1 + i)),
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.9,
          children: [
            for (var i = 0; i < cells; i++)
              if (i < lead || i >= lead + daysInMonth)
                const SizedBox.shrink()
              else
                _DayCell(
                  day: DateTime(month.year, month.month, i - lead + 1),
                  today: today,
                  selected: selected,
                  data: data,
                  onTap: onSelect,
                ),
          ],
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.today,
    required this.selected,
    required this.data,
    required this.onTap,
  });

  final DateTime day;
  final DateTime today;
  final DateTime selected;
  final CalendarMonth? data;
  final ValueChanged<DateTime> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final palette = context.palette;
    final blocked = data?.blackouts.any((b) => b.covers(day)) ?? false;
    final out = [
      for (final b in data?.bookings ?? const <VendorBooking>[])
        if (_outOn(b, day)) b,
    ];
    final pending = out
        .where((b) => b.status == VendorBookingStatus.pendingVendor)
        .length;
    final agreed = out.length - pending;
    final isSelected = DateUtils.isSameDay(day, selected);
    final isToday = DateUtils.isSameDay(day, today);
    final muted = day.isBefore(today) || blocked;

    return Semantics(
      button: true,
      selected: isSelected,
      label: [
        DateFormat('EEEE d MMMM').format(day),
        if (blocked) 'blocked',
        if (out.isNotEmpty) '${out.length} bookings out',
      ].join(', '),
      excludeSemantics: true,
      child: InkWell(
        key: ValueKey('day-${day.day}'),
        borderRadius: AppRadii.smAll,
        onTap: () => onTap(day),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.primaryContainer
                : blocked
                ? colors.surfaceContainerHighest
                : null,
            borderRadius: AppRadii.smAll,
            border: isToday ? Border.all(color: colors.primary) : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${day.day}',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: muted ? colors.onSurfaceVariant : colors.onSurface,
                  decoration: blocked ? TextDecoration.lineThrough : null,
                  fontWeight: isToday ? FontWeight.w700 : null,
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                height: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 2,
                  children: [
                    if (agreed > 0) _Dot(color: palette.success),
                    if (pending > 0) _Dot(color: palette.warning),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 6,
    height: 6,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style = context.textTheme.labelSmall?.copyWith(
      color: colors.onSurfaceVariant,
    );
    Widget entry(Widget mark, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.xs,
      children: [
        mark,
        Text(label, style: style),
      ],
    );
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppSpacing.lg,
      children: [
        entry(_Dot(color: context.palette.success), 'Booked'),
        entry(_Dot(color: context.palette.warning), 'Awaiting you'),
        entry(
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          'Blocked',
        ),
      ],
    );
  }
}

class _DayAgenda extends StatelessWidget {
  const _DayAgenda({
    required this.day,
    required this.today,
    required this.data,
    required this.canBlock,
    required this.onBlock,
    required this.onUnblock,
  });

  final DateTime day;
  final DateTime today;
  final CalendarMonth data;
  final bool canBlock;
  final VoidCallback onBlock;
  final ValueChanged<Blackout> onUnblock;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final muted = text.bodyMedium?.copyWith(
      color: context.colors.onSurfaceVariant,
    );
    final blackout = data.blackouts.where((b) => b.covers(day)).firstOrNull;
    final out = [
      for (final b in data.bookings)
        if (_outOn(b, day)) b,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(DateFormat('EEEE d MMMM').format(day), style: text.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        if (blackout != null)
          Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: ListTile(
              leading: const Icon(Icons.event_busy_rounded),
              title: Text(
                'Blocked '
                '${_rangeLabel(blackout.startsOn, blackout.endsOn)}',
              ),
              subtitle: Text(
                [
                  ?blackout.reason,
                  'Customers can’t book these days.',
                ].join(' · '),
              ),
              trailing: canBlock
                  ? TextButton(
                      onPressed: () => onUnblock(blackout),
                      child: const Text('Open'),
                    )
                  : null,
            ),
          )
        else if (canBlock && !day.isBefore(today))
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: onBlock,
                icon: const Icon(Icons.block_rounded),
                label: const Text('Block this day'),
              ),
            ),
          ),
        if (out.isEmpty)
          Text('Nothing out this day.', style: muted)
        else
          for (final b in out) _AgendaBooking(booking: b, day: day),
      ],
    );
  }
}

class _AgendaBooking extends StatelessWidget {
  const _AgendaBooking({required this.booking, required this.day});

  final VendorBooking booking;
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final b = booking;
    final time = DateFormat('h:mm a');
    final goesOut = DateUtils.isSameDay(b.startsAt, day);
    final comesBack = DateUtils.isSameDay(b.endsAt, day);
    final when = switch ((goesOut, comesBack)) {
      (true, true) =>
        'Out ${time.format(b.startsAt)}, back ${time.format(b.endsAt)}',
      (true, false) => 'Goes out ${time.format(b.startsAt)}',
      (false, true) => 'Comes back ${time.format(b.endsAt)}',
      _ => 'Out until ${DateFormat('d MMM').format(b.endsAt)}',
    };
    final pending = b.status == VendorBookingStatus.pendingVendor;
    final items = [for (final l in b.lines) '${l.qty} × ${l.title}'];

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Icon(
          goesOut
              ? Icons.outbox_rounded
              : comesBack
              ? Icons.move_to_inbox_rounded
              : Icons.event_available_rounded,
          color: pending ? context.palette.warning : context.palette.success,
        ),
        title: Text(b.customerName),
        subtitle: Text(
          '${items.join(', ')}\n'
          '$when${pending ? ' · Awaiting your answer' : ''}',
        ),
        isThreeLine: true,
        trailing: Text(
          '#${b.number}',
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

/// Asks for an optional reason. Pops it (possibly empty) to block, or null
/// to cancel. Owns its controller, which must outlive the closing animation.
class _BlockDialog extends StatefulWidget {
  const _BlockDialog({required this.start, required this.end});

  final DateTime start;
  final DateTime end;

  @override
  State<_BlockDialog> createState() => _BlockDialogState();
}

class _BlockDialogState extends State<_BlockDialog> {
  final _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Block ${_rangeLabel(widget.start, widget.end)}?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customers won’t be able to book these days. Bookings you '
            'already have stay.',
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _reason,
            maxLength: 120,
            decoration: const InputDecoration(
              labelText: 'Reason (optional)',
              hintText: 'Christmas break',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_reason.text),
          child: const Text('Block'),
        ),
      ],
    );
  }
}
