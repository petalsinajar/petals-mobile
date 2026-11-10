import 'package:json_annotation/json_annotation.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';

part 'auth_dtos.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class MeDto {
  MeDto({
    required this.id,
    required this.handle,
    required this.phone,
    this.displayName,
    this.avatarUrl,
    this.bio,
    this.city,
    this.isPrivate = false,
    this.counts = const {},
    this.settings = const {},
    this.needsProfile = false,
    this.vendors = const [],
  });

  factory MeDto.fromJson(Map<String, dynamic> json) => _$MeDtoFromJson(json);

  final String id;
  final String handle;
  final String phone;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
  final String? city;
  final bool isPrivate;
  final Map<String, int?> counts;

  /// Free-form on the server; the app reads `notify.{push,sms,suggestions}`.
  final Map<String, dynamic> settings;
  final bool needsProfile;
  final List<MeVendorDto> vendors;

  Me toDomain() {
    final notify = settings['notify'] is Map
        ? (settings['notify'] as Map).cast<String, dynamic>()
        : const <String, dynamic>{};
    bool on(String key) => notify[key] != false;
    return Me(
      id: id,
      handle: handle,
      phone: phone,
      displayName: displayName ?? '',
      avatarUrl: (avatarUrl ?? '').isEmpty ? null : avatarUrl,
      bio: (bio ?? '').isEmpty ? null : bio,
      city: (city ?? '').isEmpty ? null : city,
      isPrivate: isPrivate,
      counts: MeCounts(
        followers: counts['followers'] ?? 0,
        following: counts['following'] ?? 0,
        posts: counts['posts'] ?? 0,
      ),
      notify: NotifySettings(
        push: on('push'),
        sms: on('sms'),
        suggestions: on('suggestions'),
      ),
      needsProfile: needsProfile,
      vendors: [for (final v in vendors) v.toDomain()],
    );
  }
}

/// `PATCH /v1/me` body: only what changed; empty text becomes null (cleared).
Map<String, dynamic> profileChangesJson(ProfileChanges c) {
  String? text(String value) => value.trim().isEmpty ? null : value.trim();
  return {
    if (c.displayName case final v?) 'display_name': v.trim(),
    if (c.handle case final v?) 'handle': v.trim(),
    if (c.bio case final v?) 'bio': text(v),
    if (c.city case final v?) 'city': text(v),
    'avatar_media_id': ?c.avatarMediaId,
    'is_private': ?c.isPrivate,
    if (c.notify case final n?)
      'settings': {
        'notify': {'push': n.push, 'sms': n.sms, 'suggestions': n.suggestions},
      },
  };
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class MeVendorDto {
  MeVendorDto({
    required this.id,
    required this.handle,
    required this.name,
    required this.role,
    this.logoUrl,
  });

  factory MeVendorDto.fromJson(Map<String, dynamic> json) =>
      _$MeVendorDtoFromJson(json);

  final String id;
  final String handle;
  final String name;
  final String role;
  final String? logoUrl;

  MeVendor toDomain() => MeVendor(
    id: id,
    handle: handle,
    name: name,
    role: role,
    logoUrl: logoUrl,
  );
}
