import 'package:flutter/material.dart';
import 'package:petalsinajar/core/widgets/placeholder_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Discover',
      headline: 'Find your look',
      message:
          'Search vendors, browse categories and shop trending event looks.',
      icon: Icons.travel_explore_rounded,
    );
  }
}
