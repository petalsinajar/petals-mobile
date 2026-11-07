import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/app_shell.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/features/catalog/presentation/discover_screen.dart';
import 'package:petalsinajar/features/events/presentation/my_events_screen.dart';
import 'package:petalsinajar/features/feed/presentation/feed_screen.dart';
import 'package:petalsinajar/features/posts/presentation/create_screen.dart';
import 'package:petalsinajar/features/profile/presentation/profile_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/calendar_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/inventory_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/requests_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/today_screen.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_profile_screen.dart';

const _userDestinations = [
  ShellDestination(
    label: 'Feed',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
  ),
  ShellDestination(
    label: 'Discover',
    icon: Icons.explore_outlined,
    selectedIcon: Icons.explore_rounded,
  ),
  ShellDestination(
    label: 'Create',
    icon: Icons.add_circle_outline_rounded,
    selectedIcon: Icons.add_circle_rounded,
  ),
  ShellDestination(
    label: 'My Events',
    icon: Icons.celebration_outlined,
    selectedIcon: Icons.celebration_rounded,
  ),
  ShellDestination(
    label: 'Profile',
    icon: Icons.person_outline_rounded,
    selectedIcon: Icons.person_rounded,
  ),
];

const _vendorDestinations = [
  ShellDestination(
    label: 'Today',
    icon: Icons.today_outlined,
    selectedIcon: Icons.today_rounded,
  ),
  ShellDestination(
    label: 'Requests',
    icon: Icons.inbox_outlined,
    selectedIcon: Icons.inbox_rounded,
  ),
  ShellDestination(
    label: 'Calendar',
    icon: Icons.calendar_month_outlined,
    selectedIcon: Icons.calendar_month_rounded,
  ),
  ShellDestination(
    label: 'Inventory',
    icon: Icons.inventory_2_outlined,
    selectedIcon: Icons.inventory_2_rounded,
  ),
  ShellDestination(
    label: 'Business',
    icon: Icons.storefront_outlined,
    selectedIcon: Icons.storefront_rounded,
  ),
];

StatefulShellBranch _branch(String path, Widget screen) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (_, _) => screen)],
);

/// Feed · Discover · Create · My Events · Profile.
final userShellRoute = StatefulShellRoute.indexedStack(
  builder: (context, state, shell) =>
      AppShell(navigationShell: shell, destinations: _userDestinations),
  branches: [
    _branch(Routes.feed, const FeedScreen()),
    _branch(Routes.discover, const DiscoverScreen()),
    _branch(Routes.create, const CreateScreen()),
    _branch(Routes.myEvents, const MyEventsScreen()),
    _branch(Routes.profile, const ProfileScreen()),
  ],
);

/// Today · Requests · Calendar · Inventory · Business, in vendor colors.
final vendorShellRoute = StatefulShellRoute.indexedStack(
  builder: (context, state, shell) => VendorBranding(
    child: AppShell(navigationShell: shell, destinations: _vendorDestinations),
  ),
  branches: [
    _branch(Routes.vendorToday, const VendorTodayScreen()),
    _branch(Routes.vendorRequests, const VendorRequestsScreen()),
    _branch(Routes.vendorCalendar, const VendorCalendarScreen()),
    _branch(Routes.vendorInventory, const VendorInventoryScreen()),
    _branch(Routes.vendorProfile, const VendorProfileScreen()),
  ],
);
