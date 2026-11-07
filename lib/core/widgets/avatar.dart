import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';

enum AvatarSize {
  xs(AppSizes.avatarXs),
  sm(AppSizes.avatarSm),
  md(AppSizes.avatarMd),
  lg(AppSizes.avatarLg),
  xl(AppSizes.avatarXl)
  ;

  const AvatarSize(this.dimension);

  final double dimension;
}

/// Round avatar for people and vendors. Falls back to initials, and shows a
/// storefront badge when [isVendor] so businesses are recognisable in feeds.
class Avatar extends StatelessWidget {
  const Avatar({
    required this.name,
    this.imageUrl,
    this.blurhash,
    this.size = AvatarSize.md,
    this.isVendor = false,
    this.onTap,
    super.key,
  });

  final String name;
  final String? imageUrl;
  final String? blurhash;
  final AvatarSize size;
  final bool isVendor;
  final VoidCallback? onTap;

  /// "Ama Mensah" → "AM", "kwameb" → "K".
  static String initialsOf(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    final letters = parts.take(2).map((p) => p.characters.first.toUpperCase());
    return letters.isEmpty ? '?' : letters.join();
  }

  @override
  Widget build(BuildContext context) {
    final d = size.dimension;
    final url = imageUrl;
    final face = ClipOval(
      child: SizedBox.square(
        dimension: d,
        child: url != null && url.isNotEmpty
            ? MediaImage(url: url, blurhash: blurhash, width: d, height: d)
            : _Initials(name: name, dimension: d),
      ),
    );

    Widget avatar = face;
    if (isVendor) {
      final badge = (d * 0.4).clamp(14.0, 30.0);
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          face,
          Positioned(
            right: -AppSpacing.xxs,
            bottom: -AppSpacing.xxs,
            child: _VendorBadge(dimension: badge),
          ),
        ],
      );
    }

    return Semantics(
      label: isVendor ? '$name, business' : name,
      image: true,
      button: onTap != null,
      excludeSemantics: true,
      child: onTap == null
          ? avatar
          : GestureDetector(onTap: onTap, child: avatar),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.name, required this.dimension});

  final String name;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Stable per name, so someone keeps their color everywhere.
    final pairs = [
      (colors.primaryContainer, colors.onPrimaryContainer),
      (colors.secondaryContainer, colors.onSecondaryContainer),
      (colors.tertiaryContainer, colors.onTertiaryContainer),
    ];
    final (bg, fg) = pairs[name.codeUnits.fold(0, (a, b) => a + b) % 3];
    return ColoredBox(
      color: bg,
      child: Center(
        child: Text(
          Avatar.initialsOf(name),
          style: context.textTheme.labelLarge?.copyWith(
            color: fg,
            fontSize: dimension * 0.38,
          ),
        ),
      ),
    );
  }
}

class _VendorBadge extends StatelessWidget {
  const _VendorBadge({required this.dimension});

  final double dimension;

  @override
  Widget build(BuildContext context) {
    final accent = context.palette.vendor;
    return Container(
      key: const Key('avatar-vendor-badge'),
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        color: accent.color,
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.surface, width: 2),
      ),
      child: Icon(
        Icons.storefront_rounded,
        size: dimension * 0.58,
        color: accent.onColor,
      ),
    );
  }
}
