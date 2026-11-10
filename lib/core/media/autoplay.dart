import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'autoplay.g.dart';

/// Whether the phone is on Wi-Fi (or Ethernet); replaceable in tests.
@Riverpod(keepAlive: true)
Stream<bool> onWifi(Ref ref) async* {
  final connectivity = Connectivity();
  bool wifi(List<ConnectivityResult> r) =>
      r.contains(ConnectivityResult.wifi) ||
      r.contains(ConnectivityResult.ethernet);
  yield wifi(await connectivity.checkConnectivity());
  yield* connectivity.onConnectivityChanged.map(wifi);
}

/// "Autoplay videos on mobile data" — off unless the user turns it on.
@Riverpod(keepAlive: true)
class AutoplayOnCellular extends _$AutoplayOnCellular {
  static const storageKey = 'media.autoplay_cellular';

  @override
  bool build() =>
      ref.read(sharedPreferencesProvider).getBool(storageKey) ?? false;

  Future<void> set({required bool allowed}) async {
    state = allowed;
    await ref.read(sharedPreferencesProvider).setBool(storageKey, allowed);
  }
}

/// Feed videos may start on their own: on Wi-Fi, or when allowed.
@riverpod
bool canAutoplay(Ref ref) =>
    (ref.watch(onWifiProvider).value ?? false) ||
    ref.watch(autoplayOnCellularProvider);
