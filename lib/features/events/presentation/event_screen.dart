import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/core/widgets/skeleton.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';
import 'package:petalsinajar/features/events/presentation/event_labels.dart';
import 'package:petalsinajar/features/events/presentation/events_controllers.dart';
import 'package:petalsinajar/features/events/presentation/widgets/countdown.dart';
import 'package:petalsinajar/features/events/presentation/widgets/event_cover.dart';
import 'package:petalsinajar/features/events/presentation/widgets/event_feed_section.dart';
import 'package:petalsinajar/features/events/presentation/widgets/people.dart';
import 'package:petalsinajar/features/events/presentation/widgets/plan_section.dart';
import 'package:petalsinajar/features/events/presentation/widgets/rsvp_section.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// `/events/:id`. [initial] (from the tapped card) paints the cover while the
/// detail loads, so the Hero lands on a real image.
class EventScreen extends ConsumerWidget {
  const EventScreen({required this.eventId, this.initial, super.key});

  final String eventId;
  final Event? initial;

  Future<void> _rsvp(
    BuildContext context,
    WidgetRef ref,
    RsvpStatus status,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(eventDetailControllerProvider(eventId).notifier)
          .rsvp(status);
    } on Object catch (e) {
      await Haptics.warning();
      final (_, title, _) = ErrorState.describe(e);
      messenger.showSnackBar(
        SnackBar(content: Text("$title — your RSVP wasn't saved.")),
      );
    }
  }

  Future<void> _refresh(WidgetRef ref) async {
    final detail = eventDetailControllerProvider(eventId);
    ref
      ..invalidate(eventFeedProvider(eventId))
      ..invalidate(eventPlanProvider(eventId))
      ..invalidate(detail);
    await ref.read(detail.future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(eventDetailControllerProvider(eventId));
    final event = detail.value?.event ?? initial;

    if (detail.hasError && !detail.hasValue) {
      return Scaffold(
        appBar: AppBar(),
        body: ErrorState(
          error: detail.error!,
          onRetry: () => ref.invalidate(eventDetailControllerProvider(eventId)),
        ),
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refresh(ref),
        edgeOffset: kToolbarHeight,
        child: CustomScrollView(
          slivers: [
            _CoverAppBar(eventId: eventId, event: event),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screen,
                AppSpacing.lg,
                AppSpacing.screen,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: switch (detail.value) {
                  final d? => _Body(
                    detail: d,
                    onRsvp: (s) => _rsvp(context, ref, s),
                  ),
                  null => const SkeletonList(itemCount: 4),
                },
              ),
            ),
            if (detail.hasValue)
              SliverPadding(
                padding: AppSpacing.screenPadding,
                sliver: SliverToBoxAdapter(
                  child: EventFeedSection(eventId: eventId),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CoverAppBar extends StatelessWidget {
  const _CoverAppBar({required this.eventId, required this.event});

  final String eventId;
  final Event? event;

  @override
  Widget build(BuildContext context) {
    final e = event;
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: MediaQuery.sizeOf(context).width * 9 / 16,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: eventCoverHeroTag(eventId),
          child: e == null
              ? const Bone()
              : EventCover(type: e.type, cover: e.cover),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.detail, required this.onRsvp});

  final EventDetail detail;
  final ValueChanged<RsvpStatus> onRsvp;

  @override
  Widget build(BuildContext context) {
    final event = detail.event;
    final text = context.textTheme;
    final accent = context.palette.accentFor(event.type);
    final muted = context.colors.onSurfaceVariant;
    const gap = SizedBox(height: AppSpacing.xl);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(event.type.icon, size: AppSizes.iconSm, color: accent.color),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '${event.type.label} · ${event.visibility.label}',
              style: text.labelLarge?.copyWith(color: accent.color),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(event.title, style: text.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        _InfoLine(
          icon: Icons.schedule_rounded,
          text: EventDates.startLine(event.startsAt),
        ),
        _InfoLine(
          icon: Icons.place_rounded,
          text: [
            event.venue.name,
            event.venue.city,
          ].where((s) => s.isNotEmpty).toSet().join(', '),
        ),
        _InfoLine(
          icon: Icons.groups_rounded,
          text: '${event.guestCount} guests expected',
        ),
        gap,
        EventCountdown(event: event),
        gap,
        HostsRow(host: detail.host, coHosts: detail.coHosts),
        if (event.description.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(event.description, style: text.bodyLarge),
        ],
        gap,
        RsvpSection(detail: detail, onRsvp: onRsvp),
        if (event.viewerIsHosting) ...[
          gap,
          Text('Plan & rent', style: text.titleMedium),
          Text(
            'Bookings and cart for this event',
            style: text.bodySmall?.copyWith(color: muted),
          ),
          const SizedBox(height: AppSpacing.md),
          PlanSection(eventId: event.id),
        ],
        gap,
        Text('Event feed', style: text.titleMedium),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final muted = context.colors.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: AppSizes.iconSm, color: muted),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(color: muted),
            ),
          ),
        ],
      ),
    );
  }
}
