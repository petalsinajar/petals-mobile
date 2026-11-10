import 'package:dio/dio.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/network/dio_client.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';
import 'package:petalsinajar/features/posts/domain/posts_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_repository_impl.g.dart';

class PostsRepositoryImpl implements PostsRepository {
  PostsRepositoryImpl(this._dio);

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

  List<Json> _data(Json body) =>
      (body['data'] as List? ?? const []).cast<Json>();

  @override
  Future<UploadedImage> upload(String path) => _call(
    () async => _dio.post<Json>(
      '/uploads',
      data: FormData.fromMap({'file': await MultipartFile.fromFile(path)}),
    ),
    (j) => UploadedImage(
      url: j['url'] as String,
      width: j['width'] as int?,
      height: j['height'] as int?,
    ),
  );

  @override
  Future<String> create(NewPost post) => _call(
    () => _dio.post<Json>(
      '/posts',
      data: {
        'as_vendor_id': ?post.asVendorId,
        'event_id': ?post.eventId,
        if (post.caption.trim().isNotEmpty) 'caption': post.caption.trim(),
        'visibility': switch (post.visibility) {
          PostVisibility.public => 'public',
          PostVisibility.followers => 'followers',
          PostVisibility.eventMembers => 'event_members',
        },
        'media': [
          for (final m in post.media)
            {'url': m.url, 'type': 'image', 'w': ?m.width, 'h': ?m.height},
        ],
        'tags': [
          for (final t in post.tags)
            {
              'media_index': t.mediaIndex,
              'x': t.x,
              'y': t.y,
              'target_type': t.target.type.name,
              'target_id': t.target.id,
            },
        ],
      },
    ),
    (j) => j['id'] as String,
  );

  @override
  Future<List<PostableEvent>> postableEvents() async {
    Future<List<Json>> scope(String s) => _call(
      () => _dio.get<Json>('/me/events', queryParameters: {'scope': s}),
      _data,
    );
    final [upcoming, past] = await Future.wait([
      scope('upcoming'),
      scope('past'),
    ]);
    return [
      for (final j in [...upcoming, ...past])
        if (j['is_host'] == true ||
            j['my_rsvp'] == 'going' ||
            j['my_rsvp'] == 'maybe')
          PostableEvent(
            id: j['id'] as String,
            title: j['title'] as String,
            startsAt: DateTime.parse(j['starts_at'] as String).toLocal(),
          ),
    ];
  }

  @override
  Future<List<TagTarget>> searchTargets(TagTargetType type, String query) {
    final q = query.trim();
    return switch (type) {
      TagTargetType.item => _call(
        () => _dio.get<Json>('/items', queryParameters: {'q': q, 'limit': 20}),
        (body) => [
          for (final j in _data(body))
            TagTarget(
              type: TagTargetType.item,
              id: j['id'] as String,
              label: j['title'] as String,
              subtitle: (j['vendor'] as Json?)?['name'] as String?,
              imageUrl:
                  ((j['media'] as List?)?.firstOrNull as Json?)?['url']
                      as String?,
            ),
        ],
      ),
      TagTargetType.vendor => _call(
        () =>
            _dio.get<Json>('/vendors', queryParameters: {'q': q, 'limit': 20}),
        (body) => [
          for (final j in _data(body))
            TagTarget(
              type: TagTargetType.vendor,
              id: j['id'] as String,
              label: j['name'] as String,
              subtitle: j['city'] as String?,
              imageUrl: j['logo_url'] as String?,
            ),
        ],
      ),
    };
  }
}

@Riverpod(keepAlive: true)
PostsRepository postsRepository(Ref ref) =>
    PostsRepositoryImpl(ref.watch(dioProvider));
