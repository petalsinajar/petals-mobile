import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/network/dio_client.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/bookings/domain/booking.dart';
import 'package:petalsinajar/features/bookings/domain/bookings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookings_repository_impl.g.dart';

DateTime _time(Object? raw) => DateTime.parse(raw! as String).toLocal();

/// `BookingResource`, as the customer sees it.
CustomerBooking bookingOf(Json j) {
  final window = j['window'] as Json;
  final totals = j['totals'] as Json? ?? const {};
  final vendor = j['vendor'] as Json?;
  final fulfilment = j['fulfilment'] as Json?;
  final notes = j['notes'] as Json?;
  return CustomerBooking(
    id: j['id'] as String,
    number: j['number'] as String,
    status: BookingStatus.parse(j['status'] as String),
    startsAt: _time(window['start']),
    endsAt: _time(window['end']),
    totalMinor: totals['total_minor'] as int? ?? 0,
    currency: totals['currency'] as String? ?? 'GHS',
    eventId: j['event_id'] as String?,
    vendor: vendor == null
        ? null
        : BookingVendor(
            id: vendor['id'] as String,
            name: vendor['name'] as String? ?? '',
            handle: vendor['handle'] as String?,
            logoUrl: vendor['logo_url'] as String?,
          ),
    lines: [
      for (final l in (j['lines'] as List? ?? const []).cast<Json>())
        BookingItemLine(
          title: l['title'] as String? ?? 'Item',
          qty: l['qty'] as int? ?? 1,
          lineTotalMinor: l['line_total_minor'] as int? ?? 0,
        ),
    ],
    fulfilment: fulfilment?['type'] as String?,
    respondBy: switch (j['vendor_respond_by']) {
      final String at => _time(at),
      _ => null,
    },
    customerNote: notes?['customer'] as String?,
    timeline: [
      for (final s in (j['timeline'] as List? ?? const []).cast<Json>())
        BookingStep(
          to: BookingStatus.parse(s['to'] as String),
          at: _time(s['at']),
          note: s['note'] as String?,
        ),
    ],
  );
}

class BookingsRepositoryImpl implements BookingsRepository {
  BookingsRepositoryImpl(this._dio);

  final Dio _dio;

  Future<T> _call<T>(
    Future<Response<Json>> Function() request,
    T Function(Json body) parse,
  ) async {
    try {
      return parse((await request()).data ?? const {});
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } on ApiException {
      rethrow;
    } on Object catch (e) {
      throw ApiException.from(e);
    }
  }

  @override
  Future<CustomerBooking> request(BookingRequest r) => _call(
    () => _dio.post<Json>(
      '/checkouts',
      data: {
        'event_id': r.eventId,
        'lines': [
          {'item_id': r.itemId, 'variant_id': r.variantId, 'qty': r.qty},
        ],
        'fulfilment': {
          r.vendorId: {'type': r.fulfilment.name},
        },
        if (r.note case final String note when note.trim().isNotEmpty)
          'notes': {r.vendorId: note.trim()},
      },
    ),
    (body) => bookingOf((body['bookings'] as List).cast<Json>().first),
  );

  @override
  Future<Paginated<CustomerBooking>> mine({String? cursor}) => _call(
    () => _dio.get<Json>(
      '/me/bookings',
      queryParameters: {'cursor': ?cursor},
    ),
    (body) => Paginated.fromJson(body, bookingOf),
  );

  @override
  Future<CustomerBooking> booking(String id) =>
      _call(() => _dio.get<Json>('/bookings/$id'), bookingOf);

  @override
  Future<CustomerBooking> cancel(String id, {String? reason}) => _call(
    () => _dio.post<Json>(
      '/bookings/$id/cancel',
      data: {'reason': ?reason},
    ),
    bookingOf,
  );

  @override
  Future<int> available({
    required String itemId,
    required String variantId,
    required DateTime from,
    required DateTime to,
  }) {
    final day = DateFormat('yyyy-MM-dd');
    return _call(
      () => _dio.get<Json>(
        '/items/$itemId/availability',
        queryParameters: {
          'variant_id': variantId,
          'from': day.format(from),
          'to': day.format(to),
        },
      ),
      (body) {
        final days = (body['days'] as List? ?? const []).cast<Json>();
        if (days.isEmpty) return body['capacity'] as int? ?? 0;
        return days
            .map((d) => d['available'] as int? ?? 0)
            .reduce((a, b) => a < b ? a : b);
      },
    );
  }
}

@Riverpod(keepAlive: true)
BookingsRepository bookingsRepository(Ref ref) =>
    BookingsRepositoryImpl(ref.watch(dioProvider));
