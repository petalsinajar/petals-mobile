import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';

/// A picked file before upload: the photo itself, or a video tile.
class DraftPreview extends StatelessWidget {
  const DraftPreview({required this.photo, this.fit = BoxFit.cover, super.key});

  final DraftPhoto photo;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final blank = ColoredBox(color: context.colors.surfaceContainerHighest);
    if (photo.isVideo) {
      return Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: context.colors.inverseSurface),
          Center(
            child: Icon(
              Icons.videocam_rounded,
              size: AppSizes.iconLg,
              color: context.colors.onInverseSurface,
              semanticLabel: 'Video',
            ),
          ),
        ],
      );
    }
    return Image.file(
      File(photo.path),
      fit: fit,
      errorBuilder: (_, _, _) => blank,
    );
  }
}
