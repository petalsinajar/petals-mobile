// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartLine {

 String get eventId; CartLineKind get kind;/// The package or item id.
 String get refId; String get title; int get priceMinor; String get currency; String? get vendorId; String? get vendorName; int get quantity;
/// Create a copy of CartLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartLineCopyWith<CartLine> get copyWith => _$CartLineCopyWithImpl<CartLine>(this as CartLine, _$identity);

  /// Serializes this CartLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartLine&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.title, title) || other.title == title)&&(identical(other.priceMinor, priceMinor) || other.priceMinor == priceMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,kind,refId,title,priceMinor,currency,vendorId,vendorName,quantity);

@override
String toString() {
  return 'CartLine(eventId: $eventId, kind: $kind, refId: $refId, title: $title, priceMinor: $priceMinor, currency: $currency, vendorId: $vendorId, vendorName: $vendorName, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $CartLineCopyWith<$Res>  {
  factory $CartLineCopyWith(CartLine value, $Res Function(CartLine) _then) = _$CartLineCopyWithImpl;
@useResult
$Res call({
 String eventId, CartLineKind kind, String refId, String title, int priceMinor, String currency, String? vendorId, String? vendorName, int quantity
});




}
/// @nodoc
class _$CartLineCopyWithImpl<$Res>
    implements $CartLineCopyWith<$Res> {
  _$CartLineCopyWithImpl(this._self, this._then);

  final CartLine _self;
  final $Res Function(CartLine) _then;

/// Create a copy of CartLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? kind = null,Object? refId = null,Object? title = null,Object? priceMinor = null,Object? currency = null,Object? vendorId = freezed,Object? vendorName = freezed,Object? quantity = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CartLineKind,refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priceMinor: null == priceMinor ? _self.priceMinor : priceMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,vendorId: freezed == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String?,vendorName: freezed == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CartLine].
extension CartLinePatterns on CartLine {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartLine() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartLine value)  $default,){
final _that = this;
switch (_that) {
case _CartLine():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartLine value)?  $default,){
final _that = this;
switch (_that) {
case _CartLine() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  CartLineKind kind,  String refId,  String title,  int priceMinor,  String currency,  String? vendorId,  String? vendorName,  int quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartLine() when $default != null:
return $default(_that.eventId,_that.kind,_that.refId,_that.title,_that.priceMinor,_that.currency,_that.vendorId,_that.vendorName,_that.quantity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  CartLineKind kind,  String refId,  String title,  int priceMinor,  String currency,  String? vendorId,  String? vendorName,  int quantity)  $default,) {final _that = this;
switch (_that) {
case _CartLine():
return $default(_that.eventId,_that.kind,_that.refId,_that.title,_that.priceMinor,_that.currency,_that.vendorId,_that.vendorName,_that.quantity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  CartLineKind kind,  String refId,  String title,  int priceMinor,  String currency,  String? vendorId,  String? vendorName,  int quantity)?  $default,) {final _that = this;
switch (_that) {
case _CartLine() when $default != null:
return $default(_that.eventId,_that.kind,_that.refId,_that.title,_that.priceMinor,_that.currency,_that.vendorId,_that.vendorName,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartLine implements CartLine {
  const _CartLine({required this.eventId, required this.kind, required this.refId, required this.title, required this.priceMinor, required this.currency, this.vendorId, this.vendorName, this.quantity = 1});
  factory _CartLine.fromJson(Map<String, dynamic> json) => _$CartLineFromJson(json);

@override final  String eventId;
@override final  CartLineKind kind;
/// The package or item id.
@override final  String refId;
@override final  String title;
@override final  int priceMinor;
@override final  String currency;
@override final  String? vendorId;
@override final  String? vendorName;
@override@JsonKey() final  int quantity;

/// Create a copy of CartLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartLineCopyWith<_CartLine> get copyWith => __$CartLineCopyWithImpl<_CartLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartLine&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.title, title) || other.title == title)&&(identical(other.priceMinor, priceMinor) || other.priceMinor == priceMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,kind,refId,title,priceMinor,currency,vendorId,vendorName,quantity);

@override
String toString() {
  return 'CartLine(eventId: $eventId, kind: $kind, refId: $refId, title: $title, priceMinor: $priceMinor, currency: $currency, vendorId: $vendorId, vendorName: $vendorName, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$CartLineCopyWith<$Res> implements $CartLineCopyWith<$Res> {
  factory _$CartLineCopyWith(_CartLine value, $Res Function(_CartLine) _then) = __$CartLineCopyWithImpl;
@override @useResult
$Res call({
 String eventId, CartLineKind kind, String refId, String title, int priceMinor, String currency, String? vendorId, String? vendorName, int quantity
});




}
/// @nodoc
class __$CartLineCopyWithImpl<$Res>
    implements _$CartLineCopyWith<$Res> {
  __$CartLineCopyWithImpl(this._self, this._then);

  final _CartLine _self;
  final $Res Function(_CartLine) _then;

/// Create a copy of CartLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? kind = null,Object? refId = null,Object? title = null,Object? priceMinor = null,Object? currency = null,Object? vendorId = freezed,Object? vendorName = freezed,Object? quantity = null,}) {
  return _then(_CartLine(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CartLineKind,refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priceMinor: null == priceMinor ? _self.priceMinor : priceMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,vendorId: freezed == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String?,vendorName: freezed == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
