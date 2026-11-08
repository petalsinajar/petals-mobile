import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/app/theme/theme_mode.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container([
  Map<String, Object> saved = const {},
]) async {
  SharedPreferences.setMockInitialValues(saved);
  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('follows the phone until the user chooses', () async {
    final container = await _container();
    expect(container.read(appThemeModeProvider), ThemeMode.system);
  });

  test('a choice applies at once and survives a restart', () async {
    final container = await _container();
    await container.read(appThemeModeProvider.notifier).set(ThemeMode.dark);
    expect(container.read(appThemeModeProvider), ThemeMode.dark);

    // A new container over the same storage is a restart.
    final prefs = await SharedPreferences.getInstance();
    final restarted = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(restarted.dispose);
    expect(restarted.read(appThemeModeProvider), ThemeMode.dark);
  });

  test('an unknown saved value falls back to the phone setting', () async {
    final container = await _container({'theme_mode': 'sepia'});
    expect(container.read(appThemeModeProvider), ThemeMode.system);
  });
}
