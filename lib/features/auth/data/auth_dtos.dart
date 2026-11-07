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
    this.needsProfile = false,
    this.vendors = const [],
  });

  factory MeDto.fromJson(Map<String, dynamic> json) => _$MeDtoFromJson(json);

  final String id;
  final String handle;
  final String phone;
  final String? displayName;
  final String? avatarUrl;
  final bool needsProfile;
  final List<MeVendorDto> vendors;

  Me toDomain() => Me(
    id: id,
    handle: handle,
    phone: phone,
    displayName: displayName ?? '',
    avatarUrl: avatarUrl,
    needsProfile: needsProfile,
    vendors: [for (final v in vendors) v.toDomain()],
  );
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
