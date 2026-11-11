import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/theme/app_theme.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/domain/auth_repository.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:petalsinajar/features/posts/data/posts_repository_impl.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';
import 'package:petalsinajar/features/posts/domain/posts_repository.dart';
import 'package:petalsinajar/features/posts/presentation/create_post_controller.dart';
import 'package:petalsinajar/features/posts/presentation/create_screen.dart';
import 'package:petalsinajar/features/posts/presentation/pending_posts.dart';
import 'package:petalsinajar/features/posts/presentation/photo_source.dart';

import '../../helpers/fake_http_adapter.dart';

const _chair = TagTarget(
  type: TagTargetType.item,
  id: '01jitem0000000000000000000',
  label: 'Chiavari chair',
  subtitle: 'Royal Canopies',
);

class _Repo implements PostsRepository {
  final created = <NewPost>[];
  bool failCreate = false;

  @override
  Future<void> delete(String postId) async {}

  @override
  Future<String> create(NewPost post) async {
    if (failCreate) {
      throw const ApiException(type: ApiErrorType.server, message: 'Down');
    }
    created.add(post);
    return 'p1';
  }

  @override
  Future<List<PostableEvent>> postableEvents() async => [
    PostableEvent(
      id: 'e1',
      title: 'Our wedding',
      startsAt: DateTime(2026, 12, 12),
    ),
  ];

  @override
  Future<List<TagTarget>> searchTargets(TagTargetType type, String q) async =>
      type == TagTargetType.item ? const [_chair] : const [];
}

class _Photos implements PhotoSource {
  @override
  Future<List<DraftPhoto>> gallery({required int limit}) async => const [
    DraftPhoto(path: 'a.jpg'),
    DraftPhoto(path: 'b.mp4', isVideo: true),
  ].take(limit).toList();

  @override
  Future<DraftPhoto?> camera() async => const DraftPhoto(path: 'cam.jpg');

  @override
  Future<DraftPhoto?> recordVideo() async =>
      const DraftPhoto(path: 'clip.mp4', isVideo: true);
}

/// Records what Share hands over, instead of uploading.
class _Pending extends PendingPosts {
  final submitted = <PostDraft>[];

  @override
  List<PendingPost> build() => const [];

  @override
  Future<PendingPost> submit(PostDraft draft) async {
    submitted.add(draft);
    return PendingPost(
      id: 'pp1',
      jobIds: const [],
      previews: draft.photos,
      createdAt: DateTime(2026),
    );
  }
}

class _Auth implements AuthRepository {
  @override
  Future<Me?> restore() async => const Me(
    id: 'u1',
    handle: 'ama',
    phone: '+233240000001',
    displayName: 'Ama Mensah',
    vendors: [
      MeVendor(
        id: 'v1',
        handle: 'royal',
        name: 'Royal Canopies',
        role: 'owner',
      ),
      MeVendor(id: 'v2', handle: 'glow', name: 'Glow Decor', role: 'staff'),
    ],
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('repository', () {
    late FakeHttpAdapter api;
    late PostsRepositoryImpl repo;

    setUp(() {
      api = FakeHttpAdapter((o) async {
        return switch ((o.method, o.path)) {
          ('POST', '/posts') => jsonBody(201, {'id': 'p1'}),
          ('GET', '/me/events') => jsonBody(200, {
            'data': [
              {
                'id': 'e-${o.queryParameters['scope']}-host',
                'title': 'Hosting',
                'starts_at': '2026-12-12T14:00:00+00:00',
                'is_host': true,
              },
              {
                'id': 'e-${o.queryParameters['scope']}-declined',
                'title': 'Not going',
                'starts_at': '2026-12-12T14:00:00+00:00',
                'is_host': false,
                'my_rsvp': 'declined',
              },
            ],
            'next_cursor': null,
          }),
          _ => jsonBody(404, {'message': 'Not found'}),
        };
      });
      repo = PostsRepositoryImpl(
        Dio(BaseOptions(baseUrl: 'https://api.test/v1'))
          ..httpClientAdapter = api,
      );
    });

    test('a post is sent in the backend’s shape', () async {
      await repo.create(
        const NewPost(
          mediaIds: [
            '01jmedia00000000000000000a',
            '01jmedia00000000000000000b',
          ],
          caption: '  Our day #wedding ',
          asVendorId: 'v1',
          eventId: 'e1',
          visibility: PostVisibility.eventMembers,
          tags: [DraftTag(mediaIndex: 0, x: 0.4, y: 0.6, target: _chair)],
        ),
      );

      expect(api.requests.last.data, {
        'as_vendor_id': 'v1',
        'event_id': 'e1',
        'caption': 'Our day #wedding',
        'visibility': 'event_members',
        'media': ['01jmedia00000000000000000a', '01jmedia00000000000000000b'],
        'tags': [
          {
            'media_index': 0,
            'x': 0.4,
            'y': 0.6,
            'target_type': 'item',
            'target_id': '01jitem0000000000000000000',
          },
        ],
      });
    });

    test('only events you host or are going to can be posted to', () async {
      final events = await repo.postableEvents();
      expect(events.map((e) => e.id), ['e-upcoming-host', 'e-past-host']);
    });
  });

  group('draft', () {
    late _Repo repo;
    late ProviderContainer c;

    setUp(() {
      repo = _Repo();
      c = ProviderContainer(
        overrides: [
          postsRepositoryProvider.overrideWithValue(repo),
          pendingPostsProvider.overrideWith(_Pending.new),
        ],
      );
      addTearDown(c.dispose);
    });

    CreatePost draft() => c.read(createPostProvider.notifier);

    test('removing a photo drops its tags and shifts the later ones', () {
      draft()
        ..addPhotos(const [
          DraftPhoto(path: 'a'),
          DraftPhoto(path: 'b'),
          DraftPhoto(path: 'c'),
        ])
        ..addTag(const DraftTag(mediaIndex: 0, x: 0, y: 0, target: _chair))
        ..addTag(const DraftTag(mediaIndex: 1, x: 0, y: 0, target: _chair))
        ..addTag(const DraftTag(mediaIndex: 2, x: 0, y: 0, target: _chair))
        ..removePhoto(1);

      expect(c.read(createPostProvider).tags.map((t) => t.mediaIndex), [0, 1]);
    });

    test('at most 10 photos', () {
      draft().addPhotos([for (var i = 0; i < 14; i++) DraftPhoto(path: '$i')]);
      expect(c.read(createPostProvider).photos, hasLength(10));
    });

    test('clearing the event takes "guests only" back to everyone', () {
      draft()
        ..setEvent(
          PostableEvent(id: 'e1', title: 'W', startsAt: DateTime(2026)),
        )
        ..setVisibility(PostVisibility.eventMembers)
        ..setEvent(null);
      expect(c.read(createPostProvider).visibility, PostVisibility.public);
    });

    test('sharing hands the draft to the upload queue and clears it', () async {
      draft()
        ..addPhotos(const [
          DraftPhoto(path: 'a.jpg'),
          DraftPhoto(path: 'v.mp4', isVideo: true),
        ])
        ..setCaption('Hello');

      await draft().share();

      final pending = c.read(pendingPostsProvider.notifier) as _Pending;
      expect(pending.submitted.single.caption, 'Hello');
      expect(pending.submitted.single.photos.last.isVideo, isTrue);
      expect(c.read(createPostProvider).isEmpty, isTrue);
      expect(repo.created, isEmpty, reason: 'publishes once uploads are ready');
    });
  });

  testWidgets('pick, tag, choose who sees it, share, land on the feed', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(400, 1400)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final repo = _Repo();
    final pending = _Pending();
    final router = GoRouter(
      initialLocation: '/create',
      routes: [
        GoRoute(path: '/create', builder: (_, _) => const CreateScreen()),
        GoRoute(
          path: '/feed',
          builder: (_, _) => const Scaffold(body: Text('the feed')),
        ),
      ],
    );
    final themes = AppThemes.build(googleFonts: false);
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          postsRepositoryProvider.overrideWithValue(repo),
          photoSourceProvider.overrideWithValue(_Photos()),
          authRepositoryProvider.overrideWithValue(_Auth()),
          pendingPostsProvider.overrideWith(() => pending),
        ],
        child: MaterialApp.router(
          theme: themes.light,
          routerConfig: router,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(disableAnimations: true),
            child: child!,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Choose photos'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Remove photo 2'), findsOneWidget);

    // Tag the first photo.
    await tester.tapAt(tester.getCenter(find.byType(PageView)));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'chiavari');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Chiavari chair'));
    await tester.pumpAndSettle();
    expect(
      find.text('Item tags show to others once the vendor approves them.'),
      findsOneWidget,
    );

    // Staff can't post as Glow Decor, so only Ama and Royal Canopies.
    expect(find.text('Posting as'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextField, 'Caption'),
      'Our day #wedding',
    );
    await tester.tap(find.text('Followers'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Share'));
    await tester.tap(find.text('Share'));
    await tester.pumpAndSettle();

    // Share returns at once: the post uploads in the background.
    final post = pending.submitted.single;
    expect(post.photos.map((p) => p.isVideo), [false, true]);
    expect(post.caption, 'Our day #wedding');
    expect(post.visibility, PostVisibility.followers);
    expect(post.tags.single.target, _chair);
    expect(post.tags.single.x, closeTo(0.5, 0.01));
    expect(find.text('the feed'), findsOneWidget);
    expect(find.text('Posting… it’s uploading in the feed'), findsOneWidget);
  });
}
