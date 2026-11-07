import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/mock_session.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/network/dio_client.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/events/data/event_dtos.dart';
import 'package:petalsinajar/features/events/data/events_mock_source.dart';
import 'package:petalsinajar/features/events/data/events_remote_source.dart';
import 'package:petalsinajar/features/events/data/events_source.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';
import 'package:petalsinajar/features/events/domain/event_draft.dart';
import 'package:petalsinajar/features/events/domain/event_plan.dart';
import 'package:petalsinajar/features/events/domain/events_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_repository_impl.g.dart';

class EventsRepositoryImpl implements EventsRepository {
  EventsRepositoryImpl(this._source);

  final EventsSource _source;

  /// Malformed payloads surface as [ApiException]s, like network errors.
  Future<T> _parse<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on ApiException {
      rethrow;
    } on Object catch (e) {
      throw ApiException.from(e);
    }
  }

  @override
  Future<List<Event>> myEvents() => _parse(() async {
    final rows = await _source.myEvents();
    return [for (final r in rows) EventDto.fromJson(r).toDomain()];
  });

  @override
  Future<EventDetail> detail(String eventId) => _parse(
    () async =>
        EventDetailDto.fromJson(await _source.detail(eventId)).toDomain(),
  );

  @override
  Future<Paginated<EventPost>> feed(String eventId, {String? cursor}) =>
      _parse(() async {
        final body = await _source.feed(eventId, cursor: cursor);
        return Paginated.fromJson(
          body,
          (j) => EventPostDto.fromJson(j).toDomain(),
        );
      });

  @override
  Future<EventPlan> plan(String eventId) => _parse(
    () async => EventPlanDto.fromJson(await _source.plan(eventId)).toDomain(),
  );

  @override
  Future<Event> create(EventDraft draft) => _parse(() async {
    final fields = {
      'type': draft.type!.name,
      'title': draft.title.trim(),
      'description': '',
      'starts_at': draft.startsAt!.toUtc().toIso8601String(),
      if (draft.endsAt case final ends?)
        'ends_at': ends.toUtc().toIso8601String(),
      'venue': {
        'name': draft.venueName.trim(),
        'city': draft.venueCity.trim(),
        if (draft.venueAddress.trim().isNotEmpty)
          'address': draft.venueAddress.trim(),
      },
      'guest_count': draft.guestCount,
      'visibility': draft.visibility.name,
    };
    final json = await _source.create(fields, coverPath: draft.coverPath);
    return EventDto.fromJson(json).toDomain();
  });

  @override
  Future<EventDetail> rsvp(String eventId, RsvpStatus status) => _parse(
    () async => EventDetailDto.fromJson(
      await _source.rsvp(eventId, enumToSnake(status)),
    ).toDomain(),
  );
}

@Riverpod(keepAlive: true)
EventsRepository eventsRepository(Ref ref) {
  final source = ref.watch(appConfigProvider).useMocks
      ? EventsMockSource(
          seed: ref.watch(seedLoaderProvider),
          delay: ref.watch(mockDelayProvider),
          viewerId: ref.watch(mockViewerIdProvider),
        )
      : EventsRemoteSource(ref.watch(dioProvider));
  return EventsRepositoryImpl(source);
}
