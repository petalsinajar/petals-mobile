// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventBooking {

 String get id; EventPerson get vendor; BookingStatus get status; DateTime get startsOn; DateTime get endsOn; int get totalMinor; String get currency; List<String> get itemTitles; int get itemQuantity;
/// Create a copy of EventBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventBookingCopyWith<EventBooking> get copyWith => _$EventBookingCopyWithImpl<EventBooking>(this as EventBooking, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.status, status) || other.status == status)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.itemTitles, itemTitles)&&(identical(other.itemQuantity, itemQuantity) || other.itemQuantity == itemQuantity));
}


@override
int get hashCode => Object.hash(runtimeType,id,vendor,status,startsOn,endsOn,totalMinor,currency,const DeepCollectionEquality().hash(itemTitles),itemQuantity);

@override
String toString() {
  return 'EventBooking(id: $id, vendor: $vendor, status: $status, startsOn: $startsOn, endsOn: $endsOn, totalMinor: $totalMinor, currency: $currency, itemTitles: $itemTitles, itemQuantity: $itemQuantity)';
}


}

/// @nodoc
abstract mixin class $EventBookingCopyWith<$Res>  {
  factory $EventBookingCopyWith(EventBooking value, $Res Function(EventBooking) _then) = _$EventBookingCopyWithImpl;
@useResult
$Res call({
 String id, EventPerson vendor, BookingStatus status, DateTime startsOn, DateTime endsOn, int totalMinor, String currency, List<String> itemTitles, int itemQuantity
});


$EventPersonCopyWith<$Res> get vendor;

}
/// @nodoc
class _$EventBookingCopyWithImpl<$Res>
    implements $EventBookingCopyWith<$Res> {
  _$EventBookingCopyWithImpl(this._self, this._then);

  final EventBooking _self;
  final $Res Function(EventBooking) _then;

/// Create a copy of EventBooking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vendor = null,Object? status = null,Object? startsOn = null,Object? endsOn = null,Object? totalMinor = null,Object? currency = null,Object? itemTitles = null,Object? itemQuantity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as EventPerson,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime,endsOn: null == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,itemTitles: null == itemTitles ? _self.itemTitles : itemTitles // ignore: cast_nullable_to_non_nullable
as List<String>,itemQuantity: null == itemQuantity ? _self.itemQuantity : itemQuantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of EventBooking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventPersonCopyWith<$Res> get vendor {
  
  return $EventPersonCopyWith<$Res>(_self.vendor, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventBooking].
extension EventBookingPatterns on EventBooking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventBooking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventBooking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventBooking value)  $default,){
final _that = this;
switch (_that) {
case _EventBooking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventBooking value)?  $default,){
final _that = this;
switch (_that) {
case _EventBooking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  EventPerson vendor,  BookingStatus status,  DateTime startsOn,  DateTime endsOn,  int totalMinor,  String currency,  List<String> itemTitles,  int itemQuantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventBooking() when $default != null:
return $default(_that.id,_that.vendor,_that.status,_that.startsOn,_that.endsOn,_that.totalMinor,_that.currency,_that.itemTitles,_that.itemQuantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  EventPerson vendor,  BookingStatus status,  DateTime startsOn,  DateTime endsOn,  int totalMinor,  String currency,  List<String> itemTitles,  int itemQuantity)  $default,) {final _that = this;
switch (_that) {
case _EventBooking():
return $default(_that.id,_that.vendor,_that.status,_that.startsOn,_that.endsOn,_that.totalMinor,_that.currency,_that.itemTitles,_that.itemQuantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  EventPerson vendor,  BookingStatus status,  DateTime startsOn,  DateTime endsOn,  int totalMinor,  String currency,  List<String> itemTitles,  int itemQuantity)?  $default,) {final _that = this;
switch (_that) {
case _EventBooking() when $default != null:
return $default(_that.id,_that.vendor,_that.status,_that.startsOn,_that.endsOn,_that.totalMinor,_that.currency,_that.itemTitles,_that.itemQuantity);case _:
  return null;

}
}

}

/// @nodoc


class _EventBooking implements EventBooking {
  const _EventBooking({required this.id, required this.vendor, required this.status, required this.startsOn, required this.endsOn, required this.totalMinor, required this.currency, final  List<String> itemTitles = const <String>[], this.itemQuantity = 0}): _itemTitles = itemTitles;
  

@override final  String id;
@override final  EventPerson vendor;
@override final  BookingStatus status;
@override final  DateTime startsOn;
@override final  DateTime endsOn;
@override final  int totalMinor;
@override final  String currency;
 final  List<String> _itemTitles;
@override@JsonKey() List<String> get itemTitles {
  if (_itemTitles is EqualUnmodifiableListView) return _itemTitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_itemTitles);
}

@override@JsonKey() final  int itemQuantity;

/// Create a copy of EventBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventBookingCopyWith<_EventBooking> get copyWith => __$EventBookingCopyWithImpl<_EventBooking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.status, status) || other.status == status)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._itemTitles, _itemTitles)&&(identical(other.itemQuantity, itemQuantity) || other.itemQuantity == itemQuantity));
}


@override
int get hashCode => Object.hash(runtimeType,id,vendor,status,startsOn,endsOn,totalMinor,currency,const DeepCollectionEquality().hash(_itemTitles),itemQuantity);

@override
String toString() {
  return 'EventBooking(id: $id, vendor: $vendor, status: $status, startsOn: $startsOn, endsOn: $endsOn, totalMinor: $totalMinor, currency: $currency, itemTitles: $itemTitles, itemQuantity: $itemQuantity)';
}


}

/// @nodoc
abstract mixin class _$EventBookingCopyWith<$Res> implements $EventBookingCopyWith<$Res> {
  factory _$EventBookingCopyWith(_EventBooking value, $Res Function(_EventBooking) _then) = __$EventBookingCopyWithImpl;
@override @useResult
$Res call({
 String id, EventPerson vendor, BookingStatus status, DateTime startsOn, DateTime endsOn, int totalMinor, String currency, List<String> itemTitles, int itemQuantity
});


@override $EventPersonCopyWith<$Res> get vendor;

}
/// @nodoc
class __$EventBookingCopyWithImpl<$Res>
    implements _$EventBookingCopyWith<$Res> {
  __$EventBookingCopyWithImpl(this._self, this._then);

  final _EventBooking _self;
  final $Res Function(_EventBooking) _then;

/// Create a copy of EventBooking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vendor = null,Object? status = null,Object? startsOn = null,Object? endsOn = null,Object? totalMinor = null,Object? currency = null,Object? itemTitles = null,Object? itemQuantity = null,}) {
  return _then(_EventBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as EventPerson,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime,endsOn: null == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,itemTitles: null == itemTitles ? _self._itemTitles : itemTitles // ignore: cast_nullable_to_non_nullable
as List<String>,itemQuantity: null == itemQuantity ? _self.itemQuantity : itemQuantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of EventBooking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventPersonCopyWith<$Res> get vendor {
  
  return $EventPersonCopyWith<$Res>(_self.vendor, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}

/// @nodoc
mixin _$EventCartLine {

 String get itemId; String get title; String get vendorName; int get quantity; int get lineTotalMinor; String get currency;
/// Create a copy of EventCartLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCartLineCopyWith<EventCartLine> get copyWith => _$EventCartLineCopyWithImpl<EventCartLine>(this as EventCartLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventCartLine&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.title, title) || other.title == title)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lineTotalMinor, lineTotalMinor) || other.lineTotalMinor == lineTotalMinor)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode => Object.hash(runtimeType,itemId,title,vendorName,quantity,lineTotalMinor,currency);

@override
String toString() {
  return 'EventCartLine(itemId: $itemId, title: $title, vendorName: $vendorName, quantity: $quantity, lineTotalMinor: $lineTotalMinor, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $EventCartLineCopyWith<$Res>  {
  factory $EventCartLineCopyWith(EventCartLine value, $Res Function(EventCartLine) _then) = _$EventCartLineCopyWithImpl;
@useResult
$Res call({
 String itemId, String title, String vendorName, int quantity, int lineTotalMinor, String currency
});




}
/// @nodoc
class _$EventCartLineCopyWithImpl<$Res>
    implements $EventCartLineCopyWith<$Res> {
  _$EventCartLineCopyWithImpl(this._self, this._then);

  final EventCartLine _self;
  final $Res Function(EventCartLine) _then;

/// Create a copy of EventCartLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemId = null,Object? title = null,Object? vendorName = null,Object? quantity = null,Object? lineTotalMinor = null,Object? currency = null,}) {
  return _then(_self.copyWith(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lineTotalMinor: null == lineTotalMinor ? _self.lineTotalMinor : lineTotalMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EventCartLine].
extension EventCartLinePatterns on EventCartLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventCartLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventCartLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventCartLine value)  $default,){
final _that = this;
switch (_that) {
case _EventCartLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventCartLine value)?  $default,){
final _that = this;
switch (_that) {
case _EventCartLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String itemId,  String title,  String vendorName,  int quantity,  int lineTotalMinor,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventCartLine() when $default != null:
return $default(_that.itemId,_that.title,_that.vendorName,_that.quantity,_that.lineTotalMinor,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String itemId,  String title,  String vendorName,  int quantity,  int lineTotalMinor,  String currency)  $default,) {final _that = this;
switch (_that) {
case _EventCartLine():
return $default(_that.itemId,_that.title,_that.vendorName,_that.quantity,_that.lineTotalMinor,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String itemId,  String title,  String vendorName,  int quantity,  int lineTotalMinor,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _EventCartLine() when $default != null:
return $default(_that.itemId,_that.title,_that.vendorName,_that.quantity,_that.lineTotalMinor,_that.currency);case _:
  return null;

}
}

}

/// @nodoc


class _EventCartLine implements EventCartLine {
  const _EventCartLine({required this.itemId, required this.title, required this.vendorName, required this.quantity, required this.lineTotalMinor, required this.currency});
  

@override final  String itemId;
@override final  String title;
@override final  String vendorName;
@override final  int quantity;
@override final  int lineTotalMinor;
@override final  String currency;

/// Create a copy of EventCartLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCartLineCopyWith<_EventCartLine> get copyWith => __$EventCartLineCopyWithImpl<_EventCartLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventCartLine&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.title, title) || other.title == title)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lineTotalMinor, lineTotalMinor) || other.lineTotalMinor == lineTotalMinor)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode => Object.hash(runtimeType,itemId,title,vendorName,quantity,lineTotalMinor,currency);

@override
String toString() {
  return 'EventCartLine(itemId: $itemId, title: $title, vendorName: $vendorName, quantity: $quantity, lineTotalMinor: $lineTotalMinor, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$EventCartLineCopyWith<$Res> implements $EventCartLineCopyWith<$Res> {
  factory _$EventCartLineCopyWith(_EventCartLine value, $Res Function(_EventCartLine) _then) = __$EventCartLineCopyWithImpl;
@override @useResult
$Res call({
 String itemId, String title, String vendorName, int quantity, int lineTotalMinor, String currency
});




}
/// @nodoc
class __$EventCartLineCopyWithImpl<$Res>
    implements _$EventCartLineCopyWith<$Res> {
  __$EventCartLineCopyWithImpl(this._self, this._then);

  final _EventCartLine _self;
  final $Res Function(_EventCartLine) _then;

/// Create a copy of EventCartLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemId = null,Object? title = null,Object? vendorName = null,Object? quantity = null,Object? lineTotalMinor = null,Object? currency = null,}) {
  return _then(_EventCartLine(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lineTotalMinor: null == lineTotalMinor ? _self.lineTotalMinor : lineTotalMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$EventPlan {

 List<EventBooking> get bookings; List<EventCartLine> get cart;
/// Create a copy of EventPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventPlanCopyWith<EventPlan> get copyWith => _$EventPlanCopyWithImpl<EventPlan>(this as EventPlan, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventPlan&&const DeepCollectionEquality().equals(other.bookings, bookings)&&const DeepCollectionEquality().equals(other.cart, cart));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bookings),const DeepCollectionEquality().hash(cart));

@override
String toString() {
  return 'EventPlan(bookings: $bookings, cart: $cart)';
}


}

/// @nodoc
abstract mixin class $EventPlanCopyWith<$Res>  {
  factory $EventPlanCopyWith(EventPlan value, $Res Function(EventPlan) _then) = _$EventPlanCopyWithImpl;
@useResult
$Res call({
 List<EventBooking> bookings, List<EventCartLine> cart
});




}
/// @nodoc
class _$EventPlanCopyWithImpl<$Res>
    implements $EventPlanCopyWith<$Res> {
  _$EventPlanCopyWithImpl(this._self, this._then);

  final EventPlan _self;
  final $Res Function(EventPlan) _then;

/// Create a copy of EventPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookings = null,Object? cart = null,}) {
  return _then(_self.copyWith(
bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<EventBooking>,cart: null == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as List<EventCartLine>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventPlan].
extension EventPlanPatterns on EventPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventPlan value)  $default,){
final _that = this;
switch (_that) {
case _EventPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventPlan value)?  $default,){
final _that = this;
switch (_that) {
case _EventPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EventBooking> bookings,  List<EventCartLine> cart)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventPlan() when $default != null:
return $default(_that.bookings,_that.cart);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EventBooking> bookings,  List<EventCartLine> cart)  $default,) {final _that = this;
switch (_that) {
case _EventPlan():
return $default(_that.bookings,_that.cart);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EventBooking> bookings,  List<EventCartLine> cart)?  $default,) {final _that = this;
switch (_that) {
case _EventPlan() when $default != null:
return $default(_that.bookings,_that.cart);case _:
  return null;

}
}

}

/// @nodoc


class _EventPlan extends EventPlan {
  const _EventPlan({final  List<EventBooking> bookings = const <EventBooking>[], final  List<EventCartLine> cart = const <EventCartLine>[]}): _bookings = bookings,_cart = cart,super._();
  

 final  List<EventBooking> _bookings;
@override@JsonKey() List<EventBooking> get bookings {
  if (_bookings is EqualUnmodifiableListView) return _bookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookings);
}

 final  List<EventCartLine> _cart;
@override@JsonKey() List<EventCartLine> get cart {
  if (_cart is EqualUnmodifiableListView) return _cart;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cart);
}


/// Create a copy of EventPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventPlanCopyWith<_EventPlan> get copyWith => __$EventPlanCopyWithImpl<_EventPlan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPlan&&const DeepCollectionEquality().equals(other._bookings, _bookings)&&const DeepCollectionEquality().equals(other._cart, _cart));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_bookings),const DeepCollectionEquality().hash(_cart));

@override
String toString() {
  return 'EventPlan(bookings: $bookings, cart: $cart)';
}


}

/// @nodoc
abstract mixin class _$EventPlanCopyWith<$Res> implements $EventPlanCopyWith<$Res> {
  factory _$EventPlanCopyWith(_EventPlan value, $Res Function(_EventPlan) _then) = __$EventPlanCopyWithImpl;
@override @useResult
$Res call({
 List<EventBooking> bookings, List<EventCartLine> cart
});




}
/// @nodoc
class __$EventPlanCopyWithImpl<$Res>
    implements _$EventPlanCopyWith<$Res> {
  __$EventPlanCopyWithImpl(this._self, this._then);

  final _EventPlan _self;
  final $Res Function(_EventPlan) _then;

/// Create a copy of EventPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookings = null,Object? cart = null,}) {
  return _then(_EventPlan(
bookings: null == bookings ? _self._bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<EventBooking>,cart: null == cart ? _self._cart : cart // ignore: cast_nullable_to_non_nullable
as List<EventCartLine>,
  ));
}


}

// dart format on
