import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_palette.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/money.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

/// Material icons for the API's category icon keys.
IconData categoryIcon(String? key) => switch (key) {
  'chair' => Icons.chair_alt_rounded,
  'table' => Icons.table_restaurant_rounded,
  'tent' => Icons.festival_rounded,
  'sparkles' => Icons.auto_awesome_rounded,
  'bulb' => Icons.lightbulb_rounded,
  'speaker' => Icons.speaker_rounded,
  'utensils' => Icons.restaurant_rounded,
  'balloon' => Icons.celebration_rounded,
  'stage' => Icons.theater_comedy_rounded,
  _ => Icons.category_rounded,
};

String eventTypePlural(EventType type) => switch (type) {
  EventType.wedding => 'Weddings',
  EventType.birthday => 'Birthdays',
  EventType.corporate => 'Corporate',
};

String eventTypeLabel(EventType type) => switch (type) {
  EventType.wedding => 'Wedding',
  EventType.birthday => 'Birthday',
  EventType.corporate => 'Corporate',
};

/// The accent for [type]; the brand primary for "All".
Accent accentOf(BuildContext context, EventType? type) {
  if (type != null) return context.palette.accentFor(type);
  final c = context.colors;
  return Accent(
    color: c.primary,
    onColor: c.onPrimary,
    container: c.primaryContainer,
    onContainer: c.onPrimaryContainer,
  );
}

/// "from GH₵12 / event".
String fromPrice(ItemCard item) {
  final unit = switch (item.unit) {
    'per_day' => 'day',
    'per_hour' => 'hour',
    _ => 'event',
  };
  return 'from ${MoneyFormat.format(item.fromPriceMinor, item.currency)} '
      '/ $unit';
}

/// "20–30 guests", "Up to 30 guests", or null.
String? guestRange(PackageCard p) => switch ((p.guestMin, p.guestMax)) {
  (final int min, final int max) when min != max => '$min–$max guests',
  (_, final int max) => 'Up to $max guests',
  (final int min, null) => '$min+ guests',
  _ => null,
};

/// "2.4 km", or "Under 1 km".
String? distanceLabel(double? km) => switch (km) {
  null => null,
  < 1 => 'Under 1 km',
  < 10 => '${km.toStringAsFixed(1)} km',
  _ => '${km.round()} km',
};

/// "4.8 (23)", or null with no reviews yet.
String? ratingLabel(Rating rating) {
  final avg = rating.average;
  if (avg == null || rating.count == 0) return null;
  return '${avg.toStringAsFixed(1)} (${rating.count})';
}

/// "Near East Legon", "Near you".
String placeLabel(DiscoverPlace place) => 'Near ${place.label}';

/// "chairs" → "Chairs", for vendor category slugs.
String categorySlugLabel(String slug) => slug.isEmpty
    ? slug
    : slug[0].toUpperCase() + slug.substring(1).replaceAll('_', ' ');
