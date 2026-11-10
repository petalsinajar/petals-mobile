import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/app/theme/theme_mode.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';

/// The Profile tab: who you are at a glance, and the account menu.
///
/// The router only shows it signed in, so the session always has a user.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(authSessionProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: me == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              // Pull to pick up changes made elsewhere (counts, businesses).
              onRefresh: () => ref.refresh(authSessionProvider.future),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppSpacing.screen),
                children: [
                  _Summary(me: me),
                  const SizedBox(height: AppSpacing.xl),
                  _Menu(me: me),
                ],
              ),
            ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.me});

  final Me me;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final muted = context.colors.onSurfaceVariant;
    final name = me.displayName.isEmpty ? '@${me.handle}' : me.displayName;
    return Column(
      children: [
        Avatar(name: name, imageUrl: me.avatarUrl, size: AvatarSize.xl),
        const SizedBox(height: AppSpacing.md),
        Text(name, style: text.titleLarge, textAlign: TextAlign.center),
        Text('@${me.handle}', style: text.bodyMedium?.copyWith(color: muted)),
        if (me.city case final city?) ...[
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.place_outlined, size: AppSizes.iconSm, color: muted),
              const SizedBox(width: AppSpacing.xxs),
              Text(city, style: text.bodySmall?.copyWith(color: muted)),
            ],
          ),
        ],
        if (me.bio case final bio?) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(bio, style: text.bodyMedium, textAlign: TextAlign.center),
        ],
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Count(value: me.counts.posts, label: 'Posts'),
            _Count(value: me.counts.followers, label: 'Followers'),
            _Count(value: me.counts.following, label: 'Following'),
          ],
        ),
      ],
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    // Its own node, so a screen reader says "12 Followers", not all three
    // counts run together.
    return Semantics(
      container: true,
      label: '$value $label',
      excludeSemantics: true,
      child: Column(
        children: [
          Text('$value', style: text.titleMedium),
          Text(
            label,
            style: text.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _Menu extends ConsumerWidget {
  const _Menu({required this.me});

  final Me me;

  static String _modeLabel(ThemeMode mode) => switch (mode) {
    ThemeMode.system => 'Same as phone',
    ThemeMode.light => 'Light',
    ThemeMode.dark => 'Dark',
  };

  Future<void> _switchToBusiness(BuildContext context, WidgetRef ref) async {
    final vendors = me.vendors;
    final vendor = vendors.length == 1
        ? vendors.single
        : await showModalBottomSheet<MeVendor>(
            context: context,
            showDragHandle: true,
            builder: (context) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final v in vendors)
                    ListTile(
                      leading: Avatar(
                        name: v.name,
                        imageUrl: v.logoUrl,
                        isVendor: true,
                        size: AvatarSize.sm,
                      ),
                      title: Text(v.name),
                      subtitle: Text('@${v.handle} · ${v.role}'),
                      onTap: () => Navigator.of(context).pop(v),
                    ),
                ],
              ),
            ),
          );
    if (vendor == null) return;
    ref
        .read(activeActorProvider.notifier)
        .actAsVendor(
          vendorId: vendor.id,
          name: vendor.name,
          logoUrl: vendor.logoUrl,
        );
  }

  Future<void> _pickTheme(BuildContext context, WidgetRef ref) async {
    final current = ref.read(appThemeModeProvider);
    final picked = await showModalBottomSheet<ThemeMode>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: RadioGroup<ThemeMode>(
          groupValue: current,
          onChanged: (mode) => Navigator.of(context).pop(mode),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final mode in ThemeMode.values)
                RadioListTile<ThemeMode>(
                  value: mode,
                  title: Text(_modeLabel(mode)),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked != null) {
      await ref.read(appThemeModeProvider.notifier).set(picked);
    }
  }

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text('You can sign back in with your phone number.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(authSessionProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendors = me.vendors;
    final themeMode = ref.watch(appThemeModeProvider);
    const chevron = Icon(Icons.chevron_right_rounded);
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.receipt_long_rounded),
                title: const Text('My bookings'),
                subtitle: const Text('Rentals you’ve requested'),
                trailing: chevron,
                onTap: () => context.push(Routes.myBookings),
              ),
              if (vendors.isEmpty)
                ListTile(
                  leading: const Icon(Icons.add_business_outlined),
                  title: const Text('Start a business'),
                  subtitle: const Text('Rent out items to event hosts'),
                  trailing: chevron,
                  onTap: () => context.push(Routes.startBusiness),
                )
              else ...[
                ListTile(
                  leading: const Icon(Icons.storefront_rounded),
                  title: const Text('Switch to business'),
                  subtitle: Text(
                    vendors.length == 1
                        ? vendors.single.name
                        : '${vendors.length} businesses',
                  ),
                  trailing: chevron,
                  onTap: () => _switchToBusiness(context, ref),
                ),
                ListTile(
                  leading: const Icon(Icons.computer_rounded),
                  title: const Text('Web dashboard sign-in'),
                  subtitle: const Text('Manage your business on a computer'),
                  trailing: chevron,
                  onTap: () => context.push(Routes.dashboardSignIn),
                ),
              ],
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Edit profile'),
                subtitle: const Text('Photo, name, username, bio'),
                trailing: chevron,
                onTap: () => context.push(Routes.profileEdit),
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Profile settings'),
                subtitle: const Text('Privacy and notifications'),
                trailing: chevron,
                onTap: () => context.push(Routes.profileSettings),
              ),
              ListTile(
                leading: Icon(
                  context.theme.brightness == Brightness.dark
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
                title: const Text('Appearance'),
                subtitle: Text(_modeLabel(themeMode)),
                trailing: chevron,
                onTap: () => _pickTheme(context, ref),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            leading: Icon(Icons.logout_rounded, color: context.colors.error),
            title: Text(
              'Sign out',
              style: TextStyle(color: context.colors.error),
            ),
            onTap: () => _signOut(context, ref),
          ),
        ),
      ],
    );
  }
}
