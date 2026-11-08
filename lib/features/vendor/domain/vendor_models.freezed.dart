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
 String? get fulfilment; String? get customerNote;
/// Create a copy of VendorBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorBookingCopyWith<VendorBooking> get copyWith => _$VendorBookingCopyWithImpl<VendorBooking>(this as VendorBooking, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerAvatarUrl, customerAvatarUrl) || other.customerAvatarUrl == customerAvatarUrl)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.respondBy, respondBy) || other.respondBy == respondBy)&&(identical(other.fulfilment, fulfilment) || other.fulfilment == fulfilment)&&(identical(other.customerNote, customerNote) || other.customerNote == customerNote));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,status,startsAt,endsAt,totalMinor,currency,customerName,customerAvatarUrl,const DeepCollectionEquality().hash(lines),respondBy,fulfilment,customerNote);

@override
String toString() {
  return 'VendorBooking(id: $id, number: $number, status: $status, startsAt: $startsAt, endsAt: $endsAt, totalMinor: $totalMinor, currency: $currency, customerName: $customerName, customerAvatarUrl: $customerAvatarUrl, lines: $lines, respondBy: $respondBy, fulfilment: $fulfilment, customerNote: $customerNote)';
}


}

/// @nodoc
abstract mixin class $VendorBookingCopyWith<$Res>  {
  factory $VendorBookingCopyWith(VendorBooking value, $Res Function(VendorBooking) _then) = _$VendorBookingCopyWithImpl;
@useResult
$Res call({
 String id, String number, VendorBookingStatus status, DateTime startsAt, DateTime endsAt, int totalMinor, String currency, String customerName, String? customerAvatarUrl, List<VendorBookingLine> lines, DateTime? respondBy, String? fulfilment, String? customerNote
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? status = null,Object? startsAt = null,Object? endsAt = null,Object? totalMinor = null,Object? currency = null,Object? customerName = null,Object? customerAvatarUrl = freezed,Object? lines = null,Object? respondBy = freezed,Object? fulfilment = freezed,Object? customerNote = freezed,}) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String number,  VendorBookingStatus status,  DateTime startsAt,  DateTime endsAt,  int totalMinor,  String currency,  String customerName,  String? customerAvatarUrl,  List<VendorBookingLine> lines,  DateTime? respondBy,  String? fulfilment,  String? customerNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorBooking() when $default != null:
return $default(_that.id,_that.number,_that.status,_that.startsAt,_that.endsAt,_that.totalMinor,_that.currency,_that.customerName,_that.customerAvatarUrl,_that.lines,_that.respondBy,_that.fulfilment,_that.customerNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String number,  VendorBookingStatus status,  DateTime startsAt,  DateTime endsAt,  int totalMinor,  String currency,  String customerName,  String? customerAvatarUrl,  List<VendorBookingLine> lines,  DateTime? respondBy,  String? fulfilment,  String? customerNote)  $default,) {final _that = this;
switch (_that) {
case _VendorBooking():
return $default(_that.id,_that.number,_that.status,_that.startsAt,_that.endsAt,_that.totalMinor,_that.currency,_that.customerName,_that.customerAvatarUrl,_that.lines,_that.respondBy,_that.fulfilment,_that.customerNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String number,  VendorBookingStatus status,  DateTime startsAt,  DateTime endsAt,  int totalMinor,  String currency,  String customerName,  String? customerAvatarUrl,  List<VendorBookingLine> lines,  DateTime? respondBy,  String? fulfilment,  String? customerNote)?  $default,) {final _that = this;
switch (_that) {
case _VendorBooking() when $default != null:
return $default(_that.id,_that.number,_that.status,_that.startsAt,_that.endsAt,_that.totalMinor,_that.currency,_that.customerName,_that.customerAvatarUrl,_that.lines,_that.respondBy,_that.fulfilment,_that.customerNote);case _:
  return null;

}
}

}

/// @nodoc


class _VendorBooking implements VendorBooking {
  const _VendorBooking({required this.id, required this.number, required this.status, required this.startsAt, required this.endsAt, required this.totalMinor, required this.currency, this.customerName = 'A customer', this.customerAvatarUrl, final  List<VendorBookingLine> lines = const <VendorBookingLine>[], this.respondBy, this.fulfilment, this.customerNote}): _lines = lines;
  

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

/// Create a copy of VendorBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorBookingCopyWith<_VendorBooking> get copyWith => __$VendorBookingCopyWithImpl<_VendorBooking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerAvatarUrl, customerAvatarUrl) || other.customerAvatarUrl == customerAvatarUrl)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.respondBy, respondBy) || other.respondBy == respondBy)&&(identical(other.fulfilment, fulfilment) || other.fulfilment == fulfilment)&&(identical(other.customerNote, customerNote) || other.customerNote == customerNote));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,status,startsAt,endsAt,totalMinor,currency,customerName,customerAvatarUrl,const DeepCollectionEquality().hash(_lines),respondBy,fulfilment,customerNote);

@override
String toString() {
  return 'VendorBooking(id: $id, number: $number, status: $status, startsAt: $startsAt, endsAt: $endsAt, totalMinor: $totalMinor, currency: $currency, customerName: $customerName, customerAvatarUrl: $customerAvatarUrl, lines: $lines, respondBy: $respondBy, fulfilment: $fulfilment, customerNote: $customerNote)';
}


}

/// @nodoc
abstract mixin class _$VendorBookingCopyWith<$Res> implements $VendorBookingCopyWith<$Res> {
  factory _$VendorBookingCopyWith(_VendorBooking value, $Res Function(_VendorBooking) _then) = __$VendorBookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String number, VendorBookingStatus status, DateTime startsAt, DateTime endsAt, int totalMinor, String currency, String customerName, String? customerAvatarUrl, List<VendorBookingLine> lines, DateTime? respondBy, String? fulfilment, String? customerNote
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? status = null,Object? startsAt = null,Object? endsAt = null,Object? totalMinor = null,Object? currency = null,Object? customerName = null,Object? customerAvatarUrl = freezed,Object? lines = null,Object? respondBy = freezed,Object? fulfilment = freezed,Object? customerNote = freezed,}) {
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

// dart format on
