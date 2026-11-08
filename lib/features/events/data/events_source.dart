import 'package:petalsinajar/core/mock/seed_loader.dart';

/// Raw API calls for events. Both sources return the backend's JSON shapes,
/// which the repository parses with the DTOs in `event_dtos.dart`. Lists are
/// `{ data, next_cursor }`; single resources are unwrapped.
abstract interface class EventsSource {
  /// `GET /v1/me/events?scope=upcoming|past&cursor=` → events I'm a member
  /// of, each with `my_rsvp` and `is_host`.
  Future<Json> myEvents({required String scope, String? cursor});

  /// `GET /v1/events/{id}` → event.
  Future<Json> detail(String eventId);

  /// `GET /v1/events/{id}/members?cursor=` → `{ role, rsvp, user }` rows.
  Future<Json> members(String eventId, {String? cursor});

  /// `GET /v1/events/{id}/posts?cursor=` → posts.
  Future<Json> feed(String eventId, {String? cursor});

  /// `GET /v1/events/{id}/bookings?cursor=` → bookings. Hosts only.
  Future<Json> bookings(String eventId, {String? cursor});

  /// `POST /v1/uploads` multipart `file` → `{ url, width, height }`.
  Future<Json> uploadImage(String path);

  /// `POST /v1/events` → event.
  Future<Json> create(Json fields);

  /// `PUT /v1/events/{id}/rsvp` `{ rsvp }` → `{ rsvp }`.
  Future<Json> rsvp(String eventId, String rsvp);
}
