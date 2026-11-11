import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/upload_queue.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/features/posts/data/posts_repository_impl.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';
import 'package:petalsinajar/features/posts/domain/posts_repository.dart';
import 'package:petalsinajar/features/posts/presentation/create_post_controller.dart';
import 'package:petalsinajar/features/posts/presentation/pending_posts.dart';
import 'package:petalsinajar/features/posts/presentation/widgets/pending_post_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/pump_app.dart';

/// The queue's state, set by the test; no real uploads.
class _Queue extends UploadQueue {
  final removed = <String>[];

  @override
  List<UploadJob> build() => const [];

  // A method, not a setter: notifiers keep their API on `state`.
  // ignore: use_setters_to_change_properties
  void set(List<UploadJob> jobs) => state = jobs;

  @override
  Future<List<UploadJob>> enqueue(
    String group,
    List<({String path, MediaKind kind})> files, {
    required MediaPurpose purpose,
    String? vendorId,
  }) async {
    final jobs = [
      for (final (i, f) in files.indexed)
        UploadJob(
          id: '$group-$i',
          group: group,
          path: '/queue/${f.path}',
          kind: f.kind,
          purpose: purpose,
          vendorId: vendorId,
        ),
    ];
    state = [...state, ...jobs];
    return jobs;
  }

  @override
  Future<void> removeGroup(String group) async {
    removed.add(group);
    state = [
      for (final j in state)
        if (j.group != group) j,
    ];
  }
}

class _Repo implements PostsRepository {
  final created = <NewPost>[];
  final deleted = <String>[];

  /// Set: creating waits here, as on a slow network.
  Completer<void>? holdCreate;

  @override
  Future<String> create(NewPost post) async {
    await holdCreate?.future;
    created.add(post);
    return 'p1';
  }

  @override
  Future<void> delete(String postId) async => deleted.add(postId);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

UploadJob _job(
  String id,
  String group,
  UploadPhase phase, {
  String? mediaId,
  double progress = 0,
  String? error,
}) => UploadJob(
  id: id,
  group: group,
  path: '/queue/$id.jpg',
  kind: MediaKind.image,
  purpose: MediaPurpose.post,
  phase: phase,
  mediaId: mediaId,
  progress: progress,
  error: error,
);

void main() {
  late _Queue queue;
  late _Repo repo;

  Future<List<Override>> overrides() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    queue = _Queue();
    repo = _Repo();
    return [
      sharedPreferencesProvider.overrideWithValue(prefs),
      uploadQueueProvider.overrideWith(() => queue),
      postsRepositoryProvider.overrideWithValue(repo),
      onlineProvider.overrideWith((ref) => Stream.value(true)),
    ];
  }

  test(
    'publishes with the media ids, in order, once every upload is ready',
    () async {
      final c = ProviderContainer(overrides: await overrides());
      addTearDown(c.dispose);
      c.listen(pendingPostsProvider, (_, _) {});

      final post = await c
          .read(pendingPostsProvider.notifier)
          .submit(
            const PostDraft(
              photos: [
                DraftPhoto(path: 'a.jpg'),
                DraftPhoto(path: 'b.mp4', isVideo: true),
              ],
              caption: 'Our day',
              visibility: PostVisibility.followers,
            ),
          );
      expect(c.read(pendingPostsProvider).single.id, post.id);

      // One ready, one still processing: not yet.
      queue.set([
        _job('${post.id}-0', post.id, UploadPhase.ready, mediaId: 'm-a'),
        _job('${post.id}-1', post.id, UploadPhase.processing, mediaId: 'm-b'),
      ]);
      await Future<void>.delayed(Duration.zero);
      expect(repo.created, isEmpty);

      queue.set([
        _job('${post.id}-0', post.id, UploadPhase.ready, mediaId: 'm-a'),
        _job('${post.id}-1', post.id, UploadPhase.ready, mediaId: 'm-b'),
      ]);
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      expect(repo.created.single.mediaIds, ['m-a', 'm-b']);
      expect(repo.created.single.visibility, PostVisibility.followers);
      expect(c.read(pendingPostsProvider), isEmpty);
      expect(queue.removed, [post.id], reason: 'its files are cleaned up');
    },
  );

  test('pending posts survive a restart', () async {
    final first = ProviderContainer(overrides: await overrides());
    addTearDown(first.dispose);
    await first
        .read(pendingPostsProvider.notifier)
        .submit(const PostDraft(photos: [DraftPhoto(path: 'a.jpg')]));
    final saved = first
        .read(sharedPreferencesProvider)
        .getString(PendingPosts.storageKey);

    SharedPreferences.setMockInitialValues({PendingPosts.storageKey: saved!});
    final prefs = await SharedPreferences.getInstance();
    final second = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        uploadQueueProvider.overrideWith(_Queue.new),
        postsRepositoryProvider.overrideWithValue(_Repo()),
      ],
    );
    addTearDown(second.dispose);
    expect(second.read(pendingPostsProvider), hasLength(1));
  });

  test('cancelled while publishing: the post is deleted once made', () async {
    final c = ProviderContainer(overrides: await overrides());
    addTearDown(c.dispose);
    c.listen(pendingPostsProvider, (_, _) {});
    repo.holdCreate = Completer<void>();

    final post = await c
        .read(pendingPostsProvider.notifier)
        .submit(const PostDraft(photos: [DraftPhoto(path: 'a.jpg')]));
    queue.set([_job('${post.id}-0', post.id, UploadPhase.ready, mediaId: 'm')]);
    await Future<void>.delayed(Duration.zero);
    expect(c.read(pendingPostsProvider).single.stage, PendingStage.publishing);

    await c.read(pendingPostsProvider.notifier).discard(post.id);
    expect(c.read(pendingPostsProvider), isEmpty);
    repo.holdCreate!.complete();
    for (var i = 0; i < 5; i++) {
      await Future<void>.delayed(Duration.zero);
    }

    expect(repo.created, hasLength(1));
    expect(repo.deleted, ['p1']);
    expect(queue.removed, [post.id]);
  });

  group('in the feed', () {
    Future<void> pump(WidgetTester tester, List<UploadJob> jobs) async {
      await tester.pumpApp(
        const PendingPostsList(),
        overrides: await overrides(),
      );
      final c = ProviderScope.containerOf(
        tester.element(find.byType(PendingPostsList)),
      );
      final post = await c
          .read(pendingPostsProvider.notifier)
          .submit(
            const PostDraft(
              photos: [
                DraftPhoto(path: 'a.jpg'),
                DraftPhoto(path: 'b.jpg'),
              ],
              caption: 'Our day',
            ),
          );
      queue.set([
        for (final j in jobs)
          _job(
            '${post.id}-${j.id}',
            post.id,
            j.phase,
            progress: j.progress,
            error: j.error,
          ),
      ]);
      await tester.pump();
    }

    testWidgets('uploading shows a progress ring and what is happening', (
      tester,
    ) async {
      await pump(tester, [
        _job('0', '', UploadPhase.ready),
        _job('1', '', UploadPhase.sending, progress: 0.5),
      ]);

      expect(find.text('Our day'), findsOneWidget);
      expect(find.text('Uploading your 2 photos…'), findsOneWidget);
      final ring = tester.widget<CircularProgressIndicator>(
        find.byKey(const Key('pending-progress')),
      );
      // (1 + (0.1 + 0.5 × 0.8)) / 2
      expect(ring.value, closeTo(0.75, 0.001));
    });

    testWidgets('while uploading it can be cancelled', (tester) async {
      await pump(tester, [
        _job('0', '', UploadPhase.sending, progress: 0.3),
        _job('1', '', UploadPhase.queued),
      ]);

      await tester.tap(find.byTooltip('Cancel post'));
      await tester.pumpAndSettle();
      expect(find.text('Cancel this post?'), findsOneWidget);
      await tester.tap(find.text('Keep uploading'));
      await tester.pumpAndSettle();
      expect(find.text('Our day'), findsOneWidget);

      await tester.tap(find.byTooltip('Cancel post'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Cancel post'));
      await tester.pumpAndSettle();

      expect(find.text('Our day'), findsNothing);
      expect(queue.removed, hasLength(1));
    });

    testWidgets('a failed upload offers retry and discard', (tester) async {
      await pump(tester, [
        _job('0', '', UploadPhase.ready),
        _job(
          '1',
          '',
          UploadPhase.failed,
          error: 'That photo is too big (16 MB). Photos can be up to 15 MB.',
        ),
      ]);
      await tester.pump();

      expect(find.textContaining('too big'), findsOneWidget);
      expect(find.byTooltip('Try again'), findsOneWidget);

      await tester.tap(find.byTooltip('Discard post'));
      await tester.pump();
      await tester.pump();
      expect(find.text('Our day'), findsNothing);
    });
  });
}
