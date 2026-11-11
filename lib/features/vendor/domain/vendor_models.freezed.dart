// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Blackout {

 String get id; DateTime get startsOn; DateTime get endsOn; String? get reason;
/// Create a copy of Blackout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlackoutCopyWith<Blackout> get copyWith => _$BlackoutCopyWithImpl<Blackout>(this as Blackout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Blackout&&(identical(other.id, id) || other.id == id)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,id,startsOn,endsOn,reason);

@override
String toString() {
  return 'Blackout(id: $id, startsOn: $startsOn, endsOn: $endsOn, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $BlackoutCopyWith<$Res>  {
  factory $BlackoutCopyWith(Blackout value, $Res Function(Blackout) _then) = _$BlackoutCopyWithImpl;
@useResult
$Res call({
 String id, DateTime startsOn, DateTime endsOn, String? reason
});




}
/// @nodoc
class _$BlackoutCopyWithImpl<$Res>
    implements $BlackoutCopyWith<$Res> {
  _$BlackoutCopyWithImpl(this._self, this._then);

  final Blackout _self;
  final $Res Function(Blackout) _then;

/// Create a copy of Blackout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startsOn = null,Object? endsOn = null,Object? reason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime,endsOn: null == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Blackout].
extension BlackoutPatterns on Blackout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Blackout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Blackout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Blackout value)  $default,){
final _that = this;
switch (_that) {
case _Blackout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Blackout value)?  $default,){
final _that = this;
switch (_that) {
case _Blackout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime startsOn,  DateTime endsOn,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Blackout() when $default != null:
return $default(_that.id,_that.startsOn,_that.endsOn,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime startsOn,  DateTime endsOn,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _Blackout():
return $default(_that.id,_that.startsOn,_that.endsOn,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime startsOn,  DateTime endsOn,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _Blackout() when $default != null:
return $default(_that.id,_that.startsOn,_that.endsOn,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class _Blackout extends Blackout {
  const _Blackout({required this.id, required this.startsOn, required this.endsOn, this.reason}): super._();
  

@override final  String id;
@override final  DateTime startsOn;
@override final  DateTime endsOn;
@override final  String? reason;

/// Create a copy of Blackout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlackoutCopyWith<_Blackout> get copyWith => __$BlackoutCopyWithImpl<_Blackout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Blackout&&(identical(other.id, id) || other.id == id)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,id,startsOn,endsOn,reason);

@override
String toString() {
  return 'Blackout(id: $id, startsOn: $startsOn, endsOn: $endsOn, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$BlackoutCopyWith<$Res> implements $BlackoutCopyWith<$Res> {
  factory _$BlackoutCopyWith(_Blackout value, $Res Function(_Blackout) _then) = __$BlackoutCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime startsOn, DateTime endsOn, String? reason
});




}
/// @nodoc
class __$BlackoutCopyWithImpl<$Res>
    implements _$BlackoutCopyWith<$Res> {
  __$BlackoutCopyWithImpl(this._self, this._then);

  final _Blackout _self;
  final $Res Function(_Blackout) _then;

/// Create a copy of Blackout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startsOn = null,Object? endsOn = null,Object? reason = freezed,}) {
  return _then(_Blackout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime,endsOn: null == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$VendorBookingLine {

 String get title; int get qty;
/// Create a copy of VendorBookingLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorBookingLineCopyWith<VendorBookingLine> get copyWith => _$VendorBookingLineCopyWithImpl<VendorBookingLine>(this as VendorBookingLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorBookingLine&&(identical(other.title, title) || other.title == title)&&(identical(other.qty, qty) || other.qty == qty));
}


@override
int get hashCode => Object.hash(runtimeType,title,qty);

@override
String toString() {
  return 'VendorBookingLine(title: $title, qty: $qty)';
}


}

/// @nodoc
abstract mixin class $VendorBookingLineCopyWith<$Res>  {
  factory $VendorBookingLineCopyWith(VendorBookingLine value, $Res Function(VendorBookingLine) _then) = _$VendorBookingLineCopyWithImpl;
@useResult
$Res call({
 String title, int qty
});




}
/// @nodoc
class _$VendorBookingLineCopyWithImpl<$Res>
    implements $VendorBookingLineCopyWith<$Res> {
  _$VendorBookingLineCopyWithImpl(this._self, this._then);

  final VendorBookingLine _self;
  final $Res Function(VendorBookingLine) _then;

/// Create a copy of VendorBookingLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? qty = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorBookingLine].
extension VendorBookingLinePatterns on VendorBookingLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorBookingLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorBookingLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorBookingLine value)  $default,){
final _that = this;
switch (_that) {
case _VendorBookingLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorBookingLine value)?  $default,){
final _that = this;
switch (_that) {
case _VendorBookingLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  int qty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorBookingLine() when $default != null:
return $default(_that.title,_that.qty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  int qty)  $default,) {final _that = this;
switch (_that) {
case _VendorBookingLine():
return $default(_that.title,_that.qty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  int qty)?  $default,) {final _that = this;
switch (_that) {
case _VendorBookingLine() when $default != null:
return $default(_that.title,_that.qty);case _:
  return null;

}
}

}

/// @nodoc


class _VendorBookingLine implements VendorBookingLine {
  const _VendorBookingLine({required this.title, required this.qty});
  

@override final  String title;
@override final  int qty;

/// Create a copy of VendorBookingLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorBookingLineCopyWith<_VendorBookingLine> get copyWith => __$VendorBookingLineCopyWithImpl<_VendorBookingLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorBookingLine&&(identical(other.title, title) || other.title == title)&&(identical(other.qty, qty) || other.qty == qty));
}


@override
int get hashCode => Object.hash(runtimeType,title,qty);

@override
String toString() {
  return 'VendorBookingLine(title: $title, qty: $qty)';
}


}

/// @nodoc
abstract mixin class _$VendorBookingLineCopyWith<$Res> implements $VendorBookingLineCopyWith<$Res> {
  factory _$VendorBookingLineCopyWith(_VendorBookingLine value, $Res Function(_VendorBookingLine) _then) = __$VendorBookingLineCopyWithImpl;
@override @useResult
$Res call({
 String title, int qty
});




}
/// @nodoc
class __$VendorBookingLineCopyWithImpl<$Res>
    implements _$VendorBookingLineCopyWith<$Res> {
  __$VendorBookingLineCopyWithImpl(this._self, this._then);

  final _VendorBookingLine _self;
  final $Res Function(_VendorBookingLine) _then;

/// Create a copy of VendorBookingLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? qty = null,}) {
  return _then(_VendorBookingLine(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$VendorBooking {

 String get id; String get number; VendorBookingStatus get status; DateTime get startsAt; DateTime get endsAt; int get totalMinor; String get currency; String get customerName; String? get customerAvatarUrl; List<VendorBookingLine> get lines;/// After this, an unanswered request expires.
 DateTime? get respondBy;/// `delivery` or `pickup`.
 String? get fulfilment; String? get customerNote;/// Recorded by the vendor for a booking made outside the app.
 bool get recorded;/// Only on recorded bookings: the number the vendor took down.
 String? get customerPhone;/// Where to deliver (delivery bookings).
 String? get address;/// Who to call on the day: the customer's phone on recorded bookings,
/// else the contact given at checkout.
 String? get contactPhone;
/// Create a copy of VendorBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorBookingCopyWith<VendorBooking> get copyWith => _$VendorBookingCopyWithImpl<VendorBooking>(this as VendorBooking, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerAvatarUrl, customerAvatarUrl) || other.customerAvatarUrl == customerAvatarUrl)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.respondBy, respondBy) || other.respondBy == respondBy)&&(identical(other.fulfilment, fulfilment) || other.fulfilment == fulfilment)&&(identical(other.customerNote, customerNote) || other.customerNote == customerNote)&&(identical(other.recorded, recorded) || other.recorded == recorded)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,status,startsAt,endsAt,totalMinor,currency,customerName,customerAvatarUrl,const DeepCollectionEquality().hash(lines),respondBy,fulfilment,customerNote,recorded,customerPhone,address,contactPhone);

@override
String toString() {
  return 'VendorBooking(id: $id, number: $number, status: $status, startsAt: $startsAt, endsAt: $endsAt, totalMinor: $totalMinor, currency: $currency, customerName: $customerName, customerAvatarUrl: $customerAvatarUrl, lines: $lines, respondBy: $respondBy, fulfilment: $fulfilment, customerNote: $customerNote, recorded: $recorded, customerPhone: $customerPhone, address: $address, contactPhone: $contactPhone)';
}


}

/// @nodoc
abstract mixin class $VendorBookingCopyWith<$Res>  {
  factory $VendorBookingCopyWith(VendorBooking value, $Res Function(VendorBooking) _then) = _$VendorBookingCopyWithImpl;
@useResult
$Res call({
 String id, String number, VendorBookingStatus status, DateTime startsAt, DateTime endsAt, int totalMinor, String currency, String customerName, String? customerAvatarUrl, List<VendorBookingLine> lines, DateTime? respondBy, String? fulfilment, String? customerNote, bool recorded, String? customerPhone, String? address, String? contactPhone
});




}
/// @nodoc
class _$VendorBookingCopyWithImpl<$Res>
    implements $VendorBookingCopyWith<$Res> {
  _$VendorBookingCopyWithImpl(this._self, this._then);

  final VendorBooking _self;
  final $Res Function(VendorBooking) _then;

/// Create a copy of VendorBooking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? status = null,Object? startsAt = null,Object? endsAt = null,Object? totalMinor = null,Object? currency = null,Object? customerName = null,Object? customerAvatarUrl = freezed,Object? lines = null,Object? respondBy = freezed,Object? fulfilment = freezed,Object? customerNote = freezed,Object? recorded = null,Object? customerPhone = freezed,Object? address = freezed,Object? contactPhone = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VendorBookingStatus,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerAvatarUrl: freezed == customerAvatarUrl ? _self.customerAvatarUrl : customerAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<VendorBookingLine>,respondBy: freezed == respondBy ? _self.respondBy : respondBy // ignore: cast_nullable_to_non_nullable
as DateTime?,fulfilment: freezed == fulfilment ? _self.fulfilment : fulfilment // ignore: cast_nullable_to_non_nullable
as String?,customerNote: freezed == customerNote ? _self.customerNote : customerNote // ignore: cast_nullable_to_non_nullable
as String?,recorded: null == recorded ? _self.recorded : recorded // ignore: cast_nullable_to_non_nullable
as bool,customerPhone: freezed == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorBooking].
extension VendorBookingPatterns on VendorBooking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorBooking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorBooking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorBooking value)  $default,){
final _that = this;
switch (_that) {
case _VendorBooking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorBooking value)?  $default,){
final _that = this;
switch (_that) {
case _VendorBooking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String number,  VendorBookingStatus status,  DateTime startsAt,  DateTime endsAt,  int totalMinor,  String currency,  String customerName,  String? customerAvatarUrl,  List<VendorBookingLine> lines,  DateTime? respondBy,  String? fulfilment,  String? customerNote,  bool recorded,  String? customerPhone,  String? address,  String? contactPhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorBooking() when $default != null:
return $default(_that.id,_that.number,_that.status,_that.startsAt,_that.endsAt,_that.totalMinor,_that.currency,_that.customerName,_that.customerAvatarUrl,_that.lines,_that.respondBy,_that.fulfilment,_that.customerNote,_that.recorded,_that.customerPhone,_that.address,_that.contactPhone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String number,  VendorBookingStatus status,  DateTime startsAt,  DateTime endsAt,  int totalMinor,  String currency,  String customerName,  String? customerAvatarUrl,  List<VendorBookingLine> lines,  DateTime? respondBy,  String? fulfilment,  String? customerNote,  bool recorded,  String? customerPhone,  String? address,  String? contactPhone)  $default,) {final _that = this;
switch (_that) {
case _VendorBooking():
return $default(_that.id,_that.number,_that.status,_that.startsAt,_that.endsAt,_that.totalMinor,_that.currency,_that.customerName,_that.customerAvatarUrl,_that.lines,_that.respondBy,_that.fulfilment,_that.customerNote,_that.recorded,_that.customerPhone,_that.address,_that.contactPhone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String number,  VendorBookingStatus status,  DateTime startsAt,  DateTime endsAt,  int totalMinor,  String currency,  String customerName,  String? customerAvatarUrl,  List<VendorBookingLine> lines,  DateTime? respondBy,  String? fulfilment,  String? customerNote,  bool recorded,  String? customerPhone,  String? address,  String? contactPhone)?  $default,) {final _that = this;
switch (_that) {
case _VendorBooking() when $default != null:
return $default(_that.id,_that.number,_that.status,_that.startsAt,_that.endsAt,_that.totalMinor,_that.currency,_that.customerName,_that.customerAvatarUrl,_that.lines,_that.respondBy,_that.fulfilment,_that.customerNote,_that.recorded,_that.customerPhone,_that.address,_that.contactPhone);case _:
  return null;

}
}

}

/// @nodoc


class _VendorBooking implements VendorBooking {
  const _VendorBooking({required this.id, required this.number, required this.status, required this.startsAt, required this.endsAt, required this.totalMinor, required this.currency, this.customerName = 'A customer', this.customerAvatarUrl, final  List<VendorBookingLine> lines = const <VendorBookingLine>[], this.respondBy, this.fulfilment, this.customerNote, this.recorded = false, this.customerPhone, this.address, this.contactPhone}): _lines = lines;
  

@override final  String id;
@override final  String number;
@override final  VendorBookingStatus status;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  int totalMinor;
@override final  String currency;
@override@JsonKey() final  String customerName;
@override final  String? customerAvatarUrl;
 final  List<VendorBookingLine> _lines;
@override@JsonKey() List<VendorBookingLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

/// After this, an unanswered request expires.
@override final  DateTime? respondBy;
/// `delivery` or `pickup`.
@override final  String? fulfilment;
@override final  String? customerNote;
/// Recorded by the vendor for a booking made outside the app.
@override@JsonKey() final  bool recorded;
/// Only on recorded bookings: the number the vendor took down.
@override final  String? customerPhone;
/// Where to deliver (delivery bookings).
@override final  String? address;
/// Who to call on the day: the customer's phone on recorded bookings,
/// else the contact given at checkout.
@override final  String? contactPhone;

/// Create a copy of VendorBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorBookingCopyWith<_VendorBooking> get copyWith => __$VendorBookingCopyWithImpl<_VendorBooking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerAvatarUrl, customerAvatarUrl) || other.customerAvatarUrl == customerAvatarUrl)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.respondBy, respondBy) || other.respondBy == respondBy)&&(identical(other.fulfilment, fulfilment) || other.fulfilment == fulfilment)&&(identical(other.customerNote, customerNote) || other.customerNote == customerNote)&&(identical(other.recorded, recorded) || other.recorded == recorded)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,status,startsAt,endsAt,totalMinor,currency,customerName,customerAvatarUrl,const DeepCollectionEquality().hash(_lines),respondBy,fulfilment,customerNote,recorded,customerPhone,address,contactPhone);

@override
String toString() {
  return 'VendorBooking(id: $id, number: $number, status: $status, startsAt: $startsAt, endsAt: $endsAt, totalMinor: $totalMinor, currency: $currency, customerName: $customerName, customerAvatarUrl: $customerAvatarUrl, lines: $lines, respondBy: $respondBy, fulfilment: $fulfilment, customerNote: $customerNote, recorded: $recorded, customerPhone: $customerPhone, address: $address, contactPhone: $contactPhone)';
}


}

/// @nodoc
abstract mixin class _$VendorBookingCopyWith<$Res> implements $VendorBookingCopyWith<$Res> {
  factory _$VendorBookingCopyWith(_VendorBooking value, $Res Function(_VendorBooking) _then) = __$VendorBookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String number, VendorBookingStatus status, DateTime startsAt, DateTime endsAt, int totalMinor, String currency, String customerName, String? customerAvatarUrl, List<VendorBookingLine> lines, DateTime? respondBy, String? fulfilment, String? customerNote, bool recorded, String? customerPhone, String? address, String? contactPhone
});




}
/// @nodoc
class __$VendorBookingCopyWithImpl<$Res>
    implements _$VendorBookingCopyWith<$Res> {
  __$VendorBookingCopyWithImpl(this._self, this._then);

  final _VendorBooking _self;
  final $Res Function(_VendorBooking) _then;

/// Create a copy of VendorBooking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? status = null,Object? startsAt = null,Object? endsAt = null,Object? totalMinor = null,Object? currency = null,Object? customerName = null,Object? customerAvatarUrl = freezed,Object? lines = null,Object? respondBy = freezed,Object? fulfilment = freezed,Object? customerNote = freezed,Object? recorded = null,Object? customerPhone = freezed,Object? address = freezed,Object? contactPhone = freezed,}) {
  return _then(_VendorBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VendorBookingStatus,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerAvatarUrl: freezed == customerAvatarUrl ? _self.customerAvatarUrl : customerAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<VendorBookingLine>,respondBy: freezed == respondBy ? _self.respondBy : respondBy // ignore: cast_nullable_to_non_nullable
as DateTime?,fulfilment: freezed == fulfilment ? _self.fulfilment : fulfilment // ignore: cast_nullable_to_non_nullable
as String?,customerNote: freezed == customerNote ? _self.customerNote : customerNote // ignore: cast_nullable_to_non_nullable
as String?,recorded: null == recorded ? _self.recorded : recorded // ignore: cast_nullable_to_non_nullable
as bool,customerPhone: freezed == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$RecordedLine {

 String get itemId; String get variantId; int get qty;
/// Create a copy of RecordedLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordedLineCopyWith<RecordedLine> get copyWith => _$RecordedLineCopyWithImpl<RecordedLine>(this as RecordedLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordedLine&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.qty, qty) || other.qty == qty));
}


@override
int get hashCode => Object.hash(runtimeType,itemId,variantId,qty);

@override
String toString() {
  return 'RecordedLine(itemId: $itemId, variantId: $variantId, qty: $qty)';
}


}

/// @nodoc
abstract mixin class $RecordedLineCopyWith<$Res>  {
  factory $RecordedLineCopyWith(RecordedLine value, $Res Function(RecordedLine) _then) = _$RecordedLineCopyWithImpl;
@useResult
$Res call({
 String itemId, String variantId, int qty
});




}
/// @nodoc
class _$RecordedLineCopyWithImpl<$Res>
    implements $RecordedLineCopyWith<$Res> {
  _$RecordedLineCopyWithImpl(this._self, this._then);

  final RecordedLine _self;
  final $Res Function(RecordedLine) _then;

/// Create a copy of RecordedLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemId = null,Object? variantId = null,Object? qty = null,}) {
  return _then(_self.copyWith(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,variantId: null == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as String,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RecordedLine].
extension RecordedLinePatterns on RecordedLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecordedLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecordedLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecordedLine value)  $default,){
final _that = this;
switch (_that) {
case _RecordedLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecordedLine value)?  $default,){
final _that = this;
switch (_that) {
case _RecordedLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String itemId,  String variantId,  int qty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecordedLine() when $default != null:
return $default(_that.itemId,_that.variantId,_that.qty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String itemId,  String variantId,  int qty)  $default,) {final _that = this;
switch (_that) {
case _RecordedLine():
return $default(_that.itemId,_that.variantId,_that.qty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String itemId,  String variantId,  int qty)?  $default,) {final _that = this;
switch (_that) {
case _RecordedLine() when $default != null:
return $default(_that.itemId,_that.variantId,_that.qty);case _:
  return null;

}
}

}

/// @nodoc


class _RecordedLine implements RecordedLine {
  const _RecordedLine({required this.itemId, required this.variantId, required this.qty});
  

@override final  String itemId;
@override final  String variantId;
@override final  int qty;

/// Create a copy of RecordedLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordedLineCopyWith<_RecordedLine> get copyWith => __$RecordedLineCopyWithImpl<_RecordedLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecordedLine&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.qty, qty) || other.qty == qty));
}


@override
int get hashCode => Object.hash(runtimeType,itemId,variantId,qty);

@override
String toString() {
  return 'RecordedLine(itemId: $itemId, variantId: $variantId, qty: $qty)';
}


}

/// @nodoc
abstract mixin class _$RecordedLineCopyWith<$Res> implements $RecordedLineCopyWith<$Res> {
  factory _$RecordedLineCopyWith(_RecordedLine value, $Res Function(_RecordedLine) _then) = __$RecordedLineCopyWithImpl;
@override @useResult
$Res call({
 String itemId, String variantId, int qty
});




}
/// @nodoc
class __$RecordedLineCopyWithImpl<$Res>
    implements _$RecordedLineCopyWith<$Res> {
  __$RecordedLineCopyWithImpl(this._self, this._then);

  final _RecordedLine _self;
  final $Res Function(_RecordedLine) _then;

/// Create a copy of RecordedLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemId = null,Object? variantId = null,Object? qty = null,}) {
  return _then(_RecordedLine(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,variantId: null == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as String,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$RecordedBooking {

 String get customerName; String get customerPhone; DateTime get startsAt; DateTime get endsAt; List<RecordedLine> get lines; bool get delivery; String? get address; int get deliveryFeeMinor;/// Already received from the customer, outside the app.
 int get paidMinor;/// Only the business's team sees it.
 String? get note;
/// Create a copy of RecordedBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordedBookingCopyWith<RecordedBooking> get copyWith => _$RecordedBookingCopyWithImpl<RecordedBooking>(this as RecordedBooking, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordedBooking&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.delivery, delivery) || other.delivery == delivery)&&(identical(other.address, address) || other.address == address)&&(identical(other.deliveryFeeMinor, deliveryFeeMinor) || other.deliveryFeeMinor == deliveryFeeMinor)&&(identical(other.paidMinor, paidMinor) || other.paidMinor == paidMinor)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,customerName,customerPhone,startsAt,endsAt,const DeepCollectionEquality().hash(lines),delivery,address,deliveryFeeMinor,paidMinor,note);

@override
String toString() {
  return 'RecordedBooking(customerName: $customerName, customerPhone: $customerPhone, startsAt: $startsAt, endsAt: $endsAt, lines: $lines, delivery: $delivery, address: $address, deliveryFeeMinor: $deliveryFeeMinor, paidMinor: $paidMinor, note: $note)';
}


}

/// @nodoc
abstract mixin class $RecordedBookingCopyWith<$Res>  {
  factory $RecordedBookingCopyWith(RecordedBooking value, $Res Function(RecordedBooking) _then) = _$RecordedBookingCopyWithImpl;
@useResult
$Res call({
 String customerName, String customerPhone, DateTime startsAt, DateTime endsAt, List<RecordedLine> lines, bool delivery, String? address, int deliveryFeeMinor, int paidMinor, String? note
});




}
/// @nodoc
class _$RecordedBookingCopyWithImpl<$Res>
    implements $RecordedBookingCopyWith<$Res> {
  _$RecordedBookingCopyWithImpl(this._self, this._then);

  final RecordedBooking _self;
  final $Res Function(RecordedBooking) _then;

/// Create a copy of RecordedBooking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerName = null,Object? customerPhone = null,Object? startsAt = null,Object? endsAt = null,Object? lines = null,Object? delivery = null,Object? address = freezed,Object? deliveryFeeMinor = null,Object? paidMinor = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<RecordedLine>,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as bool,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,deliveryFeeMinor: null == deliveryFeeMinor ? _self.deliveryFeeMinor : deliveryFeeMinor // ignore: cast_nullable_to_non_nullable
as int,paidMinor: null == paidMinor ? _self.paidMinor : paidMinor // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecordedBooking].
extension RecordedBookingPatterns on RecordedBooking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecordedBooking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecordedBooking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecordedBooking value)  $default,){
final _that = this;
switch (_that) {
case _RecordedBooking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecordedBooking value)?  $default,){
final _that = this;
switch (_that) {
case _RecordedBooking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String customerName,  String customerPhone,  DateTime startsAt,  DateTime endsAt,  List<RecordedLine> lines,  bool delivery,  String? address,  int deliveryFeeMinor,  int paidMinor,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecordedBooking() when $default != null:
return $default(_that.customerName,_that.customerPhone,_that.startsAt,_that.endsAt,_that.lines,_that.delivery,_that.address,_that.deliveryFeeMinor,_that.paidMinor,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String customerName,  String customerPhone,  DateTime startsAt,  DateTime endsAt,  List<RecordedLine> lines,  bool delivery,  String? address,  int deliveryFeeMinor,  int paidMinor,  String? note)  $default,) {final _that = this;
switch (_that) {
case _RecordedBooking():
return $default(_that.customerName,_that.customerPhone,_that.startsAt,_that.endsAt,_that.lines,_that.delivery,_that.address,_that.deliveryFeeMinor,_that.paidMinor,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String customerName,  String customerPhone,  DateTime startsAt,  DateTime endsAt,  List<RecordedLine> lines,  bool delivery,  String? address,  int deliveryFeeMinor,  int paidMinor,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _RecordedBooking() when $default != null:
return $default(_that.customerName,_that.customerPhone,_that.startsAt,_that.endsAt,_that.lines,_that.delivery,_that.address,_that.deliveryFeeMinor,_that.paidMinor,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _RecordedBooking implements RecordedBooking {
  const _RecordedBooking({required this.customerName, required this.customerPhone, required this.startsAt, required this.endsAt, required final  List<RecordedLine> lines, this.delivery = false, this.address, this.deliveryFeeMinor = 0, this.paidMinor = 0, this.note}): _lines = lines;
  

@override final  String customerName;
@override final  String customerPhone;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
 final  List<RecordedLine> _lines;
@override List<RecordedLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override@JsonKey() final  bool delivery;
@override final  String? address;
@override@JsonKey() final  int deliveryFeeMinor;
/// Already received from the customer, outside the app.
@override@JsonKey() final  int paidMinor;
/// Only the business's team sees it.
@override final  String? note;

/// Create a copy of RecordedBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordedBookingCopyWith<_RecordedBooking> get copyWith => __$RecordedBookingCopyWithImpl<_RecordedBooking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecordedBooking&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.delivery, delivery) || other.delivery == delivery)&&(identical(other.address, address) || other.address == address)&&(identical(other.deliveryFeeMinor, deliveryFeeMinor) || other.deliveryFeeMinor == deliveryFeeMinor)&&(identical(other.paidMinor, paidMinor) || other.paidMinor == paidMinor)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,customerName,customerPhone,startsAt,endsAt,const DeepCollectionEquality().hash(_lines),delivery,address,deliveryFeeMinor,paidMinor,note);

@override
String toString() {
  return 'RecordedBooking(customerName: $customerName, customerPhone: $customerPhone, startsAt: $startsAt, endsAt: $endsAt, lines: $lines, delivery: $delivery, address: $address, deliveryFeeMinor: $deliveryFeeMinor, paidMinor: $paidMinor, note: $note)';
}


}

/// @nodoc
abstract mixin class _$RecordedBookingCopyWith<$Res> implements $RecordedBookingCopyWith<$Res> {
  factory _$RecordedBookingCopyWith(_RecordedBooking value, $Res Function(_RecordedBooking) _then) = __$RecordedBookingCopyWithImpl;
@override @useResult
$Res call({
 String customerName, String customerPhone, DateTime startsAt, DateTime endsAt, List<RecordedLine> lines, bool delivery, String? address, int deliveryFeeMinor, int paidMinor, String? note
});




}
/// @nodoc
class __$RecordedBookingCopyWithImpl<$Res>
    implements _$RecordedBookingCopyWith<$Res> {
  __$RecordedBookingCopyWithImpl(this._self, this._then);

  final _RecordedBooking _self;
  final $Res Function(_RecordedBooking) _then;

/// Create a copy of RecordedBooking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerName = null,Object? customerPhone = null,Object? startsAt = null,Object? endsAt = null,Object? lines = null,Object? delivery = null,Object? address = freezed,Object? deliveryFeeMinor = null,Object? paidMinor = null,Object? note = freezed,}) {
  return _then(_RecordedBooking(
customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<RecordedLine>,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as bool,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,deliveryFeeMinor: null == deliveryFeeMinor ? _self.deliveryFeeMinor : deliveryFeeMinor // ignore: cast_nullable_to_non_nullable
as int,paidMinor: null == paidMinor ? _self.paidMinor : paidMinor // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$BusinessCategory {

 String get id; String get name;
/// Create a copy of BusinessCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessCategoryCopyWith<BusinessCategory> get copyWith => _$BusinessCategoryCopyWithImpl<BusinessCategory>(this as BusinessCategory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'BusinessCategory(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $BusinessCategoryCopyWith<$Res>  {
  factory $BusinessCategoryCopyWith(BusinessCategory value, $Res Function(BusinessCategory) _then) = _$BusinessCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$BusinessCategoryCopyWithImpl<$Res>
    implements $BusinessCategoryCopyWith<$Res> {
  _$BusinessCategoryCopyWithImpl(this._self, this._then);

  final BusinessCategory _self;
  final $Res Function(BusinessCategory) _then;

/// Create a copy of BusinessCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessCategory].
extension BusinessCategoryPatterns on BusinessCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessCategory value)  $default,){
final _that = this;
switch (_that) {
case _BusinessCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessCategory value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessCategory() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _BusinessCategory():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _BusinessCategory() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _BusinessCategory implements BusinessCategory {
  const _BusinessCategory({required this.id, required this.name});
  

@override final  String id;
@override final  String name;

/// Create a copy of BusinessCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessCategoryCopyWith<_BusinessCategory> get copyWith => __$BusinessCategoryCopyWithImpl<_BusinessCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'BusinessCategory(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$BusinessCategoryCopyWith<$Res> implements $BusinessCategoryCopyWith<$Res> {
  factory _$BusinessCategoryCopyWith(_BusinessCategory value, $Res Function(_BusinessCategory) _then) = __$BusinessCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$BusinessCategoryCopyWithImpl<$Res>
    implements _$BusinessCategoryCopyWith<$Res> {
  __$BusinessCategoryCopyWithImpl(this._self, this._then);

  final _BusinessCategory _self;
  final $Res Function(_BusinessCategory) _then;

/// Create a copy of BusinessCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_BusinessCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$NewBusiness {

 String get name; String get handle; String? get city; List<String> get categoryIds;/// wedding, birthday, corporate, other.
 List<String> get eventTypes;
/// Create a copy of NewBusiness
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewBusinessCopyWith<NewBusiness> get copyWith => _$NewBusinessCopyWithImpl<NewBusiness>(this as NewBusiness, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewBusiness&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other.categoryIds, categoryIds)&&const DeepCollectionEquality().equals(other.eventTypes, eventTypes));
}


@override
int get hashCode => Object.hash(runtimeType,name,handle,city,const DeepCollectionEquality().hash(categoryIds),const DeepCollectionEquality().hash(eventTypes));

@override
String toString() {
  return 'NewBusiness(name: $name, handle: $handle, city: $city, categoryIds: $categoryIds, eventTypes: $eventTypes)';
}


}

/// @nodoc
abstract mixin class $NewBusinessCopyWith<$Res>  {
  factory $NewBusinessCopyWith(NewBusiness value, $Res Function(NewBusiness) _then) = _$NewBusinessCopyWithImpl;
@useResult
$Res call({
 String name, String handle, String? city, List<String> categoryIds, List<String> eventTypes
});




}
/// @nodoc
class _$NewBusinessCopyWithImpl<$Res>
    implements $NewBusinessCopyWith<$Res> {
  _$NewBusinessCopyWithImpl(this._self, this._then);

  final NewBusiness _self;
  final $Res Function(NewBusiness) _then;

/// Create a copy of NewBusiness
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? handle = null,Object? city = freezed,Object? categoryIds = null,Object? eventTypes = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,eventTypes: null == eventTypes ? _self.eventTypes : eventTypes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [NewBusiness].
extension NewBusinessPatterns on NewBusiness {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewBusiness value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewBusiness() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewBusiness value)  $default,){
final _that = this;
switch (_that) {
case _NewBusiness():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewBusiness value)?  $default,){
final _that = this;
switch (_that) {
case _NewBusiness() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String handle,  String? city,  List<String> categoryIds,  List<String> eventTypes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewBusiness() when $default != null:
return $default(_that.name,_that.handle,_that.city,_that.categoryIds,_that.eventTypes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String handle,  String? city,  List<String> categoryIds,  List<String> eventTypes)  $default,) {final _that = this;
switch (_that) {
case _NewBusiness():
return $default(_that.name,_that.handle,_that.city,_that.categoryIds,_that.eventTypes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String handle,  String? city,  List<String> categoryIds,  List<String> eventTypes)?  $default,) {final _that = this;
switch (_that) {
case _NewBusiness() when $default != null:
return $default(_that.name,_that.handle,_that.city,_that.categoryIds,_that.eventTypes);case _:
  return null;

}
}

}

/// @nodoc


class _NewBusiness implements NewBusiness {
  const _NewBusiness({required this.name, required this.handle, this.city, final  List<String> categoryIds = const <String>[], final  List<String> eventTypes = const <String>[]}): _categoryIds = categoryIds,_eventTypes = eventTypes;
  

@override final  String name;
@override final  String handle;
@override final  String? city;
 final  List<String> _categoryIds;
@override@JsonKey() List<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryIds);
}

/// wedding, birthday, corporate, other.
 final  List<String> _eventTypes;
/// wedding, birthday, corporate, other.
@override@JsonKey() List<String> get eventTypes {
  if (_eventTypes is EqualUnmodifiableListView) return _eventTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventTypes);
}


/// Create a copy of NewBusiness
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewBusinessCopyWith<_NewBusiness> get copyWith => __$NewBusinessCopyWithImpl<_NewBusiness>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewBusiness&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other._categoryIds, _categoryIds)&&const DeepCollectionEquality().equals(other._eventTypes, _eventTypes));
}


@override
int get hashCode => Object.hash(runtimeType,name,handle,city,const DeepCollectionEquality().hash(_categoryIds),const DeepCollectionEquality().hash(_eventTypes));

@override
String toString() {
  return 'NewBusiness(name: $name, handle: $handle, city: $city, categoryIds: $categoryIds, eventTypes: $eventTypes)';
}


}

/// @nodoc
abstract mixin class _$NewBusinessCopyWith<$Res> implements $NewBusinessCopyWith<$Res> {
  factory _$NewBusinessCopyWith(_NewBusiness value, $Res Function(_NewBusiness) _then) = __$NewBusinessCopyWithImpl;
@override @useResult
$Res call({
 String name, String handle, String? city, List<String> categoryIds, List<String> eventTypes
});




}
/// @nodoc
class __$NewBusinessCopyWithImpl<$Res>
    implements _$NewBusinessCopyWith<$Res> {
  __$NewBusinessCopyWithImpl(this._self, this._then);

  final _NewBusiness _self;
  final $Res Function(_NewBusiness) _then;

/// Create a copy of NewBusiness
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? handle = null,Object? city = freezed,Object? categoryIds = null,Object? eventTypes = null,}) {
  return _then(_NewBusiness(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,eventTypes: null == eventTypes ? _self._eventTypes : eventTypes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$CreatedBusiness {

 String get id; String get handle; String get name; String? get logoUrl;
/// Create a copy of CreatedBusiness
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatedBusinessCopyWith<CreatedBusiness> get copyWith => _$CreatedBusinessCopyWithImpl<CreatedBusiness>(this as CreatedBusiness, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatedBusiness&&(identical(other.id, id) || other.id == id)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,handle,name,logoUrl);

@override
String toString() {
  return 'CreatedBusiness(id: $id, handle: $handle, name: $name, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class $CreatedBusinessCopyWith<$Res>  {
  factory $CreatedBusinessCopyWith(CreatedBusiness value, $Res Function(CreatedBusiness) _then) = _$CreatedBusinessCopyWithImpl;
@useResult
$Res call({
 String id, String handle, String name, String? logoUrl
});




}
/// @nodoc
class _$CreatedBusinessCopyWithImpl<$Res>
    implements $CreatedBusinessCopyWith<$Res> {
  _$CreatedBusinessCopyWithImpl(this._self, this._then);

  final CreatedBusiness _self;
  final $Res Function(CreatedBusiness) _then;

/// Create a copy of CreatedBusiness
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? handle = null,Object? name = null,Object? logoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatedBusiness].
extension CreatedBusinessPatterns on CreatedBusiness {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatedBusiness value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatedBusiness() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatedBusiness value)  $default,){
final _that = this;
switch (_that) {
case _CreatedBusiness():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatedBusiness value)?  $default,){
final _that = this;
switch (_that) {
case _CreatedBusiness() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String handle,  String name,  String? logoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatedBusiness() when $default != null:
return $default(_that.id,_that.handle,_that.name,_that.logoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String handle,  String name,  String? logoUrl)  $default,) {final _that = this;
switch (_that) {
case _CreatedBusiness():
return $default(_that.id,_that.handle,_that.name,_that.logoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String handle,  String name,  String? logoUrl)?  $default,) {final _that = this;
switch (_that) {
case _CreatedBusiness() when $default != null:
return $default(_that.id,_that.handle,_that.name,_that.logoUrl);case _:
  return null;

}
}

}

/// @nodoc


class _CreatedBusiness implements CreatedBusiness {
  const _CreatedBusiness({required this.id, required this.handle, required this.name, this.logoUrl});
  

@override final  String id;
@override final  String handle;
@override final  String name;
@override final  String? logoUrl;

/// Create a copy of CreatedBusiness
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedBusinessCopyWith<_CreatedBusiness> get copyWith => __$CreatedBusinessCopyWithImpl<_CreatedBusiness>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedBusiness&&(identical(other.id, id) || other.id == id)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,handle,name,logoUrl);

@override
String toString() {
  return 'CreatedBusiness(id: $id, handle: $handle, name: $name, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class _$CreatedBusinessCopyWith<$Res> implements $CreatedBusinessCopyWith<$Res> {
  factory _$CreatedBusinessCopyWith(_CreatedBusiness value, $Res Function(_CreatedBusiness) _then) = __$CreatedBusinessCopyWithImpl;
@override @useResult
$Res call({
 String id, String handle, String name, String? logoUrl
});




}
/// @nodoc
class __$CreatedBusinessCopyWithImpl<$Res>
    implements _$CreatedBusinessCopyWith<$Res> {
  __$CreatedBusinessCopyWithImpl(this._self, this._then);

  final _CreatedBusiness _self;
  final $Res Function(_CreatedBusiness) _then;

/// Create a copy of CreatedBusiness
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? handle = null,Object? name = null,Object? logoUrl = freezed,}) {
  return _then(_CreatedBusiness(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$VendorItemVariant {

 String get id; String get name; int get quantity; bool get active;
/// Create a copy of VendorItemVariant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorItemVariantCopyWith<VendorItemVariant> get copyWith => _$VendorItemVariantCopyWithImpl<VendorItemVariant>(this as VendorItemVariant, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorItemVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.active, active) || other.active == active));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,quantity,active);

@override
String toString() {
  return 'VendorItemVariant(id: $id, name: $name, quantity: $quantity, active: $active)';
}


}

/// @nodoc
abstract mixin class $VendorItemVariantCopyWith<$Res>  {
  factory $VendorItemVariantCopyWith(VendorItemVariant value, $Res Function(VendorItemVariant) _then) = _$VendorItemVariantCopyWithImpl;
@useResult
$Res call({
 String id, String name, int quantity, bool active
});




}
/// @nodoc
class _$VendorItemVariantCopyWithImpl<$Res>
    implements $VendorItemVariantCopyWith<$Res> {
  _$VendorItemVariantCopyWithImpl(this._self, this._then);

  final VendorItemVariant _self;
  final $Res Function(VendorItemVariant) _then;

/// Create a copy of VendorItemVariant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? quantity = null,Object? active = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorItemVariant].
extension VendorItemVariantPatterns on VendorItemVariant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorItemVariant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorItemVariant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorItemVariant value)  $default,){
final _that = this;
switch (_that) {
case _VendorItemVariant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorItemVariant value)?  $default,){
final _that = this;
switch (_that) {
case _VendorItemVariant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int quantity,  bool active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorItemVariant() when $default != null:
return $default(_that.id,_that.name,_that.quantity,_that.active);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int quantity,  bool active)  $default,) {final _that = this;
switch (_that) {
case _VendorItemVariant():
return $default(_that.id,_that.name,_that.quantity,_that.active);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int quantity,  bool active)?  $default,) {final _that = this;
switch (_that) {
case _VendorItemVariant() when $default != null:
return $default(_that.id,_that.name,_that.quantity,_that.active);case _:
  return null;

}
}

}

/// @nodoc


class _VendorItemVariant implements VendorItemVariant {
  const _VendorItemVariant({required this.id, required this.name, required this.quantity, this.active = true});
  

@override final  String id;
@override final  String name;
@override final  int quantity;
@override@JsonKey() final  bool active;

/// Create a copy of VendorItemVariant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorItemVariantCopyWith<_VendorItemVariant> get copyWith => __$VendorItemVariantCopyWithImpl<_VendorItemVariant>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorItemVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.active, active) || other.active == active));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,quantity,active);

@override
String toString() {
  return 'VendorItemVariant(id: $id, name: $name, quantity: $quantity, active: $active)';
}


}

/// @nodoc
abstract mixin class _$VendorItemVariantCopyWith<$Res> implements $VendorItemVariantCopyWith<$Res> {
  factory _$VendorItemVariantCopyWith(_VendorItemVariant value, $Res Function(_VendorItemVariant) _then) = __$VendorItemVariantCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int quantity, bool active
});




}
/// @nodoc
class __$VendorItemVariantCopyWithImpl<$Res>
    implements _$VendorItemVariantCopyWith<$Res> {
  __$VendorItemVariantCopyWithImpl(this._self, this._then);

  final _VendorItemVariant _self;
  final $Res Function(_VendorItemVariant) _then;

/// Create a copy of VendorItemVariant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? quantity = null,Object? active = null,}) {
  return _then(_VendorItemVariant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$VendorItem {

 String get id; String get title; VendorItemStatus get status; int get fromPriceMinor; String get currency;/// `per_event`, `per_day` or `per_hour`.
 String get unit; String? get categoryId; String? get photoUrl; String? get blurhash; int get minQty; bool get instantBook; List<VendorItemVariant> get variants;/// In order; the first photo is the cover customers see.
 List<Media> get media;
/// Create a copy of VendorItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorItemCopyWith<VendorItem> get copyWith => _$VendorItemCopyWithImpl<VendorItem>(this as VendorItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.fromPriceMinor, fromPriceMinor) || other.fromPriceMinor == fromPriceMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.minQty, minQty) || other.minQty == minQty)&&(identical(other.instantBook, instantBook) || other.instantBook == instantBook)&&const DeepCollectionEquality().equals(other.variants, variants)&&const DeepCollectionEquality().equals(other.media, media));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,status,fromPriceMinor,currency,unit,categoryId,photoUrl,blurhash,minQty,instantBook,const DeepCollectionEquality().hash(variants),const DeepCollectionEquality().hash(media));

@override
String toString() {
  return 'VendorItem(id: $id, title: $title, status: $status, fromPriceMinor: $fromPriceMinor, currency: $currency, unit: $unit, categoryId: $categoryId, photoUrl: $photoUrl, blurhash: $blurhash, minQty: $minQty, instantBook: $instantBook, variants: $variants, media: $media)';
}


}

/// @nodoc
abstract mixin class $VendorItemCopyWith<$Res>  {
  factory $VendorItemCopyWith(VendorItem value, $Res Function(VendorItem) _then) = _$VendorItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, VendorItemStatus status, int fromPriceMinor, String currency, String unit, String? categoryId, String? photoUrl, String? blurhash, int minQty, bool instantBook, List<VendorItemVariant> variants, List<Media> media
});




}
/// @nodoc
class _$VendorItemCopyWithImpl<$Res>
    implements $VendorItemCopyWith<$Res> {
  _$VendorItemCopyWithImpl(this._self, this._then);

  final VendorItem _self;
  final $Res Function(VendorItem) _then;

/// Create a copy of VendorItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? status = null,Object? fromPriceMinor = null,Object? currency = null,Object? unit = null,Object? categoryId = freezed,Object? photoUrl = freezed,Object? blurhash = freezed,Object? minQty = null,Object? instantBook = null,Object? variants = null,Object? media = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VendorItemStatus,fromPriceMinor: null == fromPriceMinor ? _self.fromPriceMinor : fromPriceMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as int,instantBook: null == instantBook ? _self.instantBook : instantBook // ignore: cast_nullable_to_non_nullable
as bool,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<VendorItemVariant>,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<Media>,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorItem].
extension VendorItemPatterns on VendorItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorItem value)  $default,){
final _that = this;
switch (_that) {
case _VendorItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorItem value)?  $default,){
final _that = this;
switch (_that) {
case _VendorItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  VendorItemStatus status,  int fromPriceMinor,  String currency,  String unit,  String? categoryId,  String? photoUrl,  String? blurhash,  int minQty,  bool instantBook,  List<VendorItemVariant> variants,  List<Media> media)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorItem() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.fromPriceMinor,_that.currency,_that.unit,_that.categoryId,_that.photoUrl,_that.blurhash,_that.minQty,_that.instantBook,_that.variants,_that.media);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  VendorItemStatus status,  int fromPriceMinor,  String currency,  String unit,  String? categoryId,  String? photoUrl,  String? blurhash,  int minQty,  bool instantBook,  List<VendorItemVariant> variants,  List<Media> media)  $default,) {final _that = this;
switch (_that) {
case _VendorItem():
return $default(_that.id,_that.title,_that.status,_that.fromPriceMinor,_that.currency,_that.unit,_that.categoryId,_that.photoUrl,_that.blurhash,_that.minQty,_that.instantBook,_that.variants,_that.media);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  VendorItemStatus status,  int fromPriceMinor,  String currency,  String unit,  String? categoryId,  String? photoUrl,  String? blurhash,  int minQty,  bool instantBook,  List<VendorItemVariant> variants,  List<Media> media)?  $default,) {final _that = this;
switch (_that) {
case _VendorItem() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.fromPriceMinor,_that.currency,_that.unit,_that.categoryId,_that.photoUrl,_that.blurhash,_that.minQty,_that.instantBook,_that.variants,_that.media);case _:
  return null;

}
}

}

/// @nodoc


class _VendorItem extends VendorItem {
  const _VendorItem({required this.id, required this.title, required this.status, required this.fromPriceMinor, required this.currency, this.unit = 'per_event', this.categoryId, this.photoUrl, this.blurhash, this.minQty = 1, this.instantBook = false, final  List<VendorItemVariant> variants = const <VendorItemVariant>[], final  List<Media> media = const <Media>[]}): _variants = variants,_media = media,super._();
  

@override final  String id;
@override final  String title;
@override final  VendorItemStatus status;
@override final  int fromPriceMinor;
@override final  String currency;
/// `per_event`, `per_day` or `per_hour`.
@override@JsonKey() final  String unit;
@override final  String? categoryId;
@override final  String? photoUrl;
@override final  String? blurhash;
@override@JsonKey() final  int minQty;
@override@JsonKey() final  bool instantBook;
 final  List<VendorItemVariant> _variants;
@override@JsonKey() List<VendorItemVariant> get variants {
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variants);
}

/// In order; the first photo is the cover customers see.
 final  List<Media> _media;
/// In order; the first photo is the cover customers see.
@override@JsonKey() List<Media> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}


/// Create a copy of VendorItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorItemCopyWith<_VendorItem> get copyWith => __$VendorItemCopyWithImpl<_VendorItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.fromPriceMinor, fromPriceMinor) || other.fromPriceMinor == fromPriceMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.minQty, minQty) || other.minQty == minQty)&&(identical(other.instantBook, instantBook) || other.instantBook == instantBook)&&const DeepCollectionEquality().equals(other._variants, _variants)&&const DeepCollectionEquality().equals(other._media, _media));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,status,fromPriceMinor,currency,unit,categoryId,photoUrl,blurhash,minQty,instantBook,const DeepCollectionEquality().hash(_variants),const DeepCollectionEquality().hash(_media));

@override
String toString() {
  return 'VendorItem(id: $id, title: $title, status: $status, fromPriceMinor: $fromPriceMinor, currency: $currency, unit: $unit, categoryId: $categoryId, photoUrl: $photoUrl, blurhash: $blurhash, minQty: $minQty, instantBook: $instantBook, variants: $variants, media: $media)';
}


}

/// @nodoc
abstract mixin class _$VendorItemCopyWith<$Res> implements $VendorItemCopyWith<$Res> {
  factory _$VendorItemCopyWith(_VendorItem value, $Res Function(_VendorItem) _then) = __$VendorItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, VendorItemStatus status, int fromPriceMinor, String currency, String unit, String? categoryId, String? photoUrl, String? blurhash, int minQty, bool instantBook, List<VendorItemVariant> variants, List<Media> media
});




}
/// @nodoc
class __$VendorItemCopyWithImpl<$Res>
    implements _$VendorItemCopyWith<$Res> {
  __$VendorItemCopyWithImpl(this._self, this._then);

  final _VendorItem _self;
  final $Res Function(_VendorItem) _then;

/// Create a copy of VendorItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? status = null,Object? fromPriceMinor = null,Object? currency = null,Object? unit = null,Object? categoryId = freezed,Object? photoUrl = freezed,Object? blurhash = freezed,Object? minQty = null,Object? instantBook = null,Object? variants = null,Object? media = null,}) {
  return _then(_VendorItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VendorItemStatus,fromPriceMinor: null == fromPriceMinor ? _self.fromPriceMinor : fromPriceMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as int,instantBook: null == instantBook ? _self.instantBook : instantBook // ignore: cast_nullable_to_non_nullable
as bool,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<VendorItemVariant>,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<Media>,
  ));
}


}

/// @nodoc
mixin _$BusinessDelivery {

 bool get offered; int get baseFeeMinor; bool get setupOffered; int get setupFeeMinor;/// Set on the web; kept as-is when the app saves delivery.
 int get perKmMinor;
/// Create a copy of BusinessDelivery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessDeliveryCopyWith<BusinessDelivery> get copyWith => _$BusinessDeliveryCopyWithImpl<BusinessDelivery>(this as BusinessDelivery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessDelivery&&(identical(other.offered, offered) || other.offered == offered)&&(identical(other.baseFeeMinor, baseFeeMinor) || other.baseFeeMinor == baseFeeMinor)&&(identical(other.setupOffered, setupOffered) || other.setupOffered == setupOffered)&&(identical(other.setupFeeMinor, setupFeeMinor) || other.setupFeeMinor == setupFeeMinor)&&(identical(other.perKmMinor, perKmMinor) || other.perKmMinor == perKmMinor));
}


@override
int get hashCode => Object.hash(runtimeType,offered,baseFeeMinor,setupOffered,setupFeeMinor,perKmMinor);

@override
String toString() {
  return 'BusinessDelivery(offered: $offered, baseFeeMinor: $baseFeeMinor, setupOffered: $setupOffered, setupFeeMinor: $setupFeeMinor, perKmMinor: $perKmMinor)';
}


}

/// @nodoc
abstract mixin class $BusinessDeliveryCopyWith<$Res>  {
  factory $BusinessDeliveryCopyWith(BusinessDelivery value, $Res Function(BusinessDelivery) _then) = _$BusinessDeliveryCopyWithImpl;
@useResult
$Res call({
 bool offered, int baseFeeMinor, bool setupOffered, int setupFeeMinor, int perKmMinor
});




}
/// @nodoc
class _$BusinessDeliveryCopyWithImpl<$Res>
    implements $BusinessDeliveryCopyWith<$Res> {
  _$BusinessDeliveryCopyWithImpl(this._self, this._then);

  final BusinessDelivery _self;
  final $Res Function(BusinessDelivery) _then;

/// Create a copy of BusinessDelivery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? offered = null,Object? baseFeeMinor = null,Object? setupOffered = null,Object? setupFeeMinor = null,Object? perKmMinor = null,}) {
  return _then(_self.copyWith(
offered: null == offered ? _self.offered : offered // ignore: cast_nullable_to_non_nullable
as bool,baseFeeMinor: null == baseFeeMinor ? _self.baseFeeMinor : baseFeeMinor // ignore: cast_nullable_to_non_nullable
as int,setupOffered: null == setupOffered ? _self.setupOffered : setupOffered // ignore: cast_nullable_to_non_nullable
as bool,setupFeeMinor: null == setupFeeMinor ? _self.setupFeeMinor : setupFeeMinor // ignore: cast_nullable_to_non_nullable
as int,perKmMinor: null == perKmMinor ? _self.perKmMinor : perKmMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessDelivery].
extension BusinessDeliveryPatterns on BusinessDelivery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessDelivery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessDelivery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessDelivery value)  $default,){
final _that = this;
switch (_that) {
case _BusinessDelivery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessDelivery value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessDelivery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool offered,  int baseFeeMinor,  bool setupOffered,  int setupFeeMinor,  int perKmMinor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessDelivery() when $default != null:
return $default(_that.offered,_that.baseFeeMinor,_that.setupOffered,_that.setupFeeMinor,_that.perKmMinor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool offered,  int baseFeeMinor,  bool setupOffered,  int setupFeeMinor,  int perKmMinor)  $default,) {final _that = this;
switch (_that) {
case _BusinessDelivery():
return $default(_that.offered,_that.baseFeeMinor,_that.setupOffered,_that.setupFeeMinor,_that.perKmMinor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool offered,  int baseFeeMinor,  bool setupOffered,  int setupFeeMinor,  int perKmMinor)?  $default,) {final _that = this;
switch (_that) {
case _BusinessDelivery() when $default != null:
return $default(_that.offered,_that.baseFeeMinor,_that.setupOffered,_that.setupFeeMinor,_that.perKmMinor);case _:
  return null;

}
}

}

/// @nodoc


class _BusinessDelivery implements BusinessDelivery {
  const _BusinessDelivery({this.offered = true, this.baseFeeMinor = 0, this.setupOffered = false, this.setupFeeMinor = 0, this.perKmMinor = 0});
  

@override@JsonKey() final  bool offered;
@override@JsonKey() final  int baseFeeMinor;
@override@JsonKey() final  bool setupOffered;
@override@JsonKey() final  int setupFeeMinor;
/// Set on the web; kept as-is when the app saves delivery.
@override@JsonKey() final  int perKmMinor;

/// Create a copy of BusinessDelivery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessDeliveryCopyWith<_BusinessDelivery> get copyWith => __$BusinessDeliveryCopyWithImpl<_BusinessDelivery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessDelivery&&(identical(other.offered, offered) || other.offered == offered)&&(identical(other.baseFeeMinor, baseFeeMinor) || other.baseFeeMinor == baseFeeMinor)&&(identical(other.setupOffered, setupOffered) || other.setupOffered == setupOffered)&&(identical(other.setupFeeMinor, setupFeeMinor) || other.setupFeeMinor == setupFeeMinor)&&(identical(other.perKmMinor, perKmMinor) || other.perKmMinor == perKmMinor));
}


@override
int get hashCode => Object.hash(runtimeType,offered,baseFeeMinor,setupOffered,setupFeeMinor,perKmMinor);

@override
String toString() {
  return 'BusinessDelivery(offered: $offered, baseFeeMinor: $baseFeeMinor, setupOffered: $setupOffered, setupFeeMinor: $setupFeeMinor, perKmMinor: $perKmMinor)';
}


}

/// @nodoc
abstract mixin class _$BusinessDeliveryCopyWith<$Res> implements $BusinessDeliveryCopyWith<$Res> {
  factory _$BusinessDeliveryCopyWith(_BusinessDelivery value, $Res Function(_BusinessDelivery) _then) = __$BusinessDeliveryCopyWithImpl;
@override @useResult
$Res call({
 bool offered, int baseFeeMinor, bool setupOffered, int setupFeeMinor, int perKmMinor
});




}
/// @nodoc
class __$BusinessDeliveryCopyWithImpl<$Res>
    implements _$BusinessDeliveryCopyWith<$Res> {
  __$BusinessDeliveryCopyWithImpl(this._self, this._then);

  final _BusinessDelivery _self;
  final $Res Function(_BusinessDelivery) _then;

/// Create a copy of BusinessDelivery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? offered = null,Object? baseFeeMinor = null,Object? setupOffered = null,Object? setupFeeMinor = null,Object? perKmMinor = null,}) {
  return _then(_BusinessDelivery(
offered: null == offered ? _self.offered : offered // ignore: cast_nullable_to_non_nullable
as bool,baseFeeMinor: null == baseFeeMinor ? _self.baseFeeMinor : baseFeeMinor // ignore: cast_nullable_to_non_nullable
as int,setupOffered: null == setupOffered ? _self.setupOffered : setupOffered // ignore: cast_nullable_to_non_nullable
as bool,setupFeeMinor: null == setupFeeMinor ? _self.setupFeeMinor : setupFeeMinor // ignore: cast_nullable_to_non_nullable
as int,perKmMinor: null == perKmMinor ? _self.perKmMinor : perKmMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$BusinessProfile {

 String get id; String get handle; String get name; String? get bio; String? get logoUrl; String? get coverUrl; String? get city; List<String> get categories; List<String> get eventTypes; String? get phone; String? get whatsapp; String? get email; bool get isVerified; double? get ratingAverage; int get ratingCount; int get followers; int get posts; int get completedBookings; int? get serviceRadiusKm; BusinessDelivery get delivery; int? get depositPercent; int? get leadTimeHours;/// `owner`, `manager` or `staff`; null if not on the team.
 String? get myRole;
/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessProfileCopyWith<BusinessProfile> get copyWith => _$BusinessProfileCopyWithImpl<BusinessProfile>(this as BusinessProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.name, name) || other.name == name)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.eventTypes, eventTypes)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.email, email) || other.email == email)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.ratingAverage, ratingAverage) || other.ratingAverage == ratingAverage)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.posts, posts) || other.posts == posts)&&(identical(other.completedBookings, completedBookings) || other.completedBookings == completedBookings)&&(identical(other.serviceRadiusKm, serviceRadiusKm) || other.serviceRadiusKm == serviceRadiusKm)&&(identical(other.delivery, delivery) || other.delivery == delivery)&&(identical(other.depositPercent, depositPercent) || other.depositPercent == depositPercent)&&(identical(other.leadTimeHours, leadTimeHours) || other.leadTimeHours == leadTimeHours)&&(identical(other.myRole, myRole) || other.myRole == myRole));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,handle,name,bio,logoUrl,coverUrl,city,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(eventTypes),phone,whatsapp,email,isVerified,ratingAverage,ratingCount,followers,posts,completedBookings,serviceRadiusKm,delivery,depositPercent,leadTimeHours,myRole]);

@override
String toString() {
  return 'BusinessProfile(id: $id, handle: $handle, name: $name, bio: $bio, logoUrl: $logoUrl, coverUrl: $coverUrl, city: $city, categories: $categories, eventTypes: $eventTypes, phone: $phone, whatsapp: $whatsapp, email: $email, isVerified: $isVerified, ratingAverage: $ratingAverage, ratingCount: $ratingCount, followers: $followers, posts: $posts, completedBookings: $completedBookings, serviceRadiusKm: $serviceRadiusKm, delivery: $delivery, depositPercent: $depositPercent, leadTimeHours: $leadTimeHours, myRole: $myRole)';
}


}

/// @nodoc
abstract mixin class $BusinessProfileCopyWith<$Res>  {
  factory $BusinessProfileCopyWith(BusinessProfile value, $Res Function(BusinessProfile) _then) = _$BusinessProfileCopyWithImpl;
@useResult
$Res call({
 String id, String handle, String name, String? bio, String? logoUrl, String? coverUrl, String? city, List<String> categories, List<String> eventTypes, String? phone, String? whatsapp, String? email, bool isVerified, double? ratingAverage, int ratingCount, int followers, int posts, int completedBookings, int? serviceRadiusKm, BusinessDelivery delivery, int? depositPercent, int? leadTimeHours, String? myRole
});


$BusinessDeliveryCopyWith<$Res> get delivery;

}
/// @nodoc
class _$BusinessProfileCopyWithImpl<$Res>
    implements $BusinessProfileCopyWith<$Res> {
  _$BusinessProfileCopyWithImpl(this._self, this._then);

  final BusinessProfile _self;
  final $Res Function(BusinessProfile) _then;

/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? handle = null,Object? name = null,Object? bio = freezed,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? city = freezed,Object? categories = null,Object? eventTypes = null,Object? phone = freezed,Object? whatsapp = freezed,Object? email = freezed,Object? isVerified = null,Object? ratingAverage = freezed,Object? ratingCount = null,Object? followers = null,Object? posts = null,Object? completedBookings = null,Object? serviceRadiusKm = freezed,Object? delivery = null,Object? depositPercent = freezed,Object? leadTimeHours = freezed,Object? myRole = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,eventTypes: null == eventTypes ? _self.eventTypes : eventTypes // ignore: cast_nullable_to_non_nullable
as List<String>,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,whatsapp: freezed == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,ratingAverage: freezed == ratingAverage ? _self.ratingAverage : ratingAverage // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as int,completedBookings: null == completedBookings ? _self.completedBookings : completedBookings // ignore: cast_nullable_to_non_nullable
as int,serviceRadiusKm: freezed == serviceRadiusKm ? _self.serviceRadiusKm : serviceRadiusKm // ignore: cast_nullable_to_non_nullable
as int?,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as BusinessDelivery,depositPercent: freezed == depositPercent ? _self.depositPercent : depositPercent // ignore: cast_nullable_to_non_nullable
as int?,leadTimeHours: freezed == leadTimeHours ? _self.leadTimeHours : leadTimeHours // ignore: cast_nullable_to_non_nullable
as int?,myRole: freezed == myRole ? _self.myRole : myRole // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessDeliveryCopyWith<$Res> get delivery {
  
  return $BusinessDeliveryCopyWith<$Res>(_self.delivery, (value) {
    return _then(_self.copyWith(delivery: value));
  });
}
}


/// Adds pattern-matching-related methods to [BusinessProfile].
extension BusinessProfilePatterns on BusinessProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessProfile value)  $default,){
final _that = this;
switch (_that) {
case _BusinessProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessProfile value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String handle,  String name,  String? bio,  String? logoUrl,  String? coverUrl,  String? city,  List<String> categories,  List<String> eventTypes,  String? phone,  String? whatsapp,  String? email,  bool isVerified,  double? ratingAverage,  int ratingCount,  int followers,  int posts,  int completedBookings,  int? serviceRadiusKm,  BusinessDelivery delivery,  int? depositPercent,  int? leadTimeHours,  String? myRole)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
return $default(_that.id,_that.handle,_that.name,_that.bio,_that.logoUrl,_that.coverUrl,_that.city,_that.categories,_that.eventTypes,_that.phone,_that.whatsapp,_that.email,_that.isVerified,_that.ratingAverage,_that.ratingCount,_that.followers,_that.posts,_that.completedBookings,_that.serviceRadiusKm,_that.delivery,_that.depositPercent,_that.leadTimeHours,_that.myRole);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String handle,  String name,  String? bio,  String? logoUrl,  String? coverUrl,  String? city,  List<String> categories,  List<String> eventTypes,  String? phone,  String? whatsapp,  String? email,  bool isVerified,  double? ratingAverage,  int ratingCount,  int followers,  int posts,  int completedBookings,  int? serviceRadiusKm,  BusinessDelivery delivery,  int? depositPercent,  int? leadTimeHours,  String? myRole)  $default,) {final _that = this;
switch (_that) {
case _BusinessProfile():
return $default(_that.id,_that.handle,_that.name,_that.bio,_that.logoUrl,_that.coverUrl,_that.city,_that.categories,_that.eventTypes,_that.phone,_that.whatsapp,_that.email,_that.isVerified,_that.ratingAverage,_that.ratingCount,_that.followers,_that.posts,_that.completedBookings,_that.serviceRadiusKm,_that.delivery,_that.depositPercent,_that.leadTimeHours,_that.myRole);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String handle,  String name,  String? bio,  String? logoUrl,  String? coverUrl,  String? city,  List<String> categories,  List<String> eventTypes,  String? phone,  String? whatsapp,  String? email,  bool isVerified,  double? ratingAverage,  int ratingCount,  int followers,  int posts,  int completedBookings,  int? serviceRadiusKm,  BusinessDelivery delivery,  int? depositPercent,  int? leadTimeHours,  String? myRole)?  $default,) {final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
return $default(_that.id,_that.handle,_that.name,_that.bio,_that.logoUrl,_that.coverUrl,_that.city,_that.categories,_that.eventTypes,_that.phone,_that.whatsapp,_that.email,_that.isVerified,_that.ratingAverage,_that.ratingCount,_that.followers,_that.posts,_that.completedBookings,_that.serviceRadiusKm,_that.delivery,_that.depositPercent,_that.leadTimeHours,_that.myRole);case _:
  return null;

}
}

}

/// @nodoc


class _BusinessProfile extends BusinessProfile {
  const _BusinessProfile({required this.id, required this.handle, required this.name, this.bio, this.logoUrl, this.coverUrl, this.city, final  List<String> categories = const <String>[], final  List<String> eventTypes = const <String>[], this.phone, this.whatsapp, this.email, this.isVerified = false, this.ratingAverage, this.ratingCount = 0, this.followers = 0, this.posts = 0, this.completedBookings = 0, this.serviceRadiusKm, this.delivery = const BusinessDelivery(), this.depositPercent, this.leadTimeHours, this.myRole}): _categories = categories,_eventTypes = eventTypes,super._();
  

@override final  String id;
@override final  String handle;
@override final  String name;
@override final  String? bio;
@override final  String? logoUrl;
@override final  String? coverUrl;
@override final  String? city;
 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<String> _eventTypes;
@override@JsonKey() List<String> get eventTypes {
  if (_eventTypes is EqualUnmodifiableListView) return _eventTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventTypes);
}

@override final  String? phone;
@override final  String? whatsapp;
@override final  String? email;
@override@JsonKey() final  bool isVerified;
@override final  double? ratingAverage;
@override@JsonKey() final  int ratingCount;
@override@JsonKey() final  int followers;
@override@JsonKey() final  int posts;
@override@JsonKey() final  int completedBookings;
@override final  int? serviceRadiusKm;
@override@JsonKey() final  BusinessDelivery delivery;
@override final  int? depositPercent;
@override final  int? leadTimeHours;
/// `owner`, `manager` or `staff`; null if not on the team.
@override final  String? myRole;

/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessProfileCopyWith<_BusinessProfile> get copyWith => __$BusinessProfileCopyWithImpl<_BusinessProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.name, name) || other.name == name)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._eventTypes, _eventTypes)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.email, email) || other.email == email)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.ratingAverage, ratingAverage) || other.ratingAverage == ratingAverage)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.posts, posts) || other.posts == posts)&&(identical(other.completedBookings, completedBookings) || other.completedBookings == completedBookings)&&(identical(other.serviceRadiusKm, serviceRadiusKm) || other.serviceRadiusKm == serviceRadiusKm)&&(identical(other.delivery, delivery) || other.delivery == delivery)&&(identical(other.depositPercent, depositPercent) || other.depositPercent == depositPercent)&&(identical(other.leadTimeHours, leadTimeHours) || other.leadTimeHours == leadTimeHours)&&(identical(other.myRole, myRole) || other.myRole == myRole));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,handle,name,bio,logoUrl,coverUrl,city,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_eventTypes),phone,whatsapp,email,isVerified,ratingAverage,ratingCount,followers,posts,completedBookings,serviceRadiusKm,delivery,depositPercent,leadTimeHours,myRole]);

@override
String toString() {
  return 'BusinessProfile(id: $id, handle: $handle, name: $name, bio: $bio, logoUrl: $logoUrl, coverUrl: $coverUrl, city: $city, categories: $categories, eventTypes: $eventTypes, phone: $phone, whatsapp: $whatsapp, email: $email, isVerified: $isVerified, ratingAverage: $ratingAverage, ratingCount: $ratingCount, followers: $followers, posts: $posts, completedBookings: $completedBookings, serviceRadiusKm: $serviceRadiusKm, delivery: $delivery, depositPercent: $depositPercent, leadTimeHours: $leadTimeHours, myRole: $myRole)';
}


}

/// @nodoc
abstract mixin class _$BusinessProfileCopyWith<$Res> implements $BusinessProfileCopyWith<$Res> {
  factory _$BusinessProfileCopyWith(_BusinessProfile value, $Res Function(_BusinessProfile) _then) = __$BusinessProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String handle, String name, String? bio, String? logoUrl, String? coverUrl, String? city, List<String> categories, List<String> eventTypes, String? phone, String? whatsapp, String? email, bool isVerified, double? ratingAverage, int ratingCount, int followers, int posts, int completedBookings, int? serviceRadiusKm, BusinessDelivery delivery, int? depositPercent, int? leadTimeHours, String? myRole
});


@override $BusinessDeliveryCopyWith<$Res> get delivery;

}
/// @nodoc
class __$BusinessProfileCopyWithImpl<$Res>
    implements _$BusinessProfileCopyWith<$Res> {
  __$BusinessProfileCopyWithImpl(this._self, this._then);

  final _BusinessProfile _self;
  final $Res Function(_BusinessProfile) _then;

/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? handle = null,Object? name = null,Object? bio = freezed,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? city = freezed,Object? categories = null,Object? eventTypes = null,Object? phone = freezed,Object? whatsapp = freezed,Object? email = freezed,Object? isVerified = null,Object? ratingAverage = freezed,Object? ratingCount = null,Object? followers = null,Object? posts = null,Object? completedBookings = null,Object? serviceRadiusKm = freezed,Object? delivery = null,Object? depositPercent = freezed,Object? leadTimeHours = freezed,Object? myRole = freezed,}) {
  return _then(_BusinessProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,eventTypes: null == eventTypes ? _self._eventTypes : eventTypes // ignore: cast_nullable_to_non_nullable
as List<String>,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,whatsapp: freezed == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,ratingAverage: freezed == ratingAverage ? _self.ratingAverage : ratingAverage // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as int,completedBookings: null == completedBookings ? _self.completedBookings : completedBookings // ignore: cast_nullable_to_non_nullable
as int,serviceRadiusKm: freezed == serviceRadiusKm ? _self.serviceRadiusKm : serviceRadiusKm // ignore: cast_nullable_to_non_nullable
as int?,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as BusinessDelivery,depositPercent: freezed == depositPercent ? _self.depositPercent : depositPercent // ignore: cast_nullable_to_non_nullable
as int?,leadTimeHours: freezed == leadTimeHours ? _self.leadTimeHours : leadTimeHours // ignore: cast_nullable_to_non_nullable
as int?,myRole: freezed == myRole ? _self.myRole : myRole // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessDeliveryCopyWith<$Res> get delivery {
  
  return $BusinessDeliveryCopyWith<$Res>(_self.delivery, (value) {
    return _then(_self.copyWith(delivery: value));
  });
}
}

// dart format on
