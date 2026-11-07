// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'me.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Me {

 String get id; String get handle; String get phone;/// Empty for accounts created by a first sign-in.
 String get displayName; String? get avatarUrl;/// True until the user has set a display name.
 bool get needsProfile;/// Businesses the user can act as in vendor mode.
 List<MeVendor> get vendors;
/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeCopyWith<Me> get copyWith => _$MeCopyWithImpl<Me>(this as Me, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Me&&(identical(other.id, id) || other.id == id)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.needsProfile, needsProfile) || other.needsProfile == needsProfile)&&const DeepCollectionEquality().equals(other.vendors, vendors));
}


@override
int get hashCode => Object.hash(runtimeType,id,handle,phone,displayName,avatarUrl,needsProfile,const DeepCollectionEquality().hash(vendors));

@override
String toString() {
  return 'Me(id: $id, handle: $handle, phone: $phone, displayName: $displayName, avatarUrl: $avatarUrl, needsProfile: $needsProfile, vendors: $vendors)';
}


}

/// @nodoc
abstract mixin class $MeCopyWith<$Res>  {
  factory $MeCopyWith(Me value, $Res Function(Me) _then) = _$MeCopyWithImpl;
@useResult
$Res call({
 String id, String handle, String phone, String displayName, String? avatarUrl, bool needsProfile, List<MeVendor> vendors
});




}
/// @nodoc
class _$MeCopyWithImpl<$Res>
    implements $MeCopyWith<$Res> {
  _$MeCopyWithImpl(this._self, this._then);

  final Me _self;
  final $Res Function(Me) _then;

/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? handle = null,Object? phone = null,Object? displayName = null,Object? avatarUrl = freezed,Object? needsProfile = null,Object? vendors = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,needsProfile: null == needsProfile ? _self.needsProfile : needsProfile // ignore: cast_nullable_to_non_nullable
as bool,vendors: null == vendors ? _self.vendors : vendors // ignore: cast_nullable_to_non_nullable
as List<MeVendor>,
  ));
}

}


/// Adds pattern-matching-related methods to [Me].
extension MePatterns on Me {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Me value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Me() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Me value)  $default,){
final _that = this;
switch (_that) {
case _Me():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Me value)?  $default,){
final _that = this;
switch (_that) {
case _Me() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String handle,  String phone,  String displayName,  String? avatarUrl,  bool needsProfile,  List<MeVendor> vendors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Me() when $default != null:
return $default(_that.id,_that.handle,_that.phone,_that.displayName,_that.avatarUrl,_that.needsProfile,_that.vendors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String handle,  String phone,  String displayName,  String? avatarUrl,  bool needsProfile,  List<MeVendor> vendors)  $default,) {final _that = this;
switch (_that) {
case _Me():
return $default(_that.id,_that.handle,_that.phone,_that.displayName,_that.avatarUrl,_that.needsProfile,_that.vendors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String handle,  String phone,  String displayName,  String? avatarUrl,  bool needsProfile,  List<MeVendor> vendors)?  $default,) {final _that = this;
switch (_that) {
case _Me() when $default != null:
return $default(_that.id,_that.handle,_that.phone,_that.displayName,_that.avatarUrl,_that.needsProfile,_that.vendors);case _:
  return null;

}
}

}

/// @nodoc


class _Me implements Me {
  const _Me({required this.id, required this.handle, required this.phone, this.displayName = '', this.avatarUrl, this.needsProfile = false, final  List<MeVendor> vendors = const <MeVendor>[]}): _vendors = vendors;
  

@override final  String id;
@override final  String handle;
@override final  String phone;
/// Empty for accounts created by a first sign-in.
@override@JsonKey() final  String displayName;
@override final  String? avatarUrl;
/// True until the user has set a display name.
@override@JsonKey() final  bool needsProfile;
/// Businesses the user can act as in vendor mode.
 final  List<MeVendor> _vendors;
/// Businesses the user can act as in vendor mode.
@override@JsonKey() List<MeVendor> get vendors {
  if (_vendors is EqualUnmodifiableListView) return _vendors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vendors);
}


/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeCopyWith<_Me> get copyWith => __$MeCopyWithImpl<_Me>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Me&&(identical(other.id, id) || other.id == id)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.needsProfile, needsProfile) || other.needsProfile == needsProfile)&&const DeepCollectionEquality().equals(other._vendors, _vendors));
}


@override
int get hashCode => Object.hash(runtimeType,id,handle,phone,displayName,avatarUrl,needsProfile,const DeepCollectionEquality().hash(_vendors));

@override
String toString() {
  return 'Me(id: $id, handle: $handle, phone: $phone, displayName: $displayName, avatarUrl: $avatarUrl, needsProfile: $needsProfile, vendors: $vendors)';
}


}

/// @nodoc
abstract mixin class _$MeCopyWith<$Res> implements $MeCopyWith<$Res> {
  factory _$MeCopyWith(_Me value, $Res Function(_Me) _then) = __$MeCopyWithImpl;
@override @useResult
$Res call({
 String id, String handle, String phone, String displayName, String? avatarUrl, bool needsProfile, List<MeVendor> vendors
});




}
/// @nodoc
class __$MeCopyWithImpl<$Res>
    implements _$MeCopyWith<$Res> {
  __$MeCopyWithImpl(this._self, this._then);

  final _Me _self;
  final $Res Function(_Me) _then;

/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? handle = null,Object? phone = null,Object? displayName = null,Object? avatarUrl = freezed,Object? needsProfile = null,Object? vendors = null,}) {
  return _then(_Me(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,needsProfile: null == needsProfile ? _self.needsProfile : needsProfile // ignore: cast_nullable_to_non_nullable
as bool,vendors: null == vendors ? _self._vendors : vendors // ignore: cast_nullable_to_non_nullable
as List<MeVendor>,
  ));
}


}

/// @nodoc
mixin _$MeVendor {

 String get id; String get handle; String get name;/// `owner` or `staff`.
 String get role; String? get logoUrl;
/// Create a copy of MeVendor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeVendorCopyWith<MeVendor> get copyWith => _$MeVendorCopyWithImpl<MeVendor>(this as MeVendor, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeVendor&&(identical(other.id, id) || other.id == id)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,handle,name,role,logoUrl);

@override
String toString() {
  return 'MeVendor(id: $id, handle: $handle, name: $name, role: $role, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class $MeVendorCopyWith<$Res>  {
  factory $MeVendorCopyWith(MeVendor value, $Res Function(MeVendor) _then) = _$MeVendorCopyWithImpl;
@useResult
$Res call({
 String id, String handle, String name, String role, String? logoUrl
});




}
/// @nodoc
class _$MeVendorCopyWithImpl<$Res>
    implements $MeVendorCopyWith<$Res> {
  _$MeVendorCopyWithImpl(this._self, this._then);

  final MeVendor _self;
  final $Res Function(MeVendor) _then;

/// Create a copy of MeVendor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? handle = null,Object? name = null,Object? role = null,Object? logoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeVendor].
extension MeVendorPatterns on MeVendor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeVendor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeVendor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeVendor value)  $default,){
final _that = this;
switch (_that) {
case _MeVendor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeVendor value)?  $default,){
final _that = this;
switch (_that) {
case _MeVendor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String handle,  String name,  String role,  String? logoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeVendor() when $default != null:
return $default(_that.id,_that.handle,_that.name,_that.role,_that.logoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String handle,  String name,  String role,  String? logoUrl)  $default,) {final _that = this;
switch (_that) {
case _MeVendor():
return $default(_that.id,_that.handle,_that.name,_that.role,_that.logoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String handle,  String name,  String role,  String? logoUrl)?  $default,) {final _that = this;
switch (_that) {
case _MeVendor() when $default != null:
return $default(_that.id,_that.handle,_that.name,_that.role,_that.logoUrl);case _:
  return null;

}
}

}

/// @nodoc


class _MeVendor implements MeVendor {
  const _MeVendor({required this.id, required this.handle, required this.name, required this.role, this.logoUrl});
  

@override final  String id;
@override final  String handle;
@override final  String name;
/// `owner` or `staff`.
@override final  String role;
@override final  String? logoUrl;

/// Create a copy of MeVendor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeVendorCopyWith<_MeVendor> get copyWith => __$MeVendorCopyWithImpl<_MeVendor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeVendor&&(identical(other.id, id) || other.id == id)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,handle,name,role,logoUrl);

@override
String toString() {
  return 'MeVendor(id: $id, handle: $handle, name: $name, role: $role, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class _$MeVendorCopyWith<$Res> implements $MeVendorCopyWith<$Res> {
  factory _$MeVendorCopyWith(_MeVendor value, $Res Function(_MeVendor) _then) = __$MeVendorCopyWithImpl;
@override @useResult
$Res call({
 String id, String handle, String name, String role, String? logoUrl
});




}
/// @nodoc
class __$MeVendorCopyWithImpl<$Res>
    implements _$MeVendorCopyWith<$Res> {
  __$MeVendorCopyWithImpl(this._self, this._then);

  final _MeVendor _self;
  final $Res Function(_MeVendor) _then;

/// Create a copy of MeVendor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? handle = null,Object? name = null,Object? role = null,Object? logoUrl = freezed,}) {
  return _then(_MeVendor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$OtpChallenge {

 String get phone; Duration get expiresIn;
/// Create a copy of OtpChallenge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpChallengeCopyWith<OtpChallenge> get copyWith => _$OtpChallengeCopyWithImpl<OtpChallenge>(this as OtpChallenge, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpChallenge&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn));
}


@override
int get hashCode => Object.hash(runtimeType,phone,expiresIn);

@override
String toString() {
  return 'OtpChallenge(phone: $phone, expiresIn: $expiresIn)';
}


}

/// @nodoc
abstract mixin class $OtpChallengeCopyWith<$Res>  {
  factory $OtpChallengeCopyWith(OtpChallenge value, $Res Function(OtpChallenge) _then) = _$OtpChallengeCopyWithImpl;
@useResult
$Res call({
 String phone, Duration expiresIn
});




}
/// @nodoc
class _$OtpChallengeCopyWithImpl<$Res>
    implements $OtpChallengeCopyWith<$Res> {
  _$OtpChallengeCopyWithImpl(this._self, this._then);

  final OtpChallenge _self;
  final $Res Function(OtpChallenge) _then;

/// Create a copy of OtpChallenge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? expiresIn = null,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpChallenge].
extension OtpChallengePatterns on OtpChallenge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpChallenge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpChallenge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpChallenge value)  $default,){
final _that = this;
switch (_that) {
case _OtpChallenge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpChallenge value)?  $default,){
final _that = this;
switch (_that) {
case _OtpChallenge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone,  Duration expiresIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpChallenge() when $default != null:
return $default(_that.phone,_that.expiresIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone,  Duration expiresIn)  $default,) {final _that = this;
switch (_that) {
case _OtpChallenge():
return $default(_that.phone,_that.expiresIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone,  Duration expiresIn)?  $default,) {final _that = this;
switch (_that) {
case _OtpChallenge() when $default != null:
return $default(_that.phone,_that.expiresIn);case _:
  return null;

}
}

}

/// @nodoc


class _OtpChallenge implements OtpChallenge {
  const _OtpChallenge({required this.phone, required this.expiresIn});
  

@override final  String phone;
@override final  Duration expiresIn;

/// Create a copy of OtpChallenge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpChallengeCopyWith<_OtpChallenge> get copyWith => __$OtpChallengeCopyWithImpl<_OtpChallenge>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpChallenge&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn));
}


@override
int get hashCode => Object.hash(runtimeType,phone,expiresIn);

@override
String toString() {
  return 'OtpChallenge(phone: $phone, expiresIn: $expiresIn)';
}


}

/// @nodoc
abstract mixin class _$OtpChallengeCopyWith<$Res> implements $OtpChallengeCopyWith<$Res> {
  factory _$OtpChallengeCopyWith(_OtpChallenge value, $Res Function(_OtpChallenge) _then) = __$OtpChallengeCopyWithImpl;
@override @useResult
$Res call({
 String phone, Duration expiresIn
});




}
/// @nodoc
class __$OtpChallengeCopyWithImpl<$Res>
    implements _$OtpChallengeCopyWith<$Res> {
  __$OtpChallengeCopyWithImpl(this._self, this._then);

  final _OtpChallenge _self;
  final $Res Function(_OtpChallenge) _then;

/// Create a copy of OtpChallenge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? expiresIn = null,}) {
  return _then(_OtpChallenge(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
