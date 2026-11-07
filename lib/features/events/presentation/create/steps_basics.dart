import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/press_scale.dart';
import 'package:petalsinajar/features/events/domain/event_draft.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';
import 'package:petalsinajar/features/events/presentation/event_labels.dart';
import 'package:petalsinajar/features/events/presentation/events_controllers.dart';

class TypeStep extends ConsumerWidget {
  const TypeStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(eventDraftControllerProvider).type;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screen),
      children: [
        for (final type in EventType.values) ...[
          _TypeCard(
            type: type,
            selected: type == selected,
            onTap: () {
              unawaited(Haptics.selection());
              ref
                  .read(eventDraftControllerProvider.notifier)
                  .update((d) => d.copyWith(type: type));
            },
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final EventType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = context.palette.accentFor(type);
    final text = context.textTheme;
    final fg = selected ? accent.onColor : accent.onContainer;
    return Semantics(
      selected: selected,
      button: true,
      child: PressScale(
        child: AnimatedContainer(
          duration: context.reduceMotion ? Duration.zero : AppMotion.medium,
          curve: AppMotion.standard,
          decoration: BoxDecoration(
            color: selected ? accent.color : accent.container,
            borderRadius: AppRadii.cardAll,
          ),
          child: InkWell(
            borderRadius: AppRadii.cardAll,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Row(
                children: [
                  Icon(type.icon, size: AppSizes.iconLg, color: fg),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type.label,
                          style: text.titleLarge?.copyWith(color: fg),
                        ),
                        Text(
                          type.tagline,
                          style: text.bodyMedium?.copyWith(color: fg),
                        ),
                      ],
                    ),
                  ),
                  if (selected) Icon(Icons.check_circle_rounded, color: fg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleStep extends ConsumerWidget {
  const TitleStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.read(eventDraftControllerProvider);
    final hint = switch (draft.type) {
      EventType.wedding => "Ama & Kojo's White Wedding",
      EventType.birthday => 'Efua turns 30 🎉',
      EventType.corporate || null => 'Fintech Ghana Summit 2026',
    };
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screen),
      children: [
        TextFormField(
          initialValue: draft.title,
          autofocus: true,
          maxLength: EventDraft.maxTitleLength,
          textCapitalization: TextCapitalization.sentences,
          style: context.textTheme.titleLarge,
          decoration: InputDecoration(hintText: hint),
          onChanged: (v) => ref
              .read(eventDraftControllerProvider.notifier)
              .update((d) => d.copyWith(title: v)),
        ),
      ],
    );
  }
}

class DateTimeStep extends ConsumerWidget {
  const DateTimeStep({super.key});

  Future<void> _pickStart(BuildContext context, WidgetRef ref) async {
    final draft = ref.read(eventDraftControllerProvider);
    final now = DateTime.now();
    final initial = draft.startsAt ?? now.add(const Duration(days: 14));
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: now.add(const Duration(days: 365 * 3)),
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        draft.startsAt ?? DateTime(now.year, 1, 1, 14),
      ),
    );
    if (time == null) return;
    final start = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    ref
        .read(eventDraftControllerProvider.notifier)
        .update((d) => d.copyWith(startsAt: start, endsAt: null));
  }

  Future<void> _pickEnd(BuildContext context, WidgetRef ref) async {
    final start = ref.read(eventDraftControllerProvider).startsAt;
    if (start == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        start.add(const Duration(hours: 6)),
      ),
    );
    if (time == null) return;
    var end = DateTime(
      start.year,
      start.month,
      start.day,
      time.hour,
      time.minute,
    );
    // Ending "before" the start means it runs past midnight.
    if (!end.isAfter(start)) end = end.add(const Duration(days: 1));
    ref
        .read(eventDraftControllerProvider.notifier)
        .update((d) => d.copyWith(endsAt: end));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(eventDraftControllerProvider);
    final start = draft.startsAt;
    final end = draft.endsAt;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screen),
      children: [
        _PickerTile(
          icon: Icons.event_rounded,
          label: 'Starts',
          value: start == null
              ? 'Pick a date and time'
              : DateFormat('EEEE d MMMM y · h:mm a').format(start),
          onTap: () => _pickStart(context, ref),
        ),
        const SizedBox(height: AppSpacing.md),
        _PickerTile(
          icon: Icons.schedule_rounded,
          label: 'Ends (optional)',
          value: end == null
              ? 'Add an end time'
              : DateFormat('EEE d MMM · h:mm a').format(end),
          onTap: start == null ? null : () => _pickEnd(context, ref),
        ),
      ],
    );
  }
}

class _PickerTile extends StatelessWidget {
  const _PickerTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        enabled: onTap != null,
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(value, style: context.textTheme.titleMedium),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
