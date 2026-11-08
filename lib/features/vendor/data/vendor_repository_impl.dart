import 'package:dio/dio.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/network/dio_client.dart';
import 'package:petalsinajar/features/auth/domain/handles.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vendor_repository_impl.g.dart';

/// `pending_vendor` ↔ [VendorBookingStatus.pendingVendor].
String _snake(Enum e) =>
    e.name.replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]!.toLowerCase()}');

VendorBookingStatus _status(String raw) =>
    VendorBookingStatus.values.firstWhere(
      (s) => _snake(s) == raw,
      orElse: () => VendorBookingStatus.pendingVendor,
    );

/// `BookingResource`, as the vendor's team sees it.
VendorBooking _booking(Json j) {
  final customer = j['customer'] as Json?;
  final window = j['window'] as Json;
  final totals = j['totals'] as Json;
  final notes = j['notes'] as Json?;
  final name = customer?['name'] as String?;
  return VendorBooking(
    id: j['id'] as String,
    number: j['number'] as String,
    status: _status(j['status'] as String),
    startsAt: DateTime.parse(window['start'] as String).toLocal(),
    endsAt: DateTime.parse(window['end'] as String).toLocal(),
    totalMinor: totals['total_minor'] as int? ?? 0,
    currency: totals['currency'] as String? ?? 'GHS',
    customerName: (name ?? '').isEmpty
        ? (customer?['handle'] != null
              ? '@${customer!['handle']}'
              : 'A customer')
        : name!,
    customerAvatarUrl: customer?['avatar_url'] as String?,
    lines: [
      for (final l in (j['lines'] as List? ?? const []).cast<Json>())
        VendorBookingLine(
          title: l['title'] as String? ?? 'Item',
          qty: l['qty'] as int? ?? 1,
        ),
    ],
    respondBy: switch (j['vendor_respond_by']) {
      final String at => DateTime.parse(at).toLocal(),
      _ => null,
    },
    fulfilment: j['fulfilment'] as String?,
    customerNote: notes?['customer'] as String?,
  );
}

class VendorRepositoryImpl implements VendorRepository {
  VendorRepositoryImpl(this._dio);

  final Dio _dio;

  /// Pages a list fetches before stopping, so a huge list can't stall.
  static const _maxPages = 10;

  Future<Json> _call(Future<Response<Json>> Function() request) async {
    try {
      return (await request()).data ?? const {};
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } on ApiException {
      rethrow;
    } on Object catch (e) {
      throw ApiException.from(e);
    }
  }

  @override
  Future<List<BusinessCategory>> categories() async {
    final body = await _call(() => _dio.get<Json>('/categories'));
    return [
      for (final c in (body['data'] as List? ?? const []).cast<Json>())
        // Top-level only: a business offers "Chairs", not every sub-kind.
        if (c['parent_id'] == null)
          BusinessCategory(id: c['id'] as String, name: c['name'] as String),
    ];
  }

  @override
  Future<bool> isHandleAvailable(String handle) async {
    final h = Uri.encodeComponent(normalizeHandle(handle));
    final body = await _call(() => _dio.get<Json>('/handles/$h/available'));
    return body['available'] == true;
  }

  @override
  Future<CreatedBusiness> startBusiness(NewBusiness business) async {
    final city = business.city?.trim() ?? '';
    final body = await _call(
      () => _dio.post<Json>(
        '/vendors',
        data: {
          'name': business.name.trim(),
          'handle': normalizeHandle(business.handle),
          if (city.isNotEmpty) 'city': city,
          if (business.categoryIds.isNotEmpty)
            'categories': business.categoryIds,
          if (business.eventTypes.isNotEmpty)
            'event_types': business.eventTypes,
        },
      ),
    );
    return CreatedBusiness(
      id: body['id'] as String,
      handle: body['handle'] as String,
      name: body['name'] as String,
      logoUrl: body['logo_url'] as String?,
    );
  }

  @override
  Future<List<VendorBooking>> bookings(
    String vendorId, {
    required List<VendorBookingStatus> statuses,
  }) async {
    final rows = <VendorBooking>[];
    String? cursor;
    for (var i = 0; i < _maxPages; i++) {
      final body = await _call(
        () => _dio.get<Json>(
          '/vendors/$vendorId/bookings',
          queryParameters: {
            // `status[]=a&status[]=b`: how Laravel reads an array.
            'status[]': [for (final s in statuses) _snake(s)],
            'cursor': ?cursor,
          },
        ),
      );
      rows.addAll([
        for (final b in (body['data'] as List? ?? const []).cast<Json>())
          _booking(b),
      ]);
      cursor = body['next_cursor'] as String?;
      if (cursor == null) break;
    }
    return rows;
  }

  @override
  Future<VendorBooking> accept(String bookingId) async => _booking(
    await _call(() => _dio.post<Json>('/bookings/$bookingId/accept')),
  );

  @override
  Future<VendorBooking> decline(String bookingId, {String? reason}) async {
    final note = reason?.trim() ?? '';
    return _booking(
      await _call(
        () => _dio.post<Json>(
          '/bookings/$bookingId/decline',
          data: {if (note.isNotEmpty) 'reason': note},
        ),
      ),
    );
  }
}

@Riverpod(keepAlive: true)
VendorRepository vendorRepository(Ref ref) =>
    VendorRepositoryImpl(ref.watch(dioProvider));
