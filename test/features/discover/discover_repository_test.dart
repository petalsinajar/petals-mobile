import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/discover/data/discover_repository_impl.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

import '../../helpers/fake_http_adapter.dart';

/// Discover's calls against JSON shaped like the Laravel API's resources.
void main() {
  late FakeHttpAdapter api;
  late DiscoverRepositoryImpl repo;

  const vendorSummary = {
    'type': 'vendor',
    'id': 'v1',
    'handle': 'royal',
    'name': 'Royal Canopies',
    'logo_url': null,
    'city': 'Accra',
    'is_verified': true,
    'rating': {'avg': 4.8, 'count': 23},
  };

  Map<String, dynamic> item(String id) => {
    'id': id,
    'vendor_id': 'v1',
    'category_id': 'chairs',
    'title': 'Chiavari chair',
    'description': 'Gold, padded.',
    'media': [
      {
        'url': 'https://cdn.test/chair.jpg',
        'type': 'image',
        'w': 1080,
        'h': 1080,
        'blurhash': 'LKO2?U%2Tw=w]~RBVZRi};RPxuwH',
      },
    ],
    'vendor': vendorSummary,
    'from_price_minor': 1200,
    'pricing': {'unit': 'per_event', 'currency': 'GHS', 'tiers': <Object>[]},
    'status': 'active',
  };

  setUp(() {
    api = FakeHttpAdapter((o) async {
      return switch ((o.method, o.path)) {
        ('GET', '/categories') => jsonBody(200, {
          'data': [
            {
              'id': 'seating',
              'name': 'Seating',
              'parent_id': null,
              'icon': 'chair',
            },
            {
              'id': 'chairs',
              'name': 'Chairs',
              'parent_id': 'seating',
              'icon': 'chair',
            },
          ],
        }),
        ('GET', '/items') => jsonBody(200, {
          'data': [item('i1'), item('i2')],
          'next_cursor': 'o:2',
        }),
        ('GET', '/vendors') => jsonBody(200, {
          'data': [
            {
              ...vendorSummary,
              'bio': 'Tents for every party',
              'categories': ['tents', 'chairs'],
              'counts': {
                'followers': 120,
                'posts': 4,
                'completed_bookings': 31,
              },
              'distance_km': 2.4,
              'is_following': true,
            },
          ],
          'next_cursor': null,
        }),
        ('GET', '/packages') => jsonBody(200, {
          'data': [
            {
              'id': 'p1',
              'vendor_id': 'v1',
              'vendor': vendorSummary,
              'title': 'Kids’ party for 30',
              'event_types': ['birthday', 'other'],
              'guest_range': {'min': 20, 'max': 30},
              'lines': <Object>[],
              'price_minor': 250000,
              'currency': 'GHS',
              'media': <Object>[],
              'status': 'active',
            },
          ],
          'next_cursor': null,
        }),
        ('GET', '/feed/discover') => jsonBody(200, {
          'data': [
            {
              'id': 'post1',
              'author': {'type': 'user', 'id': 'u1', 'name': 'Akosua'},
              'event_type': 'wedding',
              'caption': 'Our day',
              'media': [
                {
                  'url': 'https://cdn.test/look.jpg',
                  'type': 'image',
                  'tags': [
                    {
                      'id': 't1',
                      'x': 0.4,
                      'y': 0.6,
                      'target': {
                        'type': 'item',
                        'id': 'i1',
                        'item': {
                          'id': 'i1',
                          'vendor_id': 'v1',
                          'title': 'Chiavari chair',
                          'image': null,
                          'from_price_minor': 1200,
                          'currency': 'GHS',
                          'unit': 'per_event',
                        },
                      },
                    },
                    {
                      'id': 't2',
                      'x': 0.1,
                      'y': 0.1,
                      'target': {'type': 'vendor', 'id': 'v2'},
                    },
                  ],
                },
              ],
              'counts': {'likes': 9, 'comments': 0, 'saves': 0},
            },
            // A video-only post has no cover, so it's left out.
            {
              'id': 'post2',
              'author': {'type': 'user', 'id': 'u2', 'name': 'Kofi'},
              'media': [
                {'url': 'https://cdn.test/v.mp4', 'type': 'video'},
              ],
            },
          ],
          'next_cursor': null,
        }),
        ('GET', '/events/e1/needs') => jsonBody(200, {
          'event_id': 'e1',
          'data': [
            {
              'category_id': 'sound',
              'category_name': 'Sound',
              'vendors': [
                {
                  'vendor': vendorSummary,
                  'from_price_minor': 30000,
                  'currency': 'GHS',
                  'distance_km': 3.1,
                },
              ],
            },
          ],
        }),
        ('GET', '/me/events') => jsonBody(200, {
          'data': [
            {
              'id': 'e1',
              'type': 'wedding',
              'title': 'Our wedding',
              'starts_at': '2026-12-12T14:00:00+00:00',
              'venue': {
                'name': 'Villa Monticello',
                'city': 'Accra',
                'lat': 5.635,
                'lng': -0.157,
              },
              'is_host': true,
            },
          ],
          'next_cursor': null,
        }),
        ('POST', '/follows') => jsonBody(201, {
          'following': true,
          'followers': 121,
        }),
        ('DELETE', '/follows') => jsonBody(200, {
          'following': false,
          'followers': 119,
        }),
        ('GET', '/items/missing') => jsonBody(404, {
          'message': 'Item not found.',
        }),
        _ => jsonBody(404, {'message': 'Not found'}),
      };
    });
    final dio = Dio(BaseOptions(baseUrl: 'https://api.test/v1'))
      ..httpClientAdapter = api;
    repo = DiscoverRepositoryImpl(dio);
  });

  test('categories are the top level only', () async {
    final categories = await repo.categories();
    expect(categories.map((c) => c.id), ['seating']);
    expect(categories.single.icon, 'chair');
  });

  test('items carry vendor, from-price and photo; filters are sent', () async {
    final page = await repo.items(
      near: (lat: 5.635, lng: -0.157),
      eventType: EventType.birthday,
      cursor: 'o:2',
    );

    expect(page.nextCursor, 'o:2');
    final first = page.items.first;
    expect(first.fromPriceMinor, 1200);
    expect(first.vendor?.name, 'Royal Canopies');
    expect(first.photo?.blurhash, isNotNull);
    expect(api.requests.last.queryParameters, {
      'lat': 5.635,
      'lng': -0.157,
      'event_type': 'birthday',
      'cursor': 'o:2',
    });
  });

  test('vendors parse distance, rating and follow state', () async {
    final vendor = (await repo.vendors(near: (lat: 5.6, lng: -0.2))).single;
    expect(vendor.distanceKm, 2.4);
    expect(vendor.rating.average, 4.8);
    expect(vendor.isFollowing, isTrue);
    expect(vendor.followers, 120);
    expect(vendor.categories, ['tents', 'chairs']);
  });

  test('packages parse the guest range and known event types', () async {
    final package = (await repo.packagesNear((lat: 5.6, lng: -0.2))).single;
    expect((package.guestMin, package.guestMax), (20, 30));
    expect(package.eventTypes, [EventType.birthday]);
    expect(package.vendor?.id, 'v1');
  });

  test('trending looks keep photo posts and count tagged vendors', () async {
    final looks = await repo.trendingLooks(eventType: EventType.wedding);
    expect(looks.map((l) => l.id), ['post1']);
    expect(looks.single.eventType, EventType.wedding);
    expect(looks.single.vendorCount, 2); // v1 via the item, v2 directly
    expect(api.requests.last.queryParameters, {'event_type': 'wedding'});
  });

  test('upcoming events and their needs', () async {
    final event = (await repo.upcomingEvents()).single;
    expect(event.isHost, isTrue);
    expect(event.hasVenueLocation, isTrue);
    expect(api.requests.last.queryParameters, {'scope': 'upcoming'});

    final need = (await repo.needs('e1')).single;
    expect(need.categoryName, 'Sound');
    expect(need.vendors.single.fromPriceMinor, 30000);
  });

  test('follow and unfollow return the server count', () async {
    expect(await repo.setFollowing('v1', following: true), 121);
    expect(api.requests.last.data, {
      'target_type': 'vendor',
      'target_id': 'v1',
    });
    expect(await repo.setFollowing('v1', following: false), 119);
  });

  test('errors surface as ApiException', () {
    expect(repo.item('missing'), throwsA(isA<ApiException>()));
  });
}
