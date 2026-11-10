import 'package:geolocator/geolocator.dart';
import 'package:petalsinajar/features/discover/domain/discover_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_locator.g.dart';

/// [DeviceLocator] on the geolocator plugin. Neighbourhood accuracy is
/// enough, and quicker and kinder to the battery than GPS.
class GeolocatorDeviceLocator implements DeviceLocator {
  const GeolocatorDeviceLocator();

  static const _timeout = Duration(seconds: 10);

  bool _granted(LocationPermission p) =>
      p == LocationPermission.always || p == LocationPermission.whileInUse;

  @override
  Future<bool> hasPermission() async {
    try {
      return _granted(await Geolocator.checkPermission());
    } on Object {
      return false;
    }
  }

  @override
  Future<LatLng?> locate() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (!_granted(permission)) return null;

      final position =
          await Geolocator.getLastKnownPosition() ??
          await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.low,
              timeLimit: _timeout,
            ),
          );
      return (lat: position.latitude, lng: position.longitude);
    } on Object {
      // Timeouts and platform errors: fall back to picking an area.
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
DeviceLocator deviceLocator(Ref ref) => const GeolocatorDeviceLocator();
