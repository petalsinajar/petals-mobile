import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';

@immutable
class ShellDestination {
  const ShellDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Bottom-navigation scaffold shared by the user and vendor shells.
class AppShell extends StatelessWidget {
  const AppShell({
    required this.navigationShell,
    required this.destinations,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<ShellDestination> destinations;

  void _onSelect(int index) {
    unawaited(Haptics.selection());
    // Tapping the current tab again pops it back to its root.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final onFirstTab = navigationShell.currentIndex == 0;
    // System back on another tab goes to the first tab; only there does it
    // leave the app. Screens pushed inside a tab are popped before this.
    return PopScope(
      canPop: onFirstTab,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) navigationShell.goBranch(0);
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onSelect,
          destinations: [
            for (final d in destinations)
              NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label,
              ),
          ],
        ),
      ),
    );
  }
}

/// Re-tints the primary color with the vendor accent, so vendor mode is
/// unmistakable at a glance.
class VendorBranding extends StatelessWidget {
  const VendorBranding({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final accent = context.palette.vendor;
    final colors = theme.colorScheme.copyWith(
      primary: accent.color,
      onPrimary: accent.onColor,
      primaryContainer: accent.container,
      onPrimaryContainer: accent.onContainer,
    );
    return Theme(
      data: theme.copyWith(
        colorScheme: colors,
        navigationBarTheme: theme.navigationBarTheme.copyWith(
          indicatorColor: accent.container,
        ),
      ),
      child: child,
    );
  }
}
