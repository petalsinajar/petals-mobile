import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/media/autoplay.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Builds the player for a stream; replaceable in tests.
typedef VideoControllerFactory = VideoPlayerController Function(Uri hls);

VideoPlayerController _networkController(Uri hls) =>
    VideoPlayerController.networkUrl(hls);

/// A video from [media]: its poster first, then the HLS stream.
///
/// With [autoplay] (the feed) it starts muted once mostly on screen — only
/// on Wi-Fi or if the user allowed mobile data — and pauses when scrolled
/// away. Otherwise it waits for a tap. Tap the sound icon to unmute.
class MediaVideo extends ConsumerStatefulWidget {
  const MediaVideo({
    required this.media,
    this.autoplay = false,
    this.aspectRatio,
    this.controllerFactory = _networkController,
    super.key,
  });

  final Media media;
  final bool autoplay;
  final double? aspectRatio;
  final VideoControllerFactory controllerFactory;

  /// Plays when at least this much is visible; pauses below [pauseBelow].
  static const playAbove = 0.6;
  static const pauseBelow = 0.2;

  @override
  ConsumerState<MediaVideo> createState() => _MediaVideoState();
}

class _MediaVideoState extends ConsumerState<MediaVideo> {
  VideoPlayerController? _controller;
  var _muted = true;
  var _wantsPlay = false;
  var _failed = false;

  /// How much is on screen, as last reported.
  var _visible = 0.0;

  @override
  void dispose() {
    unawaited(_controller?.dispose());
    super.dispose();
  }

  Future<void> _play() async {
    final hls = widget.media.hlsUrl;
    if (hls == null || _failed) return;
    _wantsPlay = true;
    var controller = _controller;
    if (controller == null) {
      controller = _controller = widget.controllerFactory(Uri.parse(hls));
      try {
        await controller.initialize();
        await controller.setLooping(true);
        await controller.setVolume(_muted ? 0 : 1);
      } on Object {
        if (mounted) setState(() => _failed = true);
        return;
      }
      if (!mounted) return;
      setState(() {});
    }
    if (_wantsPlay) await controller.play();
  }

  void _pause() {
    _wantsPlay = false;
    unawaited(_controller?.pause());
  }

  void _onVisibility(VisibilityInfo info) {
    if (!mounted) return;
    _visible = info.visibleFraction;
    if (_visible < MediaVideo.pauseBelow) return _pause();
    _maybeAutoplay(allowed: ref.read(canAutoplayProvider));
  }

  void _maybeAutoplay({required bool allowed}) {
    if (widget.autoplay && allowed && _visible >= MediaVideo.playAbove) {
      unawaited(_play());
    }
  }

  void _toggleMute() {
    setState(() => _muted = !_muted);
    unawaited(_controller?.setVolume(_muted ? 0 : 1));
  }

  @override
  Widget build(BuildContext context) {
    // Wi-Fi is often known only after the video is on screen: start then.
    ref.listen(canAutoplayProvider, (_, allowed) {
      if (mounted) _maybeAutoplay(allowed: allowed);
    });
    final media = widget.media;
    final ratio = widget.aspectRatio ?? media.aspectRatio ?? 9 / 16;
    final controller = _controller;
    final playing = controller != null && controller.value.isInitialized;

    if (!media.isReady) {
      return AspectRatio(
        aspectRatio: ratio,
        child: _Processing(media: media),
      );
    }

    return VisibilityDetector(
      key: ValueKey('video-${media.id}'),
      onVisibilityChanged: _onVisibility,
      child: AspectRatio(
        aspectRatio: ratio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // The poster stays underneath, so there's never a black frame.
            MediaImage(media: media, semanticLabel: 'Video'),
            if (playing)
              AnimatedOpacity(
                opacity: controller.value.isPlaying ? 1 : 0,
                duration: AppMotion.medium,
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),
            if (!playing || !controller.value.isPlaying)
              Center(
                child: IconButton.filledTonal(
                  iconSize: AppSizes.iconLg,
                  tooltip: _failed ? 'Video unavailable' : 'Play video',
                  onPressed: _failed ? null : _play,
                  icon: Icon(
                    _failed
                        ? Icons.videocam_off_rounded
                        : Icons.play_arrow_rounded,
                  ),
                ),
              )
            else
              Positioned.fill(
                child: GestureDetector(onTap: _pause),
              ),
            if (playing)
              Positioned(
                right: AppSpacing.sm,
                bottom: AppSpacing.sm,
                child: IconButton.filledTonal(
                  tooltip: _muted ? 'Turn sound on' : 'Mute',
                  onPressed: _toggleMute,
                  icon: Icon(
                    _muted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// While the server is still making the stream.
class _Processing extends StatelessWidget {
  const _Processing({required this.media});

  final Media media;

  @override
  Widget build(BuildContext context) {
    final failed = media.hasFailed;
    return Stack(
      fit: StackFit.expand,
      children: [
        MediaImage(media: media),
        ColoredBox(color: context.colors.scrim.withValues(alpha: 0.35)),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (failed)
                Icon(
                  Icons.error_outline_rounded,
                  color: context.colors.onPrimary,
                )
              else
                SizedBox.square(
                  dimension: AppSizes.iconMd,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.colors.onPrimary,
                  ),
                ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                failed ? 'Video couldn’t be processed' : 'Processing video…',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colors.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
