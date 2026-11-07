import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/widgets/placeholder_screen.dart';

/// Seeded vendor owned by the mock user (Royal Canopies & Chairs in
/// assets/mock/vendors.json). Replaced by the signed-in user's vendors from
/// `me` once auth lands.
const _demoVendorId = '01KN40WX00PQVQFM5AJAK7W6YH';
const _demoVendorName = 'Royal Canopies & Chairs';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlaceholderScreen(
      title: 'Profile',
      headline: 'Your profile',
      message: 'Posts, saved boards and your events. You also run a business.',
      icon: Icons.person_rounded,
      actionLabel: 'Switch to vendor mode',
      onAction: () => ref
          .read(activeActorProvider.notifier)
          .actAsVendor(vendorId: _demoVendorId, name: _demoVendorName),
    );
  }
}
