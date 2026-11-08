import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

part 'event_draft.freezed.dart';

/// The create-event stepper's steps, in order.
enum EventDraftStep { type, title, dateTime, venue, guests, visibility, cover }

/// What the host has filled in so far.
@freezed
abstract class EventDraft with _$EventDraft {
  const factory EventDraft({
    EventType? type,
    @Default('') String title,
    DateTime? startsAt,
    DateTime? endsAt,
    @Default('') String venueName,
    @Default('') String venueCity,
    @Default('') String venueAddress,
    @Default(50) int guestCount,
    @Default(EventVisibility.guests) EventVisibility visibility,

    /// Local path from the image picker; uploaded on submit.
    String? coverPath,
  }) = _EventDraft;

  const EventDraft._();

  /// How long an event runs when the host keeps the suggested end.
  static const defaultLength = Duration(hours: 5);

  static const minTitleLength = 3;
  static const maxTitleLength = 80;
  static const maxGuests = 5000;

  /// Whether [step] is complete enough to move past it.
  bool isStepValid(EventDraftStep step) => switch (step) {
    EventDraftStep.type => type != null,
    EventDraftStep.title =>
      title.trim().length >= minTitleLength &&
          title.trim().length <= maxTitleLength,
    EventDraftStep.dateTime =>
      startsAt != null && (endsAt == null || endsAt!.isAfter(startsAt!)),
    EventDraftStep.venue =>
      venueName.trim().isNotEmpty && venueCity.trim().isNotEmpty,
    EventDraftStep.guests => guestCount >= 1 && guestCount <= maxGuests,
    EventDraftStep.visibility || EventDraftStep.cover => true,
  };

  bool get isComplete => EventDraftStep.values.every(isStepValid);

  /// The end the server needs: the picked one, or [defaultLength] after the
  /// start. Only meaningful once [startsAt] is set.
  DateTime get effectiveEndsAt => endsAt ?? startsAt!.add(defaultLength);
}
