import 'package:flutter/material.dart';
import 'package:petalsinajar/core/widgets/placeholder_screen.dart';

class VendorCalendarScreen extends StatelessWidget {
  const VendorCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Calendar',
      headline: 'Your month at a glance',
      message: 'Bookings and blocked dates for your inventory.',
      icon: Icons.calendar_month_rounded,
    );
  }
}
