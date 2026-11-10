import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/async_value_view.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/entrance.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/presentation/business_photo.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_controllers.dart';
import 'package:petalsinajar/features/vendor/presentation/web_dashboard.dart';

/// Vendor mode → Inventory: what the business rents out, with stock and
/// prices. Read-only for now; adding and editing happen on the web.
/// What the item sheet needs to know about where it is.
typedef _Access = ({
  String vendorId,
  String? handle,
  bool canEdit,
  ItemPhotoPicker pickPhoto,
});

class VendorInventoryScreen extends ConsumerStatefulWidget {
  const VendorInventoryScreen({this.pickPhoto = pickItemPhoto, super.key});

  /// Photos are the one thing editable here: snapping them is easier on the
  /// phone than on the web.
  final ItemPhotoPicker pickPhoto;

  @override
  ConsumerState<VendorInventoryScreen> createState() =>
      _VendorInventoryScreenState();
}

class _VendorInventoryScreenState extends ConsumerState<VendorInventoryScreen> {
  /// Null shows everything but archived items.
  VendorItemStatus? _status;
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final actor = ref.watch(activeActorProvider);
    if (actor is! VendorActor) return const Scaffold();

    final membership = ref
        .watch(authSessionProvider)
        .value
        ?.vendors
        .where((v) => v.id == actor.vendorId)
        .firstOrNull;
    final handle = membership?.handle;
    final access = (
      vendorId: actor.vendorId,
      handle: handle,
      canEdit: membership?.role == 'owner' || membership?.role == 'manager',
      pickPhoto: widget.pickPhoto,
    );
    final provider = vendorInventoryProvider(actor.vendorId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        actions: [
          if (handle != null)
            IconButton(
              tooltip: 'Add an item on the web',
              icon: const Icon(Icons.add_rounded),
              onPressed: () =>
                  openWebDashboard(context, WebDashboard.newItem(handle)),
            ),
        ],
      ),
      body: AsyncValueView(
        value: ref.watch(provider),
        onRetry: () => ref.invalidate(provider),
        isEmpty: (items) => items.isEmpty,
        empty: EmptyState(
          title: 'No items yet',
          message:
              'Add your chairs, tents, decor and more on the web dashboard. '
              'They show up here and on Discover once they’re active.',
          icon: Icons.inventory_2_rounded,
          actionLabel: handle == null ? null : 'Add your first item',
          onAction: handle == null
              ? null
              : () => openWebDashboard(context, WebDashboard.newItem(handle)),
        ),
        data: (items) => RefreshIndicator(
          onRefresh: () => ref.refresh(provider.future),
          child: _List(
            items: items,
            access: access,
            status: _status,
            query: _query,
            onStatus: (s) => setState(() => _status = s),
            onQuery: (q) => setState(() => _query = q.trim().toLowerCase()),
          ),
        ),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    required this.items,
    required this.access,
    required this.status,
    required this.query,
    required this.onStatus,
    required this.onQuery,
  });

  final List<VendorItem> items;
  final _Access access;
  final VendorItemStatus? status;
  final String query;
  final ValueChanged<VendorItemStatus?> onStatus;
  final ValueChanged<String> onQuery;

  @override
  Widget build(BuildContext context) {
    int count(VendorItemStatus s) => items.where((i) => i.status == s).length;
    final shown = [
      for (final i in items)
        if ((status == null
                ? i.status != VendorItemStatus.archived
                : i.status == status) &&
            (query.isEmpty || i.title.toLowerCase().contains(query)))
          i,
    ];
    final active = count(VendorItemStatus.active);
    final stock = items
        .where((i) => i.status == VendorItemStatus.active)
        .fold(0, (sum, i) => sum + i.stock);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.sm,
            AppSpacing.screen,
            0,
          ),
          child: _WebBanner(handle: access.handle),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.lg,
            AppSpacing.screen,
            AppSpacing.sm,
          ),
          child: Text(
            '$active active · $stock units to rent',
            style: context.textTheme.titleMedium,
          ),
        ),
        if (items.length > 6)
          Padding(
            padding: AppSpacing.screenPadding,
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Search your items',
              ),
              onChanged: onQuery,
            ),
          ),
        SizedBox(
          height: AppSizes.minTouchTarget + AppSpacing.sm,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screen,
              vertical: AppSpacing.xs,
            ),
            children: [
              for (final s in <VendorItemStatus?>[
                null,
                ...VendorItemStatus.values,
              ])
                if (s == null || count(s) > 0)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(
                        s == null ? 'All' : '${_statusLabel(s)} · ${count(s)}',
                      ),
                      selected: status == s,
                      onSelected: (_) => onStatus(s),
                    ),
                  ),
            ],
          ),
        ),
        if (shown.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text(
              'Nothing matches.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
            ),
          )
        else
          for (final (i, item) in shown.indexed)
            _ItemTile(item: item, access: access).entrance(i),
      ],
    );
  }
}

/// "Editing happens on the web" with a button that goes there.
class _WebBanner extends StatelessWidget {
  const _WebBanner({required this.handle});

  final String? handle;

  @override
  Widget build(BuildContext context) {
    final h = handle;
    return Card(
      margin: EdgeInsets.zero,
      color: context.palette.vendor.container,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.cardAll),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Icon(Icons.computer_rounded, color: context.palette.vendor.color),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                'Add items, change prices and stock on the web dashboard. '
                'Changes show here when you pull to refresh.',
                style: context.textTheme.bodyMedium,
              ),
            ),
            if (h != null) ...[
              const SizedBox(width: AppSpacing.sm),
              AppButton(
                label: 'Open',
                size: AppButtonSize.small,
                onPressed: () =>
                    openWebDashboard(context, WebDashboard.items(h)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String _statusLabel(VendorItemStatus s) => switch (s) {
  VendorItemStatus.active => 'Active',
  VendorItemStatus.draft => 'Draft',
  VendorItemStatus.paused => 'Paused',
  VendorItemStatus.archived => 'Archived',
};

String _unit(String unit) => switch (unit) {
  'per_day' => 'day',
  'per_hour' => 'hour',
  _ => 'event',
};

class _ItemTile extends StatelessWidget {
  const _ItemTile({required this.item, required this.access});

  static const _photo = 64.0;

  final VendorItem item;
  final _Access access;

  @override
  Widget build(BuildContext context) {
    final price =
        'from ${MoneyFormat.format(item.fromPriceMinor, item.currency)} '
        '/ ${_unit(item.unit)}';
    final status = _statusLabel(item.status);
    final dim = item.status != VendorItemStatus.active;
    return Semantics(
      button: true,
      label: '${item.title}, $status, $price, ${item.stock} in stock',
      excludeSemantics: true,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screen,
          vertical: AppSpacing.xs,
        ),
        onTap: () => _showDetails(context),
        leading: SizedBox.square(
          dimension: _photo,
          child: Opacity(
            opacity: dim ? 0.5 : 1,
            child: item.photoUrl == null
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.surfaceContainerHighest,
                      borderRadius: AppRadii.smAll,
                    ),
                    child: const Icon(Icons.chair_rounded),
                  )
                : MediaImage(
                    url: item.photoUrl!,
                    blurhash: item.blurhash,
                    borderRadius: AppRadii.smAll,
                  ),
          ),
        ),
        title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          [
            price,
            [
              '${item.stock} in stock',
              if (item.variants.length > 1) '${item.variants.length} options',
            ].join(' · '),
          ].join('\n'),
        ),
        isThreeLine: true,
        trailing: item.status == VendorItemStatus.active
            ? null
            : _StatusPill(status: item.status),
      ),
    );
  }

  Future<void> _showDetails(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheet) => _ItemSheet(itemId: item.id, access: access),
  );
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final VendorItemStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      VendorItemStatus.active => context.palette.success,
      VendorItemStatus.draft => context.colors.onSurfaceVariant,
      VendorItemStatus.paused => context.palette.warning,
      VendorItemStatus.archived => context.colors.outline,
    };
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
        child: Text(
          _statusLabel(status),
          style: context.textTheme.labelSmall?.copyWith(color: color),
        ),
      ),
    );
  }
}

/// Photos (editable), stock per option, the booking rules, "Edit on web".
class _ItemSheet extends ConsumerWidget {
  const _ItemSheet({required this.itemId, required this.access});

  final String itemId;
  final _Access access;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read live, so photo changes show here as they save.
    final item = ref
        .watch(vendorInventoryProvider(access.vendorId))
        .value
        ?.where((i) => i.id == itemId)
        .firstOrNull;
    if (item == null) return const SizedBox.shrink();
    final text = context.textTheme;
    final muted = text.bodyMedium?.copyWith(
      color: context.colors.onSurfaceVariant,
    );
    final h = access.handle;
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          0,
          AppSpacing.screen,
          AppSpacing.lg,
        ),
        children: [
          Row(
            children: [
              Expanded(child: Text(item.title, style: text.titleLarge)),
              _StatusPill(status: item.status),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'from ${MoneyFormat.format(item.fromPriceMinor, item.currency)} '
            '/ ${_unit(item.unit)}',
            style: text.titleMedium?.copyWith(color: context.colors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          _ItemPhotos(item: item, access: access),
          const SizedBox(height: AppSpacing.md),
          Text('Stock', style: text.labelLarge),
          for (final v in item.variants)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      v.active ? v.name : '${v.name} (off)',
                      style: v.active ? text.bodyMedium : muted,
                    ),
                  ),
                  Text('${v.quantity}', style: text.bodyMedium),
                ],
              ),
            ),
          if (item.variants.isEmpty)
            Text('No options set up yet.', style: muted),
          const SizedBox(height: AppSpacing.md),
          Text(
            [
              if (item.minQty > 1) 'Minimum ${item.minQty} per booking',
              if (item.instantBook) 'Instant book on',
              if (item.status == VendorItemStatus.draft)
                'Customers can’t see drafts yet',
              if (item.status == VendorItemStatus.paused)
                'Hidden from customers while paused',
            ].join(' · '),
            style: muted,
          ),
          if (h != null) ...[
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Edit on the web',
              icon: Icons.open_in_new_rounded,
              expand: true,
              onPressed: () => openWebDashboard(
                context,
                WebDashboard.editItem(h, item.title),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The item's photos in order, the first being the cover. Owners and
/// managers can snap or choose new ones, remove one, or make one the cover;
/// each change saves at once.
class _ItemPhotos extends ConsumerStatefulWidget {
  const _ItemPhotos({required this.item, required this.access});

  final VendorItem item;
  final _Access access;

  @override
  ConsumerState<_ItemPhotos> createState() => _ItemPhotosState();
}

class _ItemPhotosState extends ConsumerState<_ItemPhotos> {
  static const _size = 88.0;
  static const _maxPhotos = 12;

  var _busy = false;

  VendorInventory get _inventory =>
      ref.read(vendorInventoryProvider(widget.access.vendorId).notifier);

  Future<void> _run(Future<void> Function() change, String done) async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      await change();
      unawaited(Haptics.success());
      messenger.showSnackBar(SnackBar(content: Text(done)));
    } on ApiException catch (e) {
      unawaited(Haptics.warning());
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } on MediaUploadException catch (e) {
      unawaited(Haptics.warning());
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _add({required bool camera}) async {
    final path = await widget.access.pickPhoto(camera: camera);
    if (path == null || !mounted) return;
    // A first photo, or a fresh snap of an item with none, is the cover.
    final hasPhotos = widget.item.media.any((m) => !m.isVideo);
    await _run(
      () => _inventory.addPhoto(widget.item.id, path, asCover: !hasPhotos),
      'Photo added',
    );
  }

  Future<void> _options(int index) async {
    final media = widget.item.media;
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (index > 0)
              ListTile(
                leading: const Icon(Icons.star_rounded),
                title: const Text('Make cover photo'),
                onTap: () => Navigator.of(sheet).pop('cover'),
              ),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded),
              title: const Text('Remove photo'),
              onTap: () => Navigator.of(sheet).pop('remove'),
            ),
          ],
        ),
      ),
    );
    if (!mounted || choice == null) return;
    final rest = [...media]..removeAt(index);
    if (choice == 'cover') {
      await _run(
        () => _inventory.setPhotos(widget.item.id, [media[index], ...rest]),
        'Cover photo updated',
      );
    } else {
      await _run(
        () => _inventory.setPhotos(widget.item.id, rest),
        'Photo removed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = widget.item.media;
    final canEdit = widget.access.canEdit && !_busy;
    final text = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text('Photos', style: text.labelLarge)),
            if (_busy)
              const SizedBox.square(
                dimension: AppSizes.iconSm,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        SizedBox(
          height: _size,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final (i, m) in media.indexed)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Semantics(
                    button: widget.access.canEdit,
                    label: i == 0 ? 'Cover photo' : 'Photo ${i + 1}',
                    excludeSemantics: true,
                    child: InkWell(
                      borderRadius: AppRadii.smAll,
                      onTap: canEdit ? () => _options(i) : null,
                      child: Stack(
                        children: [
                          SizedBox.square(
                            dimension: _size,
                            child: m.isVideo
                                ? DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: context
                                          .colors
                                          .surfaceContainerHighest,
                                      borderRadius: AppRadii.smAll,
                                    ),
                                    child: const Icon(Icons.videocam_rounded),
                                  )
                                : MediaImage(
                                    media: m,
                                    borderRadius: AppRadii.smAll,
                                  ),
                          ),
                          if (i == 0)
                            Positioned(
                              left: AppSpacing.xs,
                              bottom: AppSpacing.xs,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: context.colors.inverseSurface,
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.pill,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.xs,
                                  ),
                                  child: Text(
                                    'Cover',
                                    style: text.labelSmall?.copyWith(
                                      color: context.colors.onInverseSurface,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (widget.access.canEdit && media.length < _maxPhotos) ...[
                _AddTile(
                  icon: Icons.photo_camera_rounded,
                  label: 'Take photo',
                  size: _size,
                  onTap: canEdit ? () => _add(camera: true) : null,
                ),
                const SizedBox(width: AppSpacing.sm),
                _AddTile(
                  icon: Icons.photo_library_rounded,
                  label: 'Choose',
                  size: _size,
                  onTap: canEdit ? () => _add(camera: false) : null,
                ),
              ],
              if (media.isEmpty && !widget.access.canEdit)
                Center(
                  child: Text(
                    'No photos yet.',
                    style: text.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (widget.access.canEdit && media.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              'Tap a photo to make it the cover or remove it.',
              style: text.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({
    required this.icon,
    required this.label,
    required this.size,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.smAll),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(height: AppSpacing.xxs),
            Text(label, style: context.textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
