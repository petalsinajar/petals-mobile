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
 String get displayName; String? get avatarUrl; String? get bio; String? get city;/// Only approved followers see their posts.
 bool get isPrivate; MeCounts get counts; NotifySettings get notify;/// True until the user has set a display name.
 bool get needsProfile;/// Businesses the user can act as in vendor mode.
 List<MeVendor> get vendors;/// For the web dashboard; phone accounts have none until it's set.
 String? get email;/// Whether an email and password are set for the web dashboard.
 bool get hasDashboardSignIn;
/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeCopyWith<Me> get copyWith => _$MeCopyWithImpl<Me>(this as Me, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Me&&(identical(other.id, id) || other.id == id)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.city, city) || other.city == city)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.notify, notify) || other.notify == notify)&&(identical(other.needsProfile, needsProfile) || other.needsProfile == needsProfile)&&const DeepCollectionEquality().equals(other.vendors, vendors)&&(identical(other.email, email) || other.email == email)&&(identical(other.hasDashboardSignIn, hasDashboardSignIn) || other.hasDashboardSignIn == hasDashboardSignIn));
}


@override
int get hashCode => Object.hash(runtimeType,id,handle,phone,displayName,avatarUrl,bio,city,isPrivate,counts,notify,needsProfile,const DeepCollectionEquality().hash(vendors),email,hasDashboardSignIn);

@override
String toString() {
  return 'Me(id: $id, handle: $handle, phone: $phone, displayName: $displayName, avatarUrl: $avatarUrl, bio: $bio, city: $city, isPrivate: $isPrivate, counts: $counts, notify: $notify, needsProfile: $needsProfile, vendors: $vendors, email: $email, hasDashboardSignIn: $hasDashboardSignIn)';
}


}

/// @nodoc
abstract mixin class $MeCopyWith<$Res>  {
  factory $MeCopyWith(Me value, $Res Function(Me) _then) = _$MeCopyWithImpl;
@useResult
$Res call({
 String id, String handle, String phone, String displayName, String? avatarUrl, String? bio, String? city, bool isPrivate, MeCounts counts, NotifySettings notify, bool needsProfile, List<MeVendor> vendors, String? email, bool hasDashboardSignIn
});


$MeCountsCopyWith<$Res> get counts;$NotifySettingsCopyWith<$Res> get notify;

}
/// @nodoc
class _$MeCopyWithImpl<$Res>
    implements $MeCopyWith<$Res> {
  _$MeCopyWithImpl(this._self, this._then);

  final Me _self;
  final $Res Function(Me) _then;

/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? handle = null,Object? phone = null,Object? displayName = null,Object? avatarUrl = freezed,Object? bio = freezed,Object? city = freezed,Object? isPrivate = null,Object? counts = null,Object? notify = null,Object? needsProfile = null,Object? vendors = null,Object? email = freezed,Object? hasDashboardSignIn = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,isPrivate: null == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as MeCounts,notify: null == notify ? _self.notify : notify // ignore: cast_nullable_to_non_nullable
as NotifySettings,needsProfile: null == needsProfile ? _self.needsProfile : needsProfile // ignore: cast_nullable_to_non_nullable
as bool,vendors: null == vendors ? _self.vendors : vendors // ignore: cast_nullable_to_non_nullable
as List<MeVendor>,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,hasDashboardSignIn: null == hasDashboardSignIn ? _self.hasDashboardSignIn : hasDashboardSignIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeCountsCopyWith<$Res> get counts {
  
  return $MeCountsCopyWith<$Res>(_self.counts, (value) {
    return _then(_self.copyWith(counts: value));
  });
}/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotifySettingsCopyWith<$Res> get notify {
  
  return $NotifySettingsCopyWith<$Res>(_self.notify, (value) {
    return _then(_self.copyWith(notify: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String handle,  String phone,  String displayName,  String? avatarUrl,  String? bio,  String? city,  bool isPrivate,  MeCounts counts,  NotifySettings notify,  bool needsProfile,  List<MeVendor> vendors,  String? email,  bool hasDashboardSignIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Me() when $default != null:
return $default(_that.id,_that.handle,_that.phone,_that.displayName,_that.avatarUrl,_that.bio,_that.city,_that.isPrivate,_that.counts,_that.notify,_that.needsProfile,_that.vendors,_that.email,_that.hasDashboardSignIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String handle,  String phone,  String displayName,  String? avatarUrl,  String? bio,  String? city,  bool isPrivate,  MeCounts counts,  NotifySettings notify,  bool needsProfile,  List<MeVendor> vendors,  String? email,  bool hasDashboardSignIn)  $default,) {final _that = this;
switch (_that) {
case _Me():
return $default(_that.id,_that.handle,_that.phone,_that.displayName,_that.avatarUrl,_that.bio,_that.city,_that.isPrivate,_that.counts,_that.notify,_that.needsProfile,_that.vendors,_that.email,_that.hasDashboardSignIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String handle,  String phone,  String displayName,  String? avatarUrl,  String? bio,  String? city,  bool isPrivate,  MeCounts counts,  NotifySettings notify,  bool needsProfile,  List<MeVendor> vendors,  String? email,  bool hasDashboardSignIn)?  $default,) {final _that = this;
switch (_that) {
case _Me() when $default != null:
return $default(_that.id,_that.handle,_that.phone,_that.displayName,_that.avatarUrl,_that.bio,_that.city,_that.isPrivate,_that.counts,_that.notify,_that.needsProfile,_that.vendors,_that.email,_that.hasDashboardSignIn);case _:
  return null;

}
}

}

/// @nodoc


class _Me implements Me {
  const _Me({required this.id, required this.handle, required this.phone, this.displayName = '', this.avatarUrl, this.bio, this.city, this.isPrivate = false, this.counts = const MeCounts(), this.notify = const NotifySettings(), this.needsProfile = false, final  List<MeVendor> vendors = const <MeVendor>[], this.email, this.hasDashboardSignIn = false}): _vendors = vendors;
  

@override final  String id;
@override final  String handle;
@override final  String phone;
/// Empty for accounts created by a first sign-in.
@override@JsonKey() final  String displayName;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  String? city;
/// Only approved followers see their posts.
@override@JsonKey() final  bool isPrivate;
@override@JsonKey() final  MeCounts counts;
@override@JsonKey() final  NotifySettings notify;
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

/// For the web dashboard; phone accounts have none until it's set.
@override final  String? email;
/// Whether an email and password are set for the web dashboard.
@override@JsonKey() final  bool hasDashboardSignIn;

/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeCopyWith<_Me> get copyWith => __$MeCopyWithImpl<_Me>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Me&&(identical(other.id, id) || other.id == id)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.city, city) || other.city == city)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.notify, notify) || other.notify == notify)&&(identical(other.needsProfile, needsProfile) || other.needsProfile == needsProfile)&&const DeepCollectionEquality().equals(other._vendors, _vendors)&&(identical(other.email, email) || other.email == email)&&(identical(other.hasDashboardSignIn, hasDashboardSignIn) || other.hasDashboardSignIn == hasDashboardSignIn));
}


@override
int get hashCode => Object.hash(runtimeType,id,handle,phone,displayName,avatarUrl,bio,city,isPrivate,counts,notify,needsProfile,const DeepCollectionEquality().hash(_vendors),email,hasDashboardSignIn);

@override
String toString() {
  return 'Me(id: $id, handle: $handle, phone: $phone, displayName: $displayName, avatarUrl: $avatarUrl, bio: $bio, city: $city, isPrivate: $isPrivate, counts: $counts, notify: $notify, needsProfile: $needsProfile, vendors: $vendors, email: $email, hasDashboardSignIn: $hasDashboardSignIn)';
}


}

/// @nodoc
abstract mixin class _$MeCopyWith<$Res> implements $MeCopyWith<$Res> {
  factory _$MeCopyWith(_Me value, $Res Function(_Me) _then) = __$MeCopyWithImpl;
@override @useResult
$Res call({
 String id, String handle, String phone, String displayName, String? avatarUrl, String? bio, String? city, bool isPrivate, MeCounts counts, NotifySettings notify, bool needsProfile, List<MeVendor> vendors, String? email, bool hasDashboardSignIn
});


@override $MeCountsCopyWith<$Res> get counts;@override $NotifySettingsCopyWith<$Res> get notify;

}
/// @nodoc
class __$MeCopyWithImpl<$Res>
    implements _$MeCopyWith<$Res> {
  __$MeCopyWithImpl(this._self, this._then);

  final _Me _self;
  final $Res Function(_Me) _then;

/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? handle = null,Object? phone = null,Object? displayName = null,Object? avatarUrl = freezed,Object? bio = freezed,Object? city = freezed,Object? isPrivate = null,Object? counts = null,Object? notify = null,Object? needsProfile = null,Object? vendors = null,Object? email = freezed,Object? hasDashboardSignIn = null,}) {
  return _then(_Me(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,isPrivate: null == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as MeCounts,notify: null == notify ? _self.notify : notify // ignore: cast_nullable_to_non_nullable
as NotifySettings,needsProfile: null == needsProfile ? _self.needsProfile : needsProfile // ignore: cast_nullable_to_non_nullable
as bool,vendors: null == vendors ? _self._vendors : vendors // ignore: cast_nullable_to_non_nullable
as List<MeVendor>,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,hasDashboardSignIn: null == hasDashboardSignIn ? _self.hasDashboardSignIn : hasDashboardSignIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeCountsCopyWith<$Res> get counts {
  
  return $MeCountsCopyWith<$Res>(_self.counts, (value) {
    return _then(_self.copyWith(counts: value));
  });
}/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotifySettingsCopyWith<$Res> get notify {
  
  return $NotifySettingsCopyWith<$Res>(_self.notify, (value) {
    return _then(_self.copyWith(notify: value));
  });
}
}

/// @nodoc
mixin _$MeCounts {

 int get followers; int get following; int get posts;
/// Create a copy of MeCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeCountsCopyWith<MeCounts> get copyWith => _$MeCountsCopyWithImpl<MeCounts>(this as MeCounts, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeCounts&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.following, following) || other.following == following)&&(identical(other.posts, posts) || other.posts == posts));
}


@override
int get hashCode => Object.hash(runtimeType,followers,following,posts);

@override
String toString() {
  return 'MeCounts(followers: $followers, following: $following, posts: $posts)';
}


}

/// @nodoc
abstract mixin class $MeCountsCopyWith<$Res>  {
  factory $MeCountsCopyWith(MeCounts value, $Res Function(MeCounts) _then) = _$MeCountsCopyWithImpl;
@useResult
$Res call({
 int followers, int following, int posts
});




}
/// @nodoc
class _$MeCountsCopyWithImpl<$Res>
    implements $MeCountsCopyWith<$Res> {
  _$MeCountsCopyWithImpl(this._self, this._then);

  final MeCounts _self;
  final $Res Function(MeCounts) _then;

/// Create a copy of MeCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? followers = null,Object? following = null,Object? posts = null,}) {
  return _then(_self.copyWith(
followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as int,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MeCounts].
extension MeCountsPatterns on MeCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeCounts value)  $default,){
final _that = this;
switch (_that) {
case _MeCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeCounts value)?  $default,){
final _that = this;
switch (_that) {
case _MeCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int followers,  int following,  int posts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeCounts() when $default != null:
return $default(_that.followers,_that.following,_that.posts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int followers,  int following,  int posts)  $default,) {final _that = this;
switch (_that) {
case _MeCounts():
return $default(_that.followers,_that.following,_that.posts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int followers,  int following,  int posts)?  $default,) {final _that = this;
switch (_that) {
case _MeCounts() when $default != null:
return $default(_that.followers,_that.following,_that.posts);case _:
  return null;

}
}

}

/// @nodoc


class _MeCounts implements MeCounts {
  const _MeCounts({this.followers = 0, this.following = 0, this.posts = 0});
  

@override@JsonKey() final  int followers;
@override@JsonKey() final  int following;
@override@JsonKey() final  int posts;

/// Create a copy of MeCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeCountsCopyWith<_MeCounts> get copyWith => __$MeCountsCopyWithImpl<_MeCounts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeCounts&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.following, following) || other.following == following)&&(identical(other.posts, posts) || other.posts == posts));
}


@override
int get hashCode => Object.hash(runtimeType,followers,following,posts);

@override
String toString() {
  return 'MeCounts(followers: $followers, following: $following, posts: $posts)';
}


}

/// @nodoc
abstract mixin class _$MeCountsCopyWith<$Res> implements $MeCountsCopyWith<$Res> {
  factory _$MeCountsCopyWith(_MeCounts value, $Res Function(_MeCounts) _then) = __$MeCountsCopyWithImpl;
@override @useResult
$Res call({
 int followers, int following, int posts
});




}
/// @nodoc
class __$MeCountsCopyWithImpl<$Res>
    implements _$MeCountsCopyWith<$Res> {
  __$MeCountsCopyWithImpl(this._self, this._then);

  final _MeCounts _self;
  final $Res Function(_MeCounts) _then;

/// Create a copy of MeCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? followers = null,Object? following = null,Object? posts = null,}) {
  return _then(_MeCounts(
followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as int,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$NotifySettings {

 bool get push; bool get sms;/// Vendor suggestions for upcoming events.
 bool get suggestions;
/// Create a copy of NotifySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotifySettingsCopyWith<NotifySettings> get copyWith => _$NotifySettingsCopyWithImpl<NotifySettings>(this as NotifySettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotifySettings&&(identical(other.push, push) || other.push == push)&&(identical(other.sms, sms) || other.sms == sms)&&(identical(other.suggestions, suggestions) || other.suggestions == suggestions));
}


@override
int get hashCode => Object.hash(runtimeType,push,sms,suggestions);

@override
String toString() {
  return 'NotifySettings(push: $push, sms: $sms, suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class $NotifySettingsCopyWith<$Res>  {
  factory $NotifySettingsCopyWith(NotifySettings value, $Res Function(NotifySettings) _then) = _$NotifySettingsCopyWithImpl;
@useResult
$Res call({
 bool push, bool sms, bool suggestions
});




}
/// @nodoc
class _$NotifySettingsCopyWithImpl<$Res>
    implements $NotifySettingsCopyWith<$Res> {
  _$NotifySettingsCopyWithImpl(this._self, this._then);

  final NotifySettings _self;
  final $Res Function(NotifySettings) _then;

/// Create a copy of NotifySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? push = null,Object? sms = null,Object? suggestions = null,}) {
  return _then(_self.copyWith(
push: null == push ? _self.push : push // ignore: cast_nullable_to_non_nullable
as bool,sms: null == sms ? _self.sms : sms // ignore: cast_nullable_to_non_nullable
as bool,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotifySettings].
extension NotifySettingsPatterns on NotifySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotifySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotifySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotifySettings value)  $default,){
final _that = this;
switch (_that) {
case _NotifySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotifySettings value)?  $default,){
final _that = this;
switch (_that) {
case _NotifySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool push,  bool sms,  bool suggestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotifySettings() when $default != null:
return $default(_that.push,_that.sms,_that.suggestions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool push,  bool sms,  bool suggestions)  $default,) {final _that = this;
switch (_that) {
case _NotifySettings():
return $default(_that.push,_that.sms,_that.suggestions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool push,  bool sms,  bool suggestions)?  $default,) {final _that = this;
switch (_that) {
case _NotifySettings() when $default != null:
return $default(_that.push,_that.sms,_that.suggestions);case _:
  return null;

}
}

}

/// @nodoc


class _NotifySettings implements NotifySettings {
  const _NotifySettings({this.push = true, this.sms = true, this.suggestions = true});
  

@override@JsonKey() final  bool push;
@override@JsonKey() final  bool sms;
/// Vendor suggestions for upcoming events.
@override@JsonKey() final  bool suggestions;

/// Create a copy of NotifySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotifySettingsCopyWith<_NotifySettings> get copyWith => __$NotifySettingsCopyWithImpl<_NotifySettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotifySettings&&(identical(other.push, push) || other.push == push)&&(identical(other.sms, sms) || other.sms == sms)&&(identical(other.suggestions, suggestions) || other.suggestions == suggestions));
}


@override
int get hashCode => Object.hash(runtimeType,push,sms,suggestions);

@override
String toString() {
  return 'NotifySettings(push: $push, sms: $sms, suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class _$NotifySettingsCopyWith<$Res> implements $NotifySettingsCopyWith<$Res> {
  factory _$NotifySettingsCopyWith(_NotifySettings value, $Res Function(_NotifySettings) _then) = __$NotifySettingsCopyWithImpl;
@override @useResult
$Res call({
 bool push, bool sms, bool suggestions
});




}
/// @nodoc
class __$NotifySettingsCopyWithImpl<$Res>
    implements _$NotifySettingsCopyWith<$Res> {
  __$NotifySettingsCopyWithImpl(this._self, this._then);

  final _NotifySettings _self;
  final $Res Function(_NotifySettings) _then;

/// Create a copy of NotifySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? push = null,Object? sms = null,Object? suggestions = null,}) {
  return _then(_NotifySettings(
push: null == push ? _self.push : push // ignore: cast_nullable_to_non_nullable
as bool,sms: null == sms ? _self.sms : sms // ignore: cast_nullable_to_non_nullable
as bool,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ProfileChanges {

 String? get displayName; String? get handle; String? get bio; String? get city;/// A new photo: a ready upload from the shared media uploader.
 String? get avatarMediaId; bool? get isPrivate; NotifySettings? get notify;
/// Create a copy of ProfileChanges
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileChangesCopyWith<ProfileChanges> get copyWith => _$ProfileChangesCopyWithImpl<ProfileChanges>(this as ProfileChanges, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileChanges&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.city, city) || other.city == city)&&(identical(other.avatarMediaId, avatarMediaId) || other.avatarMediaId == avatarMediaId)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate)&&(identical(other.notify, notify) || other.notify == notify));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,handle,bio,city,avatarMediaId,isPrivate,notify);

@override
String toString() {
  return 'ProfileChanges(displayName: $displayName, handle: $handle, bio: $bio, city: $city, avatarMediaId: $avatarMediaId, isPrivate: $isPrivate, notify: $notify)';
}


}

/// @nodoc
abstract mixin class $ProfileChangesCopyWith<$Res>  {
  factory $ProfileChangesCopyWith(ProfileChanges value, $Res Function(ProfileChanges) _then) = _$ProfileChangesCopyWithImpl;
@useResult
$Res call({
 String? displayName, String? handle, String? bio, String? city, String? avatarMediaId, bool? isPrivate, NotifySettings? notify
});


$NotifySettingsCopyWith<$Res>? get notify;

}
/// @nodoc
class _$ProfileChangesCopyWithImpl<$Res>
    implements $ProfileChangesCopyWith<$Res> {
  _$ProfileChangesCopyWithImpl(this._self, this._then);

  final ProfileChanges _self;
  final $Res Function(ProfileChanges) _then;

/// Create a copy of ProfileChanges
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = freezed,Object? handle = freezed,Object? bio = freezed,Object? city = freezed,Object? avatarMediaId = freezed,Object? isPrivate = freezed,Object? notify = freezed,}) {
  return _then(_self.copyWith(
displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,avatarMediaId: freezed == avatarMediaId ? _self.avatarMediaId : avatarMediaId // ignore: cast_nullable_to_non_nullable
as String?,isPrivate: freezed == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool?,notify: freezed == notify ? _self.notify : notify // ignore: cast_nullable_to_non_nullable
as NotifySettings?,
  ));
}
/// Create a copy of ProfileChanges
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotifySettingsCopyWith<$Res>? get notify {
    if (_self.notify == null) {
    return null;
  }

  return $NotifySettingsCopyWith<$Res>(_self.notify!, (value) {
    return _then(_self.copyWith(notify: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileChanges].
extension ProfileChangesPatterns on ProfileChanges {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileChanges value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileChanges() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileChanges value)  $default,){
final _that = this;
switch (_that) {
case _ProfileChanges():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileChanges value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileChanges() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? displayName,  String? handle,  String? bio,  String? city,  String? avatarMediaId,  bool? isPrivate,  NotifySettings? notify)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileChanges() when $default != null:
return $default(_that.displayName,_that.handle,_that.bio,_that.city,_that.avatarMediaId,_that.isPrivate,_that.notify);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? displayName,  String? handle,  String? bio,  String? city,  String? avatarMediaId,  bool? isPrivate,  NotifySettings? notify)  $default,) {final _that = this;
switch (_that) {
case _ProfileChanges():
return $default(_that.displayName,_that.handle,_that.bio,_that.city,_that.avatarMediaId,_that.isPrivate,_that.notify);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? displayName,  String? handle,  String? bio,  String? city,  String? avatarMediaId,  bool? isPrivate,  NotifySettings? notify)?  $default,) {final _that = this;
switch (_that) {
case _ProfileChanges() when $default != null:
return $default(_that.displayName,_that.handle,_that.bio,_that.city,_that.avatarMediaId,_that.isPrivate,_that.notify);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileChanges implements ProfileChanges {
  const _ProfileChanges({this.displayName, this.handle, this.bio, this.city, this.avatarMediaId, this.isPrivate, this.notify});
  

@override final  String? displayName;
@override final  String? handle;
@override final  String? bio;
@override final  String? city;
/// A new photo: a ready upload from the shared media uploader.
@override final  String? avatarMediaId;
@override final  bool? isPrivate;
@override final  NotifySettings? notify;

/// Create a copy of ProfileChanges
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileChangesCopyWith<_ProfileChanges> get copyWith => __$ProfileChangesCopyWithImpl<_ProfileChanges>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileChanges&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.city, city) || other.city == city)&&(identical(other.avatarMediaId, avatarMediaId) || other.avatarMediaId == avatarMediaId)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate)&&(identical(other.notify, notify) || other.notify == notify));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,handle,bio,city,avatarMediaId,isPrivate,notify);

@override
String toString() {
  return 'ProfileChanges(displayName: $displayName, handle: $handle, bio: $bio, city: $city, avatarMediaId: $avatarMediaId, isPrivate: $isPrivate, notify: $notify)';
}


}

/// @nodoc
abstract mixin class _$ProfileChangesCopyWith<$Res> implements $ProfileChangesCopyWith<$Res> {
  factory _$ProfileChangesCopyWith(_ProfileChanges value, $Res Function(_ProfileChanges) _then) = __$ProfileChangesCopyWithImpl;
@override @useResult
$Res call({
 String? displayName, String? handle, String? bio, String? city, String? avatarMediaId, bool? isPrivate, NotifySettings? notify
});


@override $NotifySettingsCopyWith<$Res>? get notify;

}
/// @nodoc
class __$ProfileChangesCopyWithImpl<$Res>
    implements _$ProfileChangesCopyWith<$Res> {
  __$ProfileChangesCopyWithImpl(this._self, this._then);

  final _ProfileChanges _self;
  final $Res Function(_ProfileChanges) _then;

/// Create a copy of ProfileChanges
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = freezed,Object? handle = freezed,Object? bio = freezed,Object? city = freezed,Object? avatarMediaId = freezed,Object? isPrivate = freezed,Object? notify = freezed,}) {
  return _then(_ProfileChanges(
displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,avatarMediaId: freezed == avatarMediaId ? _self.avatarMediaId : avatarMediaId // ignore: cast_nullable_to_non_nullable
as String?,isPrivate: freezed == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool?,notify: freezed == notify ? _self.notify : notify // ignore: cast_nullable_to_non_nullable
as NotifySettings?,
  ));
}

/// Create a copy of ProfileChanges
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotifySettingsCopyWith<$Res>? get notify {
    if (_self.notify == null) {
    return null;
  }

  return $NotifySettingsCopyWith<$Res>(_self.notify!, (value) {
    return _then(_self.copyWith(notify: value));
  });
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
