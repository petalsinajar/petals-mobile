import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/core/widgets/inline_error.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/detail_args.dart';
import 'package:petalsinajar/features/discover/presentation/detail_controllers.dart';
import 'package:petalsinajar/features/discover/presentation/discover_labels.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/request_booking_sheet.dart';
import 'package:petalsinajar/features/discover/presentation/widgets/vendor_card.dart';

/// An item: photos, price, who rents it and what it is.
class ItemScreen extends ConsumerWidget {
  const ItemScreen({required this.itemId, this.args, super.key});

  final String itemId;
  final DetailArgs<ItemCard>? args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(itemDetailProvider(itemId));
    final initial = args?.initial;
    final fetched = value.value;
    // Keep what the card already knew if the fresh copy leaves it out.
    final item = fetched == null
        ? initial
        : fetched.copyWith(vendor: fetched.vendor ?? initial?.vendor);
    void retry() => ref.invalidate(itemDetailProvider(itemId));

    if (item == null) {
      return Scaffold(
        appBar: AppBar(),
        body: value.hasError
            ? ErrorState(error: value.error!, onRetry: retry)
            : const Center(child: CircularProgressIndicator()),
      );
    }

    final photos = item.photos.isEmpty ? [?item.photo] : item.photos;
    final vendor = item.vendor;
    final text = context.textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: args?.heroTag ?? 'item-${item.id}',
              child: photos.isEmpty
                  ? ColoredBox(
                      color: context.colors.surfaceContainerHighest,
                      child: const Icon(Icons.chair_rounded),
                    )
                  : PageView(
                      children: [
                        for (final p in photos)
                          MediaImage(
                            url: p.url,
                            media: p.media,
                            blurhash: p.blurhash,
                            semanticLabel: item.title,
                          ),
                      ],
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: text.headlineSmall),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  fromPrice(item),
                  style: text.titleMedium?.copyWith(
                    color: context.colors.primary,
                  ),
                ),
                if (value.hasError) ...[
                  const SizedBox(height: AppSpacing.sm),
                  InlineError(error: value.error!, onRetry: retry),
                ],
                if (vendor != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Avatar(
                      name: vendor.name,
                      imageUrl: vendor.logoUrl,
                      isVendor: true,
                    ),
                    title: Row(
                      children: [
                        Flexible(child: Text(vendor.name)),
                        if (vendor.isVerified) ...[
                          const SizedBox(width: AppSpacing.xs),
                          const VerifiedBadge(),
                        ],
                      ],
                    ),
                    subtitle: const Text('Rents this item'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => context.openVendor(vendor.id),
                  ),
                ],
                if (item.description case final String d
                    when d.trim().isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(d, style: text.bodyLarge),
                ],
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label: 'Request to book',
                  icon: Icons.event_available_rounded,
                  expand: true,
                  // Variants come with the item's own page, not the card.
                  isLoading: item.variants.isEmpty && value.isLoading,
                  onPressed: item.variants.isEmpty
                      ? null
                      : () => requestToBook(context, ref, item),
                ),
                if (vendor != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  AppButton(
                    label: 'See ${vendor.name}',
                    icon: Icons.storefront_rounded,
                    variant: AppButtonVariant.outline,
                    expand: true,
                    onPressed: () => context.openVendor(vendor.id),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
