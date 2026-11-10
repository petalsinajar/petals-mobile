import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/features/discover/domain/areas.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/discover_controllers.dart';
import 'package:petalsinajar/features/discover/presentation/discover_labels.dart';

/// Asks for location, and if that's refused, says so and offers the list.
Future<void> useMyLocation(BuildContext context, WidgetRef ref) async {
  final messenger = ScaffoldMessenger.of(context);
  final ok = await ref
      .read(discoverControllerProvider.notifier)
      .useMyLocation();
  if (ok || !context.mounted) return;
  messenger.showSnackBar(
    const SnackBar(
      content: Text(
        "We couldn't get your location. Pick an area instead.",
      ),
    ),
  );
  await showPlacePicker(context);
}

Future<void> showPlacePicker(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _PlacePickerSheet(host: context),
    );

/// The location chip: "Near East Legon", "Finding you…" or "Choose area".
class PlaceChip extends ConsumerWidget {
  const PlaceChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(discoverControllerProvider);
    final label = switch ((filter.place, filter.status)) {
      (final DiscoverPlace place, _) => placeLabel(place),
      (null, PlaceStatus.locating) => 'Finding your area…',
      (null, _) => 'Choose your area',
    };
    final icon = switch (filter.place?.source) {
      PlaceSource.eventVenue => Icons.celebration_rounded,
      PlaceSource.device => Icons.my_location_rounded,
      _ => Icons.place_rounded,
    };
    return ActionChip(
      avatar: Icon(icon, size: AppSizes.iconSm),
      label: Text(label),
      tooltip: 'Change area',
      onPressed: () {
        unawaited(Haptics.selection());
        unawaited(showPlacePicker(context));
      },
    );
  }
}

/// Shown when Discover doesn't know where the viewer is. Asks politely
/// instead of firing the system prompt on first open.
class LocationPrompt extends ConsumerWidget {
  const LocationPrompt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.md,
        AppSpacing.screen,
        0,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        color: context.colors.secondaryContainer,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.cardAll),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'See vendors that deliver to you',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Rentals depend on where your event is. Share your location '
                'once, or pick an area. We only use it to find vendors.',
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  AppButton(
                    label: 'Use my location',
                    icon: Icons.my_location_rounded,
                    size: AppButtonSize.small,
                    onPressed: () => useMyLocation(context, ref),
                  ),
                  AppButton(
                    label: 'Pick an area',
                    variant: AppButtonVariant.outline,
                    size: AppButtonSize.small,
                    onPressed: () => showPlacePicker(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlacePickerSheet extends ConsumerWidget {
  const _PlacePickerSheet({required this.host});

  /// The page that opened the sheet; it outlives the sheet for follow-ups.
  final BuildContext host;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(discoverControllerProvider).place;
    final controller = ref.read(discoverControllerProvider.notifier);
    void done() => Navigator.of(context).pop();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, scroll) => ListView(
        controller: scroll,
        children: [
          Padding(
            padding: AppSpacing.screenPadding,
            child: Text(
              'Where is your event?',
              style: context.textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ListTile(
            leading: const Icon(Icons.my_location_rounded),
            title: const Text('Use my location'),
            onTap: () {
              done();
              unawaited(useMyLocation(host, ref));
            },
          ),
          const Divider(),
          for (final area in launchAreas)
            ListTile(
              leading: const Icon(Icons.place_outlined),
              title: Text(area.name),
              selected:
                  current?.source == PlaceSource.picked &&
                  current?.label == area.name,
              onTap: () {
                unawaited(Haptics.selection());
                unawaited(controller.pickArea(area));
                done();
              },
            ),
        ],
      ),
    );
  }
}
