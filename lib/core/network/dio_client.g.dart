// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fires when the token could not be refreshed. Auth listens and signs out.

@ProviderFor(sessionExpiredEvents)
final sessionExpiredEventsProvider = SessionExpiredEventsProvider._();

/// Fires when the token could not be refreshed. Auth listens and signs out.

final class SessionExpiredEventsProvider
    extends
        $FunctionalProvider<
          Raw<StreamController<void>>,
          Raw<StreamController<void>>,
          Raw<StreamController<void>>
        >
    with $Provider<Raw<StreamController<void>>> {
  /// Fires when the token could not be refreshed. Auth listens and signs out.
  SessionExpiredEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionExpiredEventsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionExpiredEventsHash();

  @$internal
  @override
  $ProviderElement<Raw<StreamController<void>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Raw<StreamController<void>> create(Ref ref) {
    return sessionExpiredEvents(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Raw<StreamController<void>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Raw<StreamController<void>>>(value),
    );
  }
}

String _$sessionExpiredEventsHash() =>
    r'5d63f9814f976a36b3c58384c87040ea566177da';

/// The Dio used by every remote data source.

@ProviderFor(dio)
final dioProvider = DioProvider._();

/// The Dio used by every remote data source.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// The Dio used by every remote data source.
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'8fb3d905b2c451056a7fb9aa49497364e65c3371';
