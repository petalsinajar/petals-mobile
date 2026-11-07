import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/core/widgets/async_value_view.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/entrance.dart';
import 'package:petalsinajar/core/widgets/skeleton.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/my_events.dart';
import 'package:petalsinajar/features/events/presentation/events_controllers.dart';
import 'package:petalsinajar/features/events/presentation/widgets/event_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyEventsScreen extends ConsumerWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(myEventsProvider);
    void create() => context.push(Routes.createEvent);

    return DefaultTabController(
      length: MyEventsBucket.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My events'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Planning'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: create,
          icon: const Icon(Icons.add_rounded),
          label: const Text('New event'),
        ),
        body: AsyncValueView(
          value: events,
          onRetry: () => ref.invalidate(myEventsProvider),
          loading: const SkeletonList(itemCount: 3, item: _SkeletonEventCard()),
          data: (all) {
            final groups = groupMyEvents(all, DateTime.now());
            Future<void> refresh() => ref.refresh(myEventsProvider.future);
            return TabBarView(
              children: [
                for (final bucket in MyEventsBucket.values)
                  _EventList(
                    events: groups[bucket]!,
                    bucket: bucket,
                    onRefresh: refresh,
                    onCreate: create,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _EventList extends StatelessWidget {
  const _EventList({
    required this.events,
    required this.bucket,
    required this.onRefresh,
    required this.onCreate,
  });

  final List<Event> events;
  final MyEventsBucket bucket;
  final Future<void> Function() onRefresh;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      final (title, message) = switch (bucket) {
        MyEventsBucket.upcoming => (
          'Nothing on the calendar',
          'Events you RSVP to will show up here.',
        ),
        MyEventsBucket.planning => (
          'Plan something special',
          'Weddings, birthdays, launches — start with the basics.',
        ),
        MyEventsBucket.past => (
          'No memories yet',
          'Events you hosted or attended will be kept here.',
        ),
      };
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: EmptyState(
                title: title,
                message: message,
                actionLabel: bucket == MyEventsBucket.planning
                    ? 'Create an event'
                    : null,
                onAction: onCreate,
              ),
            ),
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        // Clear the FAB.
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.lg,
          AppSpacing.screen,
          AppSpacing.xxxl * 2,
        ),
        itemCount: events.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.lg),
        itemBuilder: (context, i) => EventCard(
          event: events[i],
          onTap: () =>
              context.push(Routes.event(events[i].id), extra: events[i]),
        ).entrance(i),
      ),
    );
  }
}

class _SkeletonEventCard extends StatelessWidget {
  const _SkeletonEventCard();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.lg,
        AppSpacing.screen,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Bone(borderRadius: AppRadii.cardAll),
          ),
          SizedBox(height: AppSpacing.md),
          Bone.text(words: 4),
          SizedBox(height: AppSpacing.xs),
          Bone.text(words: 3, fontSize: 12),
        ],
      ),
    );
  }
}
