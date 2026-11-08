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
    String? bio,
    String? city,

    /// Only approved followers see their posts.
    @Default(false) bool isPrivate,
    @Default(MeCounts()) MeCounts counts,
    @Default(NotifySettings()) NotifySettings notify,

    /// True until the user has set a display name.
    @Default(false) bool needsProfile,

    /// Businesses the user can act as in vendor mode.
    @Default(<MeVendor>[]) List<MeVendor> vendors,
  }) = _Me;
}

@freezed
abstract class MeCounts with _$MeCounts {
  const factory MeCounts({
    @Default(0) int followers,
    @Default(0) int following,
    @Default(0) int posts,
  }) = _MeCounts;
}

/// Which notifications the user gets. Unset means on, as the server reads
/// `settings.notify.*`.
@freezed
abstract class NotifySettings with _$NotifySettings {
  const factory NotifySettings({
    @Default(true) bool push,
    @Default(true) bool sms,

    /// Vendor suggestions for upcoming events.
    @Default(true) bool suggestions,
  }) = _NotifySettings;
}

/// An edit to the signed-in user's profile. Only the fields that are set
/// are sent; an empty string clears a text field.
@freezed
abstract class ProfileChanges with _$ProfileChanges {
  const factory ProfileChanges({
    String? displayName,
    String? handle,
    String? bio,
    String? city,
    String? avatarUrl,
    bool? isPrivate,
    NotifySettings? notify,
  }) = _ProfileChanges;
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
