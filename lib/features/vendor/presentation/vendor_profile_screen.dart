import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/widgets/placeholder_screen.dart';

class VendorProfileScreen extends ConsumerWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actor = ref.watch(activeActorProvider);
    final name = switch (actor) {
      VendorActor(:final name) => name,
      SelfActor() => 'Your business',
    };
    return PlaceholderScreen(
      title: 'Business',
      headline: name,
      message: 'Your storefront, team and payout settings.',
      icon: Icons.storefront_rounded,
      actionLabel: 'Back to personal',
      onAction: () => ref.read(activeActorProvider.notifier).actAsSelf(),
    );
  }
}
