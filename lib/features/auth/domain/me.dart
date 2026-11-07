import 'package:freezed_annotation/freezed_annotation.dart';

part 'me.freezed.dart';

/// The signed-in user, with the private fields only they can see.
@freezed
abstract class Me with _$Me {
  const factory Me({
    required String id,
    required String handle,
    required String phone,

    /// Empty for accounts created by a first sign-in.
    @Default('') String displayName,
    String? avatarUrl,

    /// True until the user has set a display name.
    @Default(false) bool needsProfile,

    /// Businesses the user can act as in vendor mode.
    @Default(<MeVendor>[]) List<MeVendor> vendors,
  }) = _Me;
}

@freezed
abstract class MeVendor with _$MeVendor {
  const factory MeVendor({
    required String id,
    required String handle,
    required String name,

    /// `owner` or `staff`.
    required String role,
    String? logoUrl,
  }) = _MeVendor;
}

/// A code was sent. [phone] is the number as the server normalised it
/// (E.164), which is what `verify` must be called with.
@freezed
abstract class OtpChallenge with _$OtpChallenge {
  const factory OtpChallenge({
    required String phone,
    required Duration expiresIn,
  }) = _OtpChallenge;
}
