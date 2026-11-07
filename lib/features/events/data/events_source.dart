import 'package:petalsinajar/core/mock/seed_loader.dart';

/// Raw API calls for events. Both sources return the same JSON shapes, which
/// the repository parses with the DTOs in `event_dtos.dart`.
abstract interface class EventsSource {
  /// `GET /v1/me/events` → `{ data: [event] }`.
  Future<List<Json>> myEvents();

  /// `GET /v1/events/{id}` → event detail.
  Future<Json> detail(String eventId);

  /// `GET /v1/events/{id}/posts?cursor=` → `{ data, next_cursor }`.
  Future<Json> feed(String eventId, {String? cursor});

  /// `GET /v1/events/{id}/plan` → `{ bookings, cart }`.
  Future<Json> plan(String eventId);

  /// `POST /v1/events` (multipart when [coverPath] is set) → event.
  Future<Json> create(Json fields, {String? coverPath});

  /// `PUT /v1/events/{id}/rsvp` `{ status }` → event detail.
  Future<Json> rsvp(String eventId, String status);
}
