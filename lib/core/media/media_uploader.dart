import 'dart:async';

import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_compressor.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/remote_media_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_uploader.g.dart';

/// Where an upload is: 0..1 while sending, then processing on the server.
enum UploadStage { preparing, sending, processing, ready }

typedef StageListener = void Function(UploadStage stage, double progress);

/// The whole upload for one file: compress, check limits, request, send
/// straight to storage, complete, then wait until the server has made its
/// sizes (or stream). Used directly for avatars, logos and covers; posts go
/// through the persisted upload queue instead.
class MediaUploader {
  MediaUploader(
    this._repo,
    this._compressor, {
    this.pollEvery = const Duration(seconds: 1),
    this.maxPollEvery = const Duration(seconds: 5),
    this.imageTimeout = const Duration(minutes: 3),
    this.videoTimeout = const Duration(minutes: 15),
  });

  final MediaRepository _repo;
  final MediaCompressor _compressor;
  final Duration pollEvery;
  final Duration maxPollEvery;
  final Duration imageTimeout;
  final Duration videoTimeout;

  /// Compresses [path] and checks it against the server's limits. Throws a
  /// [MediaUploadException] with a friendly message when it won't do.
  Future<PreparedFile> prepare(String path, MediaKind kind) async {
    final file = kind == MediaKind.video
        ? await _compressor.video(path)
        : await _compressor.image(path);
    if (MediaLimits.problem(file) case final String problem) {
      throw MediaUploadException(problem);
    }
    return file;
  }

  /// Uploads [path] and returns the media once it's ready to show.
  Future<Media> upload(
    String path, {
    required MediaPurpose purpose,
    MediaKind kind = MediaKind.image,
    String? vendorId,
    StageListener? onStage,
  }) async {
    onStage?.call(UploadStage.preparing, 0);
    final file = await prepare(path, kind);
    return send(file, purpose: purpose, vendorId: vendorId, onStage: onStage);
  }

  /// The upload for an already prepared [file].
  Future<Media> send(
    PreparedFile file, {
    required MediaPurpose purpose,
    String? vendorId,
    StageListener? onStage,
  }) async {
    final ticket = await _repo.request(
      file,
      purpose: purpose,
      vendorId: vendorId,
    );
    onStage?.call(UploadStage.sending, 0);
    final parts = await _repo.transfer(
      file,
      ticket.plan,
      onProgress: (sent, total) => onStage?.call(
        UploadStage.sending,
        total == 0 ? 0 : sent / total,
      ),
    );
    final completed = await _repo.complete(ticket.mediaId, parts: parts);
    onStage?.call(UploadStage.processing, 1);
    final ready = await waitUntilReady(completed);
    onStage?.call(UploadStage.ready, 1);
    return ready;
  }

  /// Polls until [media] is ready, backing off up to [maxPollEvery].
  Future<Media> waitUntilReady(Media media) async {
    final deadline = DateTime.now().add(
      media.isVideo ? videoTimeout : imageTimeout,
    );
    var current = media;
    var wait = pollEvery;
    while (!current.isReady) {
      if (current.hasFailed) {
        throw MediaUploadException(
          current.status == MediaStatus.rejected
              ? 'This photo or video can’t be used.'
              : 'We couldn’t process this file. Try another one.',
        );
      }
      if (DateTime.now().isAfter(deadline)) {
        throw const MediaUploadException(
          'Processing is taking too long. Try again in a moment.',
          retryable: true,
        );
      }
      await Future<void>.delayed(wait);
      final next = wait * 1.5;
      wait = next > maxPollEvery ? maxPollEvery : next;
      current = await _repo.get(media.id);
    }
    return current;
  }
}

@Riverpod(keepAlive: true)
MediaUploader mediaUploader(Ref ref) => MediaUploader(
  ref.watch(mediaRepositoryProvider),
  ref.watch(mediaCompressorProvider),
);
