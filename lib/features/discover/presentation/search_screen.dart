import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/core/widgets/skeleton.dart';
import 'package:petalsinajar/features/discover/presentation/detail_args.dart';
import 'package:petalsinajar/features/discover/presentation/detail_controllers.dart';
import 'package:petalsinajar/features/discover/presentation/discover_labels.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/catalog_cards.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/vendor_card.dart';

/// Full-screen search over items, vendors and events, optionally within a
/// category (from the Categories grid).
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({this.categoryId, this.categoryName, super.key});

  final String? categoryId;
  final String? categoryName;

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  static const _debounce = Duration(milliseconds: 350);

  final _field = TextEditingController();
  Timer? _timer;
  var _query = '';

  bool get _inCategory => widget.categoryId != null;

  @override
  void dispose() {
    _timer?.cancel();
    _field.dispose();
    super.dispose();
  }

  void _onChanged(String text) {
    _timer?.cancel();
    _timer = Timer(_debounce, () {
      if (mounted) setState(() => _query = text.trim());
    });
  }

  void _submit(String text) {
    _timer?.cancel();
    setState(() => _query = text.trim());
    unawaited(ref.read(recentSearchesProvider.notifier).add(text));
  }

  void _useRecent(String text) {
    _field.text = text;
    _submit(text);
  }

  @override
  Widget build(BuildContext context) {
    final showRecent = _query.isEmpty && !_inCategory;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: TextField(
            controller: _field,
            autofocus: !_inCategory,
            textInputAction: TextInputAction.search,
            onChanged: _onChanged,
            onSubmitted: _submit,
            decoration: InputDecoration(
              hintText: _inCategory
                  ? 'Search in ${widget.categoryName ?? 'category'}'
                  : 'Search items, vendors, events',
              border: InputBorder.none,
            ),
          ),
          actions: [
            if (_field.text.isNotEmpty)
              IconButton(
                tooltip: 'Clear',
                icon: const Icon(Icons.close_rounded),
                onPressed: () {
                  _field.clear();
                  setState(() => _query = '');
                },
              ),
          ],
          bottom: showRecent
              ? null
              : const TabBar(
                  tabs: [
                    Tab(text: 'Items'),
                    Tab(text: 'Vendors'),
                    Tab(text: 'Events'),
                  ],
                ),
        ),
        body: showRecent
            ? _Recent(onPick: _useRecent)
            : TabBarView(
                children: [
                  _ItemResults(query: _query, categoryId: widget.categoryId),
                  _VendorResults(
                    query: _query,
                    categoryId: widget.categoryId,
                  ),
                  _EventResults(query: _query),
                ],
              ),
      ),
    );
  }
}

class _Recent extends ConsumerWidget {
  const _Recent({required this.onPick});

  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recent = ref.watch(recentSearchesProvider);
    if (recent.isEmpty) {
      return const EmptyState(
        title: 'Find anything for your event',
        message: 'Try "chiavari chairs", "tent" or a vendor’s name.',
        icon: Icons.search_rounded,
      );
    }
    final notifier = ref.read(recentSearchesProvider.notifier);
    return ListView(
      children: [
        ListTile(
          title: const Text('Recent searches'),
          trailing: TextButton(
            onPressed: notifier.clear,
            child: const Text('Clear'),
          ),
        ),
        for (final q in recent)
          ListTile(
            leading: const Icon(Icons.history_rounded),
            title: Text(q),
            onTap: () => onPick(q),
            trailing: IconButton(
              tooltip: 'Remove $q',
              icon: const Icon(Icons.close_rounded),
              onPressed: () => notifier.remove(q),
            ),
          ),
      ],
    );
  }
}

/// Shared loading / error / empty handling for a results tab.
Widget _results<T>({
  required AsyncValue<T> value,
  required bool Function(T) isEmpty,
  required Widget Function(T) builder,
  required VoidCallback onRetry,
  String emptyTitle = 'No matches',
}) => value.when(
  loading: () => const SkeletonList(),
  error: (e, _) => ErrorState(error: e, onRetry: onRetry),
  data: (data) => isEmpty(data)
      ? EmptyState(
          title: emptyTitle,
          message: 'Try another word, or fewer of them.',
          icon: Icons.search_off_rounded,
        )
      : builder(data),
);

class _ItemResults extends ConsumerWidget {
  const _ItemResults({required this.query, required this.categoryId});

  final String query;
  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = searchItemsProvider(query, categoryId);
    return _results(
      value: ref.watch(provider),
      isEmpty: (page) => page.isEmpty,
      onRetry: () => ref.invalidate(provider),
      builder: (page) => LayoutBuilder(
        builder: (context, box) {
          final tile =
              (box.maxWidth - AppSpacing.screen * 2 - AppSpacing.md) / 2;
          return GridView.builder(
            padding: const EdgeInsets.all(AppSpacing.screen),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.lg,
              crossAxisSpacing: AppSpacing.md,
              mainAxisExtent:
                  tile +
                  MediaQuery.textScalerOf(
                    context,
                  ).scale(ItemTile.captionHeight),
            ),
            itemCount: page.items.length,
            itemBuilder: (context, i) {
              final item = page.items[i];
              final tag = 'search-item-${item.id}';
              return ItemTile(
                item: item,
                heroTag: tag,
                onTap: () => context.openItem(item, heroTag: tag),
              );
            },
          );
        },
      ),
    );
  }
}

class _VendorResults extends ConsumerWidget {
  const _VendorResults({required this.query, required this.categoryId});

  final String query;
  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = searchVendorsProvider(query, categoryId);
    return _results(
      value: ref.watch(provider),
      isEmpty: (vendors) => vendors.isEmpty,
      onRetry: () => ref.invalidate(provider),
      emptyTitle: query.isEmpty ? 'Type a vendor’s name' : 'No vendors found',
      builder: (vendors) => ListView(
        children: [
          for (final v in vendors)
            ListTile(
              leading: Hero(
                tag: 'search-vendor-${v.id}',
                child: Avatar(name: v.name, imageUrl: v.logoUrl),
              ),
              title: Row(
                children: [
                  Flexible(child: Text(v.name)),
                  if (v.isVerified) ...[
                    const SizedBox(width: AppSpacing.xs),
                    const VerifiedBadge(),
                  ],
                ],
              ),
              subtitle: Text(
                [
                  ?v.city,
                  ?distanceLabel(v.distanceKm),
                  ?ratingLabel(v.rating),
                ].join(' · '),
              ),
              onTap: () => context.openVendor(
                v.id,
                initial: v,
                heroTag: 'search-vendor-${v.id}',
              ),
            ),
        ],
      ),
    );
  }
}

class _EventResults extends ConsumerWidget {
  const _EventResults({required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(viewerIdProvider) == null) {
      return EmptyState(
        title: 'Sign in to search events',
        message: 'Find public events and the ones you’re invited to.',
        icon: Icons.celebration_rounded,
        actionLabel: 'Sign in',
        onAction: () => context.push(Routes.signInFrom(Routes.discover)),
      );
    }
    if (query.length < 2) {
      return const EmptyState(
        title: 'Search events by name',
        icon: Icons.celebration_rounded,
      );
    }
    final provider = searchEventsProvider(query);
    final day = DateFormat('EEE d MMM');
    return _results(
      value: ref.watch(provider),
      isEmpty: (events) => events.isEmpty,
      onRetry: () => ref.invalidate(provider),
      emptyTitle: 'No events found',
      builder: (events) => ListView(
        children: [
          for (final e in events)
            ListTile(
              leading: const Icon(Icons.event_rounded),
              title: Text(e.title),
              subtitle: Text(
                [
                  day.format(e.startsAt),
                  if (e.type != null) eventTypeLabel(e.type!),
                  ?e.venueCity,
                ].join(' · '),
              ),
              onTap: () => context.push(Routes.event(e.id)),
            ),
        ],
      ),
    );
  }
}
