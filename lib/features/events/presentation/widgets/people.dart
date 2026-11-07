import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';

/// Overlapping avatars, e.g. "who's going".
class AvatarStack extends StatelessWidget {
  const AvatarStack({
    required this.people,
    this.max = 4,
    this.size = AvatarSize.xs,
    super.key,
  });

  final List<EventPerson> people;
  final int max;
  final AvatarSize size;

  @override
  Widget build(BuildContext context) {
    final shown = people.take(max).toList();
    if (shown.isEmpty) return const SizedBox.shrink();
    final d = size.dimension;
    final step = d * 0.65;
    return SizedBox(
      width: d + step * (shown.length - 1),
      height: d,
      child: Stack(
        children: [
          for (final (i, p) in shown.indexed)
            Positioned(
              left: step * i,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: context.colors.surface, width: 2),
                ),
                child: Avatar(
                  name: p.name,
                  imageUrl: p.avatar?.url,
                  blurhash: p.avatar?.blurhash,
                  isVendor: p.isVendor,
                  size: size,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// "Hosted by" with the host first, then co-hosts.
class HostsRow extends StatelessWidget {
  const HostsRow({required this.host, required this.coHosts, super.key});

  final EventPerson host;
  final List<EventPerson> coHosts;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final names = [host.name, ...coHosts.map((p) => p.name)];
    final label = switch (names.length) {
      1 => names.first,
      2 => '${names[0]} & ${names[1]}',
      _ => '${names[0]} & ${names.length - 1} others',
    };
    return Row(
      children: [
        AvatarStack(people: [host, ...coHosts], size: AvatarSize.md),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hosted by',
                style: text.labelMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              Text(label, style: text.titleSmall),
            ],
          ),
        ),
      ],
    );
  }
}
