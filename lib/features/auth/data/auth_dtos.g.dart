// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeDto _$MeDtoFromJson(Map<String, dynamic> json) => MeDto(
  id: json['id'] as String,
  handle: json['handle'] as String,
  phone: json['phone'] as String,
  displayName: json['display_name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  needsProfile: json['needs_profile'] as bool? ?? false,
  vendors:
      (json['vendors'] as List<dynamic>?)
          ?.map((e) => MeVendorDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

MeVendorDto _$MeVendorDtoFromJson(Map<String, dynamic> json) => MeVendorDto(
  id: json['id'] as String,
  handle: json['handle'] as String,
  name: json['name'] as String,
  role: json['role'] as String,
  logoUrl: json['logo_url'] as String?,
);
