// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventImage {

 String get url; String? get blurhash; int? get width; int? get height;
/// Create a copy of EventImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventImageCopyWith<EventImage> get copyWith => _$EventImageCopyWithImpl<EventImage>(this as EventImage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventImage&&(identical(other.url, url) || other.url == url)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}


@override
int get hashCode => Object.hash(runtimeType,url,blurhash,width,height);

@override
String toString() {
  return 'EventImage(url: $url, blurhash: $blurhash, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class $EventImageCopyWith<$Res>  {
  factory $EventImageCopyWith(EventImage value, $Res Function(EventImage) _then) = _$EventImageCopyWithImpl;
@useResult
$Res call({
 String url, String? blurhash, int? width, int? height
});




}
/// @nodoc
class _$EventImageCopyWithImpl<$Res>
    implements $EventImageCopyWith<$Res> {
  _$EventImageCopyWithImpl(this._self, this._then);

  final EventImage _self;
  final $Res Function(EventImage) _then;

/// Create a copy of EventImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? blurhash = freezed,Object? width = freezed,Object? height = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventImage].
extension EventImagePatterns on EventImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventImage value)  $default,){
final _that = this;
switch (_that) {
case _EventImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventImage value)?  $default,){
final _that = this;
switch (_that) {
case _EventImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String? blurhash,  int? width,  int? height)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventImage() when $default != null:
return $default(_that.url,_that.blurhash,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String? blurhash,  int? width,  int? height)  $default,) {final _that = this;
switch (_that) {
case _EventImage():
return $default(_that.url,_that.blurhash,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String? blurhash,  int? width,  int? height)?  $default,) {final _that = this;
switch (_that) {
case _EventImage() when $default != null:
return $default(_that.url,_that.blurhash,_that.width,_that.height);case _:
  return null;

}
}

}

/// @nodoc


class _EventImage implements EventImage {
  const _EventImage({required this.url, this.blurhash, this.width, this.height});
  

@override final  String url;
@override final  String? blurhash;
@override final  int? width;
@override final  int? height;

/// Create a copy of EventImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventImageCopyWith<_EventImage> get copyWith => __$EventImageCopyWithImpl<_EventImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventImage&&(identical(other.url, url) || other.url == url)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}


@override
int get hashCode => Object.hash(runtimeType,url,blurhash,width,height);

@override
String toString() {
  return 'EventImage(url: $url, blurhash: $blurhash, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class _$EventImageCopyWith<$Res> implements $EventImageCopyWith<$Res> {
  factory _$EventImageCopyWith(_EventImage value, $Res Function(_EventImage) _then) = __$EventImageCopyWithImpl;
@override @useResult
$Res call({
 String url, String? blurhash, int? width, int? height
});




}
/// @nodoc
class __$EventImageCopyWithImpl<$Res>
    implements _$EventImageCopyWith<$Res> {
  __$EventImageCopyWithImpl(this._self, this._then);

  final _EventImage _self;
  final $Res Function(_EventImage) _then;

/// Create a copy of EventImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? blurhash = freezed,Object? width = freezed,Object? height = freezed,}) {
  return _then(_EventImage(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$EventVenue {

 String get name; String get city; String? get address;
/// Create a copy of EventVenue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventVenueCopyWith<EventVenue> get copyWith => _$EventVenueCopyWithImpl<EventVenue>(this as EventVenue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventVenue&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,name,city,address);

@override
String toString() {
  return 'EventVenue(name: $name, city: $city, address: $address)';
}


}

/// @nodoc
abstract mixin class $EventVenueCopyWith<$Res>  {
  factory $EventVenueCopyWith(EventVenue value, $Res Function(EventVenue) _then) = _$EventVenueCopyWithImpl;
@useResult
$Res call({
 String name, String city, String? address
});




}
/// @nodoc
class _$EventVenueCopyWithImpl<$Res>
    implements $EventVenueCopyWith<$Res> {
  _$EventVenueCopyWithImpl(this._self, this._then);

  final EventVenue _self;
  final $Res Function(EventVenue) _then;

/// Create a copy of EventVenue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? city = null,Object? address = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventVenue].
extension EventVenuePatterns on EventVenue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventVenue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventVenue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventVenue value)  $default,){
final _that = this;
switch (_that) {
case _EventVenue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventVenue value)?  $default,){
final _that = this;
switch (_that) {
case _EventVenue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String city,  String? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventVenue() when $default != null:
return $default(_that.name,_that.city,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String city,  String? address)  $default,) {final _that = this;
switch (_that) {
case _EventVenue():
return $default(_that.name,_that.city,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String city,  String? address)?  $default,) {final _that = this;
switch (_that) {
case _EventVenue() when $default != null:
return $default(_that.name,_that.city,_that.address);case _:
  return null;

}
}

}

/// @nodoc


class _EventVenue implements EventVenue {
  const _EventVenue({required this.name, required this.city, this.address});
  

@override final  String name;
@override final  String city;
@override final  String? address;

/// Create a copy of EventVenue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventVenueCopyWith<_EventVenue> get copyWith => __$EventVenueCopyWithImpl<_EventVenue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventVenue&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,name,city,address);

@override
String toString() {
  return 'EventVenue(name: $name, city: $city, address: $address)';
}


}

/// @nodoc
abstract mixin class _$EventVenueCopyWith<$Res> implements $EventVenueCopyWith<$Res> {
  factory _$EventVenueCopyWith(_EventVenue value, $Res Function(_EventVenue) _then) = __$EventVenueCopyWithImpl;
@override @useResult
$Res call({
 String name, String city, String? address
});




}
/// @nodoc
class __$EventVenueCopyWithImpl<$Res>
    implements _$EventVenueCopyWith<$Res> {
  __$EventVenueCopyWithImpl(this._self, this._then);

  final _EventVenue _self;
  final $Res Function(_EventVenue) _then;

/// Create a copy of EventVenue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? city = null,Object? address = freezed,}) {
  return _then(_EventVenue(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$RsvpCounts {

 int get going; int get maybe; int get declined; int get invited;
/// Create a copy of RsvpCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RsvpCountsCopyWith<RsvpCounts> get copyWith => _$RsvpCountsCopyWithImpl<RsvpCounts>(this as RsvpCounts, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RsvpCounts&&(identical(other.going, going) || other.going == going)&&(identical(other.maybe, maybe) || other.maybe == maybe)&&(identical(other.declined, declined) || other.declined == declined)&&(identical(other.invited, invited) || other.invited == invited));
}


@override
int get hashCode => Object.hash(runtimeType,going,maybe,declined,invited);

@override
String toString() {
  return 'RsvpCounts(going: $going, maybe: $maybe, declined: $declined, invited: $invited)';
}


}

/// @nodoc
abstract mixin class $RsvpCountsCopyWith<$Res>  {
  factory $RsvpCountsCopyWith(RsvpCounts value, $Res Function(RsvpCounts) _then) = _$RsvpCountsCopyWithImpl;
@useResult
$Res call({
 int going, int maybe, int declined, int invited
});




}
/// @nodoc
class _$RsvpCountsCopyWithImpl<$Res>
    implements $RsvpCountsCopyWith<$Res> {
  _$RsvpCountsCopyWithImpl(this._self, this._then);

  final RsvpCounts _self;
  final $Res Function(RsvpCounts) _then;

/// Create a copy of RsvpCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? going = null,Object? maybe = null,Object? declined = null,Object? invited = null,}) {
  return _then(_self.copyWith(
going: null == going ? _self.going : going // ignore: cast_nullable_to_non_nullable
as int,maybe: null == maybe ? _self.maybe : maybe // ignore: cast_nullable_to_non_nullable
as int,declined: null == declined ? _self.declined : declined // ignore: cast_nullable_to_non_nullable
as int,invited: null == invited ? _self.invited : invited // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RsvpCounts].
extension RsvpCountsPatterns on RsvpCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RsvpCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RsvpCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RsvpCounts value)  $default,){
final _that = this;
switch (_that) {
case _RsvpCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RsvpCounts value)?  $default,){
final _that = this;
switch (_that) {
case _RsvpCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int going,  int maybe,  int declined,  int invited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RsvpCounts() when $default != null:
return $default(_that.going,_that.maybe,_that.declined,_that.invited);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int going,  int maybe,  int declined,  int invited)  $default,) {final _that = this;
switch (_that) {
case _RsvpCounts():
return $default(_that.going,_that.maybe,_that.declined,_that.invited);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int going,  int maybe,  int declined,  int invited)?  $default,) {final _that = this;
switch (_that) {
case _RsvpCounts() when $default != null:
return $default(_that.going,_that.maybe,_that.declined,_that.invited);case _:
  return null;

}
}

}

/// @nodoc


class _RsvpCounts extends RsvpCounts {
  const _RsvpCounts({this.going = 0, this.maybe = 0, this.declined = 0, this.invited = 0}): super._();
  

@override@JsonKey() final  int going;
@override@JsonKey() final  int maybe;
@override@JsonKey() final  int declined;
@override@JsonKey() final  int invited;

/// Create a copy of RsvpCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RsvpCountsCopyWith<_RsvpCounts> get copyWith => __$RsvpCountsCopyWithImpl<_RsvpCounts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RsvpCounts&&(identical(other.going, going) || other.going == going)&&(identical(other.maybe, maybe) || other.maybe == maybe)&&(identical(other.declined, declined) || other.declined == declined)&&(identical(other.invited, invited) || other.invited == invited));
}


@override
int get hashCode => Object.hash(runtimeType,going,maybe,declined,invited);

@override
String toString() {
  return 'RsvpCounts(going: $going, maybe: $maybe, declined: $declined, invited: $invited)';
}


}

/// @nodoc
abstract mixin class _$RsvpCountsCopyWith<$Res> implements $RsvpCountsCopyWith<$Res> {
  factory _$RsvpCountsCopyWith(_RsvpCounts value, $Res Function(_RsvpCounts) _then) = __$RsvpCountsCopyWithImpl;
@override @useResult
$Res call({
 int going, int maybe, int declined, int invited
});




}
/// @nodoc
class __$RsvpCountsCopyWithImpl<$Res>
    implements _$RsvpCountsCopyWith<$Res> {
  __$RsvpCountsCopyWithImpl(this._self, this._then);

  final _RsvpCounts _self;
  final $Res Function(_RsvpCounts) _then;

/// Create a copy of RsvpCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? going = null,Object? maybe = null,Object? declined = null,Object? invited = null,}) {
  return _then(_RsvpCounts(
going: null == going ? _self.going : going // ignore: cast_nullable_to_non_nullable
as int,maybe: null == maybe ? _self.maybe : maybe // ignore: cast_nullable_to_non_nullable
as int,declined: null == declined ? _self.declined : declined // ignore: cast_nullable_to_non_nullable
as int,invited: null == invited ? _self.invited : invited // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Event {

 String get id; EventType get type; String get title; DateTime get startsAt; EventVenue get venue; int get guestCount; EventVisibility get visibility; String get hostId; DateTime get createdAt; String get description; DateTime? get endsAt; EventImage? get cover; List<String> get coHostIds; RsvpCounts get rsvpCounts; ViewerRole get viewerRole; RsvpStatus? get viewerRsvp;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.guestCount, guestCount) || other.guestCount == guestCount)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.hostId, hostId) || other.hostId == hostId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.cover, cover) || other.cover == cover)&&const DeepCollectionEquality().equals(other.coHostIds, coHostIds)&&(identical(other.rsvpCounts, rsvpCounts) || other.rsvpCounts == rsvpCounts)&&(identical(other.viewerRole, viewerRole) || other.viewerRole == viewerRole)&&(identical(other.viewerRsvp, viewerRsvp) || other.viewerRsvp == viewerRsvp));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,startsAt,venue,guestCount,visibility,hostId,createdAt,description,endsAt,cover,const DeepCollectionEquality().hash(coHostIds),rsvpCounts,viewerRole,viewerRsvp);

@override
String toString() {
  return 'Event(id: $id, type: $type, title: $title, startsAt: $startsAt, venue: $venue, guestCount: $guestCount, visibility: $visibility, hostId: $hostId, createdAt: $createdAt, description: $description, endsAt: $endsAt, cover: $cover, coHostIds: $coHostIds, rsvpCounts: $rsvpCounts, viewerRole: $viewerRole, viewerRsvp: $viewerRsvp)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id, EventType type, String title, DateTime startsAt, EventVenue venue, int guestCount, EventVisibility visibility, String hostId, DateTime createdAt, String description, DateTime? endsAt, EventImage? cover, List<String> coHostIds, RsvpCounts rsvpCounts, ViewerRole viewerRole, RsvpStatus? viewerRsvp
});


$EventVenueCopyWith<$Res> get venue;$EventImageCopyWith<$Res>? get cover;$RsvpCountsCopyWith<$Res> get rsvpCounts;

}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = null,Object? venue = null,Object? guestCount = null,Object? visibility = null,Object? hostId = null,Object? createdAt = null,Object? description = null,Object? endsAt = freezed,Object? cover = freezed,Object? coHostIds = null,Object? rsvpCounts = null,Object? viewerRole = null,Object? viewerRsvp = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as EventVenue,guestCount: null == guestCount ? _self.guestCount : guestCount // ignore: cast_nullable_to_non_nullable
as int,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as EventVisibility,hostId: null == hostId ? _self.hostId : hostId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as EventImage?,coHostIds: null == coHostIds ? _self.coHostIds : coHostIds // ignore: cast_nullable_to_non_nullable
as List<String>,rsvpCounts: null == rsvpCounts ? _self.rsvpCounts : rsvpCounts // ignore: cast_nullable_to_non_nullable
as RsvpCounts,viewerRole: null == viewerRole ? _self.viewerRole : viewerRole // ignore: cast_nullable_to_non_nullable
as ViewerRole,viewerRsvp: freezed == viewerRsvp ? _self.viewerRsvp : viewerRsvp // ignore: cast_nullable_to_non_nullable
as RsvpStatus?,
  ));
}
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventVenueCopyWith<$Res> get venue {
  
  return $EventVenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get cover {
    if (_self.cover == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.cover!, (value) {
    return _then(_self.copyWith(cover: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RsvpCountsCopyWith<$Res> get rsvpCounts {
  
  return $RsvpCountsCopyWith<$Res>(_self.rsvpCounts, (value) {
    return _then(_self.copyWith(rsvpCounts: value));
  });
}
}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Event value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Event value)  $default,){
final _that = this;
switch (_that) {
case _Event():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Event value)?  $default,){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  EventType type,  String title,  DateTime startsAt,  EventVenue venue,  int guestCount,  EventVisibility visibility,  String hostId,  DateTime createdAt,  String description,  DateTime? endsAt,  EventImage? cover,  List<String> coHostIds,  RsvpCounts rsvpCounts,  ViewerRole viewerRole,  RsvpStatus? viewerRsvp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.venue,_that.guestCount,_that.visibility,_that.hostId,_that.createdAt,_that.description,_that.endsAt,_that.cover,_that.coHostIds,_that.rsvpCounts,_that.viewerRole,_that.viewerRsvp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  EventType type,  String title,  DateTime startsAt,  EventVenue venue,  int guestCount,  EventVisibility visibility,  String hostId,  DateTime createdAt,  String description,  DateTime? endsAt,  EventImage? cover,  List<String> coHostIds,  RsvpCounts rsvpCounts,  ViewerRole viewerRole,  RsvpStatus? viewerRsvp)  $default,) {final _that = this;
switch (_that) {
case _Event():
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.venue,_that.guestCount,_that.visibility,_that.hostId,_that.createdAt,_that.description,_that.endsAt,_that.cover,_that.coHostIds,_that.rsvpCounts,_that.viewerRole,_that.viewerRsvp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  EventType type,  String title,  DateTime startsAt,  EventVenue venue,  int guestCount,  EventVisibility visibility,  String hostId,  DateTime createdAt,  String description,  DateTime? endsAt,  EventImage? cover,  List<String> coHostIds,  RsvpCounts rsvpCounts,  ViewerRole viewerRole,  RsvpStatus? viewerRsvp)?  $default,) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.venue,_that.guestCount,_that.visibility,_that.hostId,_that.createdAt,_that.description,_that.endsAt,_that.cover,_that.coHostIds,_that.rsvpCounts,_that.viewerRole,_that.viewerRsvp);case _:
  return null;

}
}

}

/// @nodoc


class _Event extends Event {
  const _Event({required this.id, required this.type, required this.title, required this.startsAt, required this.venue, required this.guestCount, required this.visibility, required this.hostId, required this.createdAt, this.description = '', this.endsAt, this.cover, final  List<String> coHostIds = const <String>[], this.rsvpCounts = const RsvpCounts(), this.viewerRole = ViewerRole.none, this.viewerRsvp}): _coHostIds = coHostIds,super._();
  

@override final  String id;
@override final  EventType type;
@override final  String title;
@override final  DateTime startsAt;
@override final  EventVenue venue;
@override final  int guestCount;
@override final  EventVisibility visibility;
@override final  String hostId;
@override final  DateTime createdAt;
@override@JsonKey() final  String description;
@override final  DateTime? endsAt;
@override final  EventImage? cover;
 final  List<String> _coHostIds;
@override@JsonKey() List<String> get coHostIds {
  if (_coHostIds is EqualUnmodifiableListView) return _coHostIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coHostIds);
}

@override@JsonKey() final  RsvpCounts rsvpCounts;
@override@JsonKey() final  ViewerRole viewerRole;
@override final  RsvpStatus? viewerRsvp;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.guestCount, guestCount) || other.guestCount == guestCount)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.hostId, hostId) || other.hostId == hostId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.cover, cover) || other.cover == cover)&&const DeepCollectionEquality().equals(other._coHostIds, _coHostIds)&&(identical(other.rsvpCounts, rsvpCounts) || other.rsvpCounts == rsvpCounts)&&(identical(other.viewerRole, viewerRole) || other.viewerRole == viewerRole)&&(identical(other.viewerRsvp, viewerRsvp) || other.viewerRsvp == viewerRsvp));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,startsAt,venue,guestCount,visibility,hostId,createdAt,description,endsAt,cover,const DeepCollectionEquality().hash(_coHostIds),rsvpCounts,viewerRole,viewerRsvp);

@override
String toString() {
  return 'Event(id: $id, type: $type, title: $title, startsAt: $startsAt, venue: $venue, guestCount: $guestCount, visibility: $visibility, hostId: $hostId, createdAt: $createdAt, description: $description, endsAt: $endsAt, cover: $cover, coHostIds: $coHostIds, rsvpCounts: $rsvpCounts, viewerRole: $viewerRole, viewerRsvp: $viewerRsvp)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id, EventType type, String title, DateTime startsAt, EventVenue venue, int guestCount, EventVisibility visibility, String hostId, DateTime createdAt, String description, DateTime? endsAt, EventImage? cover, List<String> coHostIds, RsvpCounts rsvpCounts, ViewerRole viewerRole, RsvpStatus? viewerRsvp
});


@override $EventVenueCopyWith<$Res> get venue;@override $EventImageCopyWith<$Res>? get cover;@override $RsvpCountsCopyWith<$Res> get rsvpCounts;

}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = null,Object? venue = null,Object? guestCount = null,Object? visibility = null,Object? hostId = null,Object? createdAt = null,Object? description = null,Object? endsAt = freezed,Object? cover = freezed,Object? coHostIds = null,Object? rsvpCounts = null,Object? viewerRole = null,Object? viewerRsvp = freezed,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as EventVenue,guestCount: null == guestCount ? _self.guestCount : guestCount // ignore: cast_nullable_to_non_nullable
as int,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as EventVisibility,hostId: null == hostId ? _self.hostId : hostId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as EventImage?,coHostIds: null == coHostIds ? _self._coHostIds : coHostIds // ignore: cast_nullable_to_non_nullable
as List<String>,rsvpCounts: null == rsvpCounts ? _self.rsvpCounts : rsvpCounts // ignore: cast_nullable_to_non_nullable
as RsvpCounts,viewerRole: null == viewerRole ? _self.viewerRole : viewerRole // ignore: cast_nullable_to_non_nullable
as ViewerRole,viewerRsvp: freezed == viewerRsvp ? _self.viewerRsvp : viewerRsvp // ignore: cast_nullable_to_non_nullable
as RsvpStatus?,
  ));
}

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventVenueCopyWith<$Res> get venue {
  
  return $EventVenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get cover {
    if (_self.cover == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.cover!, (value) {
    return _then(_self.copyWith(cover: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RsvpCountsCopyWith<$Res> get rsvpCounts {
  
  return $RsvpCountsCopyWith<$Res>(_self.rsvpCounts, (value) {
    return _then(_self.copyWith(rsvpCounts: value));
  });
}
}

// dart format on
