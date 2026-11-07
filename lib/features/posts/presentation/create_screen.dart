import 'package:flutter/material.dart';
import 'package:petalsinajar/core/widgets/placeholder_screen.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Create',
      headline: 'Share a moment',
      message: 'Post photos from your events and tag what you rented.',
      icon: Icons.add_a_photo_rounded,
    );
  }
}
