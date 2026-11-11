import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_compressor.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/core/media/media_repository.dart';
import 'package:petalsinajar/core/media/media_uploader.dart';

class _Repo extends Mock implements MediaRepository {}

/// Returns a "compressed" file of the given size without native code.
class _Compressor implements MediaCompressor {
  int bytes = 400 * 1024;
  int? durationMs;

  @override
  Future<PreparedFile> image(String path) async => PreparedFile(
    path: '$path.jpg',
    kind: MediaKind.image,
    mime: 'image/jpeg',
    bytes: bytes,
  );

  @override
  Future<PreparedFile> video(String path) async => PreparedFile(
    path: '$path.mp4',
    kind: MediaKind.video,
    mime: 'video/mp4',
    bytes: bytes,
    durationMs: durationMs,
  );
}

Media _media(MediaStatus status) => Media(
  id: 'm1',
  kind: MediaKind.image,
  status: status,
  urls: status == MediaStatus.ready
      ? const {'feed': 'https://cdn.test/m1.webp'}
      : const {},
);

void main() {
  late _Repo repo;
  late _Compressor compressor;
  late MediaUploader uploader;

  setUpAll(() {
    registerFallbackValue(
      const PreparedFile(path: '', kind: MediaKind.image, mime: '', bytes: 0),
    );
    registerFallbackValue(const UploadPlan(method: 'PUT'));
    registerFallbackValue(MediaPurpose.post);
  });

  setUp(() {
    repo = _Repo();
    compressor = _Compressor();
    uploader = MediaUploader(
      repo,
      compressor,
      pollEvery: Duration.zero,
      maxPollEvery: Duration.zero,
    );
    when(
      () => repo.request(
        any(),
        purpose: any(named: 'purpose'),
        vendorId: any(named: 'vendorId'),
      ),
    ).thenAnswer(
      (_) async => const UploadTicket(
        mediaId: 'm1',
        plan: UploadPlan(method: 'PUT', url: 'https://storage.test/m1'),
      ),
    );
    when(
      () => repo.transfer(any(), any(), onProgress: any(named: 'onProgress')),
    ).thenAnswer((i) async {
      final progress = i.namedArguments[#onProgress] as UploadProgress?;
      progress?.call(50, 100);
      progress?.call(100, 100);
      return const [];
    });
    when(
      () => repo.complete('m1', parts: any(named: 'parts')),
    ).thenAnswer((_) async => _media(MediaStatus.processing));
  });

  test('compress → request → send → complete → wait until ready', () async {
    var polls = 0;
    when(() => repo.get('m1')).thenAnswer(
      (_) async =>
          _media(polls++ < 1 ? MediaStatus.processing : MediaStatus.ready),
    );
    final stages = <(UploadStage, double)>[];

    final media = await uploader.upload(
      'pick',
      purpose: MediaPurpose.cover,
      vendorId: 'v1',
      onStage: (s, p) => stages.add((s, p)),
    );

    expect(media.isReady, isTrue);
    final sent =
        verify(
              () => repo.request(
                captureAny(),
                purpose: MediaPurpose.cover,
                vendorId: 'v1',
              ),
            ).captured.single
            as PreparedFile;
    expect(sent.path, 'pick.jpg', reason: 'the compressed copy is sent');
    expect(stages.first.$1, UploadStage.preparing);
    expect(stages, contains((UploadStage.sending, 0.5)));
    expect(stages.last.$1, UploadStage.ready);
    expect(polls, 2);
  });

  test('a file over the limit is refused before anything is sent', () async {
    compressor.bytes = 16 * 1024 * 1024;

    await expectLater(
      uploader.upload('pick', purpose: MediaPurpose.post),
      throwsA(
        isA<MediaUploadException>().having(
          (e) => e.message,
          'message',
          contains('up to 15 MB'),
        ),
      ),
    );
    verifyNever(
      () => repo.request(
        any(),
        purpose: any(named: 'purpose'),
        vendorId: any(named: 'vendorId'),
      ),
    );
  });

  test('a video longer than 3 minutes is refused on the phone', () async {
    compressor.durationMs = 200000;
    await expectLater(
      uploader.upload(
        'clip',
        purpose: MediaPurpose.post,
        kind: MediaKind.video,
      ),
      throwsA(isA<MediaUploadException>()),
    );
  });

  test('processing that fails on the server says so', () async {
    when(
      () => repo.get('m1'),
    ).thenAnswer((_) async => _media(MediaStatus.failed));
    await expectLater(
      uploader.upload('pick', purpose: MediaPurpose.post),
      throwsA(
        isA<MediaUploadException>().having(
          (e) => e.message,
          'message',
          contains('couldn’t process'),
        ),
      ),
    );
  });
}
