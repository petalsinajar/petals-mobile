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
import 'package:petalsinajar/features/posts/presentation/photo_source.dart';

import '../../helpers/fake_http_adapter.dart';

const _chair = TagTarget(
  type: TagTargetType.item,
  id: '01jitem0000000000000000000',
  label: 'Chiavari chair',
  subtitle: 'Royal Canopies',
);

class _Repo implements PostsRepository {
  final uploads = <String>[];
  final created = <NewPost>[];
  bool failCreate = false;

  @override
  Future<UploadedImage> upload(String path) async {
    uploads.add(path);
    return UploadedImage(
      url: 'https://cdn.test/$path',
      width: 1600,
      height: 2000,
    );
  }

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
  Future<List<String>> gallery({required int limit}) async =>
      ['a.jpg', 'b.jpg'].take(limit).toList();

  @override
  Future<String?> camera() async => 'cam.jpg';
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
          media: [
            UploadedImage(
              url: 'https://cdn.test/a.jpg',
              width: 1600,
              height: 2000,
            ),
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
        'media': [
          {
            'url': 'https://cdn.test/a.jpg',
            'type': 'image',
            'w': 1600,
            'h': 2000,
          },
        ],
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
        overrides: [postsRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(c.dispose);
    });

    CreatePost draft() => c.read(createPostProvider.notifier);

    test('removing a photo drops its tags and shifts the later ones', () {
      draft()
        ..addPhotos(['a', 'b', 'c'])
        ..addTag(const DraftTag(mediaIndex: 0, x: 0, y: 0, target: _chair))
        ..addTag(const DraftTag(mediaIndex: 1, x: 0, y: 0, target: _chair))
        ..addTag(const DraftTag(mediaIndex: 2, x: 0, y: 0, target: _chair))
        ..removePhoto(1);

      expect(c.read(createPostProvider).tags.map((t) => t.mediaIndex), [0, 1]);
    });

    test('at most 10 photos', () {
      draft().addPhotos([for (var i = 0; i < 14; i++) '$i.jpg']);
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

    test(
      'a failed share keeps the draft, and the retry does not re-upload',
      () async {
        draft()
          ..addPhotos(['a.jpg', 'b.jpg'])
          ..setCaption('Hello');
        repo.failCreate = true;
        await expectLater(draft().share(), throwsA(isA<ApiException>()));
        expect(c.read(createPostProvider).photos, hasLength(2));
        expect(c.read(createPostProvider).phase, DraftPhase.editing);

        repo.failCreate = false;
        expect(await draft().share(), 'p1');
        expect(repo.uploads, ['a.jpg', 'b.jpg'], reason: 'uploaded once each');
        expect(repo.created.single.caption, 'Hello');
        expect(c.read(createPostProvider).isEmpty, isTrue);
      },
    );
  });

  testWidgets('pick, tag, choose who sees it, share, land on the feed', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(400, 1400)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final repo = _Repo();
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

    final post = repo.created.single;
    expect(post.media, hasLength(2));
    expect(post.caption, 'Our day #wedding');
    expect(post.visibility, PostVisibility.followers);
    expect(post.tags.single.target, _chair);
    expect(post.tags.single.x, closeTo(0.5, 0.01));
    expect(find.text('the feed'), findsOneWidget);
    expect(find.text('Posted'), findsOneWidget);
  });
}
