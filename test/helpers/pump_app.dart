import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/theme/app_theme.dart';

/// Themes without runtime Google Fonts fetching (no network in tests).
final testThemes = AppThemes.build(googleFonts: false);

extension PumpApp on WidgetTester {
  /// Pumps [widget] inside the app theme, a [ProviderScope] and a [Scaffold],
  /// with animations disabled so `pumpAndSettle` terminates.
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
    ThemeMode themeMode = ThemeMode.light,
  }) {
    return pumpWidget(
      ProviderScope(
        overrides: overrides,
        // As in bootstrap(): failures show at once, with a retry button.
        retry: (_, _) => null,
        child: MaterialApp(
          theme: testThemes.light,
          darkTheme: testThemes.dark,
          themeMode: themeMode,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(disableAnimations: true),
            child: child!,
          ),
          home: Scaffold(body: widget),
        ),
      ),
    );
  }
}
