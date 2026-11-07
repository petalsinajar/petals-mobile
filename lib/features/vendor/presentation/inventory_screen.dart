import 'package:flutter/material.dart';
import 'package:petalsinajar/core/widgets/placeholder_screen.dart';

class VendorInventoryScreen extends StatelessWidget {
  const VendorInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Inventory',
      headline: 'Your catalog',
      message: 'Manage items, variants, stock and prices.',
      icon: Icons.inventory_2_rounded,
    );
  }
}
