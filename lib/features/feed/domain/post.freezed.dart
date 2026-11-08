// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostAuthor {

 String get id; String get name; String? get handle; String? get avatarUrl; bool get isVendor; bool get isVerified;
/// Create a copy of PostAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostAuthorCopyWith<PostAuthor> get copyWith => _$PostAuthorCopyWithImpl<PostAuthor>(this as PostAuthor, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostAuthor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isVendor, isVendor) || other.isVendor == isVendor)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,handle,avatarUrl,isVendor,isVerified);

@override
String toString() {
  return 'PostAuthor(id: $id, name: $name, handle: $handle, avatarUrl: $avatarUrl, isVendor: $isVendor, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class $PostAuthorCopyWith<$Res>  {
  factory $PostAuthorCopyWith(PostAuthor value, $Res Function(PostAuthor) _then) = _$PostAuthorCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? handle, String? avatarUrl, bool isVendor, bool isVerified
});




}
/// @nodoc
class _$PostAuthorCopyWithImpl<$Res>
    implements $PostAuthorCopyWith<$Res> {
  _$PostAuthorCopyWithImpl(this._self, this._then);

  final PostAuthor _self;
  final $Res Function(PostAuthor) _then;

/// Create a copy of PostAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? avatarUrl = freezed,Object? isVendor = null,Object? isVerified = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isVendor: null == isVendor ? _self.isVendor : isVendor // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostAuthor].
extension PostAuthorPatterns on PostAuthor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostAuthor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostAuthor value)  $default,){
final _that = this;
switch (_that) {
case _PostAuthor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _PostAuthor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? handle,  String? avatarUrl,  bool isVendor,  bool isVerified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostAuthor() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.avatarUrl,_that.isVendor,_that.isVerified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? handle,  String? avatarUrl,  bool isVendor,  bool isVerified)  $default,) {final _that = this;
switch (_that) {
case _PostAuthor():
return $default(_that.id,_that.name,_that.handle,_that.avatarUrl,_that.isVendor,_that.isVerified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? handle,  String? avatarUrl,  bool isVendor,  bool isVerified)?  $default,) {final _that = this;
switch (_that) {
case _PostAuthor() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.avatarUrl,_that.isVendor,_that.isVerified);case _:
  return null;

}
}

}

/// @nodoc


class _PostAuthor implements PostAuthor {
  const _PostAuthor({required this.id, required this.name, this.handle, this.avatarUrl, this.isVendor = false, this.isVerified = false});
  

@override final  String id;
@override final  String name;
@override final  String? handle;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isVendor;
@override@JsonKey() final  bool isVerified;

/// Create a copy of PostAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostAuthorCopyWith<_PostAuthor> get copyWith => __$PostAuthorCopyWithImpl<_PostAuthor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostAuthor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isVendor, isVendor) || other.isVendor == isVendor)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,handle,avatarUrl,isVendor,isVerified);

@override
String toString() {
  return 'PostAuthor(id: $id, name: $name, handle: $handle, avatarUrl: $avatarUrl, isVendor: $isVendor, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class _$PostAuthorCopyWith<$Res> implements $PostAuthorCopyWith<$Res> {
  factory _$PostAuthorCopyWith(_PostAuthor value, $Res Function(_PostAuthor) _then) = __$PostAuthorCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? handle, String? avatarUrl, bool isVendor, bool isVerified
});




}
/// @nodoc
class __$PostAuthorCopyWithImpl<$Res>
    implements _$PostAuthorCopyWith<$Res> {
  __$PostAuthorCopyWithImpl(this._self, this._then);

  final _PostAuthor _self;
  final $Res Function(_PostAuthor) _then;

/// Create a copy of PostAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? avatarUrl = freezed,Object? isVendor = null,Object? isVerified = null,}) {
  return _then(_PostAuthor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isVendor: null == isVendor ? _self.isVendor : isVendor // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$PostMedia {

 String get url; int? get width; int? get height; String? get blurhash; bool get isVideo;
/// Create a copy of PostMedia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostMediaCopyWith<PostMedia> get copyWith => _$PostMediaCopyWithImpl<PostMedia>(this as PostMedia, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostMedia&&(identical(other.url, url) || other.url == url)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.isVideo, isVideo) || other.isVideo == isVideo));
}


@override
int get hashCode => Object.hash(runtimeType,url,width,height,blurhash,isVideo);

@override
String toString() {
  return 'PostMedia(url: $url, width: $width, height: $height, blurhash: $blurhash, isVideo: $isVideo)';
}


}

/// @nodoc
abstract mixin class $PostMediaCopyWith<$Res>  {
  factory $PostMediaCopyWith(PostMedia value, $Res Function(PostMedia) _then) = _$PostMediaCopyWithImpl;
@useResult
$Res call({
 String url, int? width, int? height, String? blurhash, bool isVideo
});




}
/// @nodoc
class _$PostMediaCopyWithImpl<$Res>
    implements $PostMediaCopyWith<$Res> {
  _$PostMediaCopyWithImpl(this._self, this._then);

  final PostMedia _self;
  final $Res Function(PostMedia) _then;

/// Create a copy of PostMedia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? width = freezed,Object? height = freezed,Object? blurhash = freezed,Object? isVideo = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,isVideo: null == isVideo ? _self.isVideo : isVideo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostMedia].
extension PostMediaPatterns on PostMedia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostMedia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostMedia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostMedia value)  $default,){
final _that = this;
switch (_that) {
case _PostMedia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostMedia value)?  $default,){
final _that = this;
switch (_that) {
case _PostMedia() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  int? width,  int? height,  String? blurhash,  bool isVideo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostMedia() when $default != null:
return $default(_that.url,_that.width,_that.height,_that.blurhash,_that.isVideo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  int? width,  int? height,  String? blurhash,  bool isVideo)  $default,) {final _that = this;
switch (_that) {
case _PostMedia():
return $default(_that.url,_that.width,_that.height,_that.blurhash,_that.isVideo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  int? width,  int? height,  String? blurhash,  bool isVideo)?  $default,) {final _that = this;
switch (_that) {
case _PostMedia() when $default != null:
return $default(_that.url,_that.width,_that.height,_that.blurhash,_that.isVideo);case _:
  return null;

}
}

}

/// @nodoc


class _PostMedia extends PostMedia {
  const _PostMedia({required this.url, this.width, this.height, this.blurhash, this.isVideo = false}): super._();
  

@override final  String url;
@override final  int? width;
@override final  int? height;
@override final  String? blurhash;
@override@JsonKey() final  bool isVideo;

/// Create a copy of PostMedia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostMediaCopyWith<_PostMedia> get copyWith => __$PostMediaCopyWithImpl<_PostMedia>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostMedia&&(identical(other.url, url) || other.url == url)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.isVideo, isVideo) || other.isVideo == isVideo));
}


@override
int get hashCode => Object.hash(runtimeType,url,width,height,blurhash,isVideo);

@override
String toString() {
  return 'PostMedia(url: $url, width: $width, height: $height, blurhash: $blurhash, isVideo: $isVideo)';
}


}

/// @nodoc
abstract mixin class _$PostMediaCopyWith<$Res> implements $PostMediaCopyWith<$Res> {
  factory _$PostMediaCopyWith(_PostMedia value, $Res Function(_PostMedia) _then) = __$PostMediaCopyWithImpl;
@override @useResult
$Res call({
 String url, int? width, int? height, String? blurhash, bool isVideo
});




}
/// @nodoc
class __$PostMediaCopyWithImpl<$Res>
    implements _$PostMediaCopyWith<$Res> {
  __$PostMediaCopyWithImpl(this._self, this._then);

  final _PostMedia _self;
  final $Res Function(_PostMedia) _then;

/// Create a copy of PostMedia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? width = freezed,Object? height = freezed,Object? blurhash = freezed,Object? isVideo = null,}) {
  return _then(_PostMedia(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,isVideo: null == isVideo ? _self.isVideo : isVideo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$PostEventRef {

 String get id; String get title;
/// Create a copy of PostEventRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostEventRefCopyWith<PostEventRef> get copyWith => _$PostEventRefCopyWithImpl<PostEventRef>(this as PostEventRef, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostEventRef&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'PostEventRef(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class $PostEventRefCopyWith<$Res>  {
  factory $PostEventRefCopyWith(PostEventRef value, $Res Function(PostEventRef) _then) = _$PostEventRefCopyWithImpl;
@useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class _$PostEventRefCopyWithImpl<$Res>
    implements $PostEventRefCopyWith<$Res> {
  _$PostEventRefCopyWithImpl(this._self, this._then);

  final PostEventRef _self;
  final $Res Function(PostEventRef) _then;

/// Create a copy of PostEventRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PostEventRef].
extension PostEventRefPatterns on PostEventRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostEventRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostEventRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostEventRef value)  $default,){
final _that = this;
switch (_that) {
case _PostEventRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostEventRef value)?  $default,){
final _that = this;
switch (_that) {
case _PostEventRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostEventRef() when $default != null:
return $default(_that.id,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title)  $default,) {final _that = this;
switch (_that) {
case _PostEventRef():
return $default(_that.id,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title)?  $default,) {final _that = this;
switch (_that) {
case _PostEventRef() when $default != null:
return $default(_that.id,_that.title);case _:
  return null;

}
}

}

/// @nodoc


class _PostEventRef implements PostEventRef {
  const _PostEventRef({required this.id, required this.title});
  

@override final  String id;
@override final  String title;

/// Create a copy of PostEventRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostEventRefCopyWith<_PostEventRef> get copyWith => __$PostEventRefCopyWithImpl<_PostEventRef>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostEventRef&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'PostEventRef(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$PostEventRefCopyWith<$Res> implements $PostEventRefCopyWith<$Res> {
  factory _$PostEventRefCopyWith(_PostEventRef value, $Res Function(_PostEventRef) _then) = __$PostEventRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class __$PostEventRefCopyWithImpl<$Res>
    implements _$PostEventRefCopyWith<$Res> {
  __$PostEventRefCopyWithImpl(this._self, this._then);

  final _PostEventRef _self;
  final $Res Function(_PostEventRef) _then;

/// Create a copy of PostEventRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,}) {
  return _then(_PostEventRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$FeedPost {

 String get id; PostAuthor get author; DateTime get createdAt; String get caption; List<PostMedia> get media; PostEventRef? get event; int get likeCount; int get commentCount;/// Whether the signed-in viewer has liked it. Always false signed out.
 bool get likedByMe;
/// Create a copy of FeedPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedPostCopyWith<FeedPost> get copyWith => _$FeedPostCopyWithImpl<FeedPost>(this as FeedPost, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedPost&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.caption, caption) || other.caption == caption)&&const DeepCollectionEquality().equals(other.media, media)&&(identical(other.event, event) || other.event == event)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.likedByMe, likedByMe) || other.likedByMe == likedByMe));
}


@override
int get hashCode => Object.hash(runtimeType,id,author,createdAt,caption,const DeepCollectionEquality().hash(media),event,likeCount,commentCount,likedByMe);

@override
String toString() {
  return 'FeedPost(id: $id, author: $author, createdAt: $createdAt, caption: $caption, media: $media, event: $event, likeCount: $likeCount, commentCount: $commentCount, likedByMe: $likedByMe)';
}


}

/// @nodoc
abstract mixin class $FeedPostCopyWith<$Res>  {
  factory $FeedPostCopyWith(FeedPost value, $Res Function(FeedPost) _then) = _$FeedPostCopyWithImpl;
@useResult
$Res call({
 String id, PostAuthor author, DateTime createdAt, String caption, List<PostMedia> media, PostEventRef? event, int likeCount, int commentCount, bool likedByMe
});


$PostAuthorCopyWith<$Res> get author;$PostEventRefCopyWith<$Res>? get event;

}
/// @nodoc
class _$FeedPostCopyWithImpl<$Res>
    implements $FeedPostCopyWith<$Res> {
  _$FeedPostCopyWithImpl(this._self, this._then);

  final FeedPost _self;
  final $Res Function(FeedPost) _then;

/// Create a copy of FeedPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? createdAt = null,Object? caption = null,Object? media = null,Object? event = freezed,Object? likeCount = null,Object? commentCount = null,Object? likedByMe = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PostAuthor,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<PostMedia>,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as PostEventRef?,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,likedByMe: null == likedByMe ? _self.likedByMe : likedByMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of FeedPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostAuthorCopyWith<$Res> get author {
  
  return $PostAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of FeedPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostEventRefCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $PostEventRefCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedPost].
extension FeedPostPatterns on FeedPost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedPost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedPost value)  $default,){
final _that = this;
switch (_that) {
case _FeedPost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedPost value)?  $default,){
final _that = this;
switch (_that) {
case _FeedPost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PostAuthor author,  DateTime createdAt,  String caption,  List<PostMedia> media,  PostEventRef? event,  int likeCount,  int commentCount,  bool likedByMe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedPost() when $default != null:
return $default(_that.id,_that.author,_that.createdAt,_that.caption,_that.media,_that.event,_that.likeCount,_that.commentCount,_that.likedByMe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PostAuthor author,  DateTime createdAt,  String caption,  List<PostMedia> media,  PostEventRef? event,  int likeCount,  int commentCount,  bool likedByMe)  $default,) {final _that = this;
switch (_that) {
case _FeedPost():
return $default(_that.id,_that.author,_that.createdAt,_that.caption,_that.media,_that.event,_that.likeCount,_that.commentCount,_that.likedByMe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PostAuthor author,  DateTime createdAt,  String caption,  List<PostMedia> media,  PostEventRef? event,  int likeCount,  int commentCount,  bool likedByMe)?  $default,) {final _that = this;
switch (_that) {
case _FeedPost() when $default != null:
return $default(_that.id,_that.author,_that.createdAt,_that.caption,_that.media,_that.event,_that.likeCount,_that.commentCount,_that.likedByMe);case _:
  return null;

}
}

}

/// @nodoc


class _FeedPost extends FeedPost {
  const _FeedPost({required this.id, required this.author, required this.createdAt, this.caption = '', final  List<PostMedia> media = const <PostMedia>[], this.event, this.likeCount = 0, this.commentCount = 0, this.likedByMe = false}): _media = media,super._();
  

@override final  String id;
@override final  PostAuthor author;
@override final  DateTime createdAt;
@override@JsonKey() final  String caption;
 final  List<PostMedia> _media;
@override@JsonKey() List<PostMedia> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}

@override final  PostEventRef? event;
@override@JsonKey() final  int likeCount;
@override@JsonKey() final  int commentCount;
/// Whether the signed-in viewer has liked it. Always false signed out.
@override@JsonKey() final  bool likedByMe;

/// Create a copy of FeedPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedPostCopyWith<_FeedPost> get copyWith => __$FeedPostCopyWithImpl<_FeedPost>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedPost&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.caption, caption) || other.caption == caption)&&const DeepCollectionEquality().equals(other._media, _media)&&(identical(other.event, event) || other.event == event)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.likedByMe, likedByMe) || other.likedByMe == likedByMe));
}


@override
int get hashCode => Object.hash(runtimeType,id,author,createdAt,caption,const DeepCollectionEquality().hash(_media),event,likeCount,commentCount,likedByMe);

@override
String toString() {
  return 'FeedPost(id: $id, author: $author, createdAt: $createdAt, caption: $caption, media: $media, event: $event, likeCount: $likeCount, commentCount: $commentCount, likedByMe: $likedByMe)';
}


}

/// @nodoc
abstract mixin class _$FeedPostCopyWith<$Res> implements $FeedPostCopyWith<$Res> {
  factory _$FeedPostCopyWith(_FeedPost value, $Res Function(_FeedPost) _then) = __$FeedPostCopyWithImpl;
@override @useResult
$Res call({
 String id, PostAuthor author, DateTime createdAt, String caption, List<PostMedia> media, PostEventRef? event, int likeCount, int commentCount, bool likedByMe
});


@override $PostAuthorCopyWith<$Res> get author;@override $PostEventRefCopyWith<$Res>? get event;

}
/// @nodoc
class __$FeedPostCopyWithImpl<$Res>
    implements _$FeedPostCopyWith<$Res> {
  __$FeedPostCopyWithImpl(this._self, this._then);

  final _FeedPost _self;
  final $Res Function(_FeedPost) _then;

/// Create a copy of FeedPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? createdAt = null,Object? caption = null,Object? media = null,Object? event = freezed,Object? likeCount = null,Object? commentCount = null,Object? likedByMe = null,}) {
  return _then(_FeedPost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PostAuthor,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<PostMedia>,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as PostEventRef?,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,likedByMe: null == likedByMe ? _self.likedByMe : likedByMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FeedPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostAuthorCopyWith<$Res> get author {
  
  return $PostAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of FeedPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostEventRefCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $PostEventRefCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}

/// @nodoc
mixin _$PostComment {

 String get id; PostAuthor get author; String get body; DateTime get createdAt;
/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCommentCopyWith<PostComment> get copyWith => _$PostCommentCopyWithImpl<PostComment>(this as PostComment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostComment&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,author,body,createdAt);

@override
String toString() {
  return 'PostComment(id: $id, author: $author, body: $body, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PostCommentCopyWith<$Res>  {
  factory $PostCommentCopyWith(PostComment value, $Res Function(PostComment) _then) = _$PostCommentCopyWithImpl;
@useResult
$Res call({
 String id, PostAuthor author, String body, DateTime createdAt
});


$PostAuthorCopyWith<$Res> get author;

}
/// @nodoc
class _$PostCommentCopyWithImpl<$Res>
    implements $PostCommentCopyWith<$Res> {
  _$PostCommentCopyWithImpl(this._self, this._then);

  final PostComment _self;
  final $Res Function(PostComment) _then;

/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? body = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PostAuthor,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostAuthorCopyWith<$Res> get author {
  
  return $PostAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostComment].
extension PostCommentPatterns on PostComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostComment value)  $default,){
final _that = this;
switch (_that) {
case _PostComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostComment value)?  $default,){
final _that = this;
switch (_that) {
case _PostComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PostAuthor author,  String body,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostComment() when $default != null:
return $default(_that.id,_that.author,_that.body,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PostAuthor author,  String body,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _PostComment():
return $default(_that.id,_that.author,_that.body,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PostAuthor author,  String body,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PostComment() when $default != null:
return $default(_that.id,_that.author,_that.body,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _PostComment implements PostComment {
  const _PostComment({required this.id, required this.author, required this.body, required this.createdAt});
  

@override final  String id;
@override final  PostAuthor author;
@override final  String body;
@override final  DateTime createdAt;

/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCommentCopyWith<_PostComment> get copyWith => __$PostCommentCopyWithImpl<_PostComment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostComment&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,author,body,createdAt);

@override
String toString() {
  return 'PostComment(id: $id, author: $author, body: $body, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PostCommentCopyWith<$Res> implements $PostCommentCopyWith<$Res> {
  factory _$PostCommentCopyWith(_PostComment value, $Res Function(_PostComment) _then) = __$PostCommentCopyWithImpl;
@override @useResult
$Res call({
 String id, PostAuthor author, String body, DateTime createdAt
});


@override $PostAuthorCopyWith<$Res> get author;

}
/// @nodoc
class __$PostCommentCopyWithImpl<$Res>
    implements _$PostCommentCopyWith<$Res> {
  __$PostCommentCopyWithImpl(this._self, this._then);

  final _PostComment _self;
  final $Res Function(_PostComment) _then;

/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? body = null,Object? createdAt = null,}) {
  return _then(_PostComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PostAuthor,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostAuthorCopyWith<$Res> get author {
  
  return $PostAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

// dart format on
