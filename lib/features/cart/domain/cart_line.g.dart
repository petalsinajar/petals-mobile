// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartLine _$CartLineFromJson(Map<String, dynamic> json) => _CartLine(
  eventId: json['eventId'] as String,
  kind: $enumDecode(_$CartLineKindEnumMap, json['kind']),
  refId: json['refId'] as String,
  title: json['title'] as String,
  priceMinor: (json['priceMinor'] as num).toInt(),
  currency: json['currency'] as String,
  vendorId: json['vendorId'] as String?,
  vendorName: json['vendorName'] as String?,
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$CartLineToJson(_CartLine instance) => <String, dynamic>{
  'eventId': instance.eventId,
  'kind': _$CartLineKindEnumMap[instance.kind]!,
  'refId': instance.refId,
  'title': instance.title,
  'priceMinor': instance.priceMinor,
  'currency': instance.currency,
  'vendorId': instance.vendorId,
  'vendorName': instance.vendorName,
  'quantity': instance.quantity,
};

const _$CartLineKindEnumMap = {
  CartLineKind.package: 'package',
  CartLineKind.item: 'item',
};
