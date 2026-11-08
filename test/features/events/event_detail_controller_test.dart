import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/events/data/events_repository_impl.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_detail.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';
import 'package:petalsinajar/features/events/domain/events_repository.dart';
import 'package:petalsinajar/features/events/presentation/events_controllers.dart';

class _MockRepo extends Mock implements EventsRepository {}

void main() {
  setUpAll(() => registerFallbackValue(RsvpStatus.going));

  final detail = EventDetail(
    event: Event(
      id: 'e1',
      type: EventType.wedding,
      title: 'Wedding',
      startsAt: DateTime.utc(2030),
      venue: const EventVenue(name: 'Garden', city: 'Accra'),
      guestCount: 100,
      visibility: EventVisibility.guests,
      hostId: 'h1',
      rsvpCounts: const RsvpCounts(going: 10, invited: 5),
      viewerRole: ViewerRole.guest,
      viewerRsvp: RsvpStatus.invited,
    ),
    host: const EventPerson(id: 'h1', name: 'Host'),
  );

  late _MockRepo repo;
  late ProviderContainer container;
  final provider = eventDetailControllerProvider('e1');

  setUp(() {
    repo = _MockRepo();
    when(() => repo.detail('e1')).thenAnswer((_) async => detail);
    container = ProviderContainer.test(
      overrides: [eventsRepositoryProvider.overrideWithValue(repo)],
      retry: (_, _) => null,
    );
  });

  test('rsvp updates optimistically, then takes the saved detail', () async {
    final saved = detail.copyWith.event(
      viewerRsvp: RsvpStatus.going,
      rsvpCounts: const RsvpCounts(going: 11, invited: 4),
    );
    when(() => repo.rsvp('e1', RsvpStatus.going)).thenAnswer((_) async {
      // Mid-flight, the UI already shows the new answer.
      final shown = container.read(provider).requireValue.event;
      expect(shown.viewerRsvp, RsvpStatus.going);
      expect(shown.rsvpCounts.going, 11);
      return saved;
    });
    await container.read(provider.future);

    await container.read(provider.notifier).rsvp(RsvpStatus.going);

    expect(container.read(provider).requireValue, saved);
  });

  test('rsvp rolls back and rethrows when saving fails', () async {
    when(() => repo.rsvp(any(), any())).thenThrow(
      const ApiException(type: ApiErrorType.network, message: 'offline'),
    );
    await container.read(provider.future);

    await expectLater(
      container.read(provider.notifier).rsvp(RsvpStatus.maybe),
      throwsA(isA<ApiException>()),
    );
    expect(container.read(provider).requireValue, detail);
  });

  test('choosing the current answer is a no-op', () async {
    await container.read(provider.future);
    await container.read(provider.notifier).rsvp(RsvpStatus.invited);
    verifyNever(() => repo.rsvp(any(), any()));
  });
}
