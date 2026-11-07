// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myEvents)
final myEventsProvider = MyEventsProvider._();

final class MyEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  MyEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    return myEvents(ref);
  }
}

String _$myEventsHash() => r'f2d873d011a510f942bf139a9f438565ce1fc309';

@ProviderFor(eventPlan)
final eventPlanProvider = EventPlanFamily._();

final class EventPlanProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventPlan>,
          EventPlan,
          FutureOr<EventPlan>
        >
    with $FutureModifier<EventPlan>, $FutureProvider<EventPlan> {
  EventPlanProvider._({
    required EventPlanFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventPlanProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventPlanHash();

  @override
  String toString() {
    return r'eventPlanProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EventPlan> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<EventPlan> create(Ref ref) {
    final argument = this.argument as String;
    return eventPlan(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventPlanProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventPlanHash() => r'918d0d7f7618181bec18c9d905e9f16d583af03c';

final class EventPlanFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EventPlan>, String> {
  EventPlanFamily._()
    : super(
        retry: null,
        name: r'eventPlanProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventPlanProvider call(String eventId) =>
      EventPlanProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventPlanProvider';
}

/// The event page header, with optimistic RSVP.

@ProviderFor(EventDetailController)
final eventDetailControllerProvider = EventDetailControllerFamily._();

/// The event page header, with optimistic RSVP.
final class EventDetailControllerProvider
    extends $AsyncNotifierProvider<EventDetailController, EventDetail> {
  /// The event page header, with optimistic RSVP.
  EventDetailControllerProvider._({
    required EventDetailControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailControllerHash();

  @override
  String toString() {
    return r'eventDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventDetailController create() => EventDetailController();

  @override
  bool operator ==(Object other) {
    return other is EventDetailControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailControllerHash() =>
    r'ddda606284799f85ee817b43cecdefb8868d20a3';

/// The event page header, with optimistic RSVP.

final class EventDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          EventDetailController,
          AsyncValue<EventDetail>,
          EventDetail,
          FutureOr<EventDetail>,
          String
        > {
  EventDetailControllerFamily._()
    : super(
        retry: null,
        name: r'eventDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The event page header, with optimistic RSVP.

  EventDetailControllerProvider call(String eventId) =>
      EventDetailControllerProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventDetailControllerProvider';
}

/// The event page header, with optimistic RSVP.

abstract class _$EventDetailController extends $AsyncNotifier<EventDetail> {
  late final _$args = ref.$arg as String;
  String get eventId => _$args;

  FutureOr<EventDetail> build(String eventId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<EventDetail>, EventDetail>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EventDetail>, EventDetail>,
              AsyncValue<EventDetail>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// The event's post feed, with "load more".

@ProviderFor(EventFeed)
final eventFeedProvider = EventFeedFamily._();

/// The event's post feed, with "load more".
final class EventFeedProvider
    extends $AsyncNotifierProvider<EventFeed, Paginated<EventPost>> {
  /// The event's post feed, with "load more".
  EventFeedProvider._({
    required EventFeedFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventFeedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventFeedHash();

  @override
  String toString() {
    return r'eventFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventFeed create() => EventFeed();

  @override
  bool operator ==(Object other) {
    return other is EventFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventFeedHash() => r'e6fcdae3653b09f42375e396dce272771d6ea981';

/// The event's post feed, with "load more".

final class EventFeedFamily extends $Family
    with
        $ClassFamilyOverride<
          EventFeed,
          AsyncValue<Paginated<EventPost>>,
          Paginated<EventPost>,
          FutureOr<Paginated<EventPost>>,
          String
        > {
  EventFeedFamily._()
    : super(
        retry: null,
        name: r'eventFeedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The event's post feed, with "load more".

  EventFeedProvider call(String eventId) =>
      EventFeedProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventFeedProvider';
}

/// The event's post feed, with "load more".

abstract class _$EventFeed extends $AsyncNotifier<Paginated<EventPost>> {
  late final _$args = ref.$arg as String;
  String get eventId => _$args;

  FutureOr<Paginated<EventPost>> build(String eventId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Paginated<EventPost>>, Paginated<EventPost>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Paginated<EventPost>>,
                Paginated<EventPost>
              >,
              AsyncValue<Paginated<EventPost>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// The create-event stepper's in-progress answers.

@ProviderFor(EventDraftController)
final eventDraftControllerProvider = EventDraftControllerProvider._();

/// The create-event stepper's in-progress answers.
final class EventDraftControllerProvider
    extends $NotifierProvider<EventDraftController, EventDraft> {
  /// The create-event stepper's in-progress answers.
  EventDraftControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventDraftControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventDraftControllerHash();

  @$internal
  @override
  EventDraftController create() => EventDraftController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventDraft>(value),
    );
  }
}

String _$eventDraftControllerHash() =>
    r'43f18c5ec67457e5b9e8e1fe2b8223577e625875';

/// The create-event stepper's in-progress answers.

abstract class _$EventDraftController extends $Notifier<EventDraft> {
  EventDraft build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<EventDraft, EventDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EventDraft, EventDraft>,
              EventDraft,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Submitting the draft. `AsyncData(null)` until an event is created.

@ProviderFor(CreateEvent)
final createEventProvider = CreateEventProvider._();

/// Submitting the draft. `AsyncData(null)` until an event is created.
final class CreateEventProvider
    extends $AsyncNotifierProvider<CreateEvent, Event?> {
  /// Submitting the draft. `AsyncData(null)` until an event is created.
  CreateEventProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createEventProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createEventHash();

  @$internal
  @override
  CreateEvent create() => CreateEvent();
}

String _$createEventHash() => r'7a0200cd80bf2f7bdce42cbb728b450b12912fb7';

/// Submitting the draft. `AsyncData(null)` until an event is created.

abstract class _$CreateEvent extends $AsyncNotifier<Event?> {
  FutureOr<Event?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Event?>, Event?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Event?>, Event?>,
              AsyncValue<Event?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
