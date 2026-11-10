import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

// Parsers for the Laravel resources Discover reads. Unknown or missing
// optional fields fall back to defaults rather than failing the section.

EventType? eventTypeOf(Object? raw) =>
    EventType.values.where((t) => t.name == raw).firstOrNull;

double? _double(Object? raw) => switch (raw) {
  final num n => n.toDouble(),
  final String s => double.tryParse(s),
  _ => null,
};

Rating _rating(Object? raw) {
  final j = raw as Json? ?? const {};
  return Rating(average: _double(j['avg']), count: j['count'] as int? ?? 0);
}

bool _isVideo(Json m) => m['kind'] == 'video' || m['type'] == 'video';

/// `Media::toPayload` (or the older `{ url, w, h }`). Media still processing
/// has no URL yet and is skipped.
Photo? photoOf(Object? raw) {
  if (raw is! Json) return null;
  final Media media;
  try {
    media = Media.fromApi(raw);
  } on Object {
    return null;
  }
  final url = media.stillUrl;
  if (url == null) return null;
  return Photo(
    url: url,
    blurhash: media.blurhash,
    width: media.width,
    height: media.height,
    media: media,
  );
}

List<Photo> _photos(Object? raw) => [
  for (final m in (raw as List? ?? const []).cast<Json>())
    if (!_isVideo(m)) ?photoOf(m),
];

/// `VendorSummary` (item, package and need cards).
VendorRef? vendorRefOf(Object? raw) {
  if (raw is! Json) return null;
  return VendorRef(
    id: raw['id'] as String,
    name: raw['name'] as String? ?? '',
    handle: raw['handle'] as String?,
    logoUrl: raw['logo_url'] as String?,
    isVerified: raw['is_verified'] as bool? ?? false,
  );
}

/// `GET /categories` row.
CatalogCategory categoryOf(Json j) => CatalogCategory(
  id: j['id'] as String,
  name: j['name'] as String,
  icon: j['icon'] as String?,
);

/// `VendorResource`, plus `distance_km` and `is_following` from the index.
VendorCard vendorOf(Json j) {
  final counts = j['counts'] as Json? ?? const {};
  return VendorCard(
    id: j['id'] as String,
    name: j['name'] as String? ?? '',
    handle: j['handle'] as String?,
    logoUrl: j['logo_url'] as String?,
    coverUrl: j['cover_url'] as String?,
    city: j['city'] as String?,
    bio: j['bio'] as String?,
    isVerified: j['is_verified'] as bool? ?? false,
    rating: _rating(j['rating']),
    categories: (j['categories'] as List? ?? const []).cast<String>(),
    followers: counts['followers'] as int? ?? 0,
    completedBookings: counts['completed_bookings'] as int? ?? 0,
    distanceKm: _double(j['distance_km']),
    isFollowing: j['is_following'] as bool? ?? false,
  );
}

/// `ItemResource`.
ItemCard itemOf(Json j) {
  final pricing = j['pricing'] as Json? ?? const {};
  final photos = _photos(j['media']);
  final vendor = vendorRefOf(j['vendor']);
  return ItemCard(
    id: j['id'] as String,
    title: j['title'] as String,
    fromPriceMinor: j['from_price_minor'] as int? ?? 0,
    currency: pricing['currency'] as String? ?? 'GHS',
    unit: pricing['unit'] as String? ?? 'per_event',
    photo: photos.firstOrNull,
    photos: photos,
    vendorId: j['vendor_id'] as String? ?? vendor?.id,
    vendor: vendor,
    description: j['description'] as String?,
    minQty: j['min_qty'] as int? ?? 1,
    variants: [
      for (final v in (j['variants'] as List? ?? const []).cast<Json>())
        if (v['active'] != false)
          ItemVariant(
            id: v['id'] as String,
            name: v['name'] as String? ?? 'Standard',
            quantity: v['quantity'] as int? ?? 0,
            priceDeltaMinor: v['price_delta_minor'] as int? ?? 0,
          ),
    ],
  );
}

/// The item card inside a post tag (`CatalogReader::cards`).
ItemCard tagItemOf(Json j) => ItemCard(
  id: j['id'] as String,
  title: j['title'] as String? ?? '',
  fromPriceMinor: j['from_price_minor'] as int? ?? 0,
  currency: j['currency'] as String? ?? 'GHS',
  unit: j['unit'] as String? ?? 'per_event',
  photo: photoOf(j['image']),
  vendorId: j['vendor_id'] as String?,
);

/// `PackageResource`.
PackageCard packageOf(Json j) {
  final range = j['guest_range'] as Json? ?? const {};
  return PackageCard(
    id: j['id'] as String,
    title: j['title'] as String,
    priceMinor: j['price_minor'] as int? ?? 0,
    currency: j['currency'] as String? ?? 'GHS',
    guestMin: range['min'] as int?,
    guestMax: range['max'] as int?,
    description: j['description'] as String?,
    photo: _photos(j['media']).firstOrNull,
    vendor: vendorRefOf(j['vendor']),
    eventTypes: [
      for (final t in (j['event_types'] as List? ?? const [])) ?eventTypeOf(t),
    ],
  );
}

/// `EventResource`.
UpcomingEvent upcomingEventOf(Json j) {
  final venue = j['venue'] as Json? ?? const {};
  return UpcomingEvent(
    id: j['id'] as String,
    title: j['title'] as String,
    startsAt: DateTime.parse(j['starts_at'] as String).toLocal(),
    type: eventTypeOf(j['type']),
    venueName: venue['name'] as String?,
    venueCity: venue['city'] as String?,
    lat: _double(venue['lat']),
    lng: _double(venue['lng']),
    isHost: j['is_host'] as bool? ?? false,
  );
}

/// `GET /events/{id}/needs` row.
EventNeed needOf(Json j) => EventNeed(
  categoryId: j['category_id'] as String,
  categoryName: j['category_name'] as String? ?? j['category_id'] as String,
  vendors: [
    for (final v in (j['vendors'] as List? ?? const []).cast<Json>())
      if (vendorRefOf(v['vendor']) case final VendorRef vendor)
        NeedVendor(
          vendor: vendor,
          fromPriceMinor: v['from_price_minor'] as int?,
          currency: v['currency'] as String?,
          distanceKm: _double(v['distance_km']),
        ),
  ],
);

/// The post presenter's JSON.
LookPost lookOf(Json j) {
  final author = j['author'] as Json? ?? const {};
  final counts = j['counts'] as Json? ?? const {};
  return LookPost(
    id: j['id'] as String,
    authorName: author['name'] as String? ?? author['handle'] as String? ?? '',
    authorAvatarUrl: author['avatar_url'] as String?,
    authorIsVendor: author['type'] == 'vendor',
    eventType: eventTypeOf(j['event_type'] ?? (j['event'] as Json?)?['type']),
    caption: j['caption'] as String? ?? '',
    likeCount: counts['likes'] as int? ?? 0,
    media: [
      for (final m in (j['media'] as List? ?? const []).cast<Json>())
        if (photoOf(m) case final Photo photo)
          LookMedia(
            photo: photo,
            isVideo: _isVideo(m),
            tags: [
              for (final t in (m['tags'] as List? ?? const []).cast<Json>())
                _tagOf(t),
            ],
          ),
    ],
  );
}

LookTag _tagOf(Json t) {
  final target = t['target'] as Json;
  return LookTag(
    id: t['id'] as String,
    x: _double(t['x']) ?? 0.5,
    y: _double(t['y']) ?? 0.5,
    targetType: target['type'] as String,
    targetId: target['id'] as String,
    item: switch (target['item']) {
      final Json item => tagItemOf(item),
      _ => null,
    },
  );
}
