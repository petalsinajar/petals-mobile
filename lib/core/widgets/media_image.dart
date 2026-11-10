import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/media/media.dart';

/// Network image that never shows a blank box: the blurhash (or a skeleton
/// tint) is painted immediately, then the photo fades in over it.
///
/// Give it a [media] and it picks the smallest size (thumb / feed / full)
/// that's sharp at its width on this screen; or a plain [url].
class MediaImage extends StatelessWidget {
  const MediaImage({
    this.url,
    this.media,
    this.blurhash,
    this.width,
    this.height,
    this.aspectRatio,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.semanticLabel,
    super.key,
  });

  final String? url;
  final Media? media;
  final String? blurhash;
  final double? width;
  final double? height;

  /// When set, sizes the image by width (e.g. 4 / 5 for feed photos).
  final double? aspectRatio;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    Widget image = LayoutBuilder(
      builder: (context, constraints) {
        // Decode at display size, not the 1080 px original.
        final dpr = MediaQuery.devicePixelRatioOf(context);
        final targetWidth = width ?? constraints.maxWidth;
        final cacheWidth = targetWidth.isFinite
            ? (targetWidth * dpr).round()
            : null;
        final hash = blurhash ?? media?.blurhash;
        final source =
            media?.imageUrlFor(
              targetWidth.isFinite ? targetWidth * dpr : 1080,
            ) ??
            url;
        if (source == null) {
          // Still processing on the server: hold the place.
          return _Placeholder(blurhash: hash);
        }
        return CachedNetworkImage(
          imageUrl: source,
          width: width,
          height: height,
          fit: fit,
          memCacheWidth: cacheWidth,
          fadeInDuration: context.reduceMotion ? Duration.zero : AppMotion.slow,
          fadeInCurve: AppMotion.standard,
          fadeOutDuration: AppMotion.fast,
          placeholder: (context, _) => _Placeholder(blurhash: hash),
          errorWidget: (context, _, _) => Stack(
            fit: StackFit.expand,
            children: [
              _Placeholder(blurhash: hash),
              Icon(
                Icons.broken_image_outlined,
                color: context.colors.onSurfaceVariant,
              ),
            ],
          ),
        );
      },
    );

    if (aspectRatio != null) {
      image = AspectRatio(aspectRatio: aspectRatio!, child: image);
    } else if (width != null || height != null) {
      image = SizedBox(width: width, height: height, child: image);
    }
    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return Semantics(
      image: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: image,
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.blurhash});

  final String? blurhash;

  @override
  Widget build(BuildContext context) {
    final hash = blurhash;
    if (hash == null || hash.isEmpty) {
      return ColoredBox(color: context.palette.skeletonBase);
    }
    return BlurHash(
      hash: hash,
      imageFit: BoxFit.cover,
      color: context.palette.skeletonBase,
    );
  }
}
