import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/features/discover/presentation/discover_controllers.dart';
import 'package:petalsinajar/features/discover/presentation/discover_labels.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/place_picker.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

/// Looks like a search field; opens the full-screen search.
class DiscoverSearchBar extends StatelessWidget {
  const DiscoverSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Search items, vendors and events',
      excludeSemantics: true,
      child: Material(
        color: context.colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          onTap: () => context.push(Routes.search),
          child: SizedBox(
            height: AppSizes.buttonMd,
            child: Row(
              children: [
                const SizedBox(width: AppSpacing.lg),
                Icon(
                  Icons.search_rounded,
                  color: context.colors.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Search chairs, tents, vendors…',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The location chip on its own row (it can be long: "Near Airport
/// Residential"), then All · Weddings · Birthdays · Corporate.
class DiscoverFilters extends ConsumerWidget {
  const DiscoverFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      discoverControllerProvider.select((f) => f.eventType),
    );
    void choose(EventType? type) {
      unawaited(Haptics.selection());
      ref.read(discoverControllerProvider.notifier).setEventType(type);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: AppSpacing.screenPadding,
          child: PlaceChip(),
        ),
        SizedBox(
          height: AppSizes.minTouchTarget,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: AppSpacing.screenPadding,
            children: [
              for (final type in <EventType?>[null, ...EventType.values]) ...[
                _TypeChip(
                  type: type,
                  selected: selected == type,
                  onSelected: () => choose(type),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.type,
    required this.selected,
    required this.onSelected,
  });

  final EventType? type;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final accent = accentOf(context, type);
    final t = type;
    return ChoiceChip(
      label: Text(t == null ? 'All' : eventTypePlural(t)),
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
      selectedColor: accent.color,
      side: BorderSide(color: accent.color),
      labelStyle: TextStyle(
        color: selected ? accent.onColor : accent.onContainer,
      ),
    );
  }
}
