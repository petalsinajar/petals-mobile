import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/entrance.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/detail_args.dart';
import 'package:petalsinajar/features/discover/presentation/detail_controllers.dart';
import 'package:petalsinajar/features/discover/presentation/discover_labels.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/add_to_event.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/catalog_cards.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/discover_section.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/vendor_card.dart';

/// A vendor's storefront: who they are, Follow, packages and items.
class VendorScreen extends ConsumerWidget {
  const VendorScreen({required this.vendorId, this.args, super.key});

  final String vendorId;
  final DetailArgs<VendorCard>? args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = vendorDetailProvider(vendorId);
    final value = ref.watch(provider);
    final vendor = value.value ?? args?.initial;

    if (vendor == null) {
      return Scaffold(
        appBar: AppBar(),
        body: value.hasError
            ? ErrorState(
                error: value.error!,
                onRetry: () => ref.invalidate(provider),
              )
            : const Center(child: CircularProgressIndicator()),
      );
    }

    Future<void> follow() async {
      if (ref.read(viewerIdProvider) == null) {
        unawaited(context.push(Routes.signInFrom(Routes.vendor(vendorId))));
        return;
      }
      unawaited(Haptics.light());
      final messenger = ScaffoldMessenger.of(context);
      try {
        await ref.read(provider.notifier).toggleFollow();
      } on Object {
        messenger.showSnackBar(
          const SnackBar(content: Text("Couldn't update follow. Try again.")),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(vendor.name)),
      body: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(vendorPackagesProvider(vendorId))
            ..invalidate(vendorItemsProvider(vendorId));
          await ref.refresh(provider.future).then((_) {}, onError: (_) {});
        },
        child: ListView(
          children: [
            _Header(
              vendor: vendor,
              heroTag: args?.heroTag ?? 'vendor-${vendor.id}',
              onFollow: follow,
            ),
            _Packages(vendorId: vendorId),
            _Items(vendorId: vendorId),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.vendor,
    required this.heroTag,
    required this.onFollow,
  });

  final VendorCard vendor;
  final String heroTag;
  final VoidCallback onFollow;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final muted = text.bodyMedium?.copyWith(
      color: context.colors.onSurfaceVariant,
    );
    final facts = [
      if (ratingLabel(vendor.rating) case final String r) '★ $r',
      ?vendor.city,
      '${vendor.followers} followers',
      if (vendor.completedBookings > 0) '${vendor.completedBookings} bookings',
    ];
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Hero(
                tag: heroTag,
                child: Avatar(
                  name: vendor.name,
                  imageUrl: vendor.logoUrl,
                  size: AvatarSize.xl,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(vendor.name, style: text.titleLarge),
                        ),
                        if (vendor.isVerified) ...[
                          const SizedBox(width: AppSpacing.xs),
                          const VerifiedBadge(size: AppSizes.iconMd),
                        ],
                      ],
                    ),
                    if (vendor.handle case final String h)
                      Text('@$h', style: muted),
                    const SizedBox(height: AppSpacing.sm),
                    FollowButton(
                      following: vendor.isFollowing,
                      onPressed: onFollow,
                      vendorName: vendor.name,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(facts.join(' · '), style: muted),
          if (vendor.bio case final String bio when bio.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(bio, style: text.bodyLarge),
          ],
          if (vendor.categories.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                for (final c in vendor.categories)
                  Chip(label: Text(categorySlugLabel(c))),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Packages extends ConsumerWidget {
  const _Packages({required this.vendorId});

  final String vendorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DiscoverSection(
      value: ref.watch(vendorPackagesProvider(vendorId)),
      title: 'Packages',
      isEmpty: (p) => p.isEmpty,
      onRetry: () => ref.invalidate(vendorPackagesProvider(vendorId)),
      skeleton: const SkeletonStrip(
        width: PackageCardView.width,
        height: PackageCardView.height,
        count: 2,
      ),
      builder: (packages) => HorizontalStrip(
        height: PackageCardView.height,
        itemCount: packages.length,
        itemBuilder: (context, i) => PackageCardView(
          package: packages[i],
          onTap: () => addPackageToEvent(context, ref, packages[i]),
          onAdd: () => addPackageToEvent(context, ref, packages[i]),
        ).entrance(i),
      ),
    );
  }
}

class _Items extends ConsumerWidget {
  const _Items({required this.vendorId});

  final String vendorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DiscoverSection(
      value: ref.watch(vendorItemsProvider(vendorId)),
      title: 'Items',
      isEmpty: (page) => page.isEmpty,
      onRetry: () => ref.invalidate(vendorItemsProvider(vendorId)),
      skeleton: const SkeletonStrip(width: 168, height: 248, count: 2),
      builder: (page) => HorizontalStrip(
        height:
            168 +
            MediaQuery.textScalerOf(context).scale(
              ItemTile.captionHeight,
            ),
        itemCount: page.items.length,
        itemBuilder: (context, i) {
          final item = page.items[i];
          final tag = 'vendor-item-${item.id}';
          return SizedBox(
            width: 168,
            child: ItemTile(
              item: item,
              heroTag: tag,
              onTap: () => context.openItem(item, heroTag: tag),
            ),
          ).entrance(i);
        },
      ),
    );
  }
}
