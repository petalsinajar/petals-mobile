import 'package:dio/dio.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/feed/data/feed_source.dart';

class FeedRemoteSource implements FeedSource {
  FeedRemoteSource(this._dio);

  final Dio _dio;

  Future<Json> _call(Future<Response<Json>> Function() request) async {
    try {
      final response = await request();
      return response.data ?? const {};
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Json> _page(String path, String? cursor) => _call(
    () => _dio.get<Json>(path, queryParameters: {'cursor': ?cursor}),
  );

  @override
  Future<Json> discover({String? cursor}) => _page('/feed/discover', cursor);

  @override
  Future<Json> following({String? cursor}) => _page('/feed/following', cursor);

  @override
  Future<Json> react(String postId) =>
      _call(() => _dio.put<Json>('/posts/$postId/reaction'));

  @override
  Future<Json> unreact(String postId) =>
      _call(() => _dio.delete<Json>('/posts/$postId/reaction'));

  @override
  Future<Json> comments(String postId, {String? cursor}) =>
      _page('/posts/$postId/comments', cursor);

  @override
  Future<Json> addComment(String postId, String body) => _call(
    () => _dio.post<Json>('/posts/$postId/comments', data: {'body': body}),
  );
}
