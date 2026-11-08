import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/mock_session.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/network/dio_client.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/feed/data/feed_dtos.dart';
import 'package:petalsinajar/features/feed/data/feed_mock_source.dart';
import 'package:petalsinajar/features/feed/data/feed_remote_source.dart';
import 'package:petalsinajar/features/feed/data/feed_source.dart';
import 'package:petalsinajar/features/feed/domain/feed_repository.dart';
import 'package:petalsinajar/features/feed/domain/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_repository_impl.g.dart';

class FeedRepositoryImpl implements FeedRepository {
  FeedRepositoryImpl(this._source);

  final FeedSource _source;

  /// Malformed payloads surface as [ApiException]s, like network errors.
  Future<T> _parse<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on ApiException {
      rethrow;
    } on Object catch (e) {
      throw ApiException.from(e);
    }
  }

  @override
  Future<Paginated<FeedPost>> feed(FeedKind kind, {String? cursor}) =>
      _parse(() async {
        final body = switch (kind) {
          FeedKind.forYou => await _source.discover(cursor: cursor),
          FeedKind.following => await _source.following(cursor: cursor),
        };
        return Paginated.fromJson(body, (j) => PostDto.fromJson(j).toDomain());
      });

  @override
  Future<int> like(String postId) => _parse(
    () async => (await _source.react(postId))['likes'] as int,
  );

  @override
  Future<int> unlike(String postId) => _parse(
    () async => (await _source.unreact(postId))['likes'] as int,
  );

  @override
  Future<Paginated<PostComment>> comments(String postId, {String? cursor}) =>
      _parse(() async {
        final body = await _source.comments(postId, cursor: cursor);
        return Paginated.fromJson(
          body,
          (j) => CommentDto.fromJson(j).toDomain(),
        );
      });

  @override
  Future<PostComment> addComment(String postId, String body) => _parse(
    () async =>
        CommentDto.fromJson(await _source.addComment(postId, body)).toDomain(),
  );
}

@Riverpod(keepAlive: true)
FeedRepository feedRepository(Ref ref) {
  final source = ref.watch(appConfigProvider).useMocks
      ? FeedMockSource(
          seed: ref.watch(seedLoaderProvider),
          delay: ref.watch(mockDelayProvider),
          viewerId: ref.watch(mockViewerIdProvider),
        )
      : FeedRemoteSource(ref.watch(dioProvider));
  return FeedRepositoryImpl(source);
}
