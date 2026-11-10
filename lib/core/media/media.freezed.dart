// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Media {

 String get id; MediaKind get kind; MediaStatus get status; Map<String, String> get urls; int? get width; int? get height; String? get blurhash; int? get durationMs;
/// Create a copy of Media
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaCopyWith<Media> get copyWith => _$MediaCopyWithImpl<Media>(this as Media, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Media&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.urls, urls)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,status,const DeepCollectionEquality().hash(urls),width,height,blurhash,durationMs);

@override
String toString() {
  return 'Media(id: $id, kind: $kind, status: $status, urls: $urls, width: $width, height: $height, blurhash: $blurhash, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class $MediaCopyWith<$Res>  {
  factory $MediaCopyWith(Media value, $Res Function(Media) _then) = _$MediaCopyWithImpl;
@useResult
$Res call({
 String id, MediaKind kind, MediaStatus status, Map<String, String> urls, int? width, int? height, String? blurhash, int? durationMs
});




}
/// @nodoc
class _$MediaCopyWithImpl<$Res>
    implements $MediaCopyWith<$Res> {
  _$MediaCopyWithImpl(this._self, this._then);

  final Media _self;
  final $Res Function(Media) _then;

/// Create a copy of Media
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? status = null,Object? urls = null,Object? width = freezed,Object? height = freezed,Object? blurhash = freezed,Object? durationMs = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MediaKind,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MediaStatus,urls: null == urls ? _self.urls : urls // ignore: cast_nullable_to_non_nullable
as Map<String, String>,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Media].
extension MediaPatterns on Media {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Media value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Media() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Media value)  $default,){
final _that = this;
switch (_that) {
case _Media():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Media value)?  $default,){
final _that = this;
switch (_that) {
case _Media() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  MediaKind kind,  MediaStatus status,  Map<String, String> urls,  int? width,  int? height,  String? blurhash,  int? durationMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Media() when $default != null:
return $default(_that.id,_that.kind,_that.status,_that.urls,_that.width,_that.height,_that.blurhash,_that.durationMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  MediaKind kind,  MediaStatus status,  Map<String, String> urls,  int? width,  int? height,  String? blurhash,  int? durationMs)  $default,) {final _that = this;
switch (_that) {
case _Media():
return $default(_that.id,_that.kind,_that.status,_that.urls,_that.width,_that.height,_that.blurhash,_that.durationMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  MediaKind kind,  MediaStatus status,  Map<String, String> urls,  int? width,  int? height,  String? blurhash,  int? durationMs)?  $default,) {final _that = this;
switch (_that) {
case _Media() when $default != null:
return $default(_that.id,_that.kind,_that.status,_that.urls,_that.width,_that.height,_that.blurhash,_that.durationMs);case _:
  return null;

}
}

}

/// @nodoc


class _Media extends Media {
  const _Media({required this.id, required this.kind, required this.status, final  Map<String, String> urls = const <String, String>{}, this.width, this.height, this.blurhash, this.durationMs}): _urls = urls,super._();
  

@override final  String id;
@override final  MediaKind kind;
@override final  MediaStatus status;
 final  Map<String, String> _urls;
@override@JsonKey() Map<String, String> get urls {
  if (_urls is EqualUnmodifiableMapView) return _urls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_urls);
}

@override final  int? width;
@override final  int? height;
@override final  String? blurhash;
@override final  int? durationMs;

/// Create a copy of Media
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaCopyWith<_Media> get copyWith => __$MediaCopyWithImpl<_Media>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Media&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._urls, _urls)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,status,const DeepCollectionEquality().hash(_urls),width,height,blurhash,durationMs);

@override
String toString() {
  return 'Media(id: $id, kind: $kind, status: $status, urls: $urls, width: $width, height: $height, blurhash: $blurhash, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class _$MediaCopyWith<$Res> implements $MediaCopyWith<$Res> {
  factory _$MediaCopyWith(_Media value, $Res Function(_Media) _then) = __$MediaCopyWithImpl;
@override @useResult
$Res call({
 String id, MediaKind kind, MediaStatus status, Map<String, String> urls, int? width, int? height, String? blurhash, int? durationMs
});




}
/// @nodoc
class __$MediaCopyWithImpl<$Res>
    implements _$MediaCopyWith<$Res> {
  __$MediaCopyWithImpl(this._self, this._then);

  final _Media _self;
  final $Res Function(_Media) _then;

/// Create a copy of Media
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? status = null,Object? urls = null,Object? width = freezed,Object? height = freezed,Object? blurhash = freezed,Object? durationMs = freezed,}) {
  return _then(_Media(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MediaKind,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MediaStatus,urls: null == urls ? _self._urls : urls // ignore: cast_nullable_to_non_nullable
as Map<String, String>,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
