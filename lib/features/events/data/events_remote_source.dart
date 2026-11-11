import 'package:dio/dio.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/events/data/events_source.dart';

class EventsRemoteSource implements EventsSource {
  EventsRemoteSource(this._dio);

  final Dio _dio;

  Future<Json> _call(Future<Response<Json>> Function() request) async {
    try {
      final response = await request();
      return response.data ?? const {};
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Json> _page(String path, {String? cursor, Json query = const {}}) =>
      _call(
        () => _dio.get<Json>(
          path,
          queryParameters: {...query, 'cursor': ?cursor},
        ),
      );

  @override
  Future<Json> myEvents({required String scope, String? cursor}) =>
      _page('/me/events', cursor: cursor, query: {'scope': scope});

  @override
  Future<Json> detail(String eventId) =>
      _call(() => _dio.get<Json>('/events/$eventId'));

  @override
  Future<Json> members(String eventId, {String? cursor}) =>
      _page('/events/$eventId/members', cursor: cursor);

  @override
  Future<Json> feed(String eventId, {String? cursor}) =>
      _page('/events/$eventId/posts', cursor: cursor);

  @override
  Future<Json> bookings(String eventId, {String? cursor}) =>
      _page('/events/$eventId/bookings', cursor: cursor);

  @override
  Future<Json> create(Json fields) =>
      _call(() => _dio.post<Json>('/events', data: fields));

  @override
  Future<Json> rsvp(String eventId, String rsvp) => _call(
    () => _dio.put<Json>('/events/$eventId/rsvp', data: {'rsvp': rsvp}),
  );
}
