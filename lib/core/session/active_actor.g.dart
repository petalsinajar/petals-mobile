// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_actor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActiveActor)
final activeActorProvider = ActiveActorProvider._();

final class ActiveActorProvider extends $NotifierProvider<ActiveActor, Actor> {
  ActiveActorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeActorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeActorHash();

  @$internal
  @override
  ActiveActor create() => ActiveActor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Actor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Actor>(value),
    );
  }
}

String _$activeActorHash() => r'1a968f45bd6c3ab973f1797586c18cc77c512585';

abstract class _$ActiveActor extends $Notifier<Actor> {
  Actor build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Actor, Actor>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Actor, Actor>,
              Actor,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
