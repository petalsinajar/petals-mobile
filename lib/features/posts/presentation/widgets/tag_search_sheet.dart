import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/inline_error.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';
import 'package:petalsinajar/features/posts/presentation/create_post_controller.dart';

/// Search for what to tag: an item someone rented, or a vendor.
Future<TagTarget?> showTagSearch(BuildContext context) =>
    showModalBottomSheet<TagTarget>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const _TagSearchSheet(),
    );

class _TagSearchSheet extends StatefulWidget {
  const _TagSearchSheet();

  @override
  State<_TagSearchSheet> createState() => _TagSearchSheetState();
}

class _TagSearchSheetState extends State<_TagSearchSheet> {
  final _field = TextEditingController();
  Timer? _debounce;
  var _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _field.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.75,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: AppSpacing.screenPadding,
                child: TextField(
                  controller: _field,
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: 'Search chairs, tents, vendors…',
                  ),
                  onChanged: (text) {
                    _debounce?.cancel();
                    _debounce = Timer(
                      const Duration(milliseconds: 300),
                      () => setState(() => _query = text.trim()),
                    );
                  },
                ),
              ),
              const TabBar(
                tabs: [
                  Tab(text: 'Items'),
                  Tab(text: 'Vendors'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _Results(type: TagTargetType.item, query: _query),
                    _Results(type: TagTargetType.vendor, query: _query),
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

class _Results extends ConsumerWidget {
  const _Results({required this.type, required this.query});

  final TagTargetType type;
  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (query.length < 2) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Text(
          type == TagTargetType.item
              ? 'Type what you rented, e.g. "chiavari".'
              : 'Type a vendor’s name.',
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      );
    }
    final provider = tagSearchProvider(type, query);
    return ref
        .watch(provider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Padding(
            padding: AppSpacing.screenPadding,
            child: InlineError(
              error: e,
              onRetry: () => ref.invalidate(provider),
            ),
          ),
          data: (results) => results.isEmpty
              ? const Center(child: Text('Nothing found'))
              : ListView(
                  children: [
                    for (final t in results)
                      ListTile(
                        leading: type == TagTargetType.vendor
                            ? Avatar(name: t.label, imageUrl: t.imageUrl)
                            : SizedBox.square(
                                dimension: AppSizes.avatarMd,
                                child: t.imageUrl == null
                                    ? const Icon(Icons.chair_rounded)
                                    : MediaImage(
                                        url: t.imageUrl!,
                                        borderRadius: AppRadii.smAll,
                                      ),
                              ),
                        title: Text(t.label),
                        subtitle: t.subtitle == null ? null : Text(t.subtitle!),
                        onTap: () => Navigator.of(context).pop(t),
                      ),
                  ],
                ),
        );
  }
}
