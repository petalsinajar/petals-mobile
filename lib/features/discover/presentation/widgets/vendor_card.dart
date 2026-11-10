import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/press_scale.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/discover_labels.dart';

/// The blue tick next to verified vendors.
class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({this.size = AppSizes.iconSm, super.key});

  final double size;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Verified',
    child: Icon(
      Icons.verified_rounded,
      size: size,
      color: context.palette.corporate.color,
    ),
  );
}

/// Follow / Following, switching with a little spring.
class FollowButton extends StatelessWidget {
  const FollowButton({
    required this.following,
    required this.onPressed,
    required this.vendorName,
    super.key,
  });

  final bool following;
  final VoidCallback onPressed;
  final String vendorName;

  @override
  Widget build(BuildContext context) {
    final label = following ? 'Following' : 'Follow';
    final child = AnimatedSwitcher(
      duration: AppMotion.fast,
      switchInCurve: AppMotion.spring,
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: Text(label, key: ValueKey(following)),
    );
    const style = ButtonStyle(
      visualDensity: VisualDensity.compact,
      minimumSize: WidgetStatePropertyAll(
        Size(0, AppSizes.buttonSm),
      ),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: AppSpacing.md),
      ),
    );
    return Semantics(
      label: following ? 'Unfollow $vendorName' : 'Follow $vendorName',
      excludeSemantics: true,
      button: true,
      child: following
          ? OutlinedButton(onPressed: onPressed, style: style, child: child)
          : FilledButton(onPressed: onPressed, style: style, child: child),
    );
  }
}

/// A vendor near the viewer: logo, name, tick, rating, distance, categories
/// and Follow.
class VendorCardView extends StatelessWidget {
  const VendorCardView({
    required this.vendor,
    required this.heroTag,
    required this.onTap,
    required this.onFollow,
    super.key,
  });

  static const width = 240.0;
  static const height = 176.0;

  final VendorCard vendor;
  final String heroTag;
  final VoidCallback onTap;
  final VoidCallback onFollow;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final muted = context.colors.onSurfaceVariant;
    final facts = [
      ?ratingLabel(vendor.rating),
      ?distanceLabel(vendor.distanceKm),
      if (vendor.rating.count == 0 && vendor.city != null) vendor.city!,
    ];
    return SizedBox(
      width: width,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.cardAll),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Semantics(
                  button: true,
                  label: [
                    vendor.name,
                    if (vendor.isVerified) 'verified',
                    ...facts,
                  ].join(', '),
                  excludeSemantics: true,
                  child: PressScale(
                    child: InkWell(
                      onTap: onTap,
                      borderRadius: AppRadii.mdAll,
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
                                  size: AvatarSize.lg,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
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
                                            style: text.titleSmall,
                                          ),
                                        ),
                                        if (vendor.isVerified) ...[
                                          const SizedBox(width: AppSpacing.xs),
                                          const VerifiedBadge(),
                                        ],
                                      ],
                                    ),
                                    if (facts.isNotEmpty)
                                      Row(
                                        children: [
                                          if (vendor.rating.count > 0)
                                            Icon(
                                              Icons.star_rounded,
                                              size: AppSizes.iconSm,
                                              color: context.palette.warning,
                                            ),
                                          Flexible(
                                            child: Text(
                                              facts.join(' · '),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: text.bodySmall?.copyWith(
                                                color: muted,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            vendor.categories.isEmpty
                                ? (vendor.bio ?? '')
                                : vendor.categories
                                      .map(categorySlugLabel)
                                      .join(' · '),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: text.bodySmall?.copyWith(color: muted),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              FollowButton(
                following: vendor.isFollowing,
                onPressed: onFollow,
                vendorName: vendor.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
