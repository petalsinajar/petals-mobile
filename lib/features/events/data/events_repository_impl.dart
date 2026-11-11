import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/media_uploader.dart';
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
  EventsRepositoryImpl(this._source, {this.uploadCover});

  final EventsSource _source;

  /// Uploads a cover photo and returns its media id. Without it (demo data)
  /// the picked file is shown as-is.
  final Future<String> Function(String path)? uploadCover;

  /// Lists the app shows whole (My Events, guest lists) stop after this many
  /// pages, so a huge list can't stall a screen.
  static const _maxPages = 10;

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

  /// Every row of a cursor-paginated list, up to [_maxPages] pages.
  Future<List<Json>> _all(Future<Json> Function(String? cursor) page) async {
    final rows = <Json>[];
    String? cursor;
    for (var i = 0; i < _maxPages; i++) {
      final body = await page(cursor);
      rows.addAll((body['data'] as List? ?? const []).cast<Json>());
      cursor = body['next_cursor'] as String?;
      if (cursor == null) break;
    }
    return rows;
  }

  @override
  Future<List<Event>> myEvents() => _parse(() async {
    // The server splits by end time; the screen re-buckets by role and RSVP.
    final [upcoming, past] = await Future.wait([
      _all((c) => _source.myEvents(scope: 'upcoming', cursor: c)),
      _all((c) => _source.myEvents(scope: 'past', cursor: c)),
    ]);
    return [
      for (final r in [...upcoming, ...past]) EventDto.fromJson(r).toDomain(),
    ];
  });

  @override
  Future<EventDetail> detail(String eventId) => _parse(() async {
    // Future.wait, not a record's `.wait`: that wraps failures in a
    // ParallelWaitError, and a 404 must stay a 404.
    final [event as Json, members as List<Json>] = await Future.wait<Object>([
      _source.detail(eventId),
      _all((c) => _source.members(eventId, cursor: c)),
    ]);
    return eventDetailFrom(EventDto.fromJson(event), [
      for (final m in members) MemberDto.fromJson(m),
    ]);
  });

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
  Future<EventPlan> plan(String eventId) => _parse(() async {
    final rows = await _all((c) => _source.bookings(eventId, cursor: c));
    // The cart lands with checkout; until then a plan is its bookings.
    return EventPlan(
      bookings: [for (final b in rows) EventBookingDto.fromJson(b).toDomain()],
    );
  });

  @override
  Future<Event> create(EventDraft draft) => _parse(() async {
    final path = draft.coverPath;
    final upload = uploadCover;
    final coverMediaId = path != null && upload != null
        ? await upload(path)
        : null;
    final localCover = path != null && upload == null
        ? Uri.file(path).toString()
        : null;
    final startsAt = draft.startsAt!;
    String? optional(String value) =>
        value.trim().isEmpty ? null : value.trim();

    final json = await _source.create({
      'type': draft.type!.name,
      'title': draft.title.trim(),
      'starts_at': startsAt.toUtc().toIso8601String(),
      'ends_at': draft.effectiveEndsAt.toUtc().toIso8601String(),
      'timezone': 'Africa/Accra',
      'venue_name': draft.venueName.trim(),
      'venue_city': draft.venueCity.trim(),
      'venue_address': ?optional(draft.venueAddress),
      'guest_count': draft.guestCount,
      'visibility': draft.visibility.name,
      'cover_media_id': ?coverMediaId,
      'cover_url': ?localCover,
    });
    return EventDto.fromJson(json).toDomain();
  });

  @override
  Future<EventDetail> rsvp(String eventId, RsvpStatus status) =>
      _parse(() async {
        await _source.rsvp(eventId, status.name);
        // The server answers with just the RSVP; reload counts and guests.
        return detail(eventId);
      });
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
  if (ref.watch(appConfigProvider).useMocks) {
    return EventsRepositoryImpl(source);
  }
  final uploader = ref.watch(mediaUploaderProvider);
  return EventsRepositoryImpl(
    source,
    uploadCover: (path) async =>
        (await uploader.upload(path, purpose: MediaPurpose.eventCover)).id,
  );
}
