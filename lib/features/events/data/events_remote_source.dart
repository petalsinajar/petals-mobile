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

  @override
  Future<List<Json>> myEvents() async {
    final body = await _call(() => _dio.get<Json>('/me/events'));
    return (body['data'] as List? ?? const []).cast<Json>();
  }

  @override
  Future<Json> detail(String eventId) =>
      _call(() => _dio.get<Json>('/events/$eventId'));

  @override
  Future<Json> feed(String eventId, {String? cursor}) => _call(
    () => _dio.get<Json>(
      '/events/$eventId/posts',
      queryParameters: {'cursor': ?cursor},
    ),
  );

  @override
  Future<Json> plan(String eventId) =>
      _call(() => _dio.get<Json>('/events/$eventId/plan'));

  @override
  Future<Json> create(Json fields, {String? coverPath}) async {
    final data = coverPath == null
        ? fields as Object
        : FormData.fromMap({
            ...fields,
            'cover': await MultipartFile.fromFile(coverPath),
          });
    final body = await _call(() => _dio.post<Json>('/events', data: data));
    // Laravel resources wrap single objects in `data`.
    return body['data'] as Json? ?? body;
  }

  @override
  Future<Json> rsvp(String eventId, String status) async {
    final body = await _call(
      () => _dio.put<Json>('/events/$eventId/rsvp', data: {'status': status}),
    );
    return body['data'] as Json? ?? body;
  }
}
