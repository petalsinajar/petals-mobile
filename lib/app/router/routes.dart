/// Every path in the app. Navigate with these, never with string literals.
abstract final class Routes {
  // User shell tabs.
  static const feed = '/feed';
  static const discover = '/discover';
  static const create = '/create';
  static const myEvents = '/my-events';
  static const profile = '/profile';

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
