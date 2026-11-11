import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/upload_queue.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/features/feed/domain/feed_repository.dart';
import 'package:petalsinajar/features/feed/presentation/feed_controllers.dart';
import 'package:petalsinajar/features/posts/data/posts_repository_impl.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';
import 'package:petalsinajar/features/posts/presentation/create_post_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'pending_posts.g.dart';

enum PendingStage { uploading, publishing, failed }

/// A post the user shared whose photos and videos are still uploading. It
/// shows at the top of the feed and publishes itself once they're ready.
@immutable
class PendingPost {
  const PendingPost({
    required this.id,
    required this.jobIds,
    required this.previews,
    required this.createdAt,
    this.caption = '',
    this.asVendorId,
    this.eventId,
    this.visibility = PostVisibility.public,
    this.tags = const [],
    this.stage = PendingStage.uploading,
    this.error,
  });

  factory PendingPost.fromJson(Map<String, dynamic> j) => PendingPost(
    id: j['id'] as String,
    jobIds: (j['job_ids'] as List).cast<String>(),
    previews: [
      for (final p in (j['previews'] as List).cast<Map<String, dynamic>>())
        DraftPhoto(path: p['path'] as String, isVideo: p['video'] == true),
    ],
    createdAt: DateTime.parse(j['created_at'] as String),
    caption: j['caption'] as String? ?? '',
    asVendorId: j['as_vendor_id'] as String?,
    eventId: j['event_id'] as String?,
    visibility: PostVisibility.values.byName(j['visibility'] as String),
    tags: [
      for (final t in (j['tags'] as List).cast<Map<String, dynamic>>())
        DraftTag(
          mediaIndex: t['media_index'] as int,
          x: (t['x'] as num).toDouble(),
          y: (t['y'] as num).toDouble(),
          target: TagTarget(
            type: TagTargetType.values.byName(t['type'] as String),
            id: t['target_id'] as String,
            label: t['label'] as String,
          ),
        ),
    ],
    // Publishing was cut off by a restart: try again.
    stage: j['stage'] == 'failed'
        ? PendingStage.failed
        : PendingStage.uploading,
    error: j['error'] as String?,
  );

  final String id;

  /// The upload queue's jobs, in the post's media order.
  final List<String> jobIds;

  /// The picked files, for thumbnails while uploading.
  final List<DraftPhoto> previews;
  final DateTime createdAt;
  final String caption;
  final String? asVendorId;
  final String? eventId;
  final PostVisibility visibility;
  final List<DraftTag> tags;
  final PendingStage stage;
  final String? error;

  PendingPost copyWith({PendingStage? stage, String? error}) => PendingPost(
    id: id,
    jobIds: jobIds,
    previews: previews,
    createdAt: createdAt,
    caption: caption,
    asVendorId: asVendorId,
    eventId: eventId,
    visibility: visibility,
    tags: tags,
    stage: stage ?? this.stage,
    error: error,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'job_ids': jobIds,
    'previews': [
      for (final p in previews) {'path': p.path, 'video': p.isVideo},
    ],
    'created_at': createdAt.toIso8601String(),
    'caption': caption,
    'as_vendor_id': asVendorId,
    'event_id': eventId,
    'visibility': visibility.name,
    'tags': [
      for (final t in tags)
        {
          'media_index': t.mediaIndex,
          'x': t.x,
          'y': t.y,
          'type': t.target.type.name,
          'target_id': t.target.id,
          'label': t.target.label,
        },
    ],
    'stage': stage.name,
    'error': error,
  };
}

/// Overall progress 0..1 of [post]'s uploads: sending counts for most of
/// it, server processing for the rest.
double pendingProgress(PendingPost post, List<UploadJob> jobs) {
  final mine = [
    for (final j in jobs)
      if (j.group == post.id) j,
  ];
  if (mine.isEmpty) return 0;
  double of(UploadJob j) => switch (j.phase) {
    UploadPhase.ready => 1,
    UploadPhase.processing => 0.9,
    UploadPhase.sending => 0.1 + j.progress * 0.8,
    UploadPhase.preparing => 0.05,
    UploadPhase.queued || UploadPhase.failed => 0,
  };
  return mine.map(of).reduce((a, b) => a + b) / mine.length;
}

/// Shared posts still uploading, kept across restarts.
@Riverpod(keepAlive: true)
class PendingPosts extends _$PendingPosts {
  static const storageKey = 'posts.pending';

  final _publishing = <String>{};

  /// Discarded while publishing: deleted again once the server has it.
  final _discarded = <String>{};

  @override
  List<PendingPost> build() {
    ref.listen(uploadQueueProvider, (_, _) => _check());
    final raw = ref.read(sharedPreferencesProvider).getString(storageKey);
    final posts = <PendingPost>[];
    if (raw != null) {
      try {
        for (final j
            in (jsonDecode(raw) as List).cast<Map<String, dynamic>>()) {
          posts.add(PendingPost.fromJson(j));
        }
      } on Object {
        // Unreadable: drop it rather than crash.
      }
    }
    if (posts.isNotEmpty) scheduleMicrotask(_check);
    return posts;
  }

  Future<void> _save() => ref
      .read(sharedPreferencesProvider)
      .setString(storageKey, jsonEncode([for (final p in state) p.toJson()]));

  void _put(PendingPost post) {
    state = [for (final p in state) p.id == post.id ? post : p];
    unawaited(_save());
  }

  /// Queues [draft]'s files and returns at once; the post publishes itself
  /// when they're ready.
  Future<PendingPost> submit(PostDraft draft) async {
    final id = const Uuid().v4();
    final queue = ref.read(uploadQueueProvider.notifier);
    final jobs = await queue.enqueue(
      id,
      [
        for (final p in draft.photos)
          (path: p.path, kind: p.isVideo ? MediaKind.video : MediaKind.image),
      ],
      purpose: MediaPurpose.post,
      vendorId: draft.asVendorId,
    );
    final post = PendingPost(
      id: id,
      jobIds: [for (final j in jobs) j.id],
      // The queue's copies: the picker's files can be cleaned up any time.
      previews: [
        for (final (i, j) in jobs.indexed)
          DraftPhoto(path: j.path, isVideo: draft.photos[i].isVideo),
      ],
      createdAt: DateTime.now(),
      caption: draft.caption,
      asVendorId: draft.asVendorId,
      eventId: draft.event?.id,
      visibility: draft.visibility,
      tags: draft.tags,
    );
    state = [post, ...state];
    await _save();
    return post;
  }

  /// Publishes posts whose media is all ready; flags ones that failed.
  void _check() {
    if (!ref.mounted) return;
    final jobs = ref.read(uploadQueueProvider);
    for (final post in state) {
      if (post.stage == PendingStage.failed || _publishing.contains(post.id)) {
        continue;
      }
      final mine = [
        for (final id in post.jobIds)
          ?jobs.where((j) => j.id == id).firstOrNull,
      ];
      if (mine.length != post.jobIds.length) {
        _put(
          post.copyWith(
            stage: PendingStage.failed,
            error: 'Some photos were lost. Discard and share again.',
          ),
        );
        continue;
      }
      if (mine.firstWhere((j) => j.isFailed, orElse: () => mine.first)
          case final failed when failed.isFailed) {
        _put(
          post.copyWith(
            stage: PendingStage.failed,
            error: failed.error ?? 'An upload failed.',
          ),
        );
        continue;
      }
      if (mine.every((j) => j.isDone)) {
        unawaited(_publish(post, [for (final j in mine) j.mediaId!]));
      }
    }
  }

  Future<void> _publish(PendingPost post, List<String> mediaIds) async {
    _publishing.add(post.id);
    _put(post.copyWith(stage: PendingStage.publishing));
    final repo = ref.read(postsRepositoryProvider);
    try {
      final created = await repo.create(
        NewPost(
          mediaIds: mediaIds,
          caption: post.caption,
          asVendorId: post.asVendorId,
          eventId: post.eventId,
          visibility: post.visibility,
          tags: post.tags,
        ),
      );
      // Cancelled while it was being created: take it down again.
      if (_discarded.remove(post.id)) {
        try {
          await repo.delete(created);
        } on Object {
          // Best effort; the poster can still delete it from the feed.
        }
        return;
      }
      if (!ref.mounted) return;
      state = [
        for (final p in state)
          if (p.id != post.id) p,
      ];
      await _save();
      await ref.read(uploadQueueProvider.notifier).removeGroup(post.id);
      ref
        ..invalidate(feedPostsProvider(FeedKind.forYou))
        ..invalidate(feedPostsProvider(FeedKind.following));
    } on ApiException catch (e) {
      if (!ref.mounted) return;
      _put(
        post.copyWith(
          stage: PendingStage.failed,
          error: e.fieldErrors.values.expand((m) => m).firstOrNull ?? e.message,
        ),
      );
    } finally {
      _publishing.remove(post.id);
      _discarded.remove(post.id);
    }
  }

  /// Retries failed uploads (or the publish) for [postId].
  void retry(String postId) {
    final post = state.where((p) => p.id == postId).firstOrNull;
    if (post == null) return;
    _put(post.copyWith(stage: PendingStage.uploading));
    final queue = ref.read(uploadQueueProvider.notifier);
    for (final j in ref.read(uploadQueueProvider)) {
      if (j.group == postId && j.isFailed) queue.retry(j.id);
    }
    _check();
  }

  /// Cancels [postId] at any stage: stops its uploads, deletes its files,
  /// and if it was mid-publish, deletes the post once created.
  Future<void> discard(String postId) async {
    if (_publishing.contains(postId)) _discarded.add(postId);
    state = [
      for (final p in state)
        if (p.id != postId) p,
    ];
    await _save();
    await ref.read(uploadQueueProvider.notifier).removeGroup(postId);
  }
}
