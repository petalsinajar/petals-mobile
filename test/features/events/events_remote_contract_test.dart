import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/features/events/data/events_remote_source.dart';
import 'package:petalsinajar/features/events/data/events_repository_impl.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_draft.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

import '../../helpers/fake_http_adapter.dart';

/// The live path: the repository over [EventsRemoteSource], against JSON
/// shaped like the Laravel API's, checking the requests it sends.
void main() {
  late FakeHttpAdapter api;
  late EventsRepositoryImpl repo;
  late Map<String, Object> rsvpByEvent;

  Map<String, dynamic> event(
    String id, {
    String? myRsvp,
    bool isHost = false,
  }) => {
    'id': id,
    'type': 'wedding',
    'title': 'Event $id',
    'description': null,
    'cover_url': null,
    'starts_at': '2030-06-01T14:00:00+00:00',
    'ends_at': '2030-06-01T19:00:00+00:00',
    'venue': {'name': 'Hall', 'address': null, 'city': 'Accra'},
    'guest_count': 100,
    'visibility': 'guests',
    'host': {'type': 'user', 'id': 'host', 'handle': 'ama', 'name': 'Ama'},
    'counts': {'going': 1, 'maybe': 0, 'declined': 0},
    'my_rsvp': ?myRsvp,
    'is_host': isHost,
  };

  setUp(() {
    rsvpByEvent = {};
    api = FakeHttpAdapter((o) async {
      final path = o.path;
      return switch ((o.method, path)) {
        ('GET', '/me/events') when o.queryParameters['scope'] == 'upcoming' =>
          o.queryParameters['cursor'] == null
              ? jsonBody(200, {
                  'data': [event('e1', isHost: true, myRsvp: 'going')],
                  'next_cursor': 'page2',
                })
              : jsonBody(200, {
                  'data': [event('e2', myRsvp: 'maybe')],
                  'next_cursor': null,
                }),
        ('GET', '/me/events') => jsonBody(200, {
          'data': [event('e3', myRsvp: 'going')],
          'next_cursor': null,
        }),
        ('GET', '/events/e1') => jsonBody(
          200,
          event('e1', myRsvp: rsvpByEvent['e1'] as String?),
        ),
        ('GET', '/events/e1/members') => jsonBody(200, {
          'data': [
            {
              'role': 'host',
              'rsvp': 'going',
              'user': {'id': 'host', 'handle': 'ama', 'display_name': 'Ama'},
            },
            {
              'role': 'cohost',
              'rsvp': 'going',
              'user': {'id': 'co', 'handle': 'kojo', 'display_name': 'Kojo'},
            },
            {
              'role': 'guest',
              'rsvp': 'maybe',
              'user': {'id': 'g1', 'handle': 'efua', 'display_name': 'Efua'},
            },
          ],
          'next_cursor': null,
        }),
        ('GET', '/events/missing') ||
        ('GET', '/events/missing/members') => jsonBody(404, {
          'message': 'Not found.',
        }),
        ('PUT', '/events/e1/rsvp') => () {
          rsvpByEvent['e1'] = (o.data as Map)['rsvp'] as Object;
          return jsonBody(200, {'rsvp': rsvpByEvent['e1']});
        }(),
        ('POST', '/uploads') => jsonBody(201, {
          'url': 'https://petalsinajar.com/storage/uploads/2026/11/a.jpg',
          'width': 1200,
          'height': 800,
        }),
        ('POST', '/events') => jsonBody(201, {
          ...event('new', isHost: true, myRsvp: 'going'),
          'cover_url': (o.data as Map)['cover_url'],
        }),
        _ => jsonBody(500, {'message': 'Unexpected ${o.method} $path'}),
      };
    });
    final dio = Dio(BaseOptions(baseUrl: 'https://api.test/v1'))
      ..httpClientAdapter = api;
    repo = EventsRepositoryImpl(EventsRemoteSource(dio));
  });

  test('my events reads every page of both scopes', () async {
    final events = await repo.myEvents();

    expect(events.map((e) => e.id), ['e1', 'e2', 'e3']);
    expect(events.first.viewerRole, ViewerRole.host);
    expect(events[1].viewerRole, ViewerRole.guest);
    expect(events[1].viewerRsvp, RsvpStatus.maybe);
  });

  test('detail joins the event with its members', () async {
    final d = await repo.detail('e1');

    expect(d.host.name, 'Ama');
    expect(d.coHosts.single.name, 'Kojo');
    expect(d.event.coHostIds, ['co']);
    expect(d.guests.single.person.name, 'Efua');
    expect(d.guests.single.status, RsvpStatus.maybe);
  });

  test('a missing event is still a 404', () async {
    await expectLater(
      repo.detail('missing'),
      throwsA(
        isA<Object>().having((e) => '$e', 'error', contains('notFound')),
      ),
    );
  });

  test('rsvp sends { rsvp } and returns the reloaded detail', () async {
    final d = await repo.rsvp('e1', RsvpStatus.declined);

    final put = api.requests.singleWhere((r) => r.method == 'PUT');
    expect(put.data, {'rsvp': 'declined'});
    expect(d.event.viewerRsvp, RsvpStatus.declined);
  });

  test('create uploads the cover first, then posts flat fields', () async {
    final cover = File(
      '${Directory.systemTemp.createTempSync().path}/cover.jpg',
    )..writeAsBytesSync([0xFF, 0xD8, 0xFF]);
    final start = DateTime.utc(2030, 6, 1, 14);

    final created = await repo.create(
      EventDraft(
        type: EventType.wedding,
        title: '  Ama & Kojo  ',
        startsAt: start,
        venueName: 'Aburi Gardens',
        venueCity: 'Aburi',
        guestCount: 250,
        coverPath: cover.path,
      ),
    );

    final [upload, post] = api.requests
        .where((r) => r.method == 'POST')
        .toList();
    expect(upload.path, '/uploads');
    expect(upload.data, isA<FormData>());
    expect(post.path, '/events');
    expect(post.data, {
      'type': 'wedding',
      'title': 'Ama & Kojo',
      'starts_at': '2030-06-01T14:00:00.000Z',
      'ends_at': '2030-06-01T19:00:00.000Z',
      'timezone': 'Africa/Accra',
      'venue_name': 'Aburi Gardens',
      'venue_city': 'Aburi',
      'guest_count': 250,
      'visibility': 'guests',
      'cover_url': 'https://petalsinajar.com/storage/uploads/2026/11/a.jpg',
    });
    expect(created.cover?.url, endsWith('/uploads/2026/11/a.jpg'));
  });
}
