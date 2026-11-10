import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/entrance.dart';
import 'package:petalsinajar/core/widgets/press_scale.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/detail_args.dart';
import 'package:petalsinajar/features/discover/presentation/discover_controllers.dart';
import 'package:petalsinajar/features/discover/presentation/discover_labels.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/discover_section.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/vendor_card.dart';

/// What the viewer's next event still needs, with vendors free that day.
/// Hidden unless they host an upcoming event that's missing something.
class ForYourEventSection extends ConsumerWidget {
  const ForYourEventSection({super.key});

  static const _cardWidth = 220.0;
  static const _cardHeight = 200.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(forYourEventProvider);
    final gap = value.value;
    final event = gap?.event;
    return DiscoverSection(
      value: value,
      title: 'For your event',
      subtitle: event == null
          ? null
          : '${event.title} · '
                '${DateFormat('EEE d MMM').format(event.startsAt)}',
      trailing: event == null
          ? null
          : TextButton(
              onPressed: () => context.push(Routes.event(event.id)),
              child: const Text('Open'),
            ),
      isEmpty: (gap) => gap == null,
      onRetry: () => ref.invalidate(forYourEventProvider),
      skeleton: const SkeletonStrip(width: _cardWidth, height: _cardHeight),
      builder: (gap) => HorizontalStrip(
        height: _cardHeight,
        itemCount: gap!.needs.length,
        itemBuilder: (context, i) => SizedBox(
          width: _cardWidth,
          child: _NeedCard(need: gap.needs[i]),
        ).entrance(i),
      ),
    );
  }
}

/// "Still needed: Sound" with the best few vendors free on the day.
class _NeedCard extends StatelessWidget {
  const _NeedCard({required this.need});

  final EventNeed need;

  @override
  Widget build(BuildContext context) {
    final accent = context.palette.vendor;
    return Card(
      margin: EdgeInsets.zero,
      color: accent.container,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.cardAll),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Still needed',
              style: context.textTheme.labelSmall?.copyWith(
                color: accent.onContainer,
              ),
            ),
            Text(
              need.categoryName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            for (final v in need.vendors.take(3))
              _NeedVendorRow(entry: v, category: need.categoryName),
          ],
        ),
      ),
    );
  }
}

class _NeedVendorRow extends StatelessWidget {
  const _NeedVendorRow({required this.entry, required this.category});

  final NeedVendor entry;
  final String category;

  @override
  Widget build(BuildContext context) {
    final vendor = entry.vendor;
    final price = switch ((entry.fromPriceMinor, entry.currency)) {
      (final int minor, final String currency) =>
        'from ${MoneyFormat.format(minor, currency)}',
      _ => null,
    };
    final facts = [?price, ?distanceLabel(entry.distanceKm)].join(' · ');
    return Semantics(
      button: true,
      label: '${vendor.name}, free for $category, $facts',
      excludeSemantics: true,
      child: PressScale(
        child: InkWell(
          borderRadius: AppRadii.smAll,
          onTap: () => context.openVendor(vendor.id),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
            child: Row(
              children: [
                Avatar(
                  name: vendor.name,
                  imageUrl: vendor.logoUrl,
                  size: AvatarSize.xs,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              vendor.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          if (vendor.isVerified) ...[
                            const SizedBox(width: AppSpacing.xxs),
                            const VerifiedBadge(size: 14),
                          ],
                        ],
                      ),
                      if (facts.isNotEmpty)
                        Text(
                          facts,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
