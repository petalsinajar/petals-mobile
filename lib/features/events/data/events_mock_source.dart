import 'dart:convert';

import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/mock_pagination.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/events/data/events_source.dart';
import 'package:uuid/uuid.dart';

/// Answers with the backend's JSON (`EventResource`, member rows,
/// `PostPresenter`, `BookingResource`) built from the seed files, so the
/// same DTOs parse mock and live responses. Creates and RSVPs live in memory
/// until restart.
class EventsMockSource implements EventsSource {
  EventsMockSource({
    required SeedLoader seed,
    required MockDelay delay,
    required String viewerId,
    DateTime Function()? clock,
  }) : _seed = seed,
       _delay = delay,
       _viewerId = viewerId,
       _clock = clock ?? DateTime.now;

  final SeedLoader _seed;
  final MockDelay _delay;
  final String _viewerId;
  final DateTime Function() _clock;

  /// Seed-shaped rows: `host_id`, `co_host_ids`, `guests`, `rsvp_counts`.
  List<Json>? _events;
  late Map<String, Json> _users;
  late Map<String, Json> _vendors;

  Future<List<Json>> _loadEvents() async {
    if (_events case final events?) return events;
    final [events, users, vendors] = await Future.wait([
      _seed.load('events'),
      _seed.load('users'),
      _seed.load('vendors'),
    ]);
    _users = {for (final u in users) u['id'] as String: u};
    _vendors = {for (final v in vendors) v['id'] as String: v};
    // Deep copy: seed rows are cached and shared, ours get mutated.
    return _events = (jsonDecode(jsonEncode(events)) as List).cast<Json>();
  }

  Future<Json> _find(String eventId) async {
    final events = await _loadEvents();
    for (final e in events) {
      if (e['id'] == eventId) return e;
    }
    throw const ApiException(
      type: ApiErrorType.notFound,
      message: 'Event not found',
      statusCode: 404,
    );
  }

  /// `ActorResource` for a user.
  Json _actor(String id) {
    final u = _users[id];
    return {
      'type': 'user',
      'id': id,
      'handle': u?['handle'],
      'name': u?['name'] ?? 'Guest',
      'avatar_url': (u?['avatar'] as Json?)?['url'],
      'is_verified': false,
    };
  }

  /// `ActorResource` for a vendor.
  Json _vendorActor(String id) {
    final v = _vendors[id];
    return {
      'type': 'vendor',
      'id': id,
      'handle': v?['handle'],
      'name': v?['name'] ?? 'Vendor',
      'avatar_url': (v?['logo'] as Json?)?['url'],
      'is_verified': v?['verified'] ?? false,
    };
  }

  /// `UserResource`, as embedded in member rows.
  Json _user(String id) {
    final u = _users[id];
    return {
      'type': 'user',
      'id': id,
      'handle': u?['handle'],
      'display_name': u?['name'] ?? '',
      'avatar_url': (u?['avatar'] as Json?)?['url'],
    };
  }

  bool _hosts(Json e) =>
      e['host_id'] == _viewerId ||
      (e['co_host_ids'] as List).contains(_viewerId);

  /// How the viewer answered, as `my_rsvp`. Hosts are going.
  String? _myRsvp(Json e) {
    if (_hosts(e)) return 'going';
    final guests = (e['guests'] as List).cast<Json>();
    return guests.where((g) => g['user_id'] == _viewerId).firstOrNull?['status']
        as String?;
  }

  /// `EventResource`.
  Json _resource(Json e) {
    final counts = (e['rsvp_counts'] as Map? ?? const {}).cast<String, int>();
    final venue = (e['venue'] as Map).cast<String, dynamic>();
    return {
      'id': e['id'],
      'type': e['type'],
      'title': e['title'],
      'description': e['description'],
      'cover_url': (e['cover'] as Json?)?['url'],
      'starts_at': e['starts_at'],
      'ends_at': e['ends_at'] ?? _defaultEnd(e['starts_at'] as String),
      'timezone': 'Africa/Accra',
      'venue': {
        'name': venue['name'],
        'address': venue['address'],
        'city': venue['city'],
        'lat': null,
        'lng': null,
      },
      'guest_count': e['guest_count'],
      'currency': 'GHS',
      'visibility': e['visibility'],
      'status': 'planning',
      'host': _actor(e['host_id'] as String),
      'counts': {
        'going': counts['going'] ?? 0,
        'maybe': counts['maybe'] ?? 0,
        'declined': counts['declined'] ?? 0,
        'posts': 0,
        'bookings': 0,
      },
      'my_rsvp': ?_myRsvp(e),
      'is_host': _hosts(e),
    };
  }

  static String _defaultEnd(String startsAt) => DateTime.parse(
    startsAt,
  ).add(const Duration(hours: 6)).toUtc().toIso8601String();

  Json _page(List<Json> rows, String? cursor) {
    final page = paginateList(rows, cursor: cursor);
    return {'data': page.items, 'next_cursor': page.nextCursor};
  }

  @override
  Future<Json> myEvents({required String scope, String? cursor}) async {
    final events = await _loadEvents();
    await _delay();
    final now = _clock();
    final past = scope == 'past';
    final mine =
        [
          for (final e in events)
            if (_myRsvp(e) != null &&
                DateTime.parse(
                      _resource(e)['ends_at'] as String,
                    ).isBefore(now) ==
                    past)
              _resource(e),
        ]..sort((a, b) {
          final order = '${a['starts_at']}'.compareTo('${b['starts_at']}');
          return past ? -order : order;
        });
    return _page(mine, cursor);
  }

  @override
  Future<Json> detail(String eventId) async {
    final e = await _find(eventId);
    await _delay();
    return _resource(e);
  }

  @override
  Future<Json> members(String eventId, {String? cursor}) async {
    final e = await _find(eventId);
    await _delay();
    return _page([
      {'role': 'host', 'rsvp': 'going', 'user': _user(e['host_id'] as String)},
      for (final id in (e['co_host_ids'] as List).cast<String>())
        {'role': 'cohost', 'rsvp': 'going', 'user': _user(id)},
      for (final g in (e['guests'] as List).cast<Json>())
        {
          'role': 'guest',
          'rsvp': g['status'],
          'user': _user(g['user_id'] as String),
        },
    ], cursor);
  }

  @override
  Future<Json> feed(String eventId, {String? cursor}) async {
    final e = await _find(eventId);
    final posts = await _seed.load('posts');
    final mine = [
      for (final p in posts)
        if (p['event_id'] == eventId) p,
    ]..sort((a, b) => '${b['created_at']}'.compareTo('${a['created_at']}'));
    await _delay();
    return _page([
      for (final p in mine)
        {
          'id': p['id'],
          'author': switch (p['author']) {
            {'type': 'vendor', 'id': final String id} => _vendorActor(id),
            {'id': final String id} => _actor(id),
            _ => null,
          },
          'event': {'id': e['id'], 'title': e['title'], 'type': e['type']},
          'caption': p['caption'],
          'media': [
            for (final m in (p['media'] as List).cast<Json>())
              {
                'url': m['url'],
                'type': 'image',
                'w': m['width'],
                'h': m['height'],
                'blurhash': m['blurhash'],
              },
          ],
          'counts': {
            'likes': p['like_count'] ?? 0,
            'comments': p['comment_count'] ?? 0,
            'saves': p['save_count'] ?? 0,
          },
          'my_reaction': (p['viewer_has_liked'] ?? false) == true
              ? 'like'
              : null,
          'created_at': p['created_at'],
        },
    ], cursor);
  }

  @override
  Future<Json> bookings(String eventId, {String? cursor}) async {
    await _find(eventId);
    final rows = await _seed.load('bookings');
    await _delay();
    return _page([
      for (final b in rows)
        if (b['event_id'] == eventId)
          {
            'id': b['id'],
            'event_id': b['event_id'],
            'vendor_id': b['vendor_id'],
            'vendor': {
              'id': b['vendor_id'],
              'handle': _vendors[b['vendor_id']]?['handle'],
              'name': _vendors[b['vendor_id']]?['name'],
              'logo_url': (_vendors[b['vendor_id']]?['logo'] as Json?)?['url'],
            },
            'status': b['status'],
            'lines': [
              for (final l in (b['lines'] as List).cast<Json>())
                {
                  'item_id': l['item_id'],
                  'title': l['title'],
                  'qty': l['quantity'],
                  'line_total_minor': l['line_total_minor'],
                },
            ],
            'window': {
              'start': '${b['starts_on']}T00:00:00Z',
              'end': '${b['ends_on']}T23:59:59Z',
            },
            'totals': {
              'total_minor': b['total_minor'],
              'currency': b['currency'],
            },
          },
    ], cursor);
  }

  @override
  Future<Json> uploadImage(String path) async {
    await _delay();
    // No server: point at the picked file, as the app shows it right away.
    return {'url': Uri.file(path).toString(), 'width': null, 'height': null};
  }

  @override
  Future<Json> create(Json fields) async {
    final events = await _loadEvents();
    await _delay();
    final event = <String, dynamic>{
      'id': const Uuid().v4(),
      'type': fields['type'],
      'title': fields['title'],
      'description': fields['description'],
      'starts_at': fields['starts_at'],
      'ends_at': fields['ends_at'],
      'venue': {
        'name': fields['venue_name'],
        'city': fields['venue_city'],
        'address': fields['venue_address'],
      },
      'guest_count': fields['guest_count'],
      'visibility': fields['visibility'] ?? 'public',
      'cover': fields['cover_url'] == null
          ? null
          : {'url': fields['cover_url']},
      'host_id': _viewerId,
      'co_host_ids': <String>[],
      'guests': <Json>[],
      'rsvp_counts': {'going': 1, 'maybe': 0, 'declined': 0},
      'created_at': _clock().toUtc().toIso8601String(),
    };
    events.add(event);
    return _resource(event);
  }

  @override
  Future<Json> rsvp(String eventId, String rsvp) async {
    final e = await _find(eventId);
    await _delay();
    final guests = (e['guests'] as List).cast<Json>();
    final counts = (e['rsvp_counts'] as Map).cast<String, int>();
    final existing = guests.where((g) => g['user_id'] == _viewerId).firstOrNull;
    final was = existing?['status'] as String?;
    if (existing != null) {
      existing['status'] = rsvp;
    } else {
      guests.add({'user_id': _viewerId, 'status': rsvp});
    }
    if (was != rsvp) {
      if (was != null) counts[was] = (counts[was] ?? 1) - 1;
      counts[rsvp] = (counts[rsvp] ?? 0) + 1;
    }
    e['rsvp_counts'] = counts;
    return {'rsvp': rsvp};
  }
}
