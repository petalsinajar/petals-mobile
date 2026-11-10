/// Every path in the app. Navigate with these, never with string literals.
abstract final class Routes {
  // User shell tabs.
  static const feed = '/feed';
  static const discover = '/discover';
  static const create = '/create';
  static const myEvents = '/my-events';
  static const profile = '/profile';

  // Inside the Profile tab, so the bottom bar stays.
  static const profileEdit = '/profile/edit';
  static const profileSettings = '/profile/settings';
  static const dashboardSignIn = '/profile/dashboard-sign-in';

  /// Full screen: Discover's search, optionally within a category.
  static const search = '/search';

  static String searchCategory(String categoryId, String name) => Uri(
    path: search,
    queryParameters: {'category': categoryId, 'name': name},
  ).toString();

  /// Full screen: the viewer's bookings, and one booking (push target).
  static const myBookings = '/bookings';
  static const bookingPattern = '/bookings/:id';
  static String booking(String id) => '/bookings/$id';

  /// Full screen: "Start a business".
  static const startBusiness = '/business/new';

  static const List<String> userTabs = [
    feed,
    discover,
    create,
    myEvents,
    profile,
  ];

  // Vendor shell tabs. All live under [vendorShellPrefix].
  static const vendorShellPrefix = '/vendor/';
  static const vendorToday = '/vendor/today';
  static const vendorRequests = '/vendor/requests';
  static const vendorCalendar = '/vendor/calendar';
  static const vendorInventory = '/vendor/inventory';
  static const vendorProfile = '/vendor/profile';
  static const vendorProfileEdit = '/vendor/profile/edit';

  // Sign in, then (new accounts) a name. All carry `?from=` — where to go
  // once done.
  static const signIn = '/sign-in';
  static const verifyCode = '/sign-in/verify';
  static const completeProfile = '/welcome';

  static String completeProfileFrom(String? from) => Uri(
    path: completeProfile,
    queryParameters: {'from': ?from},
  ).toString();

  static String signInFrom(String? from) => Uri(
    path: signIn,
    queryParameters: {'from': ?from},
  ).toString();

  static String verifyCodeFor({required String phone, String? from}) => Uri(
    path: verifyCode,
    queryParameters: {'phone': phone, 'from': ?from},
  ).toString();

  // Full-screen flows.
  /// Declared before [eventPattern] so `new` isn't read as an event id.
  static const createEvent = '/events/new';

  // Shareable, deep-linkable screens (registered as their features land).
  static const eventPattern = '/events/:id';
  static const postPattern = '/posts/:id';
  static const itemPattern = '/items/:id';
  static const vendorPattern = '/vendors/:id';
  static const userPattern = '/@:handle';

  static String event(String id) => '/events/$id';
  static String post(String id) => '/posts/$id';
  static String item(String id) => '/items/$id';
  static String vendor(String id) => '/vendors/$id';
  static String user(String handle) => '/@$handle';
}
