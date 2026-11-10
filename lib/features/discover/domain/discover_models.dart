import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

part 'discover_models.freezed.dart';

/// Where Discover looks for vendors.
enum PlaceSource {
  /// The venue of the viewer's next hosted event.
  eventVenue,

  /// The phone's location.
  device,

  /// An area the viewer picked.
  picked,
}

@freezed
abstract class DiscoverPlace with _$DiscoverPlace {
  const factory DiscoverPlace({
    /// "East Legon", or "you" for an unnamed device fix.
    required String label,
    required double lat,
    required double lng,
    required PlaceSource source,
  }) = _DiscoverPlace;
}

/// A catalog category, e.g. Seating or Sound. [icon] is the API's icon key.
@freezed
abstract class CatalogCategory with _$CatalogCategory {
  const factory CatalogCategory({
    required String id,
    required String name,
    String? icon,
  }) = _CatalogCategory;
}

/// The vendor fields a small card needs.
@freezed
abstract class VendorRef with _$VendorRef {
  const factory VendorRef({
    required String id,
    required String name,
    String? handle,
    String? logoUrl,
    @Default(false) bool isVerified,
  }) = _VendorRef;
}

@freezed
abstract class Rating with _$Rating {
  const factory Rating({double? average, @Default(0) int count}) = _Rating;
}

/// A vendor as Discover lists it.
@freezed
abstract class VendorCard with _$VendorCard {
  const factory VendorCard({
    required String id,
    required String name,
    String? handle,
    String? logoUrl,
    String? coverUrl,
    String? city,
    String? bio,
    @Default(false) bool isVerified,
    @Default(Rating()) Rating rating,
    @Default(<String>[]) List<String> categories,
    @Default(0) int followers,
    @Default(0) int completedBookings,

    /// From the place Discover is looking at. Null without one.
    double? distanceKm,
    @Default(false) bool isFollowing,
  }) = _VendorCard;

  const VendorCard._();

  VendorRef get ref => VendorRef(
    id: id,
    name: name,
    handle: handle,
    logoUrl: logoUrl,
    isVerified: isVerified,
  );
}

@freezed
abstract class Photo with _$Photo {
  const factory Photo({
    required String url,
    String? blurhash,
    int? width,
    int? height,

    /// Every size, when the API sent them; [url] is the feed size.
    Media? media,
  }) = _Photo;
}

/// One version of an item, e.g. "Gold", with how many the vendor owns.
@freezed
abstract class ItemVariant with _$ItemVariant {
  const factory ItemVariant({
    required String id,
    required String name,
    @Default(0) int quantity,
    @Default(0) int priceDeltaMinor,
  }) = _ItemVariant;
}

/// A rentable item: "from GH₵12 / event".
@freezed
abstract class ItemCard with _$ItemCard {
  const factory ItemCard({
    required String id,
    required String title,
    required int fromPriceMinor,
    required String currency,

    /// `per_event`, `per_day` or `per_hour`.
    @Default('per_event') String unit,
    Photo? photo,

    /// Set whenever the vendor is known; [vendor] only when the API sent
    /// its name too.
    String? vendorId,
    VendorRef? vendor,
    String? description,
    @Default(<Photo>[]) List<Photo> photos,

    /// Active variants; only on the item's own page.
    @Default(<ItemVariant>[]) List<ItemVariant> variants,
    @Default(1) int minQty,
  }) = _ItemCard;
}

/// A fixed-price bundle, e.g. "Kids' party for 30".
@freezed
abstract class PackageCard with _$PackageCard {
  const factory PackageCard({
    required String id,
    required String title,
    required int priceMinor,
    required String currency,
    int? guestMin,
    int? guestMax,
    String? description,
    Photo? photo,
    VendorRef? vendor,
    @Default(<EventType>[]) List<EventType> eventTypes,
  }) = _PackageCard;
}

/// One of the viewer's upcoming events, as Discover needs it.
@freezed
abstract class UpcomingEvent with _$UpcomingEvent {
  const factory UpcomingEvent({
    required String id,
    required String title,
    required DateTime startsAt,

    /// Null for event types the app has no accent for (`other`).
    EventType? type,
    String? venueName,
    String? venueCity,
    double? lat,
    double? lng,
    @Default(false) bool isHost,
  }) = _UpcomingEvent;

  const UpcomingEvent._();

  bool get hasVenueLocation => lat != null && lng != null;
}

/// A vendor free on the event's dates for a category it still needs.
@freezed
abstract class NeedVendor with _$NeedVendor {
  const factory NeedVendor({
    required VendorRef vendor,
    int? fromPriceMinor,
    String? currency,
    double? distanceKm,
  }) = _NeedVendor;
}

/// A category the event still needs, e.g. Sound, with vendors to fill it.
@freezed
abstract class EventNeed with _$EventNeed {
  const factory EventNeed({
    required String categoryId,
    required String categoryName,
    @Default(<NeedVendor>[]) List<NeedVendor> vendors,
  }) = _EventNeed;
}

/// "For your event": the next event the viewer hosts and what it's missing.
@freezed
abstract class EventPlanGap with _$EventPlanGap {
  const factory EventPlanGap({
    required UpcomingEvent event,
    required List<EventNeed> needs,
  }) = _EventPlanGap;
}

/// A shop-the-look pin on a photo, at fractional [x], [y].
@freezed
abstract class LookTag with _$LookTag {
  const factory LookTag({
    required String id,
    required double x,
    required double y,

    /// `item`, `vendor` or `user`.
    required String targetType,
    required String targetId,
    ItemCard? item,
  }) = _LookTag;
}

@freezed
abstract class LookMedia with _$LookMedia {
  const factory LookMedia({
    required Photo photo,
    @Default(false) bool isVideo,
    @Default(<LookTag>[]) List<LookTag> tags,
  }) = _LookMedia;
}

/// A Discover post: an event look with its rentals tagged.
@freezed
abstract class LookPost with _$LookPost {
  const factory LookPost({
    required String id,
    required String authorName,
    required List<LookMedia> media,
    String? authorAvatarUrl,
    @Default(false) bool authorIsVendor,
    EventType? eventType,
    @Default('') String caption,
    @Default(0) int likeCount,
  }) = _LookPost;

  const LookPost._();

  /// The first photo (videos have no still to show on a card).
  Photo? get cover => media.where((m) => !m.isVideo).firstOrNull?.photo;

  /// Distinct vendors tagged, directly or through an item.
  int get vendorCount => {
    for (final m in media)
      for (final t in m.tags)
        if (t.targetType == 'vendor')
          t.targetId
        else if (t.item?.vendorId case final String id)
          id,
  }.length;
}
