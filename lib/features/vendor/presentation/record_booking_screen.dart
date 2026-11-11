import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/async_value_view.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/presentation/edit_business_screen.dart'
    show parseCedis;
import 'package:petalsinajar/features/vendor/presentation/vendor_controllers.dart';

/// Requests → Record a booking: one agreed by phone or in person, so its
/// stock comes off the calendar. It's saved confirmed; if the phone belongs
/// to an app user, they see it in My bookings.
class RecordBookingScreen extends ConsumerWidget {
  const RecordBookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actor = ref.watch(activeActorProvider);
    if (actor is! VendorActor) return const Scaffold();
    final provider = vendorInventoryProvider(actor.vendorId);

    return Scaffold(
      appBar: AppBar(title: const Text('Record a booking')),
      body: AsyncValueView(
        value: ref.watch(provider),
        onRetry: () => ref.invalidate(provider),
        isEmpty: (items) => _bookable(items).isEmpty,
        empty: const EmptyState(
          title: 'No items to book',
          message:
              'Add items on the web dashboard first; active ones show here.',
          icon: Icons.inventory_2_rounded,
        ),
        data: (items) =>
            _Form(vendorId: actor.vendorId, items: _bookable(items)),
      ),
    );
  }
}

/// Active items with at least one active variant.
List<VendorItem> _bookable(List<VendorItem> items) => [
  for (final i in items)
    if (i.status == VendorItemStatus.active && i.variants.any((v) => v.active))
      i,
];

class _Line {
  _Line(this.item, this.variant, this.qty);

  final VendorItem item;
  final VendorItemVariant variant;
  int qty;

  String get title => item.variants.where((v) => v.active).length > 1
      ? '${item.title} · ${variant.name}'
      : item.title;
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.vendorId, required this.items});

  final String vendorId;
  final List<VendorItem> items;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _deliveryFee = TextEditingController();
  final _paid = TextEditingController();
  final _note = TextEditingController();
  final _lines = <_Line>[];
  final _errors = <String, String>{};
  late DateTime _out;
  late DateTime _back;
  var _delivery = false;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    final tomorrow = DateUtils.dateOnly(
      DateTime.now(),
    ).add(const Duration(days: 1));
    _out = tomorrow.add(const Duration(hours: 8));
    _back = tomorrow.add(const Duration(days: 1, hours: 18));
  }

  @override
  void dispose() {
    for (final c in [_name, _phone, _address, _deliveryFee, _paid, _note]) {
      c.dispose();
    }
    super.dispose();
  }

  String get _currency => widget.items.first.currency;

  /// From catalog prices; the server works out the exact total.
  int get _estimate =>
      _lines.fold(0, (sum, l) => sum + l.item.fromPriceMinor * l.qty) +
      (_delivery ? parseCedis(_deliveryFee.text) ?? 0 : 0);

  Future<void> _pickTime({required bool out}) async {
    final current = out ? _out : _back;
    final now = DateTime.now();
    final day = await showDatePicker(
      context: context,
      initialDate: current.isBefore(now) ? now : current,
      firstDate: DateUtils.dateOnly(now),
      lastDate: now.add(const Duration(days: 730)),
    );
    if (day == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
    );
    if (time == null || !mounted) return;
    final picked = DateTime(
      day.year,
      day.month,
      day.day,
      time.hour,
      time.minute,
    );
    setState(() {
      _errors.remove('collect_at');
      if (out) {
        _out = picked;
        // Keep the return after the handover.
        if (!_back.isAfter(_out)) _back = _out.add(const Duration(days: 1));
      } else {
        _back = picked;
      }
    });
  }

  Future<void> _addItem() async {
    final picked = await showModalBottomSheet<_Line>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _ItemPicker(items: widget.items),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _errors.remove('lines');
      final same = _lines
          .where((l) => l.variant.id == picked.variant.id)
          .firstOrNull;
      if (same != null) {
        same.qty += picked.qty;
      } else {
        _lines.add(picked);
      }
    });
  }

  Future<void> _save() async {
    final errors = <String, String>{
      if (_name.text.trim().isEmpty) 'customer.name': 'Enter their name.',
      if (_phone.text.trim().length < 9)
        'customer.phone': 'Enter their phone number.',
      if (!_back.isAfter(_out))
        'collect_at': 'The return must be after the items go out.',
      if (_delivery && _address.text.trim().isEmpty)
        'fulfilment.address': 'Where are you delivering to?',
      if (_delivery &&
          _deliveryFee.text.trim().isNotEmpty &&
          parseCedis(_deliveryFee.text) == null)
        'delivery_minor': 'Enter a fee, e.g. 150.',
      if (_paid.text.trim().isNotEmpty && parseCedis(_paid.text) == null)
        'paid_minor': 'Enter an amount, e.g. 500.',
      if (_lines.isEmpty) 'lines': 'Add at least one item.',
    };
    setState(() {
      _errors
        ..clear()
        ..addAll(errors);
    });
    if (errors.isNotEmpty) {
      unawaited(Haptics.warning());
      return;
    }

    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final saved = await ref
          .read(vendorRequestsProvider(widget.vendorId).notifier)
          .record(
            RecordedBooking(
              customerName: _name.text,
              customerPhone: _phone.text,
              startsAt: _out,
              endsAt: _back,
              delivery: _delivery,
              address: _address.text,
              deliveryFeeMinor: parseCedis(_deliveryFee.text) ?? 0,
              paidMinor: parseCedis(_paid.text) ?? 0,
              note: _note.text,
              lines: [
                for (final l in _lines)
                  RecordedLine(
                    itemId: l.item.id,
                    variantId: l.variant.id,
                    qty: l.qty,
                  ),
              ],
            ),
          );
      unawaited(Haptics.success());
      if (!mounted) return;
      setState(() => _saving = false);
      unawaited(Navigator.of(context).maybePop());
      messenger.showSnackBar(
        SnackBar(content: Text('Booking #${saved.number} recorded')),
      );
    } on ApiException catch (e) {
      unawaited(Haptics.warning());
      if (!mounted) return;
      setState(() {
        _saving = false;
        _errors.addAll({
          for (final MapEntry(:key, :value) in e.fieldErrors.entries)
            key: value.first,
        });
      });
      if (e.fieldErrors.isEmpty) {
        messenger.showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final colors = context.colors;
    final at = DateFormat('EEE d MMM, h:mm a');
    final money = [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))];

    Widget heading(String title) => Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl, bottom: AppSpacing.sm),
      child: Text(title, style: text.titleMedium),
    );

    return AbsorbPointer(
      absorbing: _saving,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          0,
          AppSpacing.screen,
          AppSpacing.xxl,
        ),
        children: [
          heading('Customer'),
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Name',
              errorText: _errors['customer.name'],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone',
              hintText: '024 123 4567',
              helperText: 'If they use the app, they’ll see the booking.',
              errorText: _errors['customer.phone'],
            ),
          ),

          heading('Dates'),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.outbox_rounded),
                  title: const Text('Goes out'),
                  subtitle: Text(at.format(_out)),
                  trailing: const Icon(Icons.edit_calendar_rounded),
                  onTap: () => _pickTime(out: true),
                ),
                ListTile(
                  leading: const Icon(Icons.move_to_inbox_rounded),
                  title: const Text('Comes back'),
                  subtitle: Text(at.format(_back)),
                  trailing: const Icon(Icons.edit_calendar_rounded),
                  onTap: () => _pickTime(out: false),
                ),
              ],
            ),
          ),
          if (_errors['collect_at'] case final error?)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Text(
                error,
                style: text.bodySmall?.copyWith(color: colors.error),
              ),
            ),

          heading('Handover'),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: false,
                label: Text('Pickup'),
                icon: Icon(Icons.storefront_rounded),
              ),
              ButtonSegment(
                value: true,
                label: Text('Delivery'),
                icon: Icon(Icons.local_shipping_rounded),
              ),
            ],
            selected: {_delivery},
            onSelectionChanged: (s) => setState(() => _delivery = s.first),
          ),
          if (_delivery) ...[
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _address,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Delivery address',
                errorText: _errors['fulfilment.address'],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _deliveryFee,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: money,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Delivery fee (optional)',
                prefixText: MoneyFormat.symbol(_currency),
                errorText: _errors['delivery_minor'],
              ),
            ),
          ],

          heading('Items'),
          for (final (i, l) in _lines.indexed)
            _LineTile(
              key: ValueKey(l.variant.id),
              line: l,
              error: _errors['lines.$i.qty'] ?? _errors['lines.$i'],
              onChanged: (qty) => setState(() {
                _errors
                  ..remove('lines.$i.qty')
                  ..remove('lines.$i');
                if (qty < 1) {
                  _lines.removeAt(i);
                } else {
                  l.qty = qty;
                }
              }),
            ),
          if (_errors['lines'] case final error?)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Text(
                error,
                style: text.bodySmall?.copyWith(color: colors.error),
              ),
            ),
          OutlinedButton.icon(
            onPressed: _addItem,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add item'),
          ),

          heading('Payment'),
          TextField(
            controller: _paid,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: money,
            decoration: InputDecoration(
              labelText: 'Already paid (optional)',
              prefixText: MoneyFormat.symbol(_currency),
              helperText: 'Cash or MoMo you’ve received outside the app.',
              errorText: _errors['paid_minor'],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _note,
            maxLines: 3,
            maxLength: 1000,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Private note (optional)',
              hintText: 'Only your team sees this',
            ),
          ),

          const SizedBox(height: AppSpacing.lg),
          if (_lines.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'About, at your catalog prices',
                      style: text.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Text(
                    MoneyFormat.format(_estimate, _currency),
                    style: text.titleMedium,
                  ),
                ],
              ),
            ),
          AppButton(
            label: 'Save booking',
            icon: Icons.check_rounded,
            expand: true,
            isLoading: _saving,
            onPressed: _saving ? null : _save,
          ),
        ],
      ),
    );
  }
}

class _LineTile extends StatelessWidget {
  const _LineTile({
    required this.line,
    required this.onChanged,
    this.error,
    super.key,
  });

  final _Line line;
  final ValueChanged<int> onChanged;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final colors = context.colors;
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(line.title, style: text.titleSmall),
                      Text(
                        '${line.variant.quantity} owned',
                        style: text.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: line.qty == 1 ? 'Remove' : 'One less',
                  onPressed: () => onChanged(line.qty - 1),
                  icon: Icon(
                    line.qty == 1
                        ? Icons.delete_outline_rounded
                        : Icons.remove_rounded,
                  ),
                ),
                Text('${line.qty}', style: text.titleMedium),
                IconButton(
                  tooltip: 'One more',
                  onPressed: () => onChanged(line.qty + 1),
                  icon: const Icon(Icons.add_rounded),
                ),
              ],
            ),
            if (error != null)
              Text(
                error!,
                style: text.bodySmall?.copyWith(color: colors.error),
              ),
          ],
        ),
      ),
    );
  }
}

/// Pick an item (and its variant), with how many. Pops a [_Line].
class _ItemPicker extends StatefulWidget {
  const _ItemPicker({required this.items});

  final List<VendorItem> items;

  @override
  State<_ItemPicker> createState() => _ItemPickerState();
}

class _ItemPickerState extends State<_ItemPicker> {
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final q = _query.toLowerCase();
    final options = [
      for (final item in widget.items)
        if (q.isEmpty || item.title.toLowerCase().contains(q))
          for (final v in item.variants)
            if (v.active) _Line(item, v, item.minQty),
    ];

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75,
      child: Column(
        children: [
          Padding(
            padding: AppSpacing.screenPadding,
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Search your items',
              ),
              onChanged: (t) => setState(() => _query = t.trim()),
            ),
          ),
          Expanded(
            child: options.isEmpty
                ? const Center(child: Text('Nothing found'))
                : ListView(
                    children: [
                      for (final o in options)
                        ListTile(
                          leading: SizedBox.square(
                            dimension: AppSizes.avatarMd,
                            child: o.item.media.isEmpty
                                ? const Icon(Icons.chair_rounded)
                                : MediaImage(
                                    media: o.item.media.first,
                                    borderRadius: AppRadii.smAll,
                                  ),
                          ),
                          title: Text(o.title),
                          subtitle: Text(
                            '${MoneyFormat.format(
                              o.item.fromPriceMinor,
                              o.item.currency,
                            )} · ${o.variant.quantity} owned',
                          ),
                          onTap: () => Navigator.of(context).pop(o),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
