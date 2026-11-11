import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/core/media/upload_queue.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/features/feed/data/feed_repository_impl.dart';
import 'package:petalsinajar/features/feed/domain/feed_repository.dart';
import 'package:petalsinajar/features/feed/domain/post.dart';
import 'package:petalsinajar/features/feed/presentation/feed_controllers.dart';
import 'package:petalsinajar/features/feed/presentation/feed_screen.dart';
import 'package:petalsinajar/features/posts/data/posts_repository_impl.dart';
import 'package:petalsinajar/features/posts/domain/posts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/pump_app.dart';

/// In-memory feed. Posts have no photos: images need a cache directory
/// that doesn't exist under test.
class _Posts implements PostsRepository {
  final deleted = <String>[];

  @override
  Future<void> delete(String postId) async => deleted.add(postId);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeFeed implements FeedRepository {
  _FakeFeed(this.posts);

  final List<FeedPost> posts;
  final Set<String> liked = {};
  final Map<String, List<PostComment>> posted = {};
  bool failLikes = false;

  @override
  Future<Paginated<FeedPost>> feed(FeedKind kind, {String? cursor}) async =>
      Paginated(items: posts);

  int _count(String id) => posts.firstWhere((p) => p.id == id).likeCount;

  @override
  Future<int> like(String postId) async {
    if (failLikes) {
      throw const ApiException(type: ApiErrorType.network, message: 'offline');
    }
    liked.add(postId);
    return _count(postId) + 1;
  }

  @override
  Future<int> unlike(String postId) async {
    liked.remove(postId);
    return _count(postId);
  }

  @override
  Future<Paginated<PostComment>> comments(
    String postId, {
    String? cursor,
  }) async => Paginated(items: posted[postId] ?? const []);

  @override
  Future<PostComment> addComment(String postId, String body) async {
    final c = PostComment(
      id: 'c${DateTime.now().microsecondsSinceEpoch}',
      author: const PostAuthor(id: 'me', name: 'Ama Mensah'),
      body: body,
      createdAt: DateTime.now(),
    );
    (posted[postId] ??= []).add(c);
    return c;
  }
}

FeedPost _post(String id, {int likes = 5, PostEventRef? event}) => FeedPost(
  id: id,
  author: const PostAuthor(
    id: 'v1',
    name: 'Royal Canopies',
    isVendor: true,
    isVerified: true,
  ),
  caption: 'Caption for $id',
  event: event,
  likeCount: likes,
  commentCount: 1,
  createdAt: DateTime.now().subtract(const Duration(hours: 2)),
);

void main() {
  group('FeedPosts controller', () {
    late _FakeFeed repo;
    late ProviderContainer container;

    setUp(() {
      repo = _FakeFeed([_post('p1'), _post('p2')]);
      container = ProviderContainer(
        overrides: [
          feedRepositoryProvider.overrideWithValue(repo),
          viewerIdProvider.overrideWithValue('me'),
        ],
      );
      addTearDown(container.dispose);
    });

    FeedPost p1() => container
        .read(feedPostsProvider(FeedKind.forYou))
        .requireValue
        .items
        .first;

    test('a like shows at once, then takes the server count', () async {
      await container.read(feedPostsProvider(FeedKind.forYou).future);
      final notifier = container.read(
        feedPostsProvider(FeedKind.forYou).notifier,
      );

      final pending = notifier.toggleLike('p1');
      expect(p1().likedByMe, isTrue);
      expect(p1().likeCount, 6);
      await pending;
      expect(repo.liked, {'p1'});
      expect(p1().likeCount, 6);

      await notifier.toggleLike('p1');
      expect(p1().likedByMe, isFalse);
      expect(p1().likeCount, 5);
    });

    test('a refused like rolls back and rethrows', () async {
      await container.read(feedPostsProvider(FeedKind.forYou).future);
      repo.failLikes = true;

      await expectLater(
        container
            .read(feedPostsProvider(FeedKind.forYou).notifier)
            .toggleLike('p1'),
        throwsA(isA<ApiException>()),
      );
      expect(p1().likedByMe, isFalse);
      expect(p1().likeCount, 5);
    });

    test('a new comment bumps the count', () async {
      await container.read(feedPostsProvider(FeedKind.forYou).future);
      container
          .read(feedPostsProvider(FeedKind.forYou).notifier)
          .commentAdded('p1');
      expect(p1().commentCount, 2);
    });
  });

  group('FeedScreen', () {
    Future<_FakeFeed> pump(
      WidgetTester tester, {
      String? viewer,
      List<FeedPost>? posts,
    }) async {
      final repo = _FakeFeed(posts ?? [_post('p1'), _post('p2')]);
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpApp(
        const FeedScreen(),
        overrides: [
          feedRepositoryProvider.overrideWithValue(repo),
          viewerIdProvider.overrideWithValue(viewer),
          // The upload queue behind "posting…" cards: nothing queued.
          sharedPreferencesProvider.overrideWithValue(prefs),
          onlineProvider.overrideWith((ref) => Stream.value(true)),
        ],
      );
      await tester.pumpAndSettle();
      return repo;
    }

    testWidgets('For you shows posts signed out', (tester) async {
      await pump(tester);

      expect(find.text('For you'), findsOneWidget);
      expect(find.text('Royal Canopies'), findsWidgets);
      expect(find.textContaining('Caption for p1'), findsOneWidget);
      expect(find.byTooltip('Verified'), findsNothing); // semantics label only
      expect(find.byIcon(Icons.verified_rounded), findsWidgets);
    });

    testWidgets('Following asks signed-out people to sign in', (tester) async {
      await pump(tester);

      await tester.tap(find.text('Following'));
      await tester.pumpAndSettle();

      expect(find.text('See who you follow'), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
    });

    testWidgets('signed in, liking fills the heart and bumps the count', (
      tester,
    ) async {
      final repo = await pump(tester, viewer: 'me', posts: [_post('p1')]);

      await tester.tap(find.byTooltip('Like'));
      await tester.pumpAndSettle();

      expect(find.byTooltip('Unlike'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
      expect(repo.liked, {'p1'});
    });

    testWidgets('comments open in a sheet and a new one is added', (
      tester,
    ) async {
      final repo = await pump(tester, viewer: 'me', posts: [_post('p1')]);

      await tester.tap(find.byTooltip('Comments'));
      await tester.pumpAndSettle();
      expect(find.text('No comments yet. Say something nice.'), findsOneWidget);

      await tester.enterText(
        find.widgetWithText(TextField, 'Add a comment…'),
        'Beautiful!',
      );
      await tester.tap(find.byTooltip('Post comment'));
      await tester.pumpAndSettle();

      expect(find.text('Beautiful!'), findsOneWidget);
      expect(repo.posted['p1'], hasLength(1));
    });

    testWidgets('signed out, the comment box becomes a sign-in prompt', (
      tester,
    ) async {
      await pump(tester, posts: [_post('p1')]);

      await tester.tap(find.byTooltip('Comments'));
      await tester.pumpAndSettle();

      expect(find.text('Sign in to comment'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Add a comment…'), findsNothing);
    });

    testWidgets('posts from an event say where', (tester) async {
      await pump(
        tester,
        posts: [
          _post(
            'p1',
            event: const PostEventRef(id: 'e1', title: 'Ama & Kojo'),
          ),
        ],
      );

      expect(find.text('at Ama & Kojo'), findsOneWidget);
    });

    testWidgets('your own post can be deleted; others have no menu', (
      tester,
    ) async {
      final posts = _Posts();
      final repo = _FakeFeed([
        _post('p1').copyWith(canDelete: true),
        _post('p2'),
      ]);
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpApp(
        const FeedScreen(),
        overrides: [
          feedRepositoryProvider.overrideWithValue(repo),
          postsRepositoryProvider.overrideWithValue(posts),
          viewerIdProvider.overrideWithValue('me'),
          sharedPreferencesProvider.overrideWithValue(prefs),
          onlineProvider.overrideWith((ref) => Stream.value(true)),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.byTooltip('Post options'), findsOneWidget);
      await tester.tap(find.byTooltip('Post options'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete post'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Delete'));
      await tester.pumpAndSettle();

      expect(posts.deleted, ['p1']);
      expect(find.textContaining('Caption for p1'), findsNothing);
      expect(find.textContaining('Caption for p2'), findsOneWidget);
      expect(find.text('Post deleted'), findsOneWidget);
    });

    testWidgets('an empty feed says so', (tester) async {
      await pump(tester, posts: []);

      expect(find.text('Nothing here yet'), findsOneWidget);
    });
  });
}
