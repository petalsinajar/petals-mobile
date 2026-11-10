import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_compress/video_compress.dart';

part 'media_compressor.g.dart';

/// Shrinks photos and videos on the phone before upload, to save people's
/// mobile data. Behind an interface so tests needn't run native code.
abstract interface class MediaCompressor {
  /// JPEG, longest edge at most [MediaLimits.imageMaxEdge].
  Future<PreparedFile> image(String path);

  /// 720p MP4, with its duration.
  Future<PreparedFile> video(String path);
}

class PluginMediaCompressor implements MediaCompressor {
  const PluginMediaCompressor();

  @override
  Future<PreparedFile> image(String path) async {
    final target =
        '${File(path).parent.path}/'
        'pij_${DateTime.now().microsecondsSinceEpoch}.jpg';
    final out = await FlutterImageCompress.compressAndGetFile(
      path,
      target,
      minWidth: MediaLimits.imageMaxEdge,
      minHeight: MediaLimits.imageMaxEdge,
      quality: MediaLimits.imageQuality,
    );
    // Some formats can't be re-encoded on some phones: send the original.
    final file = out == null ? File(path) : File(out.path);
    final decoded = await decodeImageFromList(await file.readAsBytes());
    return PreparedFile(
      path: file.path,
      kind: MediaKind.image,
      mime: out == null
          ? MediaLimits.mimeFor(path, MediaKind.image)
          : 'image/jpeg',
      bytes: await file.length(),
      width: decoded?.$1,
      height: decoded?.$2,
    );
  }

  @override
  Future<PreparedFile> video(String path) async {
    final info = await VideoCompress.compressVideo(
      path,
      quality: VideoQuality.Res1280x720Quality,
      includeAudio: true,
    );
    final file = File(info?.path ?? path);
    return PreparedFile(
      path: file.path,
      kind: MediaKind.video,
      mime: info == null
          ? MediaLimits.mimeFor(path, MediaKind.video)
          : 'video/mp4',
      bytes: await file.length(),
      width: info?.width,
      height: info?.height,
      durationMs: info?.duration?.round(),
    );
  }
}

/// (width, height) of an encoded image from its header (no full decode),
/// or null if it can't be read.
Future<(int, int)?> decodeImageFromList(List<int> bytes) async {
  try {
    final buffer = await ui.ImmutableBuffer.fromUint8List(
      Uint8List.fromList(bytes),
    );
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    final size = (descriptor.width, descriptor.height);
    descriptor.dispose();
    buffer.dispose();
    return size;
  } on Object {
    return null;
  }
}

@Riverpod(keepAlive: true)
MediaCompressor mediaCompressor(Ref ref) => const PluginMediaCompressor();
