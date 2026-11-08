import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences.g.dart';

/// Small on-device settings (theme, dismissed hints). Loaded once in
/// `bootstrap()` before the first frame, so reads are synchronous.
/// Never for secrets — tokens live in `SecureTokenStorage`.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) => throw UnimplementedError(
  'sharedPreferencesProvider must be overridden in bootstrap().',
);
