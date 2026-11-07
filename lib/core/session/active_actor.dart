import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_actor.freezed.dart';
part 'active_actor.g.dart';

/// Who the signed-in user is acting as. Lives in core because posting,
/// bookings, vendor mode and the router all need it.
@freezed
sealed class Actor with _$Actor {
  /// Acting as themself.
  const factory Actor.self() = SelfActor;

  /// Acting as a vendor the user belongs to.
  const factory Actor.vendor({
    required String vendorId,
    required String name,
    String? logoUrl,
    String? logoBlurhash,
  }) = VendorActor;
}

@Riverpod(keepAlive: true)
class ActiveActor extends _$ActiveActor {
  @override
  Actor build() => const Actor.self();

  void actAsSelf() => state = const Actor.self();

  void actAsVendor({
    required String vendorId,
    required String name,
    String? logoUrl,
    String? logoBlurhash,
  }) {
    state = Actor.vendor(
      vendorId: vendorId,
      name: name,
      logoUrl: logoUrl,
      logoBlurhash: logoBlurhash,
    );
  }
}
