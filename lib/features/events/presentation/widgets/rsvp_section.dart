import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';
import 'package:petalsinajar/features/events/presentation/event_labels.dart';
import 'package:petalsinajar/features/events/presentation/widgets/people.dart';

/// Going / Maybe / Can't go chips with counts and guest avatars. Hosts see
/// the tallies; guests can tap to answer.
class RsvpSection extends StatelessWidget {
  const RsvpSection({required this.detail, required this.onRsvp, super.key});

  static const List<RsvpStatus> statuses = [
    RsvpStatus.going,
    RsvpStatus.maybe,
    RsvpStatus.declined,
  ];

  final EventDetail detail;
  final ValueChanged<RsvpStatus> onRsvp;

  @override
  Widget build(BuildContext context) {
    final event = detail.event;
    final canAnswer = !event.viewerIsHosting;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          canAnswer ? 'Are you going?' : 'Guest list',
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            for (final (i, status) in statuses.indexed) ...[
              if (i > 0) const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _RsvpChip(
                  status: status,
                  count: event.rsvpCounts.of(status),
                  guests: detail.guestsWith(status),
                  selected: event.viewerRsvp == status,
                  type: event.type,
                  onTap: canAnswer
                      ? () {
                          unawaited(Haptics.selection());
                          onRsvp(status);
                        }
                      : null,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _RsvpChip extends StatelessWidget {
  const _RsvpChip({
    required this.status,
    required this.count,
    required this.guests,
    required this.selected,
    required this.type,
    required this.onTap,
  });

  final RsvpStatus status;
  final int count;
  final List<EventPerson> guests;
  final bool selected;
  final EventType type;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final accent = context.palette.accentFor(type);
    final colors = context.colors;
    final text = context.textTheme;
    final fg = selected ? accent.onColor : colors.onSurface;

    return Semantics(
      button: onTap != null,
      selected: selected,
      label: '${status.label}, $count',
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: context.reduceMotion ? Duration.zero : AppMotion.medium,
        curve: AppMotion.spring,
        decoration: BoxDecoration(
          color: selected ? accent.color : colors.surfaceContainerHigh,
          borderRadius: AppRadii.lgAll,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: AppRadii.lgAll,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(status.icon, size: AppSizes.iconSm, color: fg),
                      const SizedBox(width: AppSpacing.xs),
                      Flexible(
                        child: Text(
                          status.label,
                          style: text.labelLarge?.copyWith(color: fg),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '$count',
                    style: text.titleLarge?.copyWith(color: fg),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    height: AppSizes.avatarXs,
                    child: AvatarStack(people: guests, max: 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
