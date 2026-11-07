// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventDraft {

 EventType? get type; String get title; DateTime? get startsAt; DateTime? get endsAt; String get venueName; String get venueCity; String get venueAddress; int get guestCount; EventVisibility get visibility;/// Local path from the image picker; uploaded on submit.
 String? get coverPath;
/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDraftCopyWith<EventDraft> get copyWith => _$EventDraftCopyWithImpl<EventDraft>(this as EventDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDraft&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.guestCount, guestCount) || other.guestCount == guestCount)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.coverPath, coverPath) || other.coverPath == coverPath));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,startsAt,endsAt,venueName,venueCity,venueAddress,guestCount,visibility,coverPath);

@override
String toString() {
  return 'EventDraft(type: $type, title: $title, startsAt: $startsAt, endsAt: $endsAt, venueName: $venueName, venueCity: $venueCity, venueAddress: $venueAddress, guestCount: $guestCount, visibility: $visibility, coverPath: $coverPath)';
}


}

/// @nodoc
abstract mixin class $EventDraftCopyWith<$Res>  {
  factory $EventDraftCopyWith(EventDraft value, $Res Function(EventDraft) _then) = _$EventDraftCopyWithImpl;
@useResult
$Res call({
 EventType? type, String title, DateTime? startsAt, DateTime? endsAt, String venueName, String venueCity, String venueAddress, int guestCount, EventVisibility visibility, String? coverPath
});




}
/// @nodoc
class _$EventDraftCopyWithImpl<$Res>
    implements $EventDraftCopyWith<$Res> {
  _$EventDraftCopyWithImpl(this._self, this._then);

  final EventDraft _self;
  final $Res Function(EventDraft) _then;

/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? title = null,Object? startsAt = freezed,Object? endsAt = freezed,Object? venueName = null,Object? venueCity = null,Object? venueAddress = null,Object? guestCount = null,Object? visibility = null,Object? coverPath = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,venueName: null == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String,venueCity: null == venueCity ? _self.venueCity : venueCity // ignore: cast_nullable_to_non_nullable
as String,venueAddress: null == venueAddress ? _self.venueAddress : venueAddress // ignore: cast_nullable_to_non_nullable
as String,guestCount: null == guestCount ? _self.guestCount : guestCount // ignore: cast_nullable_to_non_nullable
as int,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as EventVisibility,coverPath: freezed == coverPath ? _self.coverPath : coverPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventDraft].
extension EventDraftPatterns on EventDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDraft value)  $default,){
final _that = this;
switch (_that) {
case _EventDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDraft value)?  $default,){
final _that = this;
switch (_that) {
case _EventDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EventType? type,  String title,  DateTime? startsAt,  DateTime? endsAt,  String venueName,  String venueCity,  String venueAddress,  int guestCount,  EventVisibility visibility,  String? coverPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDraft() when $default != null:
return $default(_that.type,_that.title,_that.startsAt,_that.endsAt,_that.venueName,_that.venueCity,_that.venueAddress,_that.guestCount,_that.visibility,_that.coverPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EventType? type,  String title,  DateTime? startsAt,  DateTime? endsAt,  String venueName,  String venueCity,  String venueAddress,  int guestCount,  EventVisibility visibility,  String? coverPath)  $default,) {final _that = this;
switch (_that) {
case _EventDraft():
return $default(_that.type,_that.title,_that.startsAt,_that.endsAt,_that.venueName,_that.venueCity,_that.venueAddress,_that.guestCount,_that.visibility,_that.coverPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EventType? type,  String title,  DateTime? startsAt,  DateTime? endsAt,  String venueName,  String venueCity,  String venueAddress,  int guestCount,  EventVisibility visibility,  String? coverPath)?  $default,) {final _that = this;
switch (_that) {
case _EventDraft() when $default != null:
return $default(_that.type,_that.title,_that.startsAt,_that.endsAt,_that.venueName,_that.venueCity,_that.venueAddress,_that.guestCount,_that.visibility,_that.coverPath);case _:
  return null;

}
}

}

/// @nodoc


class _EventDraft extends EventDraft {
  const _EventDraft({this.type, this.title = '', this.startsAt, this.endsAt, this.venueName = '', this.venueCity = '', this.venueAddress = '', this.guestCount = 50, this.visibility = EventVisibility.guests, this.coverPath}): super._();
  

@override final  EventType? type;
@override@JsonKey() final  String title;
@override final  DateTime? startsAt;
@override final  DateTime? endsAt;
@override@JsonKey() final  String venueName;
@override@JsonKey() final  String venueCity;
@override@JsonKey() final  String venueAddress;
@override@JsonKey() final  int guestCount;
@override@JsonKey() final  EventVisibility visibility;
/// Local path from the image picker; uploaded on submit.
@override final  String? coverPath;

/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDraftCopyWith<_EventDraft> get copyWith => __$EventDraftCopyWithImpl<_EventDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDraft&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.guestCount, guestCount) || other.guestCount == guestCount)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.coverPath, coverPath) || other.coverPath == coverPath));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,startsAt,endsAt,venueName,venueCity,venueAddress,guestCount,visibility,coverPath);

@override
String toString() {
  return 'EventDraft(type: $type, title: $title, startsAt: $startsAt, endsAt: $endsAt, venueName: $venueName, venueCity: $venueCity, venueAddress: $venueAddress, guestCount: $guestCount, visibility: $visibility, coverPath: $coverPath)';
}


}

/// @nodoc
abstract mixin class _$EventDraftCopyWith<$Res> implements $EventDraftCopyWith<$Res> {
  factory _$EventDraftCopyWith(_EventDraft value, $Res Function(_EventDraft) _then) = __$EventDraftCopyWithImpl;
@override @useResult
$Res call({
 EventType? type, String title, DateTime? startsAt, DateTime? endsAt, String venueName, String venueCity, String venueAddress, int guestCount, EventVisibility visibility, String? coverPath
});




}
/// @nodoc
class __$EventDraftCopyWithImpl<$Res>
    implements _$EventDraftCopyWith<$Res> {
  __$EventDraftCopyWithImpl(this._self, this._then);

  final _EventDraft _self;
  final $Res Function(_EventDraft) _then;

/// Create a copy of EventDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? title = null,Object? startsAt = freezed,Object? endsAt = freezed,Object? venueName = null,Object? venueCity = null,Object? venueAddress = null,Object? guestCount = null,Object? visibility = null,Object? coverPath = freezed,}) {
  return _then(_EventDraft(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,venueName: null == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String,venueCity: null == venueCity ? _self.venueCity : venueCity // ignore: cast_nullable_to_non_nullable
as String,venueAddress: null == venueAddress ? _self.venueAddress : venueAddress // ignore: cast_nullable_to_non_nullable
as String,guestCount: null == guestCount ? _self.guestCount : guestCount // ignore: cast_nullable_to_non_nullable
as int,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as EventVisibility,coverPath: freezed == coverPath ? _self.coverPath : coverPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
