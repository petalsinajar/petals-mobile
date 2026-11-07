import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_draft.dart';
import 'package:petalsinajar/features/events/presentation/event_labels.dart';
import 'package:petalsinajar/features/events/presentation/events_controllers.dart';
import 'package:petalsinajar/features/events/presentation/widgets/event_cover.dart';

class VenueStep extends ConsumerWidget {
  const VenueStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.read(eventDraftControllerProvider);
    final notifier = ref.read(eventDraftControllerProvider.notifier);
    const gap = SizedBox(height: AppSpacing.md);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screen),
      children: [
        TextFormField(
          initialValue: draft.venueName,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Venue',
            hintText: 'Aburi Botanical Gardens',
            prefixIcon: Icon(Icons.place_rounded),
          ),
          onChanged: (v) => notifier.update((d) => d.copyWith(venueName: v)),
        ),
        gap,
        TextFormField(
          initialValue: draft.venueCity,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'City',
            hintText: 'Accra',
            prefixIcon: Icon(Icons.location_city_rounded),
          ),
          onChanged: (v) => notifier.update((d) => d.copyWith(venueCity: v)),
        ),
        gap,
        TextFormField(
          initialValue: draft.venueAddress,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Address (optional)',
            helperText: 'Vendors use this for deliveries.',
            prefixIcon: Icon(Icons.map_rounded),
          ),
          onChanged: (v) => notifier.update((d) => d.copyWith(venueAddress: v)),
        ),
      ],
    );
  }
}

class GuestsStep extends ConsumerWidget {
  const GuestsStep({super.key});

  static const presets = [20, 50, 100, 250, 500];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(eventDraftControllerProvider).guestCount;
    final notifier = ref.read(eventDraftControllerProvider.notifier);
    void set(int value) {
      unawaited(Haptics.selection());
      notifier.update(
        (d) => d.copyWith(
          guestCount: value.clamp(1, EventDraft.maxGuests),
        ),
      );
    }

    final step = count >= 100 ? 10 : 1;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screen),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.filledTonal(
              tooltip: 'Fewer guests',
              onPressed: count > 1 ? () => set(count - step) : null,
              icon: const Icon(Icons.remove_rounded),
            ),
            SizedBox(
              width: AppSizes.illustration,
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: context.textTheme.displayMedium,
              ),
            ),
            IconButton.filledTonal(
              tooltip: 'More guests',
              onPressed: () => set(count + step),
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
        Text(
          'guests',
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final p in presets)
              ChoiceChip(
                label: Text('$p'),
                selected: count == p,
                onSelected: (_) => set(p),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'A rough number is fine. Vendors use it to suggest quantities.',
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class VisibilityStep extends ConsumerWidget {
  const VisibilityStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(eventDraftControllerProvider).visibility;
    return RadioGroup<EventVisibility>(
      groupValue: selected,
      onChanged: (v) {
        if (v == null) return;
        unawaited(Haptics.selection());
        ref
            .read(eventDraftControllerProvider.notifier)
            .update((d) => d.copyWith(visibility: v));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.screen),
        children: [
          for (final v in EventVisibility.values) ...[
            Card(
              child: RadioListTile<EventVisibility>(
                value: v,
                secondary: Icon(v.icon),
                title: Text(v.label),
                subtitle: Text(v.description),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class CoverStep extends ConsumerWidget {
  const CoverStep({super.key});

  Future<void> _pick(WidgetRef ref) async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (file == null) return;
    ref
        .read(eventDraftControllerProvider.notifier)
        .update((d) => d.copyWith(coverPath: file.path));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(eventDraftControllerProvider);
    final path = draft.coverPath;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screen),
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: path == null
              ? EventCover(type: draft.type!, borderRadius: AppRadii.cardAll)
              : ClipRRect(
                  borderRadius: AppRadii.cardAll,
                  child: Image.file(File(path), fit: BoxFit.cover),
                ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: path == null ? 'Choose a photo' : 'Change photo',
          icon: Icons.photo_library_rounded,
          variant: AppButtonVariant.secondary,
          onPressed: () => _pick(ref),
        ),
        if (path != null)
          AppButton(
            label: 'Remove',
            variant: AppButtonVariant.ghost,
            onPressed: () => ref
                .read(eventDraftControllerProvider.notifier)
                .update((d) => d.copyWith(coverPath: null)),
          ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Optional — you can add one later.',
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
