import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/vendor/data/vendor_repository_impl.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';

import '../../helpers/fake_http_adapter.dart';

/// The vendor calls against JSON shaped like the Laravel API's resources.
void main() {
  late FakeHttpAdapter api;
  late VendorRepositoryImpl repo;

  Map<String, dynamic> booking(String id, String status) => {
    'id': id,
    'number': 'PIJ-$id',
    'event_id': 'e1',
    'customer_id': 'c1',
    'vendor_id': 'v1',
    'customer': {
      'id': 'c1',
      'handle': 'kwame.b',
      'name': 'Kwame Boateng',
      'avatar_url': null,
    },
    'source': 'app',
    'status': status,
    'lines': [
      {'id': 'l1', 'title': 'Chiavari chair (Gold)', 'qty': 120},
      {'id': 'l2', 'title': 'Round table', 'qty': 12},
    ],
    'window': {
      'start': '2026-12-12T08:00:00+00:00',
      'end': '2026-12-13T10:00:00+00:00',
    },
    // As BookingResource sends it: an object, not just the type.
    'fulfilment': {
      'type': 'delivery',
      'address': 'Villa Monticello, East Legon',
      'lat': 5.635,
      'lng': -0.157,
      'setup': false,
      'deliver_at': '2026-12-12T08:00:00+00:00',
      'collect_at': '2026-12-13T10:00:00+00:00',
      'contact_phone': null,
    },
    'totals': {'total_minor': 480000, 'currency': 'GHS'},
    'vendor_respond_by': '2026-11-10T08:00:00+00:00',
    'notes': {'customer': 'Gate code 1234', 'vendor_internal': null},
    'created_at': '2026-11-08T08:00:00+00:00',
  };

  setUp(() {
    api = FakeHttpAdapter((o) async {
      return switch ((o.method, o.path)) {
        ('PATCH', '/vendors/v1/items/i1') => jsonBody(200, {
          'id': 'i1',
          'title': 'Chiavari chair',
          'media': (o.data as Map<String, dynamic>)['media'],
          'pricing': {
            'unit': 'per_event',
            'currency': 'GHS',
            'tiers': <Object>[],
          },
          'from_price_minor': 1200,
          'variants': <Object>[],
          'status': 'active',
          'warnings': <Object>[],
        }),
        // ItemResource, as the server sends it.
        ('GET', '/vendors/v1/items') => jsonBody(200, {
          'data': [
            {
              'id': 'i1',
              'vendor_id': 'v1',
              'category_id': 'chairs',
              'title': 'Chiavari chair',
              'media': [
                {'url': 'https://cdn.test/c.jpg', 'type': 'image'},
              ],
              'pricing': {
                'unit': 'per_event',
                'currency': 'GHS',
                'tiers': [
                  {'min_qty': 1, 'price_minor': 1500},
                  {'min_qty': 100, 'price_minor': 1200},
                ],
              },
              'min_qty': 10,
              'instant_book': false,
              'variants': [
                {
                  'id': 'g',
                  'name': 'Gold',
                  'sku': null,
                  'quantity': 120,
                  'price_delta_minor': 0,
                  'active': true,
                },
              ],
              'status': 'paused',
            },
          ],
          'next_cursor': null,
        }),
        ('GET', '/categories') => jsonBody(200, {
          'data': [
            {'id': 'chairs', 'name': 'Chairs', 'parent_id': null},
            {'id': 'tents', 'name': 'Tents', 'parent_id': null},
          ],
        }),
        ('GET', '/handles/kwame.chairs/available') => jsonBody(200, {
          'handle': 'kwame.chairs',
          'available': true,
        }),
        ('POST', '/vendors') when (o.data as Map)['handle'] == 'taken' =>
          jsonBody(422, {
            'message': 'That handle is already taken.',
            'errors': {
              'handle': ['That handle is already taken.'],
            },
          }),
        ('POST', '/vendors') => jsonBody(201, {
          'type': 'vendor',
          'id': 'v9',
          'handle': (o.data as Map)['handle'],
          'name': (o.data as Map)['name'],
          'logo_url': null,
          'my_role': 'owner',
        }),
        ('GET', '/vendors/v1/bookings') => jsonBody(200, {
          'data': [booking('b1', 'pending_vendor')],
          'next_cursor': null,
        }),
        ('POST', '/bookings/b1/accept') => jsonBody(
          200,
          booking('b1', 'accepted'),
        ),
        ('POST', '/bookings/b1/decline') => jsonBody(
          200,
          booking('b1', 'declined'),
        ),
        ('POST', '/bookings/b2/accept') => jsonBody(422, {
          'message': "A booking that is expired can't become accepted.",
          'errors': {
            'status': ["A booking that is expired can't become accepted."],
          },
        }),
        _ => jsonBody(500, {'message': 'Unexpected ${o.method} ${o.path}'}),
      };
    });
    final dio = Dio(BaseOptions(baseUrl: 'https://api.test/v1'))
      ..httpClientAdapter = api;
    repo = VendorRepositoryImpl(dio);
  });

  test('setting photos sends only the media, videos kept as videos', () async {
    final saved = await repo.setItemPhotos('v1', 'i1', const [
      ItemMedia(url: 'https://cdn.test/a.jpg', width: 1600, height: 1200),
      ItemMedia(url: 'https://cdn.test/v.mp4', isVideo: true),
    ]);

    expect(api.requests.last.data, {
      'media': [
        {
          'url': 'https://cdn.test/a.jpg',
          'type': 'image',
          'w': 1600,
          'h': 1200,
        },
        {'url': 'https://cdn.test/v.mp4', 'type': 'video'},
      ],
    });
    expect(saved.photoUrl, 'https://cdn.test/a.jpg');
    expect(saved.media, hasLength(2));
  });

  test(
    'inventory parses ItemResource, from-price from the cheapest tier',
    () async {
      final item = (await repo.items('v1')).single;
      expect(item.status, VendorItemStatus.paused);
      expect(item.fromPriceMinor, 1200);
      expect(item.stock, 120);
      expect(item.minQty, 10);
      expect(item.photoUrl, 'https://cdn.test/c.jpg');
    },
  );

  test('categories', () async {
    expect(await repo.categories(), const [
      BusinessCategory(id: 'chairs', name: 'Chairs'),
      BusinessCategory(id: 'tents', name: 'Tents'),
    ]);
  });

  test('handle availability', () async {
    expect(await repo.isHandleAvailable('@Kwame.Chairs'), isTrue);
  });

  test('starting a business sends only what was filled in', () async {
    final created = await repo.startBusiness(
      const NewBusiness(
        name: '  Kwame Chairs  ',
        handle: '@Kwame.Chairs',
        city: 'Kumasi',
        categoryIds: ['chairs'],
        eventTypes: ['wedding', 'birthday'],
      ),
    );

    expect(api.requests.single.data, {
      'name': 'Kwame Chairs',
      'handle': 'kwame.chairs',
      'city': 'Kumasi',
      'categories': ['chairs'],
      'event_types': ['wedding', 'birthday'],
    });
    expect(
      created,
      const CreatedBusiness(
        id: 'v9',
        handle: 'kwame.chairs',
        name: 'Kwame Chairs',
      ),
    );
  });

  test('a taken handle is a validation error on handle', () async {
    await expectLater(
      repo.startBusiness(const NewBusiness(name: 'X', handle: 'taken')),
      throwsA(
        isA<ApiException>().having(
          (e) => e.fieldError('handle'),
          'handle',
          'That handle is already taken.',
        ),
      ),
    );
  });

  test('bookings filter by status and parse BookingResource', () async {
    final list = await repo.bookings(
      'v1',
      statuses: RequestStatuses.needsAnswer,
    );

    // Laravel reads repeated `status[]` keys as an array.
    expect(api.requests.single.uri.query, 'status%5B%5D=pending_vendor');
    final b = list.single;
    expect(b.number, 'PIJ-b1');
    expect(b.status, VendorBookingStatus.pendingVendor);
    expect(b.customerName, 'Kwame Boateng');
    expect(b.lines, const [
      VendorBookingLine(title: 'Chiavari chair (Gold)', qty: 120),
      VendorBookingLine(title: 'Round table', qty: 12),
    ]);
    expect(b.totalMinor, 480000);
    expect(b.currency, 'GHS');
    expect(
      b.respondBy!.isAtSameMomentAs(DateTime.utc(2026, 11, 10, 8)),
      isTrue,
    );
    expect(b.fulfilment, 'delivery');
    expect(b.customerNote, 'Gate code 1234');
  });

  test('accept and decline post to the booking and return it', () async {
    expect((await repo.accept('b1')).status, VendorBookingStatus.accepted);

    final declined = await repo.decline('b1', reason: 'Fully booked that day');
    expect(declined.status, VendorBookingStatus.declined);
    expect(api.requests.last.data, {'reason': 'Fully booked that day'});
  });

  test("a stale request can't be answered", () async {
    await expectLater(
      repo.accept('b2'),
      throwsA(
        isA<ApiException>().having(
          (e) => e.fieldError('status'),
          'status',
          contains('expired'),
        ),
      ),
    );
  });
}
