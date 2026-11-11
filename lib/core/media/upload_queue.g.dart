// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_queue.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Where queued files are kept; replaceable in tests.

@ProviderFor(uploadDirectory)
final uploadDirectoryProvider = UploadDirectoryProvider._();

/// Where queued files are kept; replaceable in tests.

final class UploadDirectoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Directory>,
          Directory,
          FutureOr<Directory>
        >
    with $FutureModifier<Directory>, $FutureProvider<Directory> {
  /// Where queued files are kept; replaceable in tests.
  UploadDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadDirectoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadDirectoryHash();

  @$internal
  @override
  $FutureProviderElement<Directory> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Directory> create(Ref ref) {
    return uploadDirectory(ref);
  }
}

String _$uploadDirectoryHash() => r'dbfe67dc5790526bd6c696dee1e986fc538961b3';

/// Whether the phone is online, as a stream; replaceable in tests.

@ProviderFor(online)
final onlineProvider = OnlineProvider._();

/// Whether the phone is online, as a stream; replaceable in tests.

final class OnlineProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  /// Whether the phone is online, as a stream; replaceable in tests.
  OnlineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onlineProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onlineHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return online(ref);
  }
}

String _$onlineHash() => r'e940a9ddf8d0deee621e0f0b3752b66db133220b';

/// How long to wait before retry number `attempt`; replaceable in tests.

@ProviderFor(uploadBackoff)
final uploadBackoffProvider = UploadBackoffProvider._();

/// How long to wait before retry number `attempt`; replaceable in tests.

final class UploadBackoffProvider
    extends
        $FunctionalProvider<
          Duration Function(int attempt),
          Duration Function(int attempt),
          Duration Function(int attempt)
        >
    with $Provider<Duration Function(int attempt)> {
  /// How long to wait before retry number `attempt`; replaceable in tests.
  UploadBackoffProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadBackoffProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadBackoffHash();

  @$internal
  @override
  $ProviderElement<Duration Function(int attempt)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Duration Function(int attempt) create(Ref ref) {
    return uploadBackoff(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration Function(int attempt) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration Function(int attempt)>(
        value,
      ),
    );
  }
}

String _$uploadBackoffHash() => r'60d0c2b8150be9b6d114e06d6871f8d0ff92ce06';

/// Uploads that carry on in the background, survive restarts, pause while
/// offline and retry network failures with growing waits. One at a time,
/// oldest first, so a slow phone isn't swamped.

@ProviderFor(UploadQueue)
final uploadQueueProvider = UploadQueueProvider._();

/// Uploads that carry on in the background, survive restarts, pause while
/// offline and retry network failures with growing waits. One at a time,
/// oldest first, so a slow phone isn't swamped.
final class UploadQueueProvider
    extends $NotifierProvider<UploadQueue, List<UploadJob>> {
  /// Uploads that carry on in the background, survive restarts, pause while
  /// offline and retry network failures with growing waits. One at a time,
  /// oldest first, so a slow phone isn't swamped.
  UploadQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadQueueProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadQueueHash();

  @$internal
  @override
  UploadQueue create() => UploadQueue();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UploadJob> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UploadJob>>(value),
    );
  }
}

String _$uploadQueueHash() => r'ee32959c79c24c5a02a208dd60e60db6991ee9c4';

/// Uploads that carry on in the background, survive restarts, pause while
/// offline and retry network failures with growing waits. One at a time,
/// oldest first, so a slow phone isn't swamped.

abstract class _$UploadQueue extends $Notifier<List<UploadJob>> {
  List<UploadJob> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<UploadJob>, List<UploadJob>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<UploadJob>, List<UploadJob>>,
              List<UploadJob>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
