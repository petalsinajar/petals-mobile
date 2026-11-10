// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DraftPhoto {

 String get path;
/// Create a copy of DraftPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftPhotoCopyWith<DraftPhoto> get copyWith => _$DraftPhotoCopyWithImpl<DraftPhoto>(this as DraftPhoto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftPhoto&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode => Object.hash(runtimeType,path);

@override
String toString() {
  return 'DraftPhoto(path: $path)';
}


}

/// @nodoc
abstract mixin class $DraftPhotoCopyWith<$Res>  {
  factory $DraftPhotoCopyWith(DraftPhoto value, $Res Function(DraftPhoto) _then) = _$DraftPhotoCopyWithImpl;
@useResult
$Res call({
 String path
});




}
/// @nodoc
class _$DraftPhotoCopyWithImpl<$Res>
    implements $DraftPhotoCopyWith<$Res> {
  _$DraftPhotoCopyWithImpl(this._self, this._then);

  final DraftPhoto _self;
  final $Res Function(DraftPhoto) _then;

/// Create a copy of DraftPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,}) {
  return _then(_self.copyWith(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftPhoto].
extension DraftPhotoPatterns on DraftPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftPhoto value)  $default,){
final _that = this;
switch (_that) {
case _DraftPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _DraftPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftPhoto() when $default != null:
return $default(_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path)  $default,) {final _that = this;
switch (_that) {
case _DraftPhoto():
return $default(_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path)?  $default,) {final _that = this;
switch (_that) {
case _DraftPhoto() when $default != null:
return $default(_that.path);case _:
  return null;

}
}

}

/// @nodoc


class _DraftPhoto implements DraftPhoto {
  const _DraftPhoto({required this.path});
  

@override final  String path;

/// Create a copy of DraftPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftPhotoCopyWith<_DraftPhoto> get copyWith => __$DraftPhotoCopyWithImpl<_DraftPhoto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftPhoto&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode => Object.hash(runtimeType,path);

@override
String toString() {
  return 'DraftPhoto(path: $path)';
}


}

/// @nodoc
abstract mixin class _$DraftPhotoCopyWith<$Res> implements $DraftPhotoCopyWith<$Res> {
  factory _$DraftPhotoCopyWith(_DraftPhoto value, $Res Function(_DraftPhoto) _then) = __$DraftPhotoCopyWithImpl;
@override @useResult
$Res call({
 String path
});




}
/// @nodoc
class __$DraftPhotoCopyWithImpl<$Res>
    implements _$DraftPhotoCopyWith<$Res> {
  __$DraftPhotoCopyWithImpl(this._self, this._then);

  final _DraftPhoto _self;
  final $Res Function(_DraftPhoto) _then;

/// Create a copy of DraftPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,}) {
  return _then(_DraftPhoto(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TagTarget {

 TagTargetType get type; String get id; String get label;/// The vendor's name for items; the city for vendors.
 String? get subtitle; String? get imageUrl;
/// Create a copy of TagTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagTargetCopyWith<TagTarget> get copyWith => _$TagTargetCopyWithImpl<TagTarget>(this as TagTarget, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagTarget&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,type,id,label,subtitle,imageUrl);

@override
String toString() {
  return 'TagTarget(type: $type, id: $id, label: $label, subtitle: $subtitle, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $TagTargetCopyWith<$Res>  {
  factory $TagTargetCopyWith(TagTarget value, $Res Function(TagTarget) _then) = _$TagTargetCopyWithImpl;
@useResult
$Res call({
 TagTargetType type, String id, String label, String? subtitle, String? imageUrl
});




}
/// @nodoc
class _$TagTargetCopyWithImpl<$Res>
    implements $TagTargetCopyWith<$Res> {
  _$TagTargetCopyWithImpl(this._self, this._then);

  final TagTarget _self;
  final $Res Function(TagTarget) _then;

/// Create a copy of TagTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? id = null,Object? label = null,Object? subtitle = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TagTargetType,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TagTarget].
extension TagTargetPatterns on TagTarget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagTarget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagTarget() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagTarget value)  $default,){
final _that = this;
switch (_that) {
case _TagTarget():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagTarget value)?  $default,){
final _that = this;
switch (_that) {
case _TagTarget() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TagTargetType type,  String id,  String label,  String? subtitle,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagTarget() when $default != null:
return $default(_that.type,_that.id,_that.label,_that.subtitle,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TagTargetType type,  String id,  String label,  String? subtitle,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _TagTarget():
return $default(_that.type,_that.id,_that.label,_that.subtitle,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TagTargetType type,  String id,  String label,  String? subtitle,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _TagTarget() when $default != null:
return $default(_that.type,_that.id,_that.label,_that.subtitle,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc


class _TagTarget implements TagTarget {
  const _TagTarget({required this.type, required this.id, required this.label, this.subtitle, this.imageUrl});
  

@override final  TagTargetType type;
@override final  String id;
@override final  String label;
/// The vendor's name for items; the city for vendors.
@override final  String? subtitle;
@override final  String? imageUrl;

/// Create a copy of TagTarget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagTargetCopyWith<_TagTarget> get copyWith => __$TagTargetCopyWithImpl<_TagTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagTarget&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,type,id,label,subtitle,imageUrl);

@override
String toString() {
  return 'TagTarget(type: $type, id: $id, label: $label, subtitle: $subtitle, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$TagTargetCopyWith<$Res> implements $TagTargetCopyWith<$Res> {
  factory _$TagTargetCopyWith(_TagTarget value, $Res Function(_TagTarget) _then) = __$TagTargetCopyWithImpl;
@override @useResult
$Res call({
 TagTargetType type, String id, String label, String? subtitle, String? imageUrl
});




}
/// @nodoc
class __$TagTargetCopyWithImpl<$Res>
    implements _$TagTargetCopyWith<$Res> {
  __$TagTargetCopyWithImpl(this._self, this._then);

  final _TagTarget _self;
  final $Res Function(_TagTarget) _then;

/// Create a copy of TagTarget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? id = null,Object? label = null,Object? subtitle = freezed,Object? imageUrl = freezed,}) {
  return _then(_TagTarget(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TagTargetType,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$DraftTag {

 int get mediaIndex; double get x; double get y; TagTarget get target;
/// Create a copy of DraftTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftTagCopyWith<DraftTag> get copyWith => _$DraftTagCopyWithImpl<DraftTag>(this as DraftTag, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftTag&&(identical(other.mediaIndex, mediaIndex) || other.mediaIndex == mediaIndex)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.target, target) || other.target == target));
}


@override
int get hashCode => Object.hash(runtimeType,mediaIndex,x,y,target);

@override
String toString() {
  return 'DraftTag(mediaIndex: $mediaIndex, x: $x, y: $y, target: $target)';
}


}

/// @nodoc
abstract mixin class $DraftTagCopyWith<$Res>  {
  factory $DraftTagCopyWith(DraftTag value, $Res Function(DraftTag) _then) = _$DraftTagCopyWithImpl;
@useResult
$Res call({
 int mediaIndex, double x, double y, TagTarget target
});


$TagTargetCopyWith<$Res> get target;

}
/// @nodoc
class _$DraftTagCopyWithImpl<$Res>
    implements $DraftTagCopyWith<$Res> {
  _$DraftTagCopyWithImpl(this._self, this._then);

  final DraftTag _self;
  final $Res Function(DraftTag) _then;

/// Create a copy of DraftTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaIndex = null,Object? x = null,Object? y = null,Object? target = null,}) {
  return _then(_self.copyWith(
mediaIndex: null == mediaIndex ? _self.mediaIndex : mediaIndex // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as TagTarget,
  ));
}
/// Create a copy of DraftTag
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagTargetCopyWith<$Res> get target {
  
  return $TagTargetCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}


/// Adds pattern-matching-related methods to [DraftTag].
extension DraftTagPatterns on DraftTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftTag value)  $default,){
final _that = this;
switch (_that) {
case _DraftTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftTag value)?  $default,){
final _that = this;
switch (_that) {
case _DraftTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int mediaIndex,  double x,  double y,  TagTarget target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftTag() when $default != null:
return $default(_that.mediaIndex,_that.x,_that.y,_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int mediaIndex,  double x,  double y,  TagTarget target)  $default,) {final _that = this;
switch (_that) {
case _DraftTag():
return $default(_that.mediaIndex,_that.x,_that.y,_that.target);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int mediaIndex,  double x,  double y,  TagTarget target)?  $default,) {final _that = this;
switch (_that) {
case _DraftTag() when $default != null:
return $default(_that.mediaIndex,_that.x,_that.y,_that.target);case _:
  return null;

}
}

}

/// @nodoc


class _DraftTag implements DraftTag {
  const _DraftTag({required this.mediaIndex, required this.x, required this.y, required this.target});
  

@override final  int mediaIndex;
@override final  double x;
@override final  double y;
@override final  TagTarget target;

/// Create a copy of DraftTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftTagCopyWith<_DraftTag> get copyWith => __$DraftTagCopyWithImpl<_DraftTag>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftTag&&(identical(other.mediaIndex, mediaIndex) || other.mediaIndex == mediaIndex)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.target, target) || other.target == target));
}


@override
int get hashCode => Object.hash(runtimeType,mediaIndex,x,y,target);

@override
String toString() {
  return 'DraftTag(mediaIndex: $mediaIndex, x: $x, y: $y, target: $target)';
}


}

/// @nodoc
abstract mixin class _$DraftTagCopyWith<$Res> implements $DraftTagCopyWith<$Res> {
  factory _$DraftTagCopyWith(_DraftTag value, $Res Function(_DraftTag) _then) = __$DraftTagCopyWithImpl;
@override @useResult
$Res call({
 int mediaIndex, double x, double y, TagTarget target
});


@override $TagTargetCopyWith<$Res> get target;

}
/// @nodoc
class __$DraftTagCopyWithImpl<$Res>
    implements _$DraftTagCopyWith<$Res> {
  __$DraftTagCopyWithImpl(this._self, this._then);

  final _DraftTag _self;
  final $Res Function(_DraftTag) _then;

/// Create a copy of DraftTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaIndex = null,Object? x = null,Object? y = null,Object? target = null,}) {
  return _then(_DraftTag(
mediaIndex: null == mediaIndex ? _self.mediaIndex : mediaIndex // ignore: cast_nullable_to_non_nullable
as int,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as TagTarget,
  ));
}

/// Create a copy of DraftTag
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagTargetCopyWith<$Res> get target {
  
  return $TagTargetCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}

/// @nodoc
mixin _$PostableEvent {

 String get id; String get title; DateTime get startsAt;
/// Create a copy of PostableEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostableEventCopyWith<PostableEvent> get copyWith => _$PostableEventCopyWithImpl<PostableEvent>(this as PostableEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostableEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt);

@override
String toString() {
  return 'PostableEvent(id: $id, title: $title, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class $PostableEventCopyWith<$Res>  {
  factory $PostableEventCopyWith(PostableEvent value, $Res Function(PostableEvent) _then) = _$PostableEventCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime startsAt
});




}
/// @nodoc
class _$PostableEventCopyWithImpl<$Res>
    implements $PostableEventCopyWith<$Res> {
  _$PostableEventCopyWithImpl(this._self, this._then);

  final PostableEvent _self;
  final $Res Function(PostableEvent) _then;

/// Create a copy of PostableEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PostableEvent].
extension PostableEventPatterns on PostableEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostableEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostableEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostableEvent value)  $default,){
final _that = this;
switch (_that) {
case _PostableEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostableEvent value)?  $default,){
final _that = this;
switch (_that) {
case _PostableEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostableEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsAt)  $default,) {final _that = this;
switch (_that) {
case _PostableEvent():
return $default(_that.id,_that.title,_that.startsAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime startsAt)?  $default,) {final _that = this;
switch (_that) {
case _PostableEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt);case _:
  return null;

}
}

}

/// @nodoc


class _PostableEvent implements PostableEvent {
  const _PostableEvent({required this.id, required this.title, required this.startsAt});
  

@override final  String id;
@override final  String title;
@override final  DateTime startsAt;

/// Create a copy of PostableEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostableEventCopyWith<_PostableEvent> get copyWith => __$PostableEventCopyWithImpl<_PostableEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostableEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt);

@override
String toString() {
  return 'PostableEvent(id: $id, title: $title, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class _$PostableEventCopyWith<$Res> implements $PostableEventCopyWith<$Res> {
  factory _$PostableEventCopyWith(_PostableEvent value, $Res Function(_PostableEvent) _then) = __$PostableEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime startsAt
});




}
/// @nodoc
class __$PostableEventCopyWithImpl<$Res>
    implements _$PostableEventCopyWith<$Res> {
  __$PostableEventCopyWithImpl(this._self, this._then);

  final _PostableEvent _self;
  final $Res Function(_PostableEvent) _then;

/// Create a copy of PostableEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = null,}) {
  return _then(_PostableEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$PostingIdentity {

 String get name;/// Null for the viewer themself.
 String? get vendorId; String? get avatarUrl;
/// Create a copy of PostingIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostingIdentityCopyWith<PostingIdentity> get copyWith => _$PostingIdentityCopyWithImpl<PostingIdentity>(this as PostingIdentity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostingIdentity&&(identical(other.name, name) || other.name == name)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,name,vendorId,avatarUrl);

@override
String toString() {
  return 'PostingIdentity(name: $name, vendorId: $vendorId, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $PostingIdentityCopyWith<$Res>  {
  factory $PostingIdentityCopyWith(PostingIdentity value, $Res Function(PostingIdentity) _then) = _$PostingIdentityCopyWithImpl;
@useResult
$Res call({
 String name, String? vendorId, String? avatarUrl
});




}
/// @nodoc
class _$PostingIdentityCopyWithImpl<$Res>
    implements $PostingIdentityCopyWith<$Res> {
  _$PostingIdentityCopyWithImpl(this._self, this._then);

  final PostingIdentity _self;
  final $Res Function(PostingIdentity) _then;

/// Create a copy of PostingIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? vendorId = freezed,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,vendorId: freezed == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostingIdentity].
extension PostingIdentityPatterns on PostingIdentity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostingIdentity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostingIdentity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostingIdentity value)  $default,){
final _that = this;
switch (_that) {
case _PostingIdentity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostingIdentity value)?  $default,){
final _that = this;
switch (_that) {
case _PostingIdentity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? vendorId,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostingIdentity() when $default != null:
return $default(_that.name,_that.vendorId,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? vendorId,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _PostingIdentity():
return $default(_that.name,_that.vendorId,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? vendorId,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _PostingIdentity() when $default != null:
return $default(_that.name,_that.vendorId,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc


class _PostingIdentity implements PostingIdentity {
  const _PostingIdentity({required this.name, this.vendorId, this.avatarUrl});
  

@override final  String name;
/// Null for the viewer themself.
@override final  String? vendorId;
@override final  String? avatarUrl;

/// Create a copy of PostingIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostingIdentityCopyWith<_PostingIdentity> get copyWith => __$PostingIdentityCopyWithImpl<_PostingIdentity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostingIdentity&&(identical(other.name, name) || other.name == name)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,name,vendorId,avatarUrl);

@override
String toString() {
  return 'PostingIdentity(name: $name, vendorId: $vendorId, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$PostingIdentityCopyWith<$Res> implements $PostingIdentityCopyWith<$Res> {
  factory _$PostingIdentityCopyWith(_PostingIdentity value, $Res Function(_PostingIdentity) _then) = __$PostingIdentityCopyWithImpl;
@override @useResult
$Res call({
 String name, String? vendorId, String? avatarUrl
});




}
/// @nodoc
class __$PostingIdentityCopyWithImpl<$Res>
    implements _$PostingIdentityCopyWith<$Res> {
  __$PostingIdentityCopyWithImpl(this._self, this._then);

  final _PostingIdentity _self;
  final $Res Function(_PostingIdentity) _then;

/// Create a copy of PostingIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? vendorId = freezed,Object? avatarUrl = freezed,}) {
  return _then(_PostingIdentity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,vendorId: freezed == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$UploadedImage {

 String get url; int? get width; int? get height;
/// Create a copy of UploadedImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadedImageCopyWith<UploadedImage> get copyWith => _$UploadedImageCopyWithImpl<UploadedImage>(this as UploadedImage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadedImage&&(identical(other.url, url) || other.url == url)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}


@override
int get hashCode => Object.hash(runtimeType,url,width,height);

@override
String toString() {
  return 'UploadedImage(url: $url, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class $UploadedImageCopyWith<$Res>  {
  factory $UploadedImageCopyWith(UploadedImage value, $Res Function(UploadedImage) _then) = _$UploadedImageCopyWithImpl;
@useResult
$Res call({
 String url, int? width, int? height
});




}
/// @nodoc
class _$UploadedImageCopyWithImpl<$Res>
    implements $UploadedImageCopyWith<$Res> {
  _$UploadedImageCopyWithImpl(this._self, this._then);

  final UploadedImage _self;
  final $Res Function(UploadedImage) _then;

/// Create a copy of UploadedImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? width = freezed,Object? height = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UploadedImage].
extension UploadedImagePatterns on UploadedImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadedImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadedImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadedImage value)  $default,){
final _that = this;
switch (_that) {
case _UploadedImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadedImage value)?  $default,){
final _that = this;
switch (_that) {
case _UploadedImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  int? width,  int? height)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadedImage() when $default != null:
return $default(_that.url,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  int? width,  int? height)  $default,) {final _that = this;
switch (_that) {
case _UploadedImage():
return $default(_that.url,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  int? width,  int? height)?  $default,) {final _that = this;
switch (_that) {
case _UploadedImage() when $default != null:
return $default(_that.url,_that.width,_that.height);case _:
  return null;

}
}

}

/// @nodoc


class _UploadedImage implements UploadedImage {
  const _UploadedImage({required this.url, this.width, this.height});
  

@override final  String url;
@override final  int? width;
@override final  int? height;

/// Create a copy of UploadedImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadedImageCopyWith<_UploadedImage> get copyWith => __$UploadedImageCopyWithImpl<_UploadedImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadedImage&&(identical(other.url, url) || other.url == url)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}


@override
int get hashCode => Object.hash(runtimeType,url,width,height);

@override
String toString() {
  return 'UploadedImage(url: $url, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class _$UploadedImageCopyWith<$Res> implements $UploadedImageCopyWith<$Res> {
  factory _$UploadedImageCopyWith(_UploadedImage value, $Res Function(_UploadedImage) _then) = __$UploadedImageCopyWithImpl;
@override @useResult
$Res call({
 String url, int? width, int? height
});




}
/// @nodoc
class __$UploadedImageCopyWithImpl<$Res>
    implements _$UploadedImageCopyWith<$Res> {
  __$UploadedImageCopyWithImpl(this._self, this._then);

  final _UploadedImage _self;
  final $Res Function(_UploadedImage) _then;

/// Create a copy of UploadedImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? width = freezed,Object? height = freezed,}) {
  return _then(_UploadedImage(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$NewPost {

 List<UploadedImage> get media; String get caption; String? get asVendorId; String? get eventId; PostVisibility get visibility; List<DraftTag> get tags;
/// Create a copy of NewPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewPostCopyWith<NewPost> get copyWith => _$NewPostCopyWithImpl<NewPost>(this as NewPost, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewPost&&const DeepCollectionEquality().equals(other.media, media)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.asVendorId, asVendorId) || other.asVendorId == asVendorId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(media),caption,asVendorId,eventId,visibility,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'NewPost(media: $media, caption: $caption, asVendorId: $asVendorId, eventId: $eventId, visibility: $visibility, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $NewPostCopyWith<$Res>  {
  factory $NewPostCopyWith(NewPost value, $Res Function(NewPost) _then) = _$NewPostCopyWithImpl;
@useResult
$Res call({
 List<UploadedImage> media, String caption, String? asVendorId, String? eventId, PostVisibility visibility, List<DraftTag> tags
});




}
/// @nodoc
class _$NewPostCopyWithImpl<$Res>
    implements $NewPostCopyWith<$Res> {
  _$NewPostCopyWithImpl(this._self, this._then);

  final NewPost _self;
  final $Res Function(NewPost) _then;

/// Create a copy of NewPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? media = null,Object? caption = null,Object? asVendorId = freezed,Object? eventId = freezed,Object? visibility = null,Object? tags = null,}) {
  return _then(_self.copyWith(
media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<UploadedImage>,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,asVendorId: freezed == asVendorId ? _self.asVendorId : asVendorId // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as PostVisibility,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<DraftTag>,
  ));
}

}


/// Adds pattern-matching-related methods to [NewPost].
extension NewPostPatterns on NewPost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewPost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewPost value)  $default,){
final _that = this;
switch (_that) {
case _NewPost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewPost value)?  $default,){
final _that = this;
switch (_that) {
case _NewPost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UploadedImage> media,  String caption,  String? asVendorId,  String? eventId,  PostVisibility visibility,  List<DraftTag> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewPost() when $default != null:
return $default(_that.media,_that.caption,_that.asVendorId,_that.eventId,_that.visibility,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UploadedImage> media,  String caption,  String? asVendorId,  String? eventId,  PostVisibility visibility,  List<DraftTag> tags)  $default,) {final _that = this;
switch (_that) {
case _NewPost():
return $default(_that.media,_that.caption,_that.asVendorId,_that.eventId,_that.visibility,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UploadedImage> media,  String caption,  String? asVendorId,  String? eventId,  PostVisibility visibility,  List<DraftTag> tags)?  $default,) {final _that = this;
switch (_that) {
case _NewPost() when $default != null:
return $default(_that.media,_that.caption,_that.asVendorId,_that.eventId,_that.visibility,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _NewPost implements NewPost {
  const _NewPost({required final  List<UploadedImage> media, this.caption = '', this.asVendorId, this.eventId, this.visibility = PostVisibility.public, final  List<DraftTag> tags = const <DraftTag>[]}): _media = media,_tags = tags;
  

 final  List<UploadedImage> _media;
@override List<UploadedImage> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}

@override@JsonKey() final  String caption;
@override final  String? asVendorId;
@override final  String? eventId;
@override@JsonKey() final  PostVisibility visibility;
 final  List<DraftTag> _tags;
@override@JsonKey() List<DraftTag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of NewPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewPostCopyWith<_NewPost> get copyWith => __$NewPostCopyWithImpl<_NewPost>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewPost&&const DeepCollectionEquality().equals(other._media, _media)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.asVendorId, asVendorId) || other.asVendorId == asVendorId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_media),caption,asVendorId,eventId,visibility,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'NewPost(media: $media, caption: $caption, asVendorId: $asVendorId, eventId: $eventId, visibility: $visibility, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$NewPostCopyWith<$Res> implements $NewPostCopyWith<$Res> {
  factory _$NewPostCopyWith(_NewPost value, $Res Function(_NewPost) _then) = __$NewPostCopyWithImpl;
@override @useResult
$Res call({
 List<UploadedImage> media, String caption, String? asVendorId, String? eventId, PostVisibility visibility, List<DraftTag> tags
});




}
/// @nodoc
class __$NewPostCopyWithImpl<$Res>
    implements _$NewPostCopyWith<$Res> {
  __$NewPostCopyWithImpl(this._self, this._then);

  final _NewPost _self;
  final $Res Function(_NewPost) _then;

/// Create a copy of NewPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? media = null,Object? caption = null,Object? asVendorId = freezed,Object? eventId = freezed,Object? visibility = null,Object? tags = null,}) {
  return _then(_NewPost(
media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<UploadedImage>,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,asVendorId: freezed == asVendorId ? _self.asVendorId : asVendorId // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as PostVisibility,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<DraftTag>,
  ));
}


}

// dart format on
