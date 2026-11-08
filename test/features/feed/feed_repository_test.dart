import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/feed/data/feed_mock_source.dart';
import 'package:petalsinajar/features/feed/data/feed_remote_source.dart';
import 'package:petalsinajar/features/feed/data/feed_repository_impl.dart';
import 'package:petalsinajar/features/feed/domain/feed_repository.dart';

import '../../helpers/fake_http_adapter.dart';

const _ama = '01KK67BN00FWWT9PCC060FWN3G';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('over the seed (mock source)', () {
    late FeedRepositoryImpl repo;

    setUp(() {
      repo = FeedRepositoryImpl(
        FeedMockSource(
          seed: SeedLoader(),
          delay: MockDelay.none(),
          viewerId: _ama,
        ),
      );
    });

    test('for you ranks by likes and pages through every post', () async {
      final first = await repo.feed(FeedKind.forYou);
      final likes = first.items.map((p) => p.likeCount).toList();
      expect(likes, [...likes]..sort((a, b) => b.compareTo(a)));

      var all = first;
      while (all.hasMore) {
        all = all.append(
          await repo.feed(FeedKind.forYou, cursor: all.nextCursor),
        );
      }
      expect(all.items, hasLength(30));
      expect(all.items.map((p) => p.id).toSet(), hasLength(30));
    });

    test('posts carry their author, media and event', () async {
      final posts = (await repo.feed(FeedKind.forYou)).items;

      expect(posts.every((p) => p.author.name.isNotEmpty), isTrue);
      expect(posts.any((p) => p.author.isVendor), isTrue);
      expect(posts.every((p) => p.media.isNotEmpty), isTrue);
      expect(posts.any((p) => p.event != null), isTrue);
    });

    test('following is newest first, from events the viewer is in', () async {
      final posts = (await repo.feed(FeedKind.following)).items;

      expect(posts, isNotEmpty);
      expect(posts.every((p) => p.event != null), isTrue);
      final times = posts.map((p) => p.createdAt).toList();
      expect(times, [...times]..sort((a, b) => b.compareTo(a)));
    });

    test('like and unlike move the count once', () async {
      final post = (await repo.feed(
        FeedKind.forYou,
      )).items.firstWhere((p) => !p.likedByMe);

      expect(await repo.like(post.id), post.likeCount + 1);
      expect(
        await repo.like(post.id),
        post.likeCount + 1,
        reason: 'idempotent',
      );
      expect(await repo.unlike(post.id), post.likeCount);

      final again = (await repo.feed(
        FeedKind.forYou,
      )).items.firstWhere((p) => p.id == post.id);
      expect(again.likedByMe, isFalse);
    });

    test('comments are added and listed in order', () async {
      final post = (await repo.feed(FeedKind.forYou)).items.first;

      await repo.addComment(post.id, 'First!');
      final added = await repo.addComment(post.id, '  Gorgeous setup  ');

      expect(added.body, 'Gorgeous setup');
      expect(added.author.name, 'Ama Mensah');
      final comments = await repo.comments(post.id);
      expect(comments.items.map((c) => c.body), ['First!', 'Gorgeous setup']);
    });

    test('an empty comment is a validation error on body', () async {
      final post = (await repo.feed(FeedKind.forYou)).items.first;

      await expectLater(
        repo.addComment(post.id, '   '),
        throwsA(
          isA<ApiException>().having(
            (e) => e.fieldError('body'),
            'body',
            isNotNull,
          ),
        ),
      );
    });
  });

  group('over the live API (remote source)', () {
    late FakeHttpAdapter api;
    late FeedRepositoryImpl repo;

    Map<String, dynamic> post(String id, {String? myReaction}) => {
      'id': id,
      'author': {
        'type': 'vendor',
        'id': 'v1',
        'handle': 'royalcanopies',
        'name': 'Royal Canopies',
        'avatar_url': 'https://cdn.test/logo.png',
        'is_verified': true,
      },
      'event': {'id': 'e1', 'title': 'Ama & Kojo', 'type': 'wedding'},
      'event_type': 'wedding',
      'kind': 'post',
      'caption': 'Setup done',
      'hashtags': <String>[],
      'media': [
        {
          'url': 'https://cdn.test/a.jpg',
          'type': 'image',
          'w': 1080,
          'h': 1350,
          'tags': <Object>[],
        },
      ],
      'visibility': 'public',
      'counts': {'likes': 7, 'comments': 2, 'saves': 1},
      'my_reaction': myReaction,
      'created_at': '2026-11-01T10:00:00+00:00',
    };

    setUp(() {
      api = FakeHttpAdapter((o) async {
        return switch ((o.method, o.path)) {
          ('GET', '/feed/discover') => jsonBody(200, {
            'data': [post('p1', myReaction: 'like')],
            'next_cursor': 'next',
          }),
          ('GET', '/feed/following') => jsonBody(401, {
            'message': 'Unauthenticated.',
          }),
          ('PUT', '/posts/p1/reaction') => jsonBody(200, {
            'likes': 8,
            'my_reaction': 'like',
          }),
          ('DELETE', '/posts/p1/reaction') => jsonBody(200, {
            'likes': 6,
            'my_reaction': null,
          }),
          ('POST', '/posts/p1/comments') => jsonBody(201, {
            'id': 'c1',
            'post_id': 'p1',
            'parent_id': null,
            'author': {'type': 'user', 'id': 'u1', 'handle': 'user4567'},
            'body': (o.data as Map)['body'],
            'likes': 0,
            'replies': 0,
            'created_at': '2026-11-07T12:00:00+00:00',
          }),
          _ => jsonBody(500, {'message': 'Unexpected ${o.method} ${o.path}'}),
        };
      });
      final dio = Dio(BaseOptions(baseUrl: 'https://api.test/v1'))
        ..httpClientAdapter = api;
      repo = FeedRepositoryImpl(FeedRemoteSource(dio));
    });

    test('parses PostPresenter output', () async {
      final page = await repo.feed(FeedKind.forYou);
      final p = page.items.single;

      expect(page.nextCursor, 'next');
      expect(p.author.name, 'Royal Canopies');
      expect(p.author.isVendor, isTrue);
      expect(p.author.isVerified, isTrue);
      expect(p.event?.title, 'Ama & Kojo');
      expect(p.media.single.aspectRatio, closeTo(0.8, 0.001));
      expect(p.likeCount, 7);
      expect(p.commentCount, 2);
      expect(p.likedByMe, isTrue);
    });

    test('following signed out is an unauthorized error', () async {
      await expectLater(
        repo.feed(FeedKind.following),
        throwsA(
          isA<ApiException>().having(
            (e) => e.type,
            'type',
            ApiErrorType.unauthorized,
          ),
        ),
      );
    });

    test(
      'like / unlike hit the reaction endpoint and return the count',
      () async {
        expect(await repo.like('p1'), 8);
        expect(await repo.unlike('p1'), 6);
      },
    );

    test(
      'commenting sends { body }; a nameless author shows as @handle',
      () async {
        final c = await repo.addComment('p1', 'Lovely');

        expect(api.requests.last.data, {'body': 'Lovely'});
        expect(c.body, 'Lovely');
        expect(c.author.name, '@user4567');
      },
    );
  });
}
