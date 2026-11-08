import 'package:flutter/material.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode.g.dart';

/// Light, dark, or follow the phone (the default). Kept on the device: it's
/// a preference about this screen, not about the account.
@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    final saved = ref.watch(sharedPreferencesProvider).getString(_key);
    return ThemeMode.values.asNameMap()[saved] ?? ThemeMode.system;
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(_key, mode.name);
  }
}
