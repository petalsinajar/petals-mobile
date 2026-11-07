import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/press_scale.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/presentation/event_labels.dart';
import 'package:petalsinajar/features/events/presentation/widgets/event_cover.dart';

/// A My Events card, tinted with the event type's accent.
class EventCard extends StatelessWidget {
  const EventCard({required this.event, required this.onTap, super.key});

  final Event event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = context.palette.accentFor(event.type);
    final text = context.textTheme;
    final role = switch (event.viewerRole) {
      ViewerRole.host => 'Hosting',
      ViewerRole.coHost => 'Co-hosting',
      _ => event.viewerRsvp?.label,
    };

    return PressScale(
      child: Card(
        color: accent.container,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: eventCoverHeroTag(event.id),
                      child: EventCover(type: event.type, cover: event.cover),
                    ),
                    Positioned(
                      left: AppSpacing.md,
                      top: AppSpacing.md,
                      child: _TypeChip(event: event),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: text.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      EventDates.startLine(event.startsAt),
                      style: text.bodyMedium?.copyWith(
                        color: accent.onContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Row(
                      children: [
                        Icon(
                          Icons.place_rounded,
                          size: AppSizes.iconSm,
                          color: context.colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            event.venue.name,
                            style: text.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (role != null) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            role,
                            style: text.labelMedium?.copyWith(
                              color: accent.onContainer,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final accent = context.palette.accentFor(event.type);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent.color,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(event.type.icon, size: AppSizes.iconSm, color: accent.onColor),
            const SizedBox(width: AppSpacing.xs),
            Text(
              event.type.label,
              style: context.textTheme.labelMedium?.copyWith(
                color: accent.onColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
