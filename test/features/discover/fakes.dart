import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/network/paginated.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/domain/discover_repository.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

/// In-memory Discover data. Set a list to null to make that call fail.
class FakeDiscoverRepository implements DiscoverRepository {
  List<CatalogCategory>? categoryList = const [
    CatalogCategory(id: 'seating', name: 'Seating', icon: 'chair'),
    CatalogCategory(id: 'sound', name: 'Sound', icon: 'speaker'),
  ];
  List<LookPost>? looks = const [];
  List<VendorCard>? vendorList = const [];
  List<PackageCard>? packages = const [];
  List<ItemCard>? itemList = const [];
  List<UpcomingEvent> events = const [];
  List<EventNeed> eventNeeds = const [];

  final calls = <String>[];
  LatLng? lastNear;
  EventType? lastEventType;
  int followers = 10;
  bool failFollow = false;

  T _or<T>(T? value) =>
      value ??
      (throw const ApiException(
        type: ApiErrorType.server,
        message: 'Server error',
      ));

  @override
  Future<List<CatalogCategory>> categories() async => _or(categoryList);

  @override
  Future<List<LookPost>> trendingLooks({EventType? eventType}) async {
    calls.add('looks ${eventType?.name}');
    return _or(looks);
  }

  @override
  Future<List<VendorCard>> vendors({
    LatLng? near,
    String? query,
    String? categoryId,
    EventType? eventType,
  }) async {
    calls.add('vendors');
    lastNear = near;
    lastEventType = eventType;
    return _or(vendorList);
  }

  @override
  Future<List<PackageCard>> packagesNear(
    LatLng near, {
    EventType? eventType,
  }) async => _or(packages);

  @override
  Future<Paginated<ItemCard>> items({
    LatLng? near,
    String? query,
    String? categoryId,
    String? vendorId,
    EventType? eventType,
    String? cursor,
  }) async => Paginated(items: _or(itemList));

  @override
  Future<List<UpcomingEvent>> upcomingEvents() async => events;

  @override
  Future<List<EventNeed>> needs(String eventId) async => eventNeeds;

  @override
  Future<int> setFollowing(String vendorId, {required bool following}) async {
    calls.add('${following ? 'follow' : 'unfollow'} $vendorId');
    if (failFollow) {
      throw const ApiException(type: ApiErrorType.server, message: 'Nope');
    }
    return followers;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// A phone whose location permission the test controls.
class FakeLocator implements DeviceLocator {
  FakeLocator({this.granted = false, this.fix});

  bool granted;
  LatLng? fix;
  int prompts = 0;

  @override
  Future<bool> hasPermission() async => granted;

  @override
  Future<LatLng?> locate() async {
    prompts++;
    return fix;
  }
}

const royal = VendorCard(
  id: 'v1',
  name: 'Royal Canopies',
  isVerified: true,
  distanceKm: 2.4,
  rating: Rating(average: 4.8, count: 23),
  categories: ['tents'],
);
