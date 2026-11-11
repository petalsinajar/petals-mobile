import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/core/media/media.dart';
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
    // `{ type: delivery|pickup, address, deliver_at, … }`.
    fulfilment: (j['fulfilment'] as Json?)?['type'] as String?,
    customerNote: notes?['customer'] as String?,
    recorded: j['source'] == 'vendor_manual',
    customerPhone: customer?['phone'] as String?,
    address: (j['fulfilment'] as Json?)?['address'] as String?,
    contactPhone:
        customer?['phone'] as String? ??
        (j['fulfilment'] as Json?)?['contact_phone'] as String?,
  );
}

/// `{ id, starts_on, ends_on, reason }`, dates as `yyyy-MM-dd`.
Blackout _blackout(Json j) => Blackout(
  id: j['id'] as String,
  startsOn: DateTime.parse(j['starts_on'] as String),
  endsOn: DateTime.parse(j['ends_on'] as String),
  reason: j['reason'] as String?,
);

/// `ItemResource`. The "from" price falls back to the cheapest tier for
/// servers that don't send `from_price_minor` yet.
VendorItem _item(Json j) {
  final pricing = j['pricing'] as Json? ?? const {};
  final tiers = (pricing['tiers'] as List? ?? const []).cast<Json>();
  final media = [
    for (final m in (j['media'] as List? ?? const []).cast<Json>())
      Media.fromApi(m),
  ];
  final photo = media.where((m) => !m.isVideo && m.isReady).firstOrNull;
  return VendorItem(
    id: j['id'] as String,
    title: j['title'] as String? ?? 'Untitled',
    status: VendorItemStatus.values.firstWhere(
      (s) => s.name == j['status'],
      orElse: () => VendorItemStatus.draft,
    ),
    fromPriceMinor:
        j['from_price_minor'] as int? ??
        tiers
            .map((t) => t['price_minor'] as int? ?? 0)
            .fold<int?>(null, (min, p) => min == null || p < min ? p : min) ??
        0,
    currency: pricing['currency'] as String? ?? 'GHS',
    unit: pricing['unit'] as String? ?? 'per_event',
    categoryId: j['category_id'] as String?,
    photoUrl: photo?.stillUrl,
    blurhash: photo?.blurhash,
    media: media,
    minQty: j['min_qty'] as int? ?? 1,
    instantBook: j['instant_book'] as bool? ?? false,
    variants: [
      for (final v in (j['variants'] as List? ?? const []).cast<Json>())
        VendorItemVariant(
          id: v['id'] as String,
          name: v['name'] as String? ?? 'Standard',
          quantity: v['quantity'] as int? ?? 0,
          active: v['active'] as bool? ?? true,
        ),
    ],
  );
}

/// `VendorResource`, with `my_role`.
BusinessProfile _business(Json j) {
  final contact = j['contact'] is Map
      ? j['contact'] as Json
      : const <String, dynamic>{};
  final delivery = j['delivery'] is Map
      ? j['delivery'] as Json
      : const <String, dynamic>{};
  final area = j['service_area'] as Json? ?? const {};
  final rating = j['rating'] as Json? ?? const {};
  final counts = j['counts'] as Json? ?? const {};
  final policies = j['policies'] as Json? ?? const {};
  return BusinessProfile(
    id: j['id'] as String,
    handle: j['handle'] as String,
    name: j['name'] as String,
    bio: j['bio'] as String?,
    logoUrl: j['logo_url'] as String?,
    coverUrl: j['cover_url'] as String?,
    city: j['city'] as String?,
    categories: (j['categories'] as List? ?? const []).cast<String>(),
    eventTypes: (j['event_types'] as List? ?? const []).cast<String>(),
    phone: contact['phone'] as String?,
    whatsapp: contact['whatsapp'] as String?,
    email: contact['email'] as String?,
    isVerified: j['is_verified'] as bool? ?? false,
    ratingAverage: (rating['avg'] as num?)?.toDouble(),
    ratingCount: rating['count'] as int? ?? 0,
    followers: counts['followers'] as int? ?? 0,
    posts: counts['posts'] as int? ?? 0,
    completedBookings: counts['completed_bookings'] as int? ?? 0,
    serviceRadiusKm: area['radius_km'] as int?,
    delivery: BusinessDelivery(
      offered: delivery['offered'] as bool? ?? true,
      baseFeeMinor: delivery['base_fee_minor'] as int? ?? 0,
      setupOffered: delivery['setup_offered'] as bool? ?? false,
      setupFeeMinor: delivery['setup_fee_minor'] as int? ?? 0,
      perKmMinor: delivery['per_km_minor'] as int? ?? 0,
    ),
    depositPercent: policies['deposit_percent'] as int?,
    leadTimeHours: policies['lead_time_hours'] as int?,
    myRole: j['my_role'] as String?,
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
    DateTime? from,
    DateTime? to,
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
            'from': ?from?.toUtc().toIso8601String(),
            'to': ?to?.toUtc().toIso8601String(),
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

  static final _day = DateFormat('yyyy-MM-dd');

  @override
  Future<List<Blackout>> blackouts(
    String vendorId, {
    required DateTime from,
    required DateTime to,
  }) async {
    final body = await _call(
      () => _dio.get<Json>(
        '/vendors/$vendorId/blackouts',
        queryParameters: {'from': _day.format(from), 'to': _day.format(to)},
      ),
    );
    return [
      for (final j in (body['data'] as List? ?? const []).cast<Json>())
        _blackout(j),
    ];
  }

  @override
  Future<Blackout> addBlackout(
    String vendorId, {
    required DateTime from,
    required DateTime to,
    String? reason,
  }) async {
    final note = reason?.trim() ?? '';
    return _blackout(
      await _call(
        () => _dio.post<Json>(
          '/vendors/$vendorId/blackouts',
          data: {
            'starts_on': _day.format(from),
            'ends_on': _day.format(to),
            if (note.isNotEmpty) 'reason': note,
          },
        ),
      ),
    );
  }

  @override
  Future<void> removeBlackout(String vendorId, String blackoutId) async {
    await _call(
      () => _dio.delete<Json>('/vendors/$vendorId/blackouts/$blackoutId'),
    );
  }

  @override
  Future<VendorItem> setItemPhotos(
    String vendorId,
    String itemId,
    List<String> mediaIds,
  ) async => _item(
    await _call(
      () => _dio.patch<Json>(
        '/vendors/$vendorId/items/$itemId',
        data: {'media': mediaIds},
      ),
    ),
  );

  @override
  Future<BusinessProfile> business(String vendorId) async =>
      _business(await _call(() => _dio.get<Json>('/vendors/$vendorId')));

  @override
  Future<BusinessProfile> updateBusiness(
    String vendorId,
    Map<String, Object?> changes,
  ) async => _business(
    await _call(() => _dio.patch<Json>('/vendors/$vendorId', data: changes)),
  );

  @override
  Future<List<VendorItem>> items(String vendorId) async {
    final body = await _call(() => _dio.get<Json>('/vendors/$vendorId/items'));
    return [
      for (final j in (body['data'] as List? ?? const []).cast<Json>())
        _item(j),
    ];
  }

  @override
  Future<VendorBooking> accept(String bookingId) async => _booking(
    await _call(() => _dio.post<Json>('/bookings/$bookingId/accept')),
  );

  @override
  Future<VendorBooking> recordBooking(
    String vendorId,
    RecordedBooking booking,
  ) async {
    final note = booking.note?.trim() ?? '';
    return _booking(
      await _call(
        () => _dio.post<Json>(
          '/vendors/$vendorId/bookings',
          data: {
            'customer': {
              'name': booking.customerName.trim(),
              'phone': booking.customerPhone.trim(),
            },
            'deliver_at': booking.startsAt.toUtc().toIso8601String(),
            'collect_at': booking.endsAt.toUtc().toIso8601String(),
            'fulfilment': {
              'type': booking.delivery ? 'delivery' : 'pickup',
              if (booking.delivery) 'address': booking.address?.trim(),
            },
            'lines': [
              for (final l in booking.lines)
                {'item_id': l.itemId, 'variant_id': l.variantId, 'qty': l.qty},
            ],
            if (booking.delivery) 'delivery_minor': booking.deliveryFeeMinor,
            'paid_minor': booking.paidMinor,
            if (note.isNotEmpty) 'note': note,
          },
        ),
      ),
    );
  }

  @override
  Future<VendorBooking> advance(String bookingId, BookingStep step) async {
    final path = switch (step) {
      BookingStep.dispatch => 'dispatch',
      BookingStep.deliver => 'deliver',
      BookingStep.markReturned => 'return',
    };
    return _booking(
      await _call(() => _dio.post<Json>('/bookings/$bookingId/$path')),
    );
  }

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
