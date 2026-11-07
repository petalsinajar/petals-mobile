import 'package:flutter/material.dart';
import 'package:petalsinajar/core/widgets/placeholder_screen.dart';

class VendorRequestsScreen extends StatelessWidget {
  const VendorRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Requests',
      headline: 'No new requests',
      message:
          'Booking requests from customers will land here for you to '
          'accept or decline.',
      icon: Icons.inbox_rounded,
    );
  }
}
