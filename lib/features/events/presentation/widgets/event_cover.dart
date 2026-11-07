import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';
import 'package:petalsinajar/features/events/presentation/event_labels.dart';

/// Hero tag shared by the event card and the event page header.
String eventCoverHeroTag(String eventId) => 'event-cover-$eventId';

/// An event's cover photo, a freshly picked local file, or — with no cover —
/// a gradient in the event type's accent.
class EventCover extends StatelessWidget {
  const EventCover({
    required this.type,
    this.cover,
    this.borderRadius,
    super.key,
  });

  final EventType type;
  final EventImage? cover;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final url = cover?.url;
    final Widget image;
    if (url == null || url.isEmpty) {
      image = _TypeGradient(type: type);
    } else if (url.startsWith('file://')) {
      image = Image.file(
        File(Uri.parse(url).toFilePath()),
        fit: BoxFit.cover,
        errorBuilder: (context, _, _) => _TypeGradient(type: type),
      );
    } else {
      image = MediaImage(url: url, blurhash: cover?.blurhash);
    }
    final sized = SizedBox.expand(child: image);
    return borderRadius == null
        ? sized
        : ClipRRect(borderRadius: borderRadius!, child: sized);
  }
}

class _TypeGradient extends StatelessWidget {
  const _TypeGradient({required this.type});

  final EventType type;

  @override
  Widget build(BuildContext context) {
    final accent = context.palette.accentFor(type);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent.color, accent.container],
        ),
      ),
      child: Center(
        child: Icon(
          type.icon,
          size: AppSizes.iconLg * 2,
          color: accent.onColor.withValues(alpha: 0.85),
        ),
      ),
    );
  }
}
