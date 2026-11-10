import 'dart:math' as math;

import 'package:petalsinajar/features/discover/domain/discover_models.dart';

/// A neighbourhood or city people pick as "near".
typedef Area = ({String name, double lat, double lng});

/// Launch areas, most-used first. Picking one centres Discover on it; a
/// device fix is labelled with the nearest one within [_nameWithinKm].
const List<Area> launchAreas = [
  (name: 'East Legon', lat: 5.6350, lng: -0.1570),
  (name: 'Osu', lat: 5.5560, lng: -0.1820),
  (name: 'Airport Residential', lat: 5.6040, lng: -0.1780),
  (name: 'Cantonments', lat: 5.5800, lng: -0.1700),
  (name: 'Spintex', lat: 5.6280, lng: -0.1100),
  (name: 'Madina', lat: 5.6730, lng: -0.1660),
  (name: 'Achimota', lat: 5.6170, lng: -0.2280),
  (name: 'Dansoman', lat: 5.5480, lng: -0.2600),
  (name: 'Tema', lat: 5.6698, lng: -0.0166),
  (name: 'Kasoa', lat: 5.5340, lng: -0.4170),
  (name: 'Kumasi', lat: 6.6885, lng: -1.6244),
  (name: 'Takoradi', lat: 4.8986, lng: -1.7554),
  (name: 'Cape Coast', lat: 5.1053, lng: -1.2466),
  (name: 'Tamale', lat: 9.4008, lng: -0.8393),
];

const double _nameWithinKm = 4;

/// Great-circle distance in km.
double distanceKm(double lat1, double lng1, double lat2, double lng2) {
  const earthKm = 6371.0;
  double rad(double d) => d * math.pi / 180;
  final dLat = rad(lat2 - lat1);
  final dLng = rad(lng2 - lng1);
  final a =
      math.pow(math.sin(dLat / 2), 2) +
      math.cos(rad(lat1)) *
          math.cos(rad(lat2)) *
          math.pow(math.sin(dLng / 2), 2);
  return earthKm * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
}

/// "East Legon" when the fix is close to a known area, else "you".
DiscoverPlace placeFromDevice(double lat, double lng) {
  Area? best;
  var bestKm = double.infinity;
  for (final area in launchAreas) {
    final km = distanceKm(lat, lng, area.lat, area.lng);
    if (km < bestKm) (best, bestKm) = (area, km);
  }
  return DiscoverPlace(
    label: best != null && bestKm <= _nameWithinKm ? best.name : 'you',
    lat: lat,
    lng: lng,
    source: PlaceSource.device,
  );
}

DiscoverPlace placeFromArea(Area area) => DiscoverPlace(
  label: area.name,
  lat: area.lat,
  lng: area.lng,
  source: PlaceSource.picked,
);
