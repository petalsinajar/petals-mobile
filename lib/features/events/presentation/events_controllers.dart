import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/events/data/events_repository_impl.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';
import 'package:petalsinajar/features/events/domain/event_draft.dart';
import 'package:petalsinajar/features/events/domain/event_plan.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_controllers.g.dart';

@riverpod
Future<List<Event>> myEvents(Ref ref) =>
    ref.watch(eventsRepositoryProvider).myEvents();

@riverpod
Future<EventPlan> eventPlan(Ref ref, String eventId) =>
    ref.watch(eventsRepositoryProvider).plan(eventId);

/// The event page header, with optimistic RSVP.
@riverpod
class EventDetailController extends _$EventDetailController {
  @override
  Future<EventDetail> build(String eventId) =>
      ref.watch(eventsRepositoryProvider).detail(eventId);

  /// Updates chips and counts immediately; rolls back and rethrows on failure.
  Future<void> rsvp(RsvpStatus status) async {
    final before = state.value;
    if (before == null || before.event.viewerRsvp == status) return;

    final event = before.event;
    state = AsyncData(
      before.copyWith(
        event: event.copyWith(
          viewerRsvp: status,
          rsvpCounts: event.rsvpCounts.move(
            from: event.viewerRsvp,
            to: status,
          ),
        ),
      ),
    );
    try {
      final saved = await ref
          .read(eventsRepositoryProvider)
          .rsvp(eventId, status);
      if (!ref.mounted) return;
      state = AsyncData(saved);
      ref.invalidate(myEventsProvider);
    } on Object {
      if (ref.mounted) state = AsyncData(before);
      rethrow;
    }
  }
}

/// The event's post feed, with "load more".
@riverpod
class EventFeed extends _$EventFeed {
  var _loadingMore = false;

  @override
  Future<Paginated<EventPost>> build(String eventId) =>
      ref.watch(eventsRepositoryProvider).feed(eventId);

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || _loadingMore) return;
    _loadingMore = true;
    try {
      final next = await ref
          .read(eventsRepositoryProvider)
          .feed(eventId, cursor: current.nextCursor);
      if (ref.mounted) state = AsyncData(current.append(next));
    } finally {
      _loadingMore = false;
    }
  }
}

/// The create-event stepper's in-progress answers.
@riverpod
class EventDraftController extends _$EventDraftController {
  @override
  EventDraft build() => const EventDraft();

  void update(EventDraft Function(EventDraft draft) change) =>
      state = change(state);
}

/// Submitting the draft. `AsyncData(null)` until an event is created.
@riverpod
class CreateEvent extends _$CreateEvent {
  @override
  FutureOr<Event?> build() => null;

  Future<Event?> submit(EventDraft draft) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(eventsRepositoryProvider).create(draft),
    );
    if (state.hasValue) ref.invalidate(myEventsProvider);
    return state.value;
  }
}
