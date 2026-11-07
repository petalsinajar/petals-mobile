import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/widgets/placeholder_screen.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The router only shows this tab when signed in.
    final me = ref.watch(authSessionProvider).value;
    final vendor = me?.vendors.firstOrNull;
    final name = me == null || me.displayName.isEmpty
        ? 'Your profile'
        : me.displayName;

    return PlaceholderScreen(
      title: 'Profile',
      headline: name,
      message: vendor == null
          ? 'Posts, saved boards and your events.'
          : 'Posts, saved boards and your events. You also run a business.',
      icon: Icons.person_rounded,
      appBarActions: [
        IconButton(
          tooltip: 'Sign out',
          icon: const Icon(Icons.logout_rounded),
          onPressed: () => ref.read(authSessionProvider.notifier).signOut(),
        ),
      ],
      actionLabel: vendor == null ? null : 'Switch to vendor mode',
      onAction: vendor == null
          ? null
          : () => ref
                .read(activeActorProvider.notifier)
                .actAsVendor(
                  vendorId: vendor.id,
                  name: vendor.name,
                  logoUrl: vendor.logoUrl,
                ),
    );
  }
}
