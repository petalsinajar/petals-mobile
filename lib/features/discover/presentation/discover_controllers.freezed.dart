// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discover_controllers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiscoverFilter {

 DiscoverPlace? get place;/// Null for "All".
 EventType? get eventType; PlaceStatus get status;
/// Create a copy of DiscoverFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverFilterCopyWith<DiscoverFilter> get copyWith => _$DiscoverFilterCopyWithImpl<DiscoverFilter>(this as DiscoverFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverFilter&&(identical(other.place, place) || other.place == place)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,place,eventType,status);

@override
String toString() {
  return 'DiscoverFilter(place: $place, eventType: $eventType, status: $status)';
}


}

/// @nodoc
abstract mixin class $DiscoverFilterCopyWith<$Res>  {
  factory $DiscoverFilterCopyWith(DiscoverFilter value, $Res Function(DiscoverFilter) _then) = _$DiscoverFilterCopyWithImpl;
@useResult
$Res call({
 DiscoverPlace? place, EventType? eventType, PlaceStatus status
});


$DiscoverPlaceCopyWith<$Res>? get place;

}
/// @nodoc
class _$DiscoverFilterCopyWithImpl<$Res>
    implements $DiscoverFilterCopyWith<$Res> {
  _$DiscoverFilterCopyWithImpl(this._self, this._then);

  final DiscoverFilter _self;
  final $Res Function(DiscoverFilter) _then;

/// Create a copy of DiscoverFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? place = freezed,Object? eventType = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as DiscoverPlace?,eventType: freezed == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventType?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlaceStatus,
  ));
}
/// Create a copy of DiscoverFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscoverPlaceCopyWith<$Res>? get place {
    if (_self.place == null) {
    return null;
  }

  return $DiscoverPlaceCopyWith<$Res>(_self.place!, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// Adds pattern-matching-related methods to [DiscoverFilter].
extension DiscoverFilterPatterns on DiscoverFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscoverFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscoverFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscoverFilter value)  $default,){
final _that = this;
switch (_that) {
case _DiscoverFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscoverFilter value)?  $default,){
final _that = this;
switch (_that) {
case _DiscoverFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DiscoverPlace? place,  EventType? eventType,  PlaceStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscoverFilter() when $default != null:
return $default(_that.place,_that.eventType,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DiscoverPlace? place,  EventType? eventType,  PlaceStatus status)  $default,) {final _that = this;
switch (_that) {
case _DiscoverFilter():
return $default(_that.place,_that.eventType,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DiscoverPlace? place,  EventType? eventType,  PlaceStatus status)?  $default,) {final _that = this;
switch (_that) {
case _DiscoverFilter() when $default != null:
return $default(_that.place,_that.eventType,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _DiscoverFilter extends DiscoverFilter {
  const _DiscoverFilter({this.place, this.eventType, this.status = PlaceStatus.locating}): super._();
  

@override final  DiscoverPlace? place;
/// Null for "All".
@override final  EventType? eventType;
@override@JsonKey() final  PlaceStatus status;

/// Create a copy of DiscoverFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscoverFilterCopyWith<_DiscoverFilter> get copyWith => __$DiscoverFilterCopyWithImpl<_DiscoverFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscoverFilter&&(identical(other.place, place) || other.place == place)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,place,eventType,status);

@override
String toString() {
  return 'DiscoverFilter(place: $place, eventType: $eventType, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DiscoverFilterCopyWith<$Res> implements $DiscoverFilterCopyWith<$Res> {
  factory _$DiscoverFilterCopyWith(_DiscoverFilter value, $Res Function(_DiscoverFilter) _then) = __$DiscoverFilterCopyWithImpl;
@override @useResult
$Res call({
 DiscoverPlace? place, EventType? eventType, PlaceStatus status
});


@override $DiscoverPlaceCopyWith<$Res>? get place;

}
/// @nodoc
class __$DiscoverFilterCopyWithImpl<$Res>
    implements _$DiscoverFilterCopyWith<$Res> {
  __$DiscoverFilterCopyWithImpl(this._self, this._then);

  final _DiscoverFilter _self;
  final $Res Function(_DiscoverFilter) _then;

/// Create a copy of DiscoverFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? place = freezed,Object? eventType = freezed,Object? status = null,}) {
  return _then(_DiscoverFilter(
place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as DiscoverPlace?,eventType: freezed == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventType?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlaceStatus,
  ));
}

/// Create a copy of DiscoverFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscoverPlaceCopyWith<$Res>? get place {
    if (_self.place == null) {
    return null;
  }

  return $DiscoverPlaceCopyWith<$Res>(_self.place!, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}

// dart format on
