import 'package:dio/dio.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/network/dio_client.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/discover/data/discover_parsers.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/domain/discover_repository.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discover_repository_impl.g.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  DiscoverRepositoryImpl(this._dio);

  final Dio _dio;

  /// How many looks the trending strip shows.
  static const _trendingCount = 10;

  /// Malformed payloads surface as [ApiException]s, like network errors.
  Future<T> _get<T>(
    String path,
    T Function(Json body) parse, {
    Map<String, Object?> query = const {},
  }) async {
    try {
      final response = await _dio.get<Json>(
        path,
        queryParameters: {
          for (final MapEntry(:key, :value) in query.entries) key: ?value,
        },
      );
      return parse(response.data ?? const {});
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } on ApiException {
      rethrow;
    } on Object catch (e) {
      throw ApiException.from(e);
    }
  }

  List<T> _list<T>(Json body, T Function(Json) parse) => [
    for (final j in (body['data'] as List? ?? const []).cast<Json>()) parse(j),
  ];

  Map<String, Object?> _near(LatLng? near) => {
    'lat': near?.lat,
    'lng': near?.lng,
  };

  @override
  Future<List<CatalogCategory>> categories() => _get(
    '/categories',
    (body) => _list(
      body,
      (j) => j,
    ).where((j) => j['parent_id'] == null).map(categoryOf).toList(),
  );

  @override
  Future<List<LookPost>> trendingLooks({EventType? eventType}) => _get(
    '/feed/discover',
    query: {'event_type': eventType?.name},
    (body) => _list(
      body,
      lookOf,
    ).where((l) => l.cover != null).take(_trendingCount).toList(),
  );

  @override
  Future<LookPost> look(String postId) => _get('/posts/$postId', lookOf);

  @override
  Future<List<VendorCard>> vendors({
    LatLng? near,
    String? query,
    String? categoryId,
    EventType? eventType,
  }) => _get(
    '/vendors',
    query: {
      ..._near(near),
      'q': query,
      'category': categoryId,
      'event_type': eventType?.name,
    },
    (body) => _list(body, vendorOf),
  );

  @override
  Future<VendorCard> vendor(String vendorId) =>
      _get('/vendors/$vendorId', vendorOf);

  @override
  Future<List<PackageCard>> packagesNear(
    LatLng near, {
    EventType? eventType,
  }) => _get(
    '/packages',
    query: {..._near(near), 'event_type': eventType?.name},
    (body) => _list(body, packageOf),
  );

  @override
  Future<List<PackageCard>> vendorPackages(String vendorId) =>
      _get('/vendors/$vendorId/packages', (body) => _list(body, packageOf));

  @override
  Future<Paginated<ItemCard>> items({
    LatLng? near,
    String? query,
    String? categoryId,
    String? vendorId,
    EventType? eventType,
    String? cursor,
  }) => _get(
    '/items',
    query: {
      ..._near(near),
      'q': query,
      'category': categoryId,
      'vendor_id': vendorId,
      'event_type': eventType?.name,
      'cursor': cursor,
    },
    (body) => Paginated.fromJson(body, itemOf),
  );

  @override
  Future<ItemCard> item(String itemId) => _get('/items/$itemId', itemOf);

  @override
  Future<List<UpcomingEvent>> upcomingEvents() => _get(
    '/me/events',
    query: {'scope': 'upcoming'},
    (body) => _list(body, upcomingEventOf),
  );

  @override
  Future<List<EventNeed>> needs(String eventId) =>
      _get('/events/$eventId/needs', (body) => _list(body, needOf));

  @override
  Future<List<UpcomingEvent>> searchEvents(String query) => _get(
    '/events',
    query: {'q': query},
    (body) => _list(body, upcomingEventOf),
  );

  @override
  Future<int> setFollowing(String vendorId, {required bool following}) async {
    try {
      final data = {'target_type': 'vendor', 'target_id': vendorId};
      final response = following
          ? await _dio.post<Json>('/follows', data: data)
          : await _dio.delete<Json>('/follows', data: data);
      return response.data?['followers'] as int? ?? 0;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}

@Riverpod(keepAlive: true)
DiscoverRepository discoverRepository(Ref ref) =>
    DiscoverRepositoryImpl(ref.watch(dioProvider));
