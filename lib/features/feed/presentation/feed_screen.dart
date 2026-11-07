import 'package:flutter/widgets.dart';
import 'package:petalsinajar/core/widgets/placeholder_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Petalsinajar',
      headline: 'Your feed is warming up',
      message:
          'Posts from friends, events and vendors you follow will appear here.',
    );
  }
}
