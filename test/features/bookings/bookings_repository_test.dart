import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/bookings/data/bookings_repository_impl.dart';
import 'package:petalsinajar/features/bookings/domain/booking.dart';

import '../../helpers/fake_http_adapter.dart';

/// The customer's booking calls against `BookingResource`-shaped JSON.
Map<String, dynamic> bookingJson({
  String id = 'b1',
  String status = 'pending_vendor',
  bool timeline = false,
}) => {
  'id': id,
  'number': 'BK-26-000042',
  'event_id': 'e1',
  'vendor_id': 'v1',
  'vendor': {
    'id': 'v1',
    'handle': 'royal',
    'name': 'Royal Canopies',
    'logo_url': null,
  },
  'status': status,
  'lines': [
    {
      'id': 'l1',
      'title': 'Chiavari chair (Gold)',
      'qty': 120,
      'line_total_minor': 144000,
    },
  ],
  'window': {
    'start': '2026-12-12T11:00:00+00:00',
    'end': '2026-12-12T23:00:00+00:00',
  },
  'fulfilment': {'type': 'delivery'},
  'totals': {'total_minor': 163320, 'currency': 'GHS'},
  'vendor_respond_by': '2026-11-11T10:00:00+00:00',
  'notes': {'customer': 'Gate code 1234'},
  if (timeline)
    'timeline': [
      {
        'from': null,
        'to': 'pending_vendor',
        'note': null,
        'at': '2026-11-10T10:00:00+00:00',
      },
      {
        'from': 'pending_vendor',
        'to': 'confirmed',
        'note': 'Accepted by the vendor',
        'at': '2026-11-10T12:00:00+00:00',
      },
    ],
  'created_at': '2026-11-10T10:00:00+00:00',
};

int _qty(Object? body) {
  final lines = (body! as Map<String, dynamic>)['lines'] as List<dynamic>;
  return (lines.first as Map<String, dynamic>)['qty'] as int;
}

void main() {
  late FakeHttpAdapter api;
  late BookingsRepositoryImpl repo;

  setUp(() {
    api = FakeHttpAdapter((o) async {
      return switch ((o.method, o.path)) {
        ('POST', '/checkouts') when _qty(o.data) == 1 => jsonBody(422, {
          'message': 'Royal Canopies needs at least 48 hours’ notice.',
          'errors': {
            'fulfilment.v1.deliver_at': [
              'Royal Canopies needs at least 48 hours’ notice.',
            ],
          },
        }),
        ('POST', '/checkouts') => jsonBody(201, {
          'id': 'c1',
          'event_id': 'e1',
          'status': 'open',
          'bookings': [bookingJson()],
        }),
        ('GET', '/me/bookings') => jsonBody(200, {
          'data': [bookingJson(), bookingJson(id: 'b2', status: 'confirmed')],
          'next_cursor': 'abc',
        }),
        ('GET', '/bookings/b1') => jsonBody(200, bookingJson(timeline: true)),
        ('POST', '/bookings/b1/cancel') => jsonBody(
          200,
          bookingJson(status: 'cancelled'),
        ),
        ('GET', '/items/i1/availability') => jsonBody(200, {
          'capacity': 200,
          'days': [
            {'day': '2026-12-12', 'available': 80},
            {'day': '2026-12-13', 'available': 50},
          ],
        }),
        // The vendor blocked the 25th.
        ('GET', '/items/i2/availability') => jsonBody(200, {
          'capacity': 200,
          'days': [
            {'day': '2026-12-24', 'available': 200, 'closed': false},
            {'day': '2026-12-25', 'available': 0, 'closed': true},
          ],
        }),
        _ => jsonBody(404, {'message': 'Not found'}),
      };
    });
    final dio = Dio(BaseOptions(baseUrl: 'https://api.test/v1'))
      ..httpClientAdapter = api;
    repo = BookingsRepositoryImpl(dio);
  });

  const request = BookingRequest(
    eventId: 'e1',
    vendorId: 'v1',
    itemId: 'i1',
    variantId: 'var1',
    qty: 120,
    fulfilment: Fulfilment.pickup,
    note: '  Gate code 1234 ',
  );

  test('a request is a checkout with one line, keyed by vendor', () async {
    final booking = await repo.request(request);

    expect(api.requests.last.data, {
      'event_id': 'e1',
      'lines': [
        {'item_id': 'i1', 'variant_id': 'var1', 'qty': 120},
      ],
      'fulfilment': {
        'v1': {'type': 'pickup'},
      },
      'notes': {'v1': 'Gate code 1234'},
    });
    expect(booking.status, BookingStatus.pendingVendor);
    expect(booking.vendor?.name, 'Royal Canopies');
    expect(booking.lines.single.qty, 120);
    expect(booking.respondBy, isNotNull);
  });

  test('vendor rules come back as field errors', () async {
    await expectLater(
      repo.request(request.copyWith(qty: 1)),
      throwsA(
        isA<ApiException>().having(
          (e) => e.fieldErrors.values.first.first,
          'lead time',
          contains('48 hours'),
        ),
      ),
    );
  });

  test('my bookings page, and one booking with its timeline', () async {
    final page = await repo.mine();
    expect(page.items.map((b) => b.status), [
      BookingStatus.pendingVendor,
      BookingStatus.confirmed,
    ]);
    expect(page.nextCursor, 'abc');

    final booking = await repo.booking('b1');
    expect(booking.timeline.map((s) => s.to), [
      BookingStatus.pendingVendor,
      BookingStatus.confirmed,
    ]);
    expect(booking.timeline.last.note, 'Accepted by the vendor');
  });

  test('cancel', () async {
    final booking = await repo.cancel('b1', reason: 'Changed plans');
    expect(booking.status, BookingStatus.cancelled);
    expect(api.requests.last.data, {'reason': 'Changed plans'});
  });

  test('availability is the lowest day in the range', () async {
    final left = await repo.available(
      itemId: 'i1',
      variantId: 'var1',
      from: DateTime(2026, 12, 12),
      to: DateTime(2026, 12, 13),
    );
    expect(left, (left: 50, closed: false));
    expect(api.requests.last.queryParameters, {
      'variant_id': 'var1',
      'from': '2026-12-12',
      'to': '2026-12-13',
    });
  });

  test('a day the vendor blocked comes back closed', () async {
    final a = await repo.available(
      itemId: 'i2',
      variantId: 'var1',
      from: DateTime(2026, 12, 24),
      to: DateTime(2026, 12, 25),
    );
    expect(a, (left: 0, closed: true));
  });
}
