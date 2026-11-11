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
          // Media::toPayload for each id sent.
          'media': [
            for (final (i, id)
                in ((o.data as Map<String, dynamic>)['media'] as List).indexed)
              {
                'id': id,
                'kind': i == 0 ? 'image' : 'video',
                'status': 'ready',
                'width': 1600,
                'height': 1200,
                'blurhash': null,
                'urls': i == 0
                    ? {
                        'thumb': 'https://cdn.test/$id-thumb.webp',
                        'feed': 'https://cdn.test/$id-feed.webp',
                        'full': 'https://cdn.test/$id-full.webp',
                      }
                    : {
                        'hls': 'https://stream.test/$id.m3u8',
                        'poster': 'https://stream.test/$id.jpg',
                      },
                'duration_ms': i == 0 ? null : 12000,
              },
          ],
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
        ('POST', '/bookings/b1/dispatch') => jsonBody(
          200,
          booking('b1', 'out_for_delivery'),
        ),
        ('POST', '/bookings/b1/deliver') => jsonBody(
          200,
          booking('b1', 'delivered'),
        ),
        ('POST', '/bookings/b1/return') => jsonBody(
          200,
          booking('b1', 'returned'),
        ),
        ('POST', '/bookings/b1/decline') => jsonBody(
          200,
          booking('b1', 'declined'),
        ),
        ('GET', '/vendors/v1/blackouts') => jsonBody(200, {
          'data': [
            {
              'id': 'bo1',
              'starts_on': '2026-12-24',
              'ends_on': '2026-12-26',
              'reason': 'Christmas',
            },
          ],
        }),
        ('POST', '/vendors/v1/blackouts') => jsonBody(201, {
          'id': 'bo2',
          ...(o.data as Map<String, dynamic>),
          'reason': (o.data as Map)['reason'],
        }),
        ('DELETE', '/vendors/v1/blackouts/bo1') => jsonBody(200, {
          'message': 'Dates open again.',
        }),
        // A recorded booking: no app customer, the vendor's own contact.
        ('POST', '/vendors/v1/bookings') => jsonBody(201, {
          ...booking('b3', 'confirmed'),
          'event_id': null,
          'customer_id': null,
          'customer': {
            'id': null,
            'handle': null,
            'name': 'Akosua Mensah',
            'avatar_url': null,
            'phone': '+233241234567',
          },
          'source': 'vendor_manual',
          'vendor_respond_by': null,
        }),
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

  test(
    'setting photos sends the media ids, and reads the payloads back',
    () async {
      final saved = await repo.setItemPhotos('v1', 'i1', ['m1', 'm2']);

      expect(api.requests.last.data, {
        'media': ['m1', 'm2'],
      });
      expect(saved.media.map((m) => m.id), ['m1', 'm2']);
      expect(saved.photoUrl, 'https://cdn.test/m1-feed.webp');
      expect(saved.media.last.isVideo, isTrue);
    },
  );

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

  test('recording a booking sends it as the API expects', () async {
    final saved = await repo.recordBooking(
      'v1',
      RecordedBooking(
        customerName: ' Akosua Mensah ',
        customerPhone: '024 123 4567',
        startsAt: DateTime.utc(2026, 12, 12, 8),
        endsAt: DateTime.utc(2026, 12, 13, 18),
        delivery: true,
        address: 'East Legon',
        deliveryFeeMinor: 5000,
        paidMinor: 20000,
        note: 'Called on Sunday',
        lines: const [RecordedLine(itemId: 'i1', variantId: 'g', qty: 80)],
      ),
    );

    expect(api.requests.last.data, {
      'customer': {'name': 'Akosua Mensah', 'phone': '024 123 4567'},
      'deliver_at': '2026-12-12T08:00:00.000Z',
      'collect_at': '2026-12-13T18:00:00.000Z',
      'fulfilment': {'type': 'delivery', 'address': 'East Legon'},
      'lines': [
        {'item_id': 'i1', 'variant_id': 'g', 'qty': 80},
      ],
      'delivery_minor': 5000,
      'paid_minor': 20000,
      'note': 'Called on Sunday',
    });
    expect(saved.status, VendorBookingStatus.confirmed);
    expect(saved.recorded, isTrue);
    expect(saved.customerName, 'Akosua Mensah');
    expect(saved.customerPhone, '+233241234567');
  });

  test('a pickup sends no address or delivery fee', () async {
    await repo.recordBooking(
      'v1',
      RecordedBooking(
        customerName: 'Akosua',
        customerPhone: '0241234567',
        startsAt: DateTime.utc(2026, 12, 12, 8),
        endsAt: DateTime.utc(2026, 12, 13, 18),
        address: 'ignored',
        deliveryFeeMinor: 5000,
        lines: const [RecordedLine(itemId: 'i1', variantId: 'g', qty: 1)],
      ),
    );

    final body = api.requests.last.data as Map<String, dynamic>;
    expect(body['fulfilment'], {'type': 'pickup'});
    expect(body.containsKey('delivery_minor'), isFalse);
    expect(body.containsKey('note'), isFalse);
  });

  test('blocked days: list, add and remove', () async {
    final list = await repo.blackouts(
      'v1',
      from: DateTime(2026, 12),
      to: DateTime(2026, 12, 31),
    );
    expect(api.requests.last.queryParameters, {
      'from': '2026-12-01',
      'to': '2026-12-31',
    });
    expect(
      list.single,
      Blackout(
        id: 'bo1',
        startsOn: DateTime(2026, 12, 24),
        endsOn: DateTime(2026, 12, 26),
        reason: 'Christmas',
      ),
    );
    expect(list.single.covers(DateTime(2026, 12, 26, 23)), isTrue);
    expect(list.single.covers(DateTime(2026, 12, 27)), isFalse);

    final added = await repo.addBlackout(
      'v1',
      from: DateTime(2027, 1, 2),
      to: DateTime(2027, 1, 3),
      reason: ' Stocktake ',
    );
    expect(api.requests.last.data, {
      'starts_on': '2027-01-02',
      'ends_on': '2027-01-03',
      'reason': 'Stocktake',
    });
    expect(added.startsOn, DateTime(2027, 1, 2));

    await repo.removeBlackout('v1', 'bo1');
    expect(api.requests.last.method, 'DELETE');
  });

  test('calendar bookings are asked for by date range', () async {
    await repo.bookings(
      'v1',
      statuses: const [VendorBookingStatus.confirmed],
      from: DateTime.utc(2026, 12),
      to: DateTime.utc(2027),
    );
    expect(
      api.requests.last.queryParameters['from'],
      '2026-12-01T00:00:00.000Z',
    );
    expect(api.requests.last.queryParameters['to'], '2027-01-01T00:00:00.000Z');
  });

  test('each step posts to its endpoint', () async {
    expect(
      (await repo.advance('b1', BookingStep.dispatch)).status,
      VendorBookingStatus.outForDelivery,
    );
    expect(
      (await repo.advance('b1', BookingStep.deliver)).status,
      VendorBookingStatus.delivered,
    );
    final back = await repo.advance('b1', BookingStep.markReturned);
    expect(back.status, VendorBookingStatus.returned);
    expect(api.requests.last.path, '/bookings/b1/return');
    // Address and the checkout contact come with it.
    expect(back.address, 'Villa Monticello, East Legon');
  });

  test('what step comes next', () {
    VendorBooking b(VendorBookingStatus s, [String f = 'delivery']) =>
        VendorBooking(
          id: 'b',
          number: 'n',
          status: s,
          startsAt: DateTime(2026),
          endsAt: DateTime(2026),
          totalMinor: 0,
          currency: 'GHS',
          fulfilment: f,
        );
    expect(
      BookingStep.next(b(VendorBookingStatus.confirmed)),
      BookingStep.dispatch,
    );
    expect(
      BookingStep.next(b(VendorBookingStatus.confirmed, 'pickup')),
      BookingStep.deliver,
    );
    expect(
      BookingStep.next(b(VendorBookingStatus.outForDelivery)),
      BookingStep.deliver,
    );
    expect(
      BookingStep.next(b(VendorBookingStatus.delivered)),
      BookingStep.markReturned,
    );
    expect(BookingStep.next(b(VendorBookingStatus.pendingVendor)), isNull);
  });
}
