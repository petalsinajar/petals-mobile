import 'dart:convert';

import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/mock_pagination.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/events/data/events_source.dart';
import 'package:uuid/uuid.dart';

/// Builds the API's JSON from the seed files, joining users and vendors into
/// the embedded `host`, `guests`, `author` and `vendor` objects. Creates and
/// RSVPs live in memory until restart.
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

  Json _user(String id) {
    final u = _users[id];
    if (u == null) return {'id': id, 'name': 'Guest', 'is_vendor': false};
    return {
      'id': id,
      'name': u['name'],
      'handle': u['handle'],
      'avatar': u['avatar'],
      'is_vendor': false,
    };
  }

  Json _vendor(String id) {
    final v = _vendors[id];
    if (v == null) return {'id': id, 'name': 'Vendor', 'is_vendor': true};
    return {
      'id': id,
      'name': v['name'],
      'handle': v['handle'],
      'avatar': v['logo'],
      'is_vendor': true,
    };
  }

  /// The event resource as the API returns it, with viewer fields.
  Json _resource(Json e) {
    final guests = (e['guests'] as List).cast<Json>();
    final mine = guests.where((g) => g['user_id'] == _viewerId).firstOrNull;
    final role = e['host_id'] == _viewerId
        ? 'host'
        : (e['co_host_ids'] as List).contains(_viewerId)
        ? 'co_host'
        : mine != null
        ? 'guest'
        : 'none';
    return {
      for (final MapEntry(:key, :value) in e.entries)
        if (key != 'guests') key: value,
      'viewer_role': role,
      'viewer_rsvp': mine?['status'],
    };
  }

  Json _detail(Json e) => {
    ..._resource(e),
    'host': _user(e['host_id'] as String),
    'co_hosts': [
      for (final id in (e['co_host_ids'] as List).cast<String>()) _user(id),
    ],
    'guests': [
      for (final g in (e['guests'] as List).cast<Json>())
        {'user': _user(g['user_id'] as String), 'status': g['status']},
    ],
  };

  @override
  Future<List<Json>> myEvents() async {
    final events = await _loadEvents();
    await _delay();
    return [
      for (final e in events)
        if (_resource(e)['viewer_role'] != 'none') _resource(e),
    ];
  }

  @override
  Future<Json> detail(String eventId) async {
    final e = await _find(eventId);
    await _delay();
    return _detail(e);
  }

  @override
  Future<Json> feed(String eventId, {String? cursor}) async {
    await _find(eventId);
    final posts = await _seed.load('posts');
    final mine = [
      for (final p in posts)
        if (p['event_id'] == eventId) p,
    ]..sort((a, b) => '${b['created_at']}'.compareTo('${a['created_at']}'));
    final page = paginateList(mine, cursor: cursor);
    await _delay();
    return {
      'data': [
        for (final p in page.items)
          {
            ...p,
            'author': switch (p['author']) {
              {'type': 'vendor', 'id': final String id} => _vendor(id),
              {'id': final String id} => _user(id),
              _ => _user(''),
            },
          },
      ],
      'next_cursor': page.nextCursor,
    };
  }

  @override
  Future<Json> plan(String eventId) async {
    await _find(eventId);
    final bookings = await _seed.load('bookings');
    await _delay();
    return {
      'bookings': [
        for (final b in bookings)
          if (b['event_id'] == eventId)
            {...b, 'vendor': _vendor(b['vendor_id'] as String)},
      ],
      // The cart arrives with Phase 6; until then every event's cart is empty.
      'cart': {'lines': <Json>[], 'currency': 'GHS'},
    };
  }

  @override
  Future<Json> create(Json fields, {String? coverPath}) async {
    final events = await _loadEvents();
    await _delay();
    final now = _clock().toUtc().toIso8601String();
    final event = <String, dynamic>{
      ...fields,
      'id': const Uuid().v4(),
      'host_id': _viewerId,
      'co_host_ids': <String>[],
      'guests': <Json>[],
      'rsvp_counts': {'going': 0, 'maybe': 0, 'declined': 0, 'invited': 0},
      'cover': coverPath == null
          ? null
          : {'url': Uri.file(coverPath).toString()},
      'created_at': now,
    };
    events.add(event);
    return _resource(event);
  }

  @override
  Future<Json> rsvp(String eventId, String status) async {
    final e = await _find(eventId);
    await _delay();
    final guests = (e['guests'] as List).cast<Json>();
    final counts = (e['rsvp_counts'] as Map).cast<String, int>();
    final existing = guests.where((g) => g['user_id'] == _viewerId).firstOrNull;
    if (existing != null) {
      final from = existing['status'] as String;
      counts[from] = (counts[from] ?? 1) - 1;
      existing['status'] = status;
    } else {
      guests.add({'user_id': _viewerId, 'status': status});
    }
    counts[status] = (counts[status] ?? 0) + 1;
    e['rsvp_counts'] = counts;
    return _detail(e);
  }
}
