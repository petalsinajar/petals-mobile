import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/media/media_limits.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/core/widgets/async_value_view.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/core/widgets/media_image.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/presentation/business_photo.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_controllers.dart';
import 'package:petalsinajar/features/vendor/presentation/web_dashboard.dart';

/// Vendor mode → Business: the storefront as customers see it, quick logo
/// change, and the way to edit the rest. Staff can look but not edit.
class VendorProfileScreen extends ConsumerWidget {
  const VendorProfileScreen({
    this.pickPhoto = pickBusinessPhoto,
    super.key,
  });

  final BusinessPhotoPicker pickPhoto;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actor = ref.watch(activeActorProvider);
    if (actor is! VendorActor) return const Scaffold();
    final provider = businessProvider(actor.vendorId);

    void backToPersonal() => ref.read(activeActorProvider.notifier).actAsSelf();

    return Scaffold(
      appBar: AppBar(
        // Known from vendor mode itself, so it shows even if loading fails.
        title: Text(actor.name),
        actions: [
          if (ref.watch(provider).value?.canEdit ?? false)
            IconButton(
              tooltip: 'Edit business profile',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => context.push(Routes.vendorProfileEdit),
            ),
        ],
      ),
      body: AsyncValueView(
        value: ref.watch(provider),
        onRetry: () => ref.invalidate(provider),
        // Never strand someone in vendor mode because the profile won't load.
        error: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: ErrorState(
                error: ref.watch(provider).error ?? 'Error',
                onRetry: () => ref.invalidate(provider),
              ),
            ),
            TextButton.icon(
              onPressed: backToPersonal,
              icon: const Icon(Icons.person_outline_rounded),
              label: const Text('Back to personal'),
            ),
          ],
        ),
        data: (b) => RefreshIndicator(
          onRefresh: () => ref.refresh(provider.future),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
            children: [
              _Header(business: b, pickPhoto: pickPhoto),
              _About(business: b),
              const Divider(height: AppSpacing.xxl),
              _Menu(business: b),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends ConsumerStatefulWidget {
  const _Header({required this.business, required this.pickPhoto});

  final BusinessProfile business;
  final BusinessPhotoPicker pickPhoto;

  @override
  ConsumerState<_Header> createState() => _HeaderState();
}

class _HeaderState extends ConsumerState<_Header> {
  static const _coverHeight = 140.0;
  var _uploading = false;

  Future<void> _changeLogo() async {
    final path = await widget.pickPhoto(logo: true);
    if (path == null || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _uploading = true);
    try {
      await ref
          .read(businessProvider(widget.business.id).notifier)
          .save(const {}, logoPath: path);
      unawaited(Haptics.success());
      messenger.showSnackBar(const SnackBar(content: Text('Logo updated')));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } on MediaUploadException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final b = widget.business;
    final text = context.textTheme;
    final muted = text.bodyMedium?.copyWith(
      color: context.colors.onSurfaceVariant,
    );
    final logo = AvatarSize.xl.dimension;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: _coverHeight + logo / 2,
          child: Stack(
            children: [
              SizedBox(
                height: _coverHeight,
                width: double.infinity,
                child: b.coverUrl == null
                    ? ColoredBox(color: context.palette.vendor.container)
                    : MediaImage(url: b.coverUrl!, semanticLabel: 'Cover'),
              ),
              Positioned(
                left: AppSpacing.screen,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.colors.surface,
                      width: 3,
                    ),
                  ),
                  child: Avatar(
                    name: b.name,
                    imageUrl: b.logoUrl,
                    size: AvatarSize.xl,
                  ),
                ),
              ),
              if (b.canEdit)
                Positioned(
                  left: AppSpacing.screen + logo - AppSizes.minTouchTarget / 2,
                  bottom: 0,
                  child: _uploading
                      ? const SizedBox.square(
                          dimension: AppSizes.minTouchTarget,
                          child: Padding(
                            padding: EdgeInsets.all(AppSpacing.md),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : IconButton.filled(
                          tooltip: 'Change logo',
                          onPressed: _changeLogo,
                          icon: const Icon(Icons.photo_camera_rounded),
                        ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.md,
            AppSpacing.screen,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(child: Text(b.name, style: text.headlineSmall)),
                  if (b.isVerified) ...[
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      Icons.verified_rounded,
                      color: context.palette.corporate.color,
                      semanticLabel: 'Verified',
                    ),
                  ],
                ],
              ),
              Text(
                ['@${b.handle}', ?b.city].join(' · '),
                style: muted,
              ),
              if (!b.isVerified) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Not verified yet. Verified businesses rank higher and get '
                  'suggested to hosts.',
                  style: text.bodySmall?.copyWith(
                    color: context.palette.warning,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              _Stats(business: b),
            ],
          ),
        ),
      ],
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({required this.business});

  final BusinessProfile business;

  @override
  Widget build(BuildContext context) {
    final b = business;
    Widget stat(String value, String label) => Expanded(
      child: Column(
        children: [
          Text(value, style: context.textTheme.titleLarge),
          Text(label, style: context.textTheme.bodySmall),
        ],
      ),
    );
    return Row(
      children: [
        stat(
          b.ratingCount == 0
              ? '–'
              : '★ ${b.ratingAverage?.toStringAsFixed(1) ?? '–'}',
          b.ratingCount == 1 ? '1 review' : '${b.ratingCount} reviews',
        ),
        stat('${b.followers}', 'followers'),
        stat('${b.completedBookings}', 'bookings done'),
        stat('${b.posts}', 'posts'),
      ],
    );
  }
}

class _About extends StatelessWidget {
  const _About({required this.business});

  final BusinessProfile business;

  @override
  Widget build(BuildContext context) {
    final b = business;
    final text = context.textTheme;
    final muted = text.bodyMedium?.copyWith(
      color: context.colors.onSurfaceVariant,
    );
    String title(String slug) => slug.isEmpty
        ? slug
        : slug[0].toUpperCase() + slug.substring(1).replaceAll('_', ' ');
    final delivery = b.delivery;
    const money = MoneyFormat.format;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.lg,
        AppSpacing.screen,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (b.bio case final String bio when bio.trim().isNotEmpty)
            Text(bio, style: text.bodyLarge)
          else if (b.canEdit)
            Text(
              'Add a short bio so hosts know what you’re great at.',
              style: muted,
            ),
          if (b.categories.isNotEmpty || b.eventTypes.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                for (final c in b.categories) Chip(label: Text(title(c))),
                for (final t in b.eventTypes)
                  Chip(
                    avatar: const Icon(Icons.celebration_rounded, size: 16),
                    label: Text(title(t)),
                  ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          for (final (icon, value) in [
            (Icons.phone_rounded, b.phone),
            (Icons.chat_rounded, b.whatsapp),
            (Icons.mail_outline_rounded, b.email),
          ])
            if (value != null && value.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                child: Row(
                  children: [
                    Icon(icon, size: AppSizes.iconSm),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(child: Text(value)),
                  ],
                ),
              ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            [
              if (!delivery.offered)
                'Pickup only'
              else
                'Delivery from ${money(delivery.baseFeeMinor, 'GHS')}',
              if (delivery.setupOffered)
                'setup ${money(delivery.setupFeeMinor, 'GHS')}',
              if (b.serviceRadiusKm != null) 'within ${b.serviceRadiusKm} km',
              if (b.depositPercent != null) '${b.depositPercent}% deposit',
              if (b.leadTimeHours != null) '${b.leadTimeHours}h notice',
            ].join(' · '),
            style: muted,
          ),
        ],
      ),
    );
  }
}

class _Menu extends ConsumerWidget {
  const _Menu({required this.business});

  final BusinessProfile business;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const chevron = Icon(Icons.chevron_right_rounded);
    final b = business;
    return Column(
      children: [
        if (b.canEdit)
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Edit business profile'),
            subtitle: const Text('Logo, cover, about, contact, delivery'),
            trailing: chevron,
            onTap: () => context.push(Routes.vendorProfileEdit),
          )
        else
          const ListTile(
            leading: Icon(Icons.lock_outline_rounded),
            title: Text('Only owners and managers can edit'),
          ),
        ListTile(
          leading: const Icon(Icons.visibility_outlined),
          title: const Text('See it as customers do'),
          trailing: chevron,
          onTap: () => context.push(Routes.vendor(b.id)),
        ),
        ListTile(
          leading: const Icon(Icons.computer_rounded),
          title: const Text('Web dashboard'),
          subtitle: const Text('Items, packages, team, payouts, policies'),
          trailing: const Icon(Icons.open_in_new_rounded),
          onTap: () => openWebDashboard(context, WebDashboard.home(b.handle)),
        ),
        ListTile(
          leading: const Icon(Icons.person_outline_rounded),
          title: const Text('Back to personal'),
          onTap: () => ref.read(activeActorProvider.notifier).actAsSelf(),
        ),
      ],
    );
  }
}
