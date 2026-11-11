// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_post_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostDraft {

 List<DraftPhoto> get photos; String get caption; String? get asVendorId; PostableEvent? get event; PostVisibility get visibility; List<DraftTag> get tags; DraftPhase get phase;
/// Create a copy of PostDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDraftCopyWith<PostDraft> get copyWith => _$PostDraftCopyWithImpl<PostDraft>(this as PostDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDraft&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.asVendorId, asVendorId) || other.asVendorId == asVendorId)&&(identical(other.event, event) || other.event == event)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.phase, phase) || other.phase == phase));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(photos),caption,asVendorId,event,visibility,const DeepCollectionEquality().hash(tags),phase);

@override
String toString() {
  return 'PostDraft(photos: $photos, caption: $caption, asVendorId: $asVendorId, event: $event, visibility: $visibility, tags: $tags, phase: $phase)';
}


}

/// @nodoc
abstract mixin class $PostDraftCopyWith<$Res>  {
  factory $PostDraftCopyWith(PostDraft value, $Res Function(PostDraft) _then) = _$PostDraftCopyWithImpl;
@useResult
$Res call({
 List<DraftPhoto> photos, String caption, String? asVendorId, PostableEvent? event, PostVisibility visibility, List<DraftTag> tags, DraftPhase phase
});


$PostableEventCopyWith<$Res>? get event;

}
/// @nodoc
class _$PostDraftCopyWithImpl<$Res>
    implements $PostDraftCopyWith<$Res> {
  _$PostDraftCopyWithImpl(this._self, this._then);

  final PostDraft _self;
  final $Res Function(PostDraft) _then;

/// Create a copy of PostDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? photos = null,Object? caption = null,Object? asVendorId = freezed,Object? event = freezed,Object? visibility = null,Object? tags = null,Object? phase = null,}) {
  return _then(_self.copyWith(
photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<DraftPhoto>,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,asVendorId: freezed == asVendorId ? _self.asVendorId : asVendorId // ignore: cast_nullable_to_non_nullable
as String?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as PostableEvent?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as PostVisibility,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<DraftTag>,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as DraftPhase,
  ));
}
/// Create a copy of PostDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostableEventCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $PostableEventCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostDraft].
extension PostDraftPatterns on PostDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDraft value)  $default,){
final _that = this;
switch (_that) {
case _PostDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDraft value)?  $default,){
final _that = this;
switch (_that) {
case _PostDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DraftPhoto> photos,  String caption,  String? asVendorId,  PostableEvent? event,  PostVisibility visibility,  List<DraftTag> tags,  DraftPhase phase)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDraft() when $default != null:
return $default(_that.photos,_that.caption,_that.asVendorId,_that.event,_that.visibility,_that.tags,_that.phase);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DraftPhoto> photos,  String caption,  String? asVendorId,  PostableEvent? event,  PostVisibility visibility,  List<DraftTag> tags,  DraftPhase phase)  $default,) {final _that = this;
switch (_that) {
case _PostDraft():
return $default(_that.photos,_that.caption,_that.asVendorId,_that.event,_that.visibility,_that.tags,_that.phase);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DraftPhoto> photos,  String caption,  String? asVendorId,  PostableEvent? event,  PostVisibility visibility,  List<DraftTag> tags,  DraftPhase phase)?  $default,) {final _that = this;
switch (_that) {
case _PostDraft() when $default != null:
return $default(_that.photos,_that.caption,_that.asVendorId,_that.event,_that.visibility,_that.tags,_that.phase);case _:
  return null;

}
}

}

/// @nodoc


class _PostDraft extends PostDraft {
  const _PostDraft({final  List<DraftPhoto> photos = const <DraftPhoto>[], this.caption = '', this.asVendorId, this.event, this.visibility = PostVisibility.public, final  List<DraftTag> tags = const <DraftTag>[], this.phase = DraftPhase.editing}): _photos = photos,_tags = tags,super._();
  

 final  List<DraftPhoto> _photos;
@override@JsonKey() List<DraftPhoto> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override@JsonKey() final  String caption;
@override final  String? asVendorId;
@override final  PostableEvent? event;
@override@JsonKey() final  PostVisibility visibility;
 final  List<DraftTag> _tags;
@override@JsonKey() List<DraftTag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  DraftPhase phase;

/// Create a copy of PostDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDraftCopyWith<_PostDraft> get copyWith => __$PostDraftCopyWithImpl<_PostDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDraft&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.asVendorId, asVendorId) || other.asVendorId == asVendorId)&&(identical(other.event, event) || other.event == event)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.phase, phase) || other.phase == phase));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_photos),caption,asVendorId,event,visibility,const DeepCollectionEquality().hash(_tags),phase);

@override
String toString() {
  return 'PostDraft(photos: $photos, caption: $caption, asVendorId: $asVendorId, event: $event, visibility: $visibility, tags: $tags, phase: $phase)';
}


}

/// @nodoc
abstract mixin class _$PostDraftCopyWith<$Res> implements $PostDraftCopyWith<$Res> {
  factory _$PostDraftCopyWith(_PostDraft value, $Res Function(_PostDraft) _then) = __$PostDraftCopyWithImpl;
@override @useResult
$Res call({
 List<DraftPhoto> photos, String caption, String? asVendorId, PostableEvent? event, PostVisibility visibility, List<DraftTag> tags, DraftPhase phase
});


@override $PostableEventCopyWith<$Res>? get event;

}
/// @nodoc
class __$PostDraftCopyWithImpl<$Res>
    implements _$PostDraftCopyWith<$Res> {
  __$PostDraftCopyWithImpl(this._self, this._then);

  final _PostDraft _self;
  final $Res Function(_PostDraft) _then;

/// Create a copy of PostDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? photos = null,Object? caption = null,Object? asVendorId = freezed,Object? event = freezed,Object? visibility = null,Object? tags = null,Object? phase = null,}) {
  return _then(_PostDraft(
photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<DraftPhoto>,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,asVendorId: freezed == asVendorId ? _self.asVendorId : asVendorId // ignore: cast_nullable_to_non_nullable
as String?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as PostableEvent?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as PostVisibility,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<DraftTag>,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as DraftPhase,
  ));
}

/// Create a copy of PostDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostableEventCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $PostableEventCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}

// dart format on
