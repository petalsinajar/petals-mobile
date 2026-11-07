// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_actor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Actor {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Actor);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Actor()';
}


}

/// @nodoc
class $ActorCopyWith<$Res>  {
$ActorCopyWith(Actor _, $Res Function(Actor) __);
}


/// Adds pattern-matching-related methods to [Actor].
extension ActorPatterns on Actor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SelfActor value)?  self,TResult Function( VendorActor value)?  vendor,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SelfActor() when self != null:
return self(_that);case VendorActor() when vendor != null:
return vendor(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SelfActor value)  self,required TResult Function( VendorActor value)  vendor,}){
final _that = this;
switch (_that) {
case SelfActor():
return self(_that);case VendorActor():
return vendor(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SelfActor value)?  self,TResult? Function( VendorActor value)?  vendor,}){
final _that = this;
switch (_that) {
case SelfActor() when self != null:
return self(_that);case VendorActor() when vendor != null:
return vendor(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  self,TResult Function( String vendorId,  String name,  String? logoUrl,  String? logoBlurhash)?  vendor,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SelfActor() when self != null:
return self();case VendorActor() when vendor != null:
return vendor(_that.vendorId,_that.name,_that.logoUrl,_that.logoBlurhash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  self,required TResult Function( String vendorId,  String name,  String? logoUrl,  String? logoBlurhash)  vendor,}) {final _that = this;
switch (_that) {
case SelfActor():
return self();case VendorActor():
return vendor(_that.vendorId,_that.name,_that.logoUrl,_that.logoBlurhash);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  self,TResult? Function( String vendorId,  String name,  String? logoUrl,  String? logoBlurhash)?  vendor,}) {final _that = this;
switch (_that) {
case SelfActor() when self != null:
return self();case VendorActor() when vendor != null:
return vendor(_that.vendorId,_that.name,_that.logoUrl,_that.logoBlurhash);case _:
  return null;

}
}

}

/// @nodoc


class SelfActor implements Actor {
  const SelfActor();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelfActor);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Actor.self()';
}


}




/// @nodoc


class VendorActor implements Actor {
  const VendorActor({required this.vendorId, required this.name, this.logoUrl, this.logoBlurhash});
  

 final  String vendorId;
 final  String name;
 final  String? logoUrl;
 final  String? logoBlurhash;

/// Create a copy of Actor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorActorCopyWith<VendorActor> get copyWith => _$VendorActorCopyWithImpl<VendorActor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorActor&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.logoBlurhash, logoBlurhash) || other.logoBlurhash == logoBlurhash));
}


@override
int get hashCode => Object.hash(runtimeType,vendorId,name,logoUrl,logoBlurhash);

@override
String toString() {
  return 'Actor.vendor(vendorId: $vendorId, name: $name, logoUrl: $logoUrl, logoBlurhash: $logoBlurhash)';
}


}

/// @nodoc
abstract mixin class $VendorActorCopyWith<$Res> implements $ActorCopyWith<$Res> {
  factory $VendorActorCopyWith(VendorActor value, $Res Function(VendorActor) _then) = _$VendorActorCopyWithImpl;
@useResult
$Res call({
 String vendorId, String name, String? logoUrl, String? logoBlurhash
});




}
/// @nodoc
class _$VendorActorCopyWithImpl<$Res>
    implements $VendorActorCopyWith<$Res> {
  _$VendorActorCopyWithImpl(this._self, this._then);

  final VendorActor _self;
  final $Res Function(VendorActor) _then;

/// Create a copy of Actor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vendorId = null,Object? name = null,Object? logoUrl = freezed,Object? logoBlurhash = freezed,}) {
  return _then(VendorActor(
vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,logoBlurhash: freezed == logoBlurhash ? _self.logoBlurhash : logoBlurhash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
