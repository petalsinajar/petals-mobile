import 'package:flutter/material.dart';
import 'package:petalsinajar/core/widgets/placeholder_screen.dart';

class VendorTodayScreen extends StatelessWidget {
  const VendorTodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Today',
      headline: 'All quiet for now',
      message:
          "Today's and tomorrow's deliveries and pickups will show up here.",
      icon: Icons.local_shipping_rounded,
    );
  }
}
