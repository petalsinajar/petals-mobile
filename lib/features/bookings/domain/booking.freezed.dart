// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingVendor {

 String get id; String get name; String? get handle; String? get logoUrl;
/// Create a copy of BookingVendor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingVendorCopyWith<BookingVendor> get copyWith => _$BookingVendorCopyWithImpl<BookingVendor>(this as BookingVendor, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingVendor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,handle,logoUrl);

@override
String toString() {
  return 'BookingVendor(id: $id, name: $name, handle: $handle, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class $BookingVendorCopyWith<$Res>  {
  factory $BookingVendorCopyWith(BookingVendor value, $Res Function(BookingVendor) _then) = _$BookingVendorCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? handle, String? logoUrl
});




}
/// @nodoc
class _$BookingVendorCopyWithImpl<$Res>
    implements $BookingVendorCopyWith<$Res> {
  _$BookingVendorCopyWithImpl(this._self, this._then);

  final BookingVendor _self;
  final $Res Function(BookingVendor) _then;

/// Create a copy of BookingVendor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? logoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingVendor].
extension BookingVendorPatterns on BookingVendor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingVendor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingVendor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingVendor value)  $default,){
final _that = this;
switch (_that) {
case _BookingVendor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingVendor value)?  $default,){
final _that = this;
switch (_that) {
case _BookingVendor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? handle,  String? logoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingVendor() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.logoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? handle,  String? logoUrl)  $default,) {final _that = this;
switch (_that) {
case _BookingVendor():
return $default(_that.id,_that.name,_that.handle,_that.logoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? handle,  String? logoUrl)?  $default,) {final _that = this;
switch (_that) {
case _BookingVendor() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.logoUrl);case _:
  return null;

}
}

}

/// @nodoc


class _BookingVendor implements BookingVendor {
  const _BookingVendor({required this.id, required this.name, this.handle, this.logoUrl});
  

@override final  String id;
@override final  String name;
@override final  String? handle;
@override final  String? logoUrl;

/// Create a copy of BookingVendor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingVendorCopyWith<_BookingVendor> get copyWith => __$BookingVendorCopyWithImpl<_BookingVendor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingVendor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,handle,logoUrl);

@override
String toString() {
  return 'BookingVendor(id: $id, name: $name, handle: $handle, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class _$BookingVendorCopyWith<$Res> implements $BookingVendorCopyWith<$Res> {
  factory _$BookingVendorCopyWith(_BookingVendor value, $Res Function(_BookingVendor) _then) = __$BookingVendorCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? handle, String? logoUrl
});




}
/// @nodoc
class __$BookingVendorCopyWithImpl<$Res>
    implements _$BookingVendorCopyWith<$Res> {
  __$BookingVendorCopyWithImpl(this._self, this._then);

  final _BookingVendor _self;
  final $Res Function(_BookingVendor) _then;

/// Create a copy of BookingVendor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? logoUrl = freezed,}) {
  return _then(_BookingVendor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$BookingItemLine {

 String get title; int get qty; int get lineTotalMinor;
/// Create a copy of BookingItemLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingItemLineCopyWith<BookingItemLine> get copyWith => _$BookingItemLineCopyWithImpl<BookingItemLine>(this as BookingItemLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingItemLine&&(identical(other.title, title) || other.title == title)&&(identical(other.qty, qty) || other.qty == qty)&&(identical(other.lineTotalMinor, lineTotalMinor) || other.lineTotalMinor == lineTotalMinor));
}


@override
int get hashCode => Object.hash(runtimeType,title,qty,lineTotalMinor);

@override
String toString() {
  return 'BookingItemLine(title: $title, qty: $qty, lineTotalMinor: $lineTotalMinor)';
}


}

/// @nodoc
abstract mixin class $BookingItemLineCopyWith<$Res>  {
  factory $BookingItemLineCopyWith(BookingItemLine value, $Res Function(BookingItemLine) _then) = _$BookingItemLineCopyWithImpl;
@useResult
$Res call({
 String title, int qty, int lineTotalMinor
});




}
/// @nodoc
class _$BookingItemLineCopyWithImpl<$Res>
    implements $BookingItemLineCopyWith<$Res> {
  _$BookingItemLineCopyWithImpl(this._self, this._then);

  final BookingItemLine _self;
  final $Res Function(BookingItemLine) _then;

/// Create a copy of BookingItemLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? qty = null,Object? lineTotalMinor = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,lineTotalMinor: null == lineTotalMinor ? _self.lineTotalMinor : lineTotalMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingItemLine].
extension BookingItemLinePatterns on BookingItemLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingItemLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingItemLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingItemLine value)  $default,){
final _that = this;
switch (_that) {
case _BookingItemLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingItemLine value)?  $default,){
final _that = this;
switch (_that) {
case _BookingItemLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  int qty,  int lineTotalMinor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingItemLine() when $default != null:
return $default(_that.title,_that.qty,_that.lineTotalMinor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  int qty,  int lineTotalMinor)  $default,) {final _that = this;
switch (_that) {
case _BookingItemLine():
return $default(_that.title,_that.qty,_that.lineTotalMinor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  int qty,  int lineTotalMinor)?  $default,) {final _that = this;
switch (_that) {
case _BookingItemLine() when $default != null:
return $default(_that.title,_that.qty,_that.lineTotalMinor);case _:
  return null;

}
}

}

/// @nodoc


class _BookingItemLine implements BookingItemLine {
  const _BookingItemLine({required this.title, required this.qty, this.lineTotalMinor = 0});
  

@override final  String title;
@override final  int qty;
@override@JsonKey() final  int lineTotalMinor;

/// Create a copy of BookingItemLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingItemLineCopyWith<_BookingItemLine> get copyWith => __$BookingItemLineCopyWithImpl<_BookingItemLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingItemLine&&(identical(other.title, title) || other.title == title)&&(identical(other.qty, qty) || other.qty == qty)&&(identical(other.lineTotalMinor, lineTotalMinor) || other.lineTotalMinor == lineTotalMinor));
}


@override
int get hashCode => Object.hash(runtimeType,title,qty,lineTotalMinor);

@override
String toString() {
  return 'BookingItemLine(title: $title, qty: $qty, lineTotalMinor: $lineTotalMinor)';
}


}

/// @nodoc
abstract mixin class _$BookingItemLineCopyWith<$Res> implements $BookingItemLineCopyWith<$Res> {
  factory _$BookingItemLineCopyWith(_BookingItemLine value, $Res Function(_BookingItemLine) _then) = __$BookingItemLineCopyWithImpl;
@override @useResult
$Res call({
 String title, int qty, int lineTotalMinor
});




}
/// @nodoc
class __$BookingItemLineCopyWithImpl<$Res>
    implements _$BookingItemLineCopyWith<$Res> {
  __$BookingItemLineCopyWithImpl(this._self, this._then);

  final _BookingItemLine _self;
  final $Res Function(_BookingItemLine) _then;

/// Create a copy of BookingItemLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? qty = null,Object? lineTotalMinor = null,}) {
  return _then(_BookingItemLine(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,lineTotalMinor: null == lineTotalMinor ? _self.lineTotalMinor : lineTotalMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$BookingStep {

 BookingStatus get to; DateTime get at; String? get note;
/// Create a copy of BookingStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStepCopyWith<BookingStep> get copyWith => _$BookingStepCopyWithImpl<BookingStep>(this as BookingStep, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStep&&(identical(other.to, to) || other.to == to)&&(identical(other.at, at) || other.at == at)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,to,at,note);

@override
String toString() {
  return 'BookingStep(to: $to, at: $at, note: $note)';
}


}

/// @nodoc
abstract mixin class $BookingStepCopyWith<$Res>  {
  factory $BookingStepCopyWith(BookingStep value, $Res Function(BookingStep) _then) = _$BookingStepCopyWithImpl;
@useResult
$Res call({
 BookingStatus to, DateTime at, String? note
});




}
/// @nodoc
class _$BookingStepCopyWithImpl<$Res>
    implements $BookingStepCopyWith<$Res> {
  _$BookingStepCopyWithImpl(this._self, this._then);

  final BookingStep _self;
  final $Res Function(BookingStep) _then;

/// Create a copy of BookingStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? to = null,Object? at = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as BookingStatus,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingStep].
extension BookingStepPatterns on BookingStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingStep value)  $default,){
final _that = this;
switch (_that) {
case _BookingStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingStep value)?  $default,){
final _that = this;
switch (_that) {
case _BookingStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BookingStatus to,  DateTime at,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingStep() when $default != null:
return $default(_that.to,_that.at,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BookingStatus to,  DateTime at,  String? note)  $default,) {final _that = this;
switch (_that) {
case _BookingStep():
return $default(_that.to,_that.at,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BookingStatus to,  DateTime at,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _BookingStep() when $default != null:
return $default(_that.to,_that.at,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _BookingStep implements BookingStep {
  const _BookingStep({required this.to, required this.at, this.note});
  

@override final  BookingStatus to;
@override final  DateTime at;
@override final  String? note;

/// Create a copy of BookingStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingStepCopyWith<_BookingStep> get copyWith => __$BookingStepCopyWithImpl<_BookingStep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingStep&&(identical(other.to, to) || other.to == to)&&(identical(other.at, at) || other.at == at)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,to,at,note);

@override
String toString() {
  return 'BookingStep(to: $to, at: $at, note: $note)';
}


}

/// @nodoc
abstract mixin class _$BookingStepCopyWith<$Res> implements $BookingStepCopyWith<$Res> {
  factory _$BookingStepCopyWith(_BookingStep value, $Res Function(_BookingStep) _then) = __$BookingStepCopyWithImpl;
@override @useResult
$Res call({
 BookingStatus to, DateTime at, String? note
});




}
/// @nodoc
class __$BookingStepCopyWithImpl<$Res>
    implements _$BookingStepCopyWith<$Res> {
  __$BookingStepCopyWithImpl(this._self, this._then);

  final _BookingStep _self;
  final $Res Function(_BookingStep) _then;

/// Create a copy of BookingStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? to = null,Object? at = null,Object? note = freezed,}) {
  return _then(_BookingStep(
to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as BookingStatus,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CustomerBooking {

 String get id; String get number; BookingStatus get status; DateTime get startsAt; DateTime get endsAt; int get totalMinor; String get currency; String? get eventId; BookingVendor? get vendor; List<BookingItemLine> get lines;/// `delivery` or `pickup`.
 String? get fulfilment; DateTime? get respondBy; String? get customerNote;/// Oldest first. Only on the booking's own page.
 List<BookingStep> get timeline;
/// Create a copy of CustomerBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerBookingCopyWith<CustomerBooking> get copyWith => _$CustomerBookingCopyWithImpl<CustomerBooking>(this as CustomerBooking, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.fulfilment, fulfilment) || other.fulfilment == fulfilment)&&(identical(other.respondBy, respondBy) || other.respondBy == respondBy)&&(identical(other.customerNote, customerNote) || other.customerNote == customerNote)&&const DeepCollectionEquality().equals(other.timeline, timeline));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,status,startsAt,endsAt,totalMinor,currency,eventId,vendor,const DeepCollectionEquality().hash(lines),fulfilment,respondBy,customerNote,const DeepCollectionEquality().hash(timeline));

@override
String toString() {
  return 'CustomerBooking(id: $id, number: $number, status: $status, startsAt: $startsAt, endsAt: $endsAt, totalMinor: $totalMinor, currency: $currency, eventId: $eventId, vendor: $vendor, lines: $lines, fulfilment: $fulfilment, respondBy: $respondBy, customerNote: $customerNote, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class $CustomerBookingCopyWith<$Res>  {
  factory $CustomerBookingCopyWith(CustomerBooking value, $Res Function(CustomerBooking) _then) = _$CustomerBookingCopyWithImpl;
@useResult
$Res call({
 String id, String number, BookingStatus status, DateTime startsAt, DateTime endsAt, int totalMinor, String currency, String? eventId, BookingVendor? vendor, List<BookingItemLine> lines, String? fulfilment, DateTime? respondBy, String? customerNote, List<BookingStep> timeline
});


$BookingVendorCopyWith<$Res>? get vendor;

}
/// @nodoc
class _$CustomerBookingCopyWithImpl<$Res>
    implements $CustomerBookingCopyWith<$Res> {
  _$CustomerBookingCopyWithImpl(this._self, this._then);

  final CustomerBooking _self;
  final $Res Function(CustomerBooking) _then;

/// Create a copy of CustomerBooking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? status = null,Object? startsAt = null,Object? endsAt = null,Object? totalMinor = null,Object? currency = null,Object? eventId = freezed,Object? vendor = freezed,Object? lines = null,Object? fulfilment = freezed,Object? respondBy = freezed,Object? customerNote = freezed,Object? timeline = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as BookingVendor?,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<BookingItemLine>,fulfilment: freezed == fulfilment ? _self.fulfilment : fulfilment // ignore: cast_nullable_to_non_nullable
as String?,respondBy: freezed == respondBy ? _self.respondBy : respondBy // ignore: cast_nullable_to_non_nullable
as DateTime?,customerNote: freezed == customerNote ? _self.customerNote : customerNote // ignore: cast_nullable_to_non_nullable
as String?,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<BookingStep>,
  ));
}
/// Create a copy of CustomerBooking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingVendorCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $BookingVendorCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomerBooking].
extension CustomerBookingPatterns on CustomerBooking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerBooking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerBooking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerBooking value)  $default,){
final _that = this;
switch (_that) {
case _CustomerBooking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerBooking value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerBooking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String number,  BookingStatus status,  DateTime startsAt,  DateTime endsAt,  int totalMinor,  String currency,  String? eventId,  BookingVendor? vendor,  List<BookingItemLine> lines,  String? fulfilment,  DateTime? respondBy,  String? customerNote,  List<BookingStep> timeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerBooking() when $default != null:
return $default(_that.id,_that.number,_that.status,_that.startsAt,_that.endsAt,_that.totalMinor,_that.currency,_that.eventId,_that.vendor,_that.lines,_that.fulfilment,_that.respondBy,_that.customerNote,_that.timeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String number,  BookingStatus status,  DateTime startsAt,  DateTime endsAt,  int totalMinor,  String currency,  String? eventId,  BookingVendor? vendor,  List<BookingItemLine> lines,  String? fulfilment,  DateTime? respondBy,  String? customerNote,  List<BookingStep> timeline)  $default,) {final _that = this;
switch (_that) {
case _CustomerBooking():
return $default(_that.id,_that.number,_that.status,_that.startsAt,_that.endsAt,_that.totalMinor,_that.currency,_that.eventId,_that.vendor,_that.lines,_that.fulfilment,_that.respondBy,_that.customerNote,_that.timeline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String number,  BookingStatus status,  DateTime startsAt,  DateTime endsAt,  int totalMinor,  String currency,  String? eventId,  BookingVendor? vendor,  List<BookingItemLine> lines,  String? fulfilment,  DateTime? respondBy,  String? customerNote,  List<BookingStep> timeline)?  $default,) {final _that = this;
switch (_that) {
case _CustomerBooking() when $default != null:
return $default(_that.id,_that.number,_that.status,_that.startsAt,_that.endsAt,_that.totalMinor,_that.currency,_that.eventId,_that.vendor,_that.lines,_that.fulfilment,_that.respondBy,_that.customerNote,_that.timeline);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerBooking implements CustomerBooking {
  const _CustomerBooking({required this.id, required this.number, required this.status, required this.startsAt, required this.endsAt, required this.totalMinor, required this.currency, this.eventId, this.vendor, final  List<BookingItemLine> lines = const <BookingItemLine>[], this.fulfilment, this.respondBy, this.customerNote, final  List<BookingStep> timeline = const <BookingStep>[]}): _lines = lines,_timeline = timeline;
  

@override final  String id;
@override final  String number;
@override final  BookingStatus status;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  int totalMinor;
@override final  String currency;
@override final  String? eventId;
@override final  BookingVendor? vendor;
 final  List<BookingItemLine> _lines;
@override@JsonKey() List<BookingItemLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

/// `delivery` or `pickup`.
@override final  String? fulfilment;
@override final  DateTime? respondBy;
@override final  String? customerNote;
/// Oldest first. Only on the booking's own page.
 final  List<BookingStep> _timeline;
/// Oldest first. Only on the booking's own page.
@override@JsonKey() List<BookingStep> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}


/// Create a copy of CustomerBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerBookingCopyWith<_CustomerBooking> get copyWith => __$CustomerBookingCopyWithImpl<_CustomerBooking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.fulfilment, fulfilment) || other.fulfilment == fulfilment)&&(identical(other.respondBy, respondBy) || other.respondBy == respondBy)&&(identical(other.customerNote, customerNote) || other.customerNote == customerNote)&&const DeepCollectionEquality().equals(other._timeline, _timeline));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,status,startsAt,endsAt,totalMinor,currency,eventId,vendor,const DeepCollectionEquality().hash(_lines),fulfilment,respondBy,customerNote,const DeepCollectionEquality().hash(_timeline));

@override
String toString() {
  return 'CustomerBooking(id: $id, number: $number, status: $status, startsAt: $startsAt, endsAt: $endsAt, totalMinor: $totalMinor, currency: $currency, eventId: $eventId, vendor: $vendor, lines: $lines, fulfilment: $fulfilment, respondBy: $respondBy, customerNote: $customerNote, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class _$CustomerBookingCopyWith<$Res> implements $CustomerBookingCopyWith<$Res> {
  factory _$CustomerBookingCopyWith(_CustomerBooking value, $Res Function(_CustomerBooking) _then) = __$CustomerBookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String number, BookingStatus status, DateTime startsAt, DateTime endsAt, int totalMinor, String currency, String? eventId, BookingVendor? vendor, List<BookingItemLine> lines, String? fulfilment, DateTime? respondBy, String? customerNote, List<BookingStep> timeline
});


@override $BookingVendorCopyWith<$Res>? get vendor;

}
/// @nodoc
class __$CustomerBookingCopyWithImpl<$Res>
    implements _$CustomerBookingCopyWith<$Res> {
  __$CustomerBookingCopyWithImpl(this._self, this._then);

  final _CustomerBooking _self;
  final $Res Function(_CustomerBooking) _then;

/// Create a copy of CustomerBooking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? status = null,Object? startsAt = null,Object? endsAt = null,Object? totalMinor = null,Object? currency = null,Object? eventId = freezed,Object? vendor = freezed,Object? lines = null,Object? fulfilment = freezed,Object? respondBy = freezed,Object? customerNote = freezed,Object? timeline = null,}) {
  return _then(_CustomerBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as BookingVendor?,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<BookingItemLine>,fulfilment: freezed == fulfilment ? _self.fulfilment : fulfilment // ignore: cast_nullable_to_non_nullable
as String?,respondBy: freezed == respondBy ? _self.respondBy : respondBy // ignore: cast_nullable_to_non_nullable
as DateTime?,customerNote: freezed == customerNote ? _self.customerNote : customerNote // ignore: cast_nullable_to_non_nullable
as String?,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<BookingStep>,
  ));
}

/// Create a copy of CustomerBooking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingVendorCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $BookingVendorCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}

/// @nodoc
mixin _$BookingRequest {

 String get eventId; String get vendorId; String get itemId; String get variantId; int get qty; Fulfilment get fulfilment; String? get note;
/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingRequestCopyWith<BookingRequest> get copyWith => _$BookingRequestCopyWithImpl<BookingRequest>(this as BookingRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingRequest&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.qty, qty) || other.qty == qty)&&(identical(other.fulfilment, fulfilment) || other.fulfilment == fulfilment)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,vendorId,itemId,variantId,qty,fulfilment,note);

@override
String toString() {
  return 'BookingRequest(eventId: $eventId, vendorId: $vendorId, itemId: $itemId, variantId: $variantId, qty: $qty, fulfilment: $fulfilment, note: $note)';
}


}

/// @nodoc
abstract mixin class $BookingRequestCopyWith<$Res>  {
  factory $BookingRequestCopyWith(BookingRequest value, $Res Function(BookingRequest) _then) = _$BookingRequestCopyWithImpl;
@useResult
$Res call({
 String eventId, String vendorId, String itemId, String variantId, int qty, Fulfilment fulfilment, String? note
});




}
/// @nodoc
class _$BookingRequestCopyWithImpl<$Res>
    implements $BookingRequestCopyWith<$Res> {
  _$BookingRequestCopyWithImpl(this._self, this._then);

  final BookingRequest _self;
  final $Res Function(BookingRequest) _then;

/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? vendorId = null,Object? itemId = null,Object? variantId = null,Object? qty = null,Object? fulfilment = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,variantId: null == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as String,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,fulfilment: null == fulfilment ? _self.fulfilment : fulfilment // ignore: cast_nullable_to_non_nullable
as Fulfilment,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingRequest].
extension BookingRequestPatterns on BookingRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingRequest value)  $default,){
final _that = this;
switch (_that) {
case _BookingRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingRequest value)?  $default,){
final _that = this;
switch (_that) {
case _BookingRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String vendorId,  String itemId,  String variantId,  int qty,  Fulfilment fulfilment,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingRequest() when $default != null:
return $default(_that.eventId,_that.vendorId,_that.itemId,_that.variantId,_that.qty,_that.fulfilment,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String vendorId,  String itemId,  String variantId,  int qty,  Fulfilment fulfilment,  String? note)  $default,) {final _that = this;
switch (_that) {
case _BookingRequest():
return $default(_that.eventId,_that.vendorId,_that.itemId,_that.variantId,_that.qty,_that.fulfilment,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String vendorId,  String itemId,  String variantId,  int qty,  Fulfilment fulfilment,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _BookingRequest() when $default != null:
return $default(_that.eventId,_that.vendorId,_that.itemId,_that.variantId,_that.qty,_that.fulfilment,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _BookingRequest implements BookingRequest {
  const _BookingRequest({required this.eventId, required this.vendorId, required this.itemId, required this.variantId, required this.qty, this.fulfilment = Fulfilment.delivery, this.note});
  

@override final  String eventId;
@override final  String vendorId;
@override final  String itemId;
@override final  String variantId;
@override final  int qty;
@override@JsonKey() final  Fulfilment fulfilment;
@override final  String? note;

/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingRequestCopyWith<_BookingRequest> get copyWith => __$BookingRequestCopyWithImpl<_BookingRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingRequest&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.qty, qty) || other.qty == qty)&&(identical(other.fulfilment, fulfilment) || other.fulfilment == fulfilment)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,vendorId,itemId,variantId,qty,fulfilment,note);

@override
String toString() {
  return 'BookingRequest(eventId: $eventId, vendorId: $vendorId, itemId: $itemId, variantId: $variantId, qty: $qty, fulfilment: $fulfilment, note: $note)';
}


}

/// @nodoc
abstract mixin class _$BookingRequestCopyWith<$Res> implements $BookingRequestCopyWith<$Res> {
  factory _$BookingRequestCopyWith(_BookingRequest value, $Res Function(_BookingRequest) _then) = __$BookingRequestCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String vendorId, String itemId, String variantId, int qty, Fulfilment fulfilment, String? note
});




}
/// @nodoc
class __$BookingRequestCopyWithImpl<$Res>
    implements _$BookingRequestCopyWith<$Res> {
  __$BookingRequestCopyWithImpl(this._self, this._then);

  final _BookingRequest _self;
  final $Res Function(_BookingRequest) _then;

/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? vendorId = null,Object? itemId = null,Object? variantId = null,Object? qty = null,Object? fulfilment = null,Object? note = freezed,}) {
  return _then(_BookingRequest(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,variantId: null == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as String,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,fulfilment: null == fulfilment ? _self.fulfilment : fulfilment // ignore: cast_nullable_to_non_nullable
as Fulfilment,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
