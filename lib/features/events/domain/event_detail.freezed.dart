// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventPerson {

 String get id; String get name; String? get handle; EventImage? get avatar; bool get isVendor;
/// Create a copy of EventPerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventPersonCopyWith<EventPerson> get copyWith => _$EventPersonCopyWithImpl<EventPerson>(this as EventPerson, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventPerson&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.isVendor, isVendor) || other.isVendor == isVendor));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,handle,avatar,isVendor);

@override
String toString() {
  return 'EventPerson(id: $id, name: $name, handle: $handle, avatar: $avatar, isVendor: $isVendor)';
}


}

/// @nodoc
abstract mixin class $EventPersonCopyWith<$Res>  {
  factory $EventPersonCopyWith(EventPerson value, $Res Function(EventPerson) _then) = _$EventPersonCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? handle, EventImage? avatar, bool isVendor
});


$EventImageCopyWith<$Res>? get avatar;

}
/// @nodoc
class _$EventPersonCopyWithImpl<$Res>
    implements $EventPersonCopyWith<$Res> {
  _$EventPersonCopyWithImpl(this._self, this._then);

  final EventPerson _self;
  final $Res Function(EventPerson) _then;

/// Create a copy of EventPerson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? avatar = freezed,Object? isVendor = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as EventImage?,isVendor: null == isVendor ? _self.isVendor : isVendor // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EventPerson
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get avatar {
    if (_self.avatar == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.avatar!, (value) {
    return _then(_self.copyWith(avatar: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventPerson].
extension EventPersonPatterns on EventPerson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventPerson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventPerson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventPerson value)  $default,){
final _that = this;
switch (_that) {
case _EventPerson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventPerson value)?  $default,){
final _that = this;
switch (_that) {
case _EventPerson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? handle,  EventImage? avatar,  bool isVendor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventPerson() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.avatar,_that.isVendor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? handle,  EventImage? avatar,  bool isVendor)  $default,) {final _that = this;
switch (_that) {
case _EventPerson():
return $default(_that.id,_that.name,_that.handle,_that.avatar,_that.isVendor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? handle,  EventImage? avatar,  bool isVendor)?  $default,) {final _that = this;
switch (_that) {
case _EventPerson() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.avatar,_that.isVendor);case _:
  return null;

}
}

}

/// @nodoc


class _EventPerson implements EventPerson {
  const _EventPerson({required this.id, required this.name, this.handle, this.avatar, this.isVendor = false});
  

@override final  String id;
@override final  String name;
@override final  String? handle;
@override final  EventImage? avatar;
@override@JsonKey() final  bool isVendor;

/// Create a copy of EventPerson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventPersonCopyWith<_EventPerson> get copyWith => __$EventPersonCopyWithImpl<_EventPerson>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPerson&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.isVendor, isVendor) || other.isVendor == isVendor));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,handle,avatar,isVendor);

@override
String toString() {
  return 'EventPerson(id: $id, name: $name, handle: $handle, avatar: $avatar, isVendor: $isVendor)';
}


}

/// @nodoc
abstract mixin class _$EventPersonCopyWith<$Res> implements $EventPersonCopyWith<$Res> {
  factory _$EventPersonCopyWith(_EventPerson value, $Res Function(_EventPerson) _then) = __$EventPersonCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? handle, EventImage? avatar, bool isVendor
});


@override $EventImageCopyWith<$Res>? get avatar;

}
/// @nodoc
class __$EventPersonCopyWithImpl<$Res>
    implements _$EventPersonCopyWith<$Res> {
  __$EventPersonCopyWithImpl(this._self, this._then);

  final _EventPerson _self;
  final $Res Function(_EventPerson) _then;

/// Create a copy of EventPerson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? avatar = freezed,Object? isVendor = null,}) {
  return _then(_EventPerson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as EventImage?,isVendor: null == isVendor ? _self.isVendor : isVendor // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EventPerson
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventImageCopyWith<$Res>? get avatar {
    if (_self.avatar == null) {
    return null;
  }

  return $EventImageCopyWith<$Res>(_self.avatar!, (value) {
    return _then(_self.copyWith(avatar: value));
  });
}
}

/// @nodoc
mixin _$EventGuest {

 EventPerson get person; RsvpStatus get status;
/// Create a copy of EventGuest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventGuestCopyWith<EventGuest> get copyWith => _$EventGuestCopyWithImpl<EventGuest>(this as EventGuest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventGuest&&(identical(other.person, person) || other.person == person)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,person,status);

@override
String toString() {
  return 'EventGuest(person: $person, status: $status)';
}


}

/// @nodoc
abstract mixin class $EventGuestCopyWith<$Res>  {
  factory $EventGuestCopyWith(EventGuest value, $Res Function(EventGuest) _then) = _$EventGuestCopyWithImpl;
@useResult
$Res call({
 EventPerson person, RsvpStatus status
});


$EventPersonCopyWith<$Res> get person;

}
/// @nodoc
class _$EventGuestCopyWithImpl<$Res>
    implements $EventGuestCopyWith<$Res> {
  _$EventGuestCopyWithImpl(this._self, this._then);

  final EventGuest _self;
  final $Res Function(EventGuest) _then;

/// Create a copy of EventGuest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? person = null,Object? status = null,}) {
  return _then(_self.copyWith(
person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as EventPerson,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RsvpStatus,
  ));
}
/// Create a copy of EventGuest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventPersonCopyWith<$Res> get person {
  
  return $EventPersonCopyWith<$Res>(_self.person, (value) {
    return _then(_self.copyWith(person: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventGuest].
extension EventGuestPatterns on EventGuest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventGuest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventGuest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventGuest value)  $default,){
final _that = this;
switch (_that) {
case _EventGuest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventGuest value)?  $default,){
final _that = this;
switch (_that) {
case _EventGuest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EventPerson person,  RsvpStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventGuest() when $default != null:
return $default(_that.person,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EventPerson person,  RsvpStatus status)  $default,) {final _that = this;
switch (_that) {
case _EventGuest():
return $default(_that.person,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EventPerson person,  RsvpStatus status)?  $default,) {final _that = this;
switch (_that) {
case _EventGuest() when $default != null:
return $default(_that.person,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _EventGuest implements EventGuest {
  const _EventGuest({required this.person, required this.status});
  

@override final  EventPerson person;
@override final  RsvpStatus status;

/// Create a copy of EventGuest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventGuestCopyWith<_EventGuest> get copyWith => __$EventGuestCopyWithImpl<_EventGuest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventGuest&&(identical(other.person, person) || other.person == person)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,person,status);

@override
String toString() {
  return 'EventGuest(person: $person, status: $status)';
}


}

/// @nodoc
abstract mixin class _$EventGuestCopyWith<$Res> implements $EventGuestCopyWith<$Res> {
  factory _$EventGuestCopyWith(_EventGuest value, $Res Function(_EventGuest) _then) = __$EventGuestCopyWithImpl;
@override @useResult
$Res call({
 EventPerson person, RsvpStatus status
});


@override $EventPersonCopyWith<$Res> get person;

}
/// @nodoc
class __$EventGuestCopyWithImpl<$Res>
    implements _$EventGuestCopyWith<$Res> {
  __$EventGuestCopyWithImpl(this._self, this._then);

  final _EventGuest _self;
  final $Res Function(_EventGuest) _then;

/// Create a copy of EventGuest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? person = null,Object? status = null,}) {
  return _then(_EventGuest(
person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as EventPerson,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RsvpStatus,
  ));
}

/// Create a copy of EventGuest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventPersonCopyWith<$Res> get person {
  
  return $EventPersonCopyWith<$Res>(_self.person, (value) {
    return _then(_self.copyWith(person: value));
  });
}
}

/// @nodoc
mixin _$EventDetail {

 Event get event; EventPerson get host; List<EventPerson> get coHosts; List<EventGuest> get guests;
/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDetailCopyWith<EventDetail> get copyWith => _$EventDetailCopyWithImpl<EventDetail>(this as EventDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetail&&(identical(other.event, event) || other.event == event)&&(identical(other.host, host) || other.host == host)&&const DeepCollectionEquality().equals(other.coHosts, coHosts)&&const DeepCollectionEquality().equals(other.guests, guests));
}


@override
int get hashCode => Object.hash(runtimeType,event,host,const DeepCollectionEquality().hash(coHosts),const DeepCollectionEquality().hash(guests));

@override
String toString() {
  return 'EventDetail(event: $event, host: $host, coHosts: $coHosts, guests: $guests)';
}


}

/// @nodoc
abstract mixin class $EventDetailCopyWith<$Res>  {
  factory $EventDetailCopyWith(EventDetail value, $Res Function(EventDetail) _then) = _$EventDetailCopyWithImpl;
@useResult
$Res call({
 Event event, EventPerson host, List<EventPerson> coHosts, List<EventGuest> guests
});


$EventCopyWith<$Res> get event;$EventPersonCopyWith<$Res> get host;

}
/// @nodoc
class _$EventDetailCopyWithImpl<$Res>
    implements $EventDetailCopyWith<$Res> {
  _$EventDetailCopyWithImpl(this._self, this._then);

  final EventDetail _self;
  final $Res Function(EventDetail) _then;

/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? host = null,Object? coHosts = null,Object? guests = null,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as Event,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as EventPerson,coHosts: null == coHosts ? _self.coHosts : coHosts // ignore: cast_nullable_to_non_nullable
as List<EventPerson>,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as List<EventGuest>,
  ));
}
/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventCopyWith<$Res> get event {
  
  return $EventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventPersonCopyWith<$Res> get host {
  
  return $EventPersonCopyWith<$Res>(_self.host, (value) {
    return _then(_self.copyWith(host: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventDetail].
extension EventDetailPatterns on EventDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDetail value)  $default,){
final _that = this;
switch (_that) {
case _EventDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDetail value)?  $default,){
final _that = this;
switch (_that) {
case _EventDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Event event,  EventPerson host,  List<EventPerson> coHosts,  List<EventGuest> guests)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDetail() when $default != null:
return $default(_that.event,_that.host,_that.coHosts,_that.guests);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Event event,  EventPerson host,  List<EventPerson> coHosts,  List<EventGuest> guests)  $default,) {final _that = this;
switch (_that) {
case _EventDetail():
return $default(_that.event,_that.host,_that.coHosts,_that.guests);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Event event,  EventPerson host,  List<EventPerson> coHosts,  List<EventGuest> guests)?  $default,) {final _that = this;
switch (_that) {
case _EventDetail() when $default != null:
return $default(_that.event,_that.host,_that.coHosts,_that.guests);case _:
  return null;

}
}

}

/// @nodoc


class _EventDetail extends EventDetail {
  const _EventDetail({required this.event, required this.host, final  List<EventPerson> coHosts = const <EventPerson>[], final  List<EventGuest> guests = const <EventGuest>[]}): _coHosts = coHosts,_guests = guests,super._();
  

@override final  Event event;
@override final  EventPerson host;
 final  List<EventPerson> _coHosts;
@override@JsonKey() List<EventPerson> get coHosts {
  if (_coHosts is EqualUnmodifiableListView) return _coHosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coHosts);
}

 final  List<EventGuest> _guests;
@override@JsonKey() List<EventGuest> get guests {
  if (_guests is EqualUnmodifiableListView) return _guests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_guests);
}


/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDetailCopyWith<_EventDetail> get copyWith => __$EventDetailCopyWithImpl<_EventDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDetail&&(identical(other.event, event) || other.event == event)&&(identical(other.host, host) || other.host == host)&&const DeepCollectionEquality().equals(other._coHosts, _coHosts)&&const DeepCollectionEquality().equals(other._guests, _guests));
}


@override
int get hashCode => Object.hash(runtimeType,event,host,const DeepCollectionEquality().hash(_coHosts),const DeepCollectionEquality().hash(_guests));

@override
String toString() {
  return 'EventDetail(event: $event, host: $host, coHosts: $coHosts, guests: $guests)';
}


}

/// @nodoc
abstract mixin class _$EventDetailCopyWith<$Res> implements $EventDetailCopyWith<$Res> {
  factory _$EventDetailCopyWith(_EventDetail value, $Res Function(_EventDetail) _then) = __$EventDetailCopyWithImpl;
@override @useResult
$Res call({
 Event event, EventPerson host, List<EventPerson> coHosts, List<EventGuest> guests
});


@override $EventCopyWith<$Res> get event;@override $EventPersonCopyWith<$Res> get host;

}
/// @nodoc
class __$EventDetailCopyWithImpl<$Res>
    implements _$EventDetailCopyWith<$Res> {
  __$EventDetailCopyWithImpl(this._self, this._then);

  final _EventDetail _self;
  final $Res Function(_EventDetail) _then;

/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? host = null,Object? coHosts = null,Object? guests = null,}) {
  return _then(_EventDetail(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as Event,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as EventPerson,coHosts: null == coHosts ? _self._coHosts : coHosts // ignore: cast_nullable_to_non_nullable
as List<EventPerson>,guests: null == guests ? _self._guests : guests // ignore: cast_nullable_to_non_nullable
as List<EventGuest>,
  ));
}

/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventCopyWith<$Res> get event {
  
  return $EventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventPersonCopyWith<$Res> get host {
  
  return $EventPersonCopyWith<$Res>(_self.host, (value) {
    return _then(_self.copyWith(host: value));
  });
}
}

/// @nodoc
mixin _$EventPost {

 String get id; EventPerson get author; DateTime get createdAt; String get caption; List<EventImage> get media; int get likeCount; int get commentCount;
/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventPostCopyWith<EventPost> get copyWith => _$EventPostCopyWithImpl<EventPost>(this as EventPost, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventPost&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.caption, caption) || other.caption == caption)&&const DeepCollectionEquality().equals(other.media, media)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,author,createdAt,caption,const DeepCollectionEquality().hash(media),likeCount,commentCount);

@override
String toString() {
  return 'EventPost(id: $id, author: $author, createdAt: $createdAt, caption: $caption, media: $media, likeCount: $likeCount, commentCount: $commentCount)';
}


}

/// @nodoc
abstract mixin class $EventPostCopyWith<$Res>  {
  factory $EventPostCopyWith(EventPost value, $Res Function(EventPost) _then) = _$EventPostCopyWithImpl;
@useResult
$Res call({
 String id, EventPerson author, DateTime createdAt, String caption, List<EventImage> media, int likeCount, int commentCount
});


$EventPersonCopyWith<$Res> get author;

}
/// @nodoc
class _$EventPostCopyWithImpl<$Res>
    implements $EventPostCopyWith<$Res> {
  _$EventPostCopyWithImpl(this._self, this._then);

  final EventPost _self;
  final $Res Function(EventPost) _then;

/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? createdAt = null,Object? caption = null,Object? media = null,Object? likeCount = null,Object? commentCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as EventPerson,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<EventImage>,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventPersonCopyWith<$Res> get author {
  
  return $EventPersonCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventPost].
extension EventPostPatterns on EventPost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventPost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventPost value)  $default,){
final _that = this;
switch (_that) {
case _EventPost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventPost value)?  $default,){
final _that = this;
switch (_that) {
case _EventPost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  EventPerson author,  DateTime createdAt,  String caption,  List<EventImage> media,  int likeCount,  int commentCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventPost() when $default != null:
return $default(_that.id,_that.author,_that.createdAt,_that.caption,_that.media,_that.likeCount,_that.commentCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  EventPerson author,  DateTime createdAt,  String caption,  List<EventImage> media,  int likeCount,  int commentCount)  $default,) {final _that = this;
switch (_that) {
case _EventPost():
return $default(_that.id,_that.author,_that.createdAt,_that.caption,_that.media,_that.likeCount,_that.commentCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  EventPerson author,  DateTime createdAt,  String caption,  List<EventImage> media,  int likeCount,  int commentCount)?  $default,) {final _that = this;
switch (_that) {
case _EventPost() when $default != null:
return $default(_that.id,_that.author,_that.createdAt,_that.caption,_that.media,_that.likeCount,_that.commentCount);case _:
  return null;

}
}

}

/// @nodoc


class _EventPost implements EventPost {
  const _EventPost({required this.id, required this.author, required this.createdAt, this.caption = '', final  List<EventImage> media = const <EventImage>[], this.likeCount = 0, this.commentCount = 0}): _media = media;
  

@override final  String id;
@override final  EventPerson author;
@override final  DateTime createdAt;
@override@JsonKey() final  String caption;
 final  List<EventImage> _media;
@override@JsonKey() List<EventImage> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}

@override@JsonKey() final  int likeCount;
@override@JsonKey() final  int commentCount;

/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventPostCopyWith<_EventPost> get copyWith => __$EventPostCopyWithImpl<_EventPost>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPost&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.caption, caption) || other.caption == caption)&&const DeepCollectionEquality().equals(other._media, _media)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,author,createdAt,caption,const DeepCollectionEquality().hash(_media),likeCount,commentCount);

@override
String toString() {
  return 'EventPost(id: $id, author: $author, createdAt: $createdAt, caption: $caption, media: $media, likeCount: $likeCount, commentCount: $commentCount)';
}


}

/// @nodoc
abstract mixin class _$EventPostCopyWith<$Res> implements $EventPostCopyWith<$Res> {
  factory _$EventPostCopyWith(_EventPost value, $Res Function(_EventPost) _then) = __$EventPostCopyWithImpl;
@override @useResult
$Res call({
 String id, EventPerson author, DateTime createdAt, String caption, List<EventImage> media, int likeCount, int commentCount
});


@override $EventPersonCopyWith<$Res> get author;

}
/// @nodoc
class __$EventPostCopyWithImpl<$Res>
    implements _$EventPostCopyWith<$Res> {
  __$EventPostCopyWithImpl(this._self, this._then);

  final _EventPost _self;
  final $Res Function(_EventPost) _then;

/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? createdAt = null,Object? caption = null,Object? media = null,Object? likeCount = null,Object? commentCount = null,}) {
  return _then(_EventPost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as EventPerson,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<EventImage>,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of EventPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventPersonCopyWith<$Res> get author {
  
  return $EventPersonCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

// dart format on
