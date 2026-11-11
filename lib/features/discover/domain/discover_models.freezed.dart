// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discover_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiscoverPlace {

/// "East Legon", or "you" for an unnamed device fix.
 String get label; double get lat; double get lng; PlaceSource get source;
/// Create a copy of DiscoverPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverPlaceCopyWith<DiscoverPlace> get copyWith => _$DiscoverPlaceCopyWithImpl<DiscoverPlace>(this as DiscoverPlace, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverPlace&&(identical(other.label, label) || other.label == label)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,label,lat,lng,source);

@override
String toString() {
  return 'DiscoverPlace(label: $label, lat: $lat, lng: $lng, source: $source)';
}


}

/// @nodoc
abstract mixin class $DiscoverPlaceCopyWith<$Res>  {
  factory $DiscoverPlaceCopyWith(DiscoverPlace value, $Res Function(DiscoverPlace) _then) = _$DiscoverPlaceCopyWithImpl;
@useResult
$Res call({
 String label, double lat, double lng, PlaceSource source
});




}
/// @nodoc
class _$DiscoverPlaceCopyWithImpl<$Res>
    implements $DiscoverPlaceCopyWith<$Res> {
  _$DiscoverPlaceCopyWithImpl(this._self, this._then);

  final DiscoverPlace _self;
  final $Res Function(DiscoverPlace) _then;

/// Create a copy of DiscoverPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? lat = null,Object? lng = null,Object? source = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PlaceSource,
  ));
}

}


/// Adds pattern-matching-related methods to [DiscoverPlace].
extension DiscoverPlacePatterns on DiscoverPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscoverPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscoverPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscoverPlace value)  $default,){
final _that = this;
switch (_that) {
case _DiscoverPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscoverPlace value)?  $default,){
final _that = this;
switch (_that) {
case _DiscoverPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  double lat,  double lng,  PlaceSource source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscoverPlace() when $default != null:
return $default(_that.label,_that.lat,_that.lng,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  double lat,  double lng,  PlaceSource source)  $default,) {final _that = this;
switch (_that) {
case _DiscoverPlace():
return $default(_that.label,_that.lat,_that.lng,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  double lat,  double lng,  PlaceSource source)?  $default,) {final _that = this;
switch (_that) {
case _DiscoverPlace() when $default != null:
return $default(_that.label,_that.lat,_that.lng,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _DiscoverPlace implements DiscoverPlace {
  const _DiscoverPlace({required this.label, required this.lat, required this.lng, required this.source});
  

/// "East Legon", or "you" for an unnamed device fix.
@override final  String label;
@override final  double lat;
@override final  double lng;
@override final  PlaceSource source;

/// Create a copy of DiscoverPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscoverPlaceCopyWith<_DiscoverPlace> get copyWith => __$DiscoverPlaceCopyWithImpl<_DiscoverPlace>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscoverPlace&&(identical(other.label, label) || other.label == label)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,label,lat,lng,source);

@override
String toString() {
  return 'DiscoverPlace(label: $label, lat: $lat, lng: $lng, source: $source)';
}


}

/// @nodoc
abstract mixin class _$DiscoverPlaceCopyWith<$Res> implements $DiscoverPlaceCopyWith<$Res> {
  factory _$DiscoverPlaceCopyWith(_DiscoverPlace value, $Res Function(_DiscoverPlace) _then) = __$DiscoverPlaceCopyWithImpl;
@override @useResult
$Res call({
 String label, double lat, double lng, PlaceSource source
});




}
/// @nodoc
class __$DiscoverPlaceCopyWithImpl<$Res>
    implements _$DiscoverPlaceCopyWith<$Res> {
  __$DiscoverPlaceCopyWithImpl(this._self, this._then);

  final _DiscoverPlace _self;
  final $Res Function(_DiscoverPlace) _then;

/// Create a copy of DiscoverPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? lat = null,Object? lng = null,Object? source = null,}) {
  return _then(_DiscoverPlace(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PlaceSource,
  ));
}


}

/// @nodoc
mixin _$CatalogCategory {

 String get id; String get name; String? get icon;
/// Create a copy of CatalogCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogCategoryCopyWith<CatalogCategory> get copyWith => _$CatalogCategoryCopyWithImpl<CatalogCategory>(this as CatalogCategory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,icon);

@override
String toString() {
  return 'CatalogCategory(id: $id, name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $CatalogCategoryCopyWith<$Res>  {
  factory $CatalogCategoryCopyWith(CatalogCategory value, $Res Function(CatalogCategory) _then) = _$CatalogCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? icon
});




}
/// @nodoc
class _$CatalogCategoryCopyWithImpl<$Res>
    implements $CatalogCategoryCopyWith<$Res> {
  _$CatalogCategoryCopyWithImpl(this._self, this._then);

  final CatalogCategory _self;
  final $Res Function(CatalogCategory) _then;

/// Create a copy of CatalogCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? icon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogCategory].
extension CatalogCategoryPatterns on CatalogCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogCategory value)  $default,){
final _that = this;
switch (_that) {
case _CatalogCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogCategory value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogCategory() when $default != null:
return $default(_that.id,_that.name,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _CatalogCategory():
return $default(_that.id,_that.name,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _CatalogCategory() when $default != null:
return $default(_that.id,_that.name,_that.icon);case _:
  return null;

}
}

}

/// @nodoc


class _CatalogCategory implements CatalogCategory {
  const _CatalogCategory({required this.id, required this.name, this.icon});
  

@override final  String id;
@override final  String name;
@override final  String? icon;

/// Create a copy of CatalogCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogCategoryCopyWith<_CatalogCategory> get copyWith => __$CatalogCategoryCopyWithImpl<_CatalogCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,icon);

@override
String toString() {
  return 'CatalogCategory(id: $id, name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$CatalogCategoryCopyWith<$Res> implements $CatalogCategoryCopyWith<$Res> {
  factory _$CatalogCategoryCopyWith(_CatalogCategory value, $Res Function(_CatalogCategory) _then) = __$CatalogCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? icon
});




}
/// @nodoc
class __$CatalogCategoryCopyWithImpl<$Res>
    implements _$CatalogCategoryCopyWith<$Res> {
  __$CatalogCategoryCopyWithImpl(this._self, this._then);

  final _CatalogCategory _self;
  final $Res Function(_CatalogCategory) _then;

/// Create a copy of CatalogCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? icon = freezed,}) {
  return _then(_CatalogCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$VendorRef {

 String get id; String get name; String? get handle; String? get logoUrl; bool get isVerified;
/// Create a copy of VendorRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorRefCopyWith<VendorRef> get copyWith => _$VendorRefCopyWithImpl<VendorRef>(this as VendorRef, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,handle,logoUrl,isVerified);

@override
String toString() {
  return 'VendorRef(id: $id, name: $name, handle: $handle, logoUrl: $logoUrl, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class $VendorRefCopyWith<$Res>  {
  factory $VendorRefCopyWith(VendorRef value, $Res Function(VendorRef) _then) = _$VendorRefCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? handle, String? logoUrl, bool isVerified
});




}
/// @nodoc
class _$VendorRefCopyWithImpl<$Res>
    implements $VendorRefCopyWith<$Res> {
  _$VendorRefCopyWithImpl(this._self, this._then);

  final VendorRef _self;
  final $Res Function(VendorRef) _then;

/// Create a copy of VendorRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? logoUrl = freezed,Object? isVerified = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorRef].
extension VendorRefPatterns on VendorRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorRef value)  $default,){
final _that = this;
switch (_that) {
case _VendorRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorRef value)?  $default,){
final _that = this;
switch (_that) {
case _VendorRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? handle,  String? logoUrl,  bool isVerified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorRef() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.logoUrl,_that.isVerified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? handle,  String? logoUrl,  bool isVerified)  $default,) {final _that = this;
switch (_that) {
case _VendorRef():
return $default(_that.id,_that.name,_that.handle,_that.logoUrl,_that.isVerified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? handle,  String? logoUrl,  bool isVerified)?  $default,) {final _that = this;
switch (_that) {
case _VendorRef() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.logoUrl,_that.isVerified);case _:
  return null;

}
}

}

/// @nodoc


class _VendorRef implements VendorRef {
  const _VendorRef({required this.id, required this.name, this.handle, this.logoUrl, this.isVerified = false});
  

@override final  String id;
@override final  String name;
@override final  String? handle;
@override final  String? logoUrl;
@override@JsonKey() final  bool isVerified;

/// Create a copy of VendorRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorRefCopyWith<_VendorRef> get copyWith => __$VendorRefCopyWithImpl<_VendorRef>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,handle,logoUrl,isVerified);

@override
String toString() {
  return 'VendorRef(id: $id, name: $name, handle: $handle, logoUrl: $logoUrl, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class _$VendorRefCopyWith<$Res> implements $VendorRefCopyWith<$Res> {
  factory _$VendorRefCopyWith(_VendorRef value, $Res Function(_VendorRef) _then) = __$VendorRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? handle, String? logoUrl, bool isVerified
});




}
/// @nodoc
class __$VendorRefCopyWithImpl<$Res>
    implements _$VendorRefCopyWith<$Res> {
  __$VendorRefCopyWithImpl(this._self, this._then);

  final _VendorRef _self;
  final $Res Function(_VendorRef) _then;

/// Create a copy of VendorRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? logoUrl = freezed,Object? isVerified = null,}) {
  return _then(_VendorRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$Rating {

 double? get average; int get count;
/// Create a copy of Rating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingCopyWith<Rating> get copyWith => _$RatingCopyWithImpl<Rating>(this as Rating, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Rating&&(identical(other.average, average) || other.average == average)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,average,count);

@override
String toString() {
  return 'Rating(average: $average, count: $count)';
}


}

/// @nodoc
abstract mixin class $RatingCopyWith<$Res>  {
  factory $RatingCopyWith(Rating value, $Res Function(Rating) _then) = _$RatingCopyWithImpl;
@useResult
$Res call({
 double? average, int count
});




}
/// @nodoc
class _$RatingCopyWithImpl<$Res>
    implements $RatingCopyWith<$Res> {
  _$RatingCopyWithImpl(this._self, this._then);

  final Rating _self;
  final $Res Function(Rating) _then;

/// Create a copy of Rating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? average = freezed,Object? count = null,}) {
  return _then(_self.copyWith(
average: freezed == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Rating].
extension RatingPatterns on Rating {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Rating value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Rating() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Rating value)  $default,){
final _that = this;
switch (_that) {
case _Rating():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Rating value)?  $default,){
final _that = this;
switch (_that) {
case _Rating() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? average,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Rating() when $default != null:
return $default(_that.average,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? average,  int count)  $default,) {final _that = this;
switch (_that) {
case _Rating():
return $default(_that.average,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? average,  int count)?  $default,) {final _that = this;
switch (_that) {
case _Rating() when $default != null:
return $default(_that.average,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _Rating implements Rating {
  const _Rating({this.average, this.count = 0});
  

@override final  double? average;
@override@JsonKey() final  int count;

/// Create a copy of Rating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingCopyWith<_Rating> get copyWith => __$RatingCopyWithImpl<_Rating>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Rating&&(identical(other.average, average) || other.average == average)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,average,count);

@override
String toString() {
  return 'Rating(average: $average, count: $count)';
}


}

/// @nodoc
abstract mixin class _$RatingCopyWith<$Res> implements $RatingCopyWith<$Res> {
  factory _$RatingCopyWith(_Rating value, $Res Function(_Rating) _then) = __$RatingCopyWithImpl;
@override @useResult
$Res call({
 double? average, int count
});




}
/// @nodoc
class __$RatingCopyWithImpl<$Res>
    implements _$RatingCopyWith<$Res> {
  __$RatingCopyWithImpl(this._self, this._then);

  final _Rating _self;
  final $Res Function(_Rating) _then;

/// Create a copy of Rating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? average = freezed,Object? count = null,}) {
  return _then(_Rating(
average: freezed == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$VendorCard {

 String get id; String get name; String? get handle; String? get logoUrl; String? get coverUrl; String? get city; String? get bio; bool get isVerified; Rating get rating; List<String> get categories; int get followers; int get completedBookings;/// From the place Discover is looking at. Null without one.
 double? get distanceKm; bool get isFollowing;
/// Create a copy of VendorCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorCardCopyWith<VendorCard> get copyWith => _$VendorCardCopyWithImpl<VendorCard>(this as VendorCard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.city, city) || other.city == city)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.completedBookings, completedBookings) || other.completedBookings == completedBookings)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,handle,logoUrl,coverUrl,city,bio,isVerified,rating,const DeepCollectionEquality().hash(categories),followers,completedBookings,distanceKm,isFollowing);

@override
String toString() {
  return 'VendorCard(id: $id, name: $name, handle: $handle, logoUrl: $logoUrl, coverUrl: $coverUrl, city: $city, bio: $bio, isVerified: $isVerified, rating: $rating, categories: $categories, followers: $followers, completedBookings: $completedBookings, distanceKm: $distanceKm, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class $VendorCardCopyWith<$Res>  {
  factory $VendorCardCopyWith(VendorCard value, $Res Function(VendorCard) _then) = _$VendorCardCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? handle, String? logoUrl, String? coverUrl, String? city, String? bio, bool isVerified, Rating rating, List<String> categories, int followers, int completedBookings, double? distanceKm, bool isFollowing
});


$RatingCopyWith<$Res> get rating;

}
/// @nodoc
class _$VendorCardCopyWithImpl<$Res>
    implements $VendorCardCopyWith<$Res> {
  _$VendorCardCopyWithImpl(this._self, this._then);

  final VendorCard _self;
  final $Res Function(VendorCard) _then;

/// Create a copy of VendorCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? city = freezed,Object? bio = freezed,Object? isVerified = null,Object? rating = null,Object? categories = null,Object? followers = null,Object? completedBookings = null,Object? distanceKm = freezed,Object? isFollowing = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as Rating,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,completedBookings: null == completedBookings ? _self.completedBookings : completedBookings // ignore: cast_nullable_to_non_nullable
as int,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of VendorCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RatingCopyWith<$Res> get rating {
  
  return $RatingCopyWith<$Res>(_self.rating, (value) {
    return _then(_self.copyWith(rating: value));
  });
}
}


/// Adds pattern-matching-related methods to [VendorCard].
extension VendorCardPatterns on VendorCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorCard value)  $default,){
final _that = this;
switch (_that) {
case _VendorCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorCard value)?  $default,){
final _that = this;
switch (_that) {
case _VendorCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? handle,  String? logoUrl,  String? coverUrl,  String? city,  String? bio,  bool isVerified,  Rating rating,  List<String> categories,  int followers,  int completedBookings,  double? distanceKm,  bool isFollowing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorCard() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.logoUrl,_that.coverUrl,_that.city,_that.bio,_that.isVerified,_that.rating,_that.categories,_that.followers,_that.completedBookings,_that.distanceKm,_that.isFollowing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? handle,  String? logoUrl,  String? coverUrl,  String? city,  String? bio,  bool isVerified,  Rating rating,  List<String> categories,  int followers,  int completedBookings,  double? distanceKm,  bool isFollowing)  $default,) {final _that = this;
switch (_that) {
case _VendorCard():
return $default(_that.id,_that.name,_that.handle,_that.logoUrl,_that.coverUrl,_that.city,_that.bio,_that.isVerified,_that.rating,_that.categories,_that.followers,_that.completedBookings,_that.distanceKm,_that.isFollowing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? handle,  String? logoUrl,  String? coverUrl,  String? city,  String? bio,  bool isVerified,  Rating rating,  List<String> categories,  int followers,  int completedBookings,  double? distanceKm,  bool isFollowing)?  $default,) {final _that = this;
switch (_that) {
case _VendorCard() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.logoUrl,_that.coverUrl,_that.city,_that.bio,_that.isVerified,_that.rating,_that.categories,_that.followers,_that.completedBookings,_that.distanceKm,_that.isFollowing);case _:
  return null;

}
}

}

/// @nodoc


class _VendorCard extends VendorCard {
  const _VendorCard({required this.id, required this.name, this.handle, this.logoUrl, this.coverUrl, this.city, this.bio, this.isVerified = false, this.rating = const Rating(), final  List<String> categories = const <String>[], this.followers = 0, this.completedBookings = 0, this.distanceKm, this.isFollowing = false}): _categories = categories,super._();
  

@override final  String id;
@override final  String name;
@override final  String? handle;
@override final  String? logoUrl;
@override final  String? coverUrl;
@override final  String? city;
@override final  String? bio;
@override@JsonKey() final  bool isVerified;
@override@JsonKey() final  Rating rating;
 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  int followers;
@override@JsonKey() final  int completedBookings;
/// From the place Discover is looking at. Null without one.
@override final  double? distanceKm;
@override@JsonKey() final  bool isFollowing;

/// Create a copy of VendorCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorCardCopyWith<_VendorCard> get copyWith => __$VendorCardCopyWithImpl<_VendorCard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.city, city) || other.city == city)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.completedBookings, completedBookings) || other.completedBookings == completedBookings)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,handle,logoUrl,coverUrl,city,bio,isVerified,rating,const DeepCollectionEquality().hash(_categories),followers,completedBookings,distanceKm,isFollowing);

@override
String toString() {
  return 'VendorCard(id: $id, name: $name, handle: $handle, logoUrl: $logoUrl, coverUrl: $coverUrl, city: $city, bio: $bio, isVerified: $isVerified, rating: $rating, categories: $categories, followers: $followers, completedBookings: $completedBookings, distanceKm: $distanceKm, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class _$VendorCardCopyWith<$Res> implements $VendorCardCopyWith<$Res> {
  factory _$VendorCardCopyWith(_VendorCard value, $Res Function(_VendorCard) _then) = __$VendorCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? handle, String? logoUrl, String? coverUrl, String? city, String? bio, bool isVerified, Rating rating, List<String> categories, int followers, int completedBookings, double? distanceKm, bool isFollowing
});


@override $RatingCopyWith<$Res> get rating;

}
/// @nodoc
class __$VendorCardCopyWithImpl<$Res>
    implements _$VendorCardCopyWith<$Res> {
  __$VendorCardCopyWithImpl(this._self, this._then);

  final _VendorCard _self;
  final $Res Function(_VendorCard) _then;

/// Create a copy of VendorCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? city = freezed,Object? bio = freezed,Object? isVerified = null,Object? rating = null,Object? categories = null,Object? followers = null,Object? completedBookings = null,Object? distanceKm = freezed,Object? isFollowing = null,}) {
  return _then(_VendorCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as Rating,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,completedBookings: null == completedBookings ? _self.completedBookings : completedBookings // ignore: cast_nullable_to_non_nullable
as int,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of VendorCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RatingCopyWith<$Res> get rating {
  
  return $RatingCopyWith<$Res>(_self.rating, (value) {
    return _then(_self.copyWith(rating: value));
  });
}
}

/// @nodoc
mixin _$Photo {

 String get url; String? get blurhash; int? get width; int? get height;/// Every size, when the API sent them; [url] is the feed size.
 Media? get media;
/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoCopyWith<Photo> get copyWith => _$PhotoCopyWithImpl<Photo>(this as Photo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Photo&&(identical(other.url, url) || other.url == url)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.media, media) || other.media == media));
}


@override
int get hashCode => Object.hash(runtimeType,url,blurhash,width,height,media);

@override
String toString() {
  return 'Photo(url: $url, blurhash: $blurhash, width: $width, height: $height, media: $media)';
}


}

/// @nodoc
abstract mixin class $PhotoCopyWith<$Res>  {
  factory $PhotoCopyWith(Photo value, $Res Function(Photo) _then) = _$PhotoCopyWithImpl;
@useResult
$Res call({
 String url, String? blurhash, int? width, int? height, Media? media
});


$MediaCopyWith<$Res>? get media;

}
/// @nodoc
class _$PhotoCopyWithImpl<$Res>
    implements $PhotoCopyWith<$Res> {
  _$PhotoCopyWithImpl(this._self, this._then);

  final Photo _self;
  final $Res Function(Photo) _then;

/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? blurhash = freezed,Object? width = freezed,Object? height = freezed,Object? media = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,media: freezed == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as Media?,
  ));
}
/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaCopyWith<$Res>? get media {
    if (_self.media == null) {
    return null;
  }

  return $MediaCopyWith<$Res>(_self.media!, (value) {
    return _then(_self.copyWith(media: value));
  });
}
}


/// Adds pattern-matching-related methods to [Photo].
extension PhotoPatterns on Photo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Photo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Photo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Photo value)  $default,){
final _that = this;
switch (_that) {
case _Photo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Photo value)?  $default,){
final _that = this;
switch (_that) {
case _Photo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String? blurhash,  int? width,  int? height,  Media? media)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Photo() when $default != null:
return $default(_that.url,_that.blurhash,_that.width,_that.height,_that.media);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String? blurhash,  int? width,  int? height,  Media? media)  $default,) {final _that = this;
switch (_that) {
case _Photo():
return $default(_that.url,_that.blurhash,_that.width,_that.height,_that.media);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String? blurhash,  int? width,  int? height,  Media? media)?  $default,) {final _that = this;
switch (_that) {
case _Photo() when $default != null:
return $default(_that.url,_that.blurhash,_that.width,_that.height,_that.media);case _:
  return null;

}
}

}

/// @nodoc


class _Photo implements Photo {
  const _Photo({required this.url, this.blurhash, this.width, this.height, this.media});
  

@override final  String url;
@override final  String? blurhash;
@override final  int? width;
@override final  int? height;
/// Every size, when the API sent them; [url] is the feed size.
@override final  Media? media;

/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoCopyWith<_Photo> get copyWith => __$PhotoCopyWithImpl<_Photo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Photo&&(identical(other.url, url) || other.url == url)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.media, media) || other.media == media));
}


@override
int get hashCode => Object.hash(runtimeType,url,blurhash,width,height,media);

@override
String toString() {
  return 'Photo(url: $url, blurhash: $blurhash, width: $width, height: $height, media: $media)';
}


}

/// @nodoc
abstract mixin class _$PhotoCopyWith<$Res> implements $PhotoCopyWith<$Res> {
  factory _$PhotoCopyWith(_Photo value, $Res Function(_Photo) _then) = __$PhotoCopyWithImpl;
@override @useResult
$Res call({
 String url, String? blurhash, int? width, int? height, Media? media
});


@override $MediaCopyWith<$Res>? get media;

}
/// @nodoc
class __$PhotoCopyWithImpl<$Res>
    implements _$PhotoCopyWith<$Res> {
  __$PhotoCopyWithImpl(this._self, this._then);

  final _Photo _self;
  final $Res Function(_Photo) _then;

/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? blurhash = freezed,Object? width = freezed,Object? height = freezed,Object? media = freezed,}) {
  return _then(_Photo(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,media: freezed == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as Media?,
  ));
}

/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaCopyWith<$Res>? get media {
    if (_self.media == null) {
    return null;
  }

  return $MediaCopyWith<$Res>(_self.media!, (value) {
    return _then(_self.copyWith(media: value));
  });
}
}

/// @nodoc
mixin _$ItemVariant {

 String get id; String get name; int get quantity; int get priceDeltaMinor;
/// Create a copy of ItemVariant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemVariantCopyWith<ItemVariant> get copyWith => _$ItemVariantCopyWithImpl<ItemVariant>(this as ItemVariant, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.priceDeltaMinor, priceDeltaMinor) || other.priceDeltaMinor == priceDeltaMinor));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,quantity,priceDeltaMinor);

@override
String toString() {
  return 'ItemVariant(id: $id, name: $name, quantity: $quantity, priceDeltaMinor: $priceDeltaMinor)';
}


}

/// @nodoc
abstract mixin class $ItemVariantCopyWith<$Res>  {
  factory $ItemVariantCopyWith(ItemVariant value, $Res Function(ItemVariant) _then) = _$ItemVariantCopyWithImpl;
@useResult
$Res call({
 String id, String name, int quantity, int priceDeltaMinor
});




}
/// @nodoc
class _$ItemVariantCopyWithImpl<$Res>
    implements $ItemVariantCopyWith<$Res> {
  _$ItemVariantCopyWithImpl(this._self, this._then);

  final ItemVariant _self;
  final $Res Function(ItemVariant) _then;

/// Create a copy of ItemVariant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? quantity = null,Object? priceDeltaMinor = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,priceDeltaMinor: null == priceDeltaMinor ? _self.priceDeltaMinor : priceDeltaMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemVariant].
extension ItemVariantPatterns on ItemVariant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemVariant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemVariant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemVariant value)  $default,){
final _that = this;
switch (_that) {
case _ItemVariant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemVariant value)?  $default,){
final _that = this;
switch (_that) {
case _ItemVariant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int quantity,  int priceDeltaMinor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemVariant() when $default != null:
return $default(_that.id,_that.name,_that.quantity,_that.priceDeltaMinor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int quantity,  int priceDeltaMinor)  $default,) {final _that = this;
switch (_that) {
case _ItemVariant():
return $default(_that.id,_that.name,_that.quantity,_that.priceDeltaMinor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int quantity,  int priceDeltaMinor)?  $default,) {final _that = this;
switch (_that) {
case _ItemVariant() when $default != null:
return $default(_that.id,_that.name,_that.quantity,_that.priceDeltaMinor);case _:
  return null;

}
}

}

/// @nodoc


class _ItemVariant implements ItemVariant {
  const _ItemVariant({required this.id, required this.name, this.quantity = 0, this.priceDeltaMinor = 0});
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  int quantity;
@override@JsonKey() final  int priceDeltaMinor;

/// Create a copy of ItemVariant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemVariantCopyWith<_ItemVariant> get copyWith => __$ItemVariantCopyWithImpl<_ItemVariant>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.priceDeltaMinor, priceDeltaMinor) || other.priceDeltaMinor == priceDeltaMinor));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,quantity,priceDeltaMinor);

@override
String toString() {
  return 'ItemVariant(id: $id, name: $name, quantity: $quantity, priceDeltaMinor: $priceDeltaMinor)';
}


}

/// @nodoc
abstract mixin class _$ItemVariantCopyWith<$Res> implements $ItemVariantCopyWith<$Res> {
  factory _$ItemVariantCopyWith(_ItemVariant value, $Res Function(_ItemVariant) _then) = __$ItemVariantCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int quantity, int priceDeltaMinor
});




}
/// @nodoc
class __$ItemVariantCopyWithImpl<$Res>
    implements _$ItemVariantCopyWith<$Res> {
  __$ItemVariantCopyWithImpl(this._self, this._then);

  final _ItemVariant _self;
  final $Res Function(_ItemVariant) _then;

/// Create a copy of ItemVariant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? quantity = null,Object? priceDeltaMinor = null,}) {
  return _then(_ItemVariant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,priceDeltaMinor: null == priceDeltaMinor ? _self.priceDeltaMinor : priceDeltaMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ItemCard {

 String get id; String get title; int get fromPriceMinor; String get currency;/// `per_event`, `per_day` or `per_hour`.
 String get unit; Photo? get photo;/// Set whenever the vendor is known; [vendor] only when the API sent
/// its name too.
 String? get vendorId; VendorRef? get vendor; String? get description; List<Photo> get photos;/// Active variants; only on the item's own page.
 List<ItemVariant> get variants; int get minQty;
/// Create a copy of ItemCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemCardCopyWith<ItemCard> get copyWith => _$ItemCardCopyWithImpl<ItemCard>(this as ItemCard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemCard&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.fromPriceMinor, fromPriceMinor) || other.fromPriceMinor == fromPriceMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.photos, photos)&&const DeepCollectionEquality().equals(other.variants, variants)&&(identical(other.minQty, minQty) || other.minQty == minQty));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,fromPriceMinor,currency,unit,photo,vendorId,vendor,description,const DeepCollectionEquality().hash(photos),const DeepCollectionEquality().hash(variants),minQty);

@override
String toString() {
  return 'ItemCard(id: $id, title: $title, fromPriceMinor: $fromPriceMinor, currency: $currency, unit: $unit, photo: $photo, vendorId: $vendorId, vendor: $vendor, description: $description, photos: $photos, variants: $variants, minQty: $minQty)';
}


}

/// @nodoc
abstract mixin class $ItemCardCopyWith<$Res>  {
  factory $ItemCardCopyWith(ItemCard value, $Res Function(ItemCard) _then) = _$ItemCardCopyWithImpl;
@useResult
$Res call({
 String id, String title, int fromPriceMinor, String currency, String unit, Photo? photo, String? vendorId, VendorRef? vendor, String? description, List<Photo> photos, List<ItemVariant> variants, int minQty
});


$PhotoCopyWith<$Res>? get photo;$VendorRefCopyWith<$Res>? get vendor;

}
/// @nodoc
class _$ItemCardCopyWithImpl<$Res>
    implements $ItemCardCopyWith<$Res> {
  _$ItemCardCopyWithImpl(this._self, this._then);

  final ItemCard _self;
  final $Res Function(ItemCard) _then;

/// Create a copy of ItemCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? fromPriceMinor = null,Object? currency = null,Object? unit = null,Object? photo = freezed,Object? vendorId = freezed,Object? vendor = freezed,Object? description = freezed,Object? photos = null,Object? variants = null,Object? minQty = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,fromPriceMinor: null == fromPriceMinor ? _self.fromPriceMinor : fromPriceMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as Photo?,vendorId: freezed == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as VendorRef?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<Photo>,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<ItemVariant>,minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ItemCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhotoCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $PhotoCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}/// Create a copy of ItemCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorRefCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $VendorRefCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}


/// Adds pattern-matching-related methods to [ItemCard].
extension ItemCardPatterns on ItemCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemCard value)  $default,){
final _that = this;
switch (_that) {
case _ItemCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemCard value)?  $default,){
final _that = this;
switch (_that) {
case _ItemCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int fromPriceMinor,  String currency,  String unit,  Photo? photo,  String? vendorId,  VendorRef? vendor,  String? description,  List<Photo> photos,  List<ItemVariant> variants,  int minQty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemCard() when $default != null:
return $default(_that.id,_that.title,_that.fromPriceMinor,_that.currency,_that.unit,_that.photo,_that.vendorId,_that.vendor,_that.description,_that.photos,_that.variants,_that.minQty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int fromPriceMinor,  String currency,  String unit,  Photo? photo,  String? vendorId,  VendorRef? vendor,  String? description,  List<Photo> photos,  List<ItemVariant> variants,  int minQty)  $default,) {final _that = this;
switch (_that) {
case _ItemCard():
return $default(_that.id,_that.title,_that.fromPriceMinor,_that.currency,_that.unit,_that.photo,_that.vendorId,_that.vendor,_that.description,_that.photos,_that.variants,_that.minQty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int fromPriceMinor,  String currency,  String unit,  Photo? photo,  String? vendorId,  VendorRef? vendor,  String? description,  List<Photo> photos,  List<ItemVariant> variants,  int minQty)?  $default,) {final _that = this;
switch (_that) {
case _ItemCard() when $default != null:
return $default(_that.id,_that.title,_that.fromPriceMinor,_that.currency,_that.unit,_that.photo,_that.vendorId,_that.vendor,_that.description,_that.photos,_that.variants,_that.minQty);case _:
  return null;

}
}

}

/// @nodoc


class _ItemCard implements ItemCard {
  const _ItemCard({required this.id, required this.title, required this.fromPriceMinor, required this.currency, this.unit = 'per_event', this.photo, this.vendorId, this.vendor, this.description, final  List<Photo> photos = const <Photo>[], final  List<ItemVariant> variants = const <ItemVariant>[], this.minQty = 1}): _photos = photos,_variants = variants;
  

@override final  String id;
@override final  String title;
@override final  int fromPriceMinor;
@override final  String currency;
/// `per_event`, `per_day` or `per_hour`.
@override@JsonKey() final  String unit;
@override final  Photo? photo;
/// Set whenever the vendor is known; [vendor] only when the API sent
/// its name too.
@override final  String? vendorId;
@override final  VendorRef? vendor;
@override final  String? description;
 final  List<Photo> _photos;
@override@JsonKey() List<Photo> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

/// Active variants; only on the item's own page.
 final  List<ItemVariant> _variants;
/// Active variants; only on the item's own page.
@override@JsonKey() List<ItemVariant> get variants {
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variants);
}

@override@JsonKey() final  int minQty;

/// Create a copy of ItemCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemCardCopyWith<_ItemCard> get copyWith => __$ItemCardCopyWithImpl<_ItemCard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemCard&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.fromPriceMinor, fromPriceMinor) || other.fromPriceMinor == fromPriceMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._photos, _photos)&&const DeepCollectionEquality().equals(other._variants, _variants)&&(identical(other.minQty, minQty) || other.minQty == minQty));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,fromPriceMinor,currency,unit,photo,vendorId,vendor,description,const DeepCollectionEquality().hash(_photos),const DeepCollectionEquality().hash(_variants),minQty);

@override
String toString() {
  return 'ItemCard(id: $id, title: $title, fromPriceMinor: $fromPriceMinor, currency: $currency, unit: $unit, photo: $photo, vendorId: $vendorId, vendor: $vendor, description: $description, photos: $photos, variants: $variants, minQty: $minQty)';
}


}

/// @nodoc
abstract mixin class _$ItemCardCopyWith<$Res> implements $ItemCardCopyWith<$Res> {
  factory _$ItemCardCopyWith(_ItemCard value, $Res Function(_ItemCard) _then) = __$ItemCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int fromPriceMinor, String currency, String unit, Photo? photo, String? vendorId, VendorRef? vendor, String? description, List<Photo> photos, List<ItemVariant> variants, int minQty
});


@override $PhotoCopyWith<$Res>? get photo;@override $VendorRefCopyWith<$Res>? get vendor;

}
/// @nodoc
class __$ItemCardCopyWithImpl<$Res>
    implements _$ItemCardCopyWith<$Res> {
  __$ItemCardCopyWithImpl(this._self, this._then);

  final _ItemCard _self;
  final $Res Function(_ItemCard) _then;

/// Create a copy of ItemCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? fromPriceMinor = null,Object? currency = null,Object? unit = null,Object? photo = freezed,Object? vendorId = freezed,Object? vendor = freezed,Object? description = freezed,Object? photos = null,Object? variants = null,Object? minQty = null,}) {
  return _then(_ItemCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,fromPriceMinor: null == fromPriceMinor ? _self.fromPriceMinor : fromPriceMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as Photo?,vendorId: freezed == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as VendorRef?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<Photo>,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<ItemVariant>,minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ItemCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhotoCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $PhotoCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}/// Create a copy of ItemCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorRefCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $VendorRefCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}

/// @nodoc
mixin _$PackageCard {

 String get id; String get title; int get priceMinor; String get currency; int? get guestMin; int? get guestMax; String? get description; Photo? get photo; VendorRef? get vendor; List<EventType> get eventTypes;
/// Create a copy of PackageCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PackageCardCopyWith<PackageCard> get copyWith => _$PackageCardCopyWithImpl<PackageCard>(this as PackageCard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PackageCard&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.priceMinor, priceMinor) || other.priceMinor == priceMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.guestMin, guestMin) || other.guestMin == guestMin)&&(identical(other.guestMax, guestMax) || other.guestMax == guestMax)&&(identical(other.description, description) || other.description == description)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&const DeepCollectionEquality().equals(other.eventTypes, eventTypes));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,priceMinor,currency,guestMin,guestMax,description,photo,vendor,const DeepCollectionEquality().hash(eventTypes));

@override
String toString() {
  return 'PackageCard(id: $id, title: $title, priceMinor: $priceMinor, currency: $currency, guestMin: $guestMin, guestMax: $guestMax, description: $description, photo: $photo, vendor: $vendor, eventTypes: $eventTypes)';
}


}

/// @nodoc
abstract mixin class $PackageCardCopyWith<$Res>  {
  factory $PackageCardCopyWith(PackageCard value, $Res Function(PackageCard) _then) = _$PackageCardCopyWithImpl;
@useResult
$Res call({
 String id, String title, int priceMinor, String currency, int? guestMin, int? guestMax, String? description, Photo? photo, VendorRef? vendor, List<EventType> eventTypes
});


$PhotoCopyWith<$Res>? get photo;$VendorRefCopyWith<$Res>? get vendor;

}
/// @nodoc
class _$PackageCardCopyWithImpl<$Res>
    implements $PackageCardCopyWith<$Res> {
  _$PackageCardCopyWithImpl(this._self, this._then);

  final PackageCard _self;
  final $Res Function(PackageCard) _then;

/// Create a copy of PackageCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? priceMinor = null,Object? currency = null,Object? guestMin = freezed,Object? guestMax = freezed,Object? description = freezed,Object? photo = freezed,Object? vendor = freezed,Object? eventTypes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priceMinor: null == priceMinor ? _self.priceMinor : priceMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,guestMin: freezed == guestMin ? _self.guestMin : guestMin // ignore: cast_nullable_to_non_nullable
as int?,guestMax: freezed == guestMax ? _self.guestMax : guestMax // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as Photo?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as VendorRef?,eventTypes: null == eventTypes ? _self.eventTypes : eventTypes // ignore: cast_nullable_to_non_nullable
as List<EventType>,
  ));
}
/// Create a copy of PackageCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhotoCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $PhotoCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}/// Create a copy of PackageCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorRefCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $VendorRefCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}


/// Adds pattern-matching-related methods to [PackageCard].
extension PackageCardPatterns on PackageCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PackageCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PackageCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PackageCard value)  $default,){
final _that = this;
switch (_that) {
case _PackageCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PackageCard value)?  $default,){
final _that = this;
switch (_that) {
case _PackageCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int priceMinor,  String currency,  int? guestMin,  int? guestMax,  String? description,  Photo? photo,  VendorRef? vendor,  List<EventType> eventTypes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PackageCard() when $default != null:
return $default(_that.id,_that.title,_that.priceMinor,_that.currency,_that.guestMin,_that.guestMax,_that.description,_that.photo,_that.vendor,_that.eventTypes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int priceMinor,  String currency,  int? guestMin,  int? guestMax,  String? description,  Photo? photo,  VendorRef? vendor,  List<EventType> eventTypes)  $default,) {final _that = this;
switch (_that) {
case _PackageCard():
return $default(_that.id,_that.title,_that.priceMinor,_that.currency,_that.guestMin,_that.guestMax,_that.description,_that.photo,_that.vendor,_that.eventTypes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int priceMinor,  String currency,  int? guestMin,  int? guestMax,  String? description,  Photo? photo,  VendorRef? vendor,  List<EventType> eventTypes)?  $default,) {final _that = this;
switch (_that) {
case _PackageCard() when $default != null:
return $default(_that.id,_that.title,_that.priceMinor,_that.currency,_that.guestMin,_that.guestMax,_that.description,_that.photo,_that.vendor,_that.eventTypes);case _:
  return null;

}
}

}

/// @nodoc


class _PackageCard implements PackageCard {
  const _PackageCard({required this.id, required this.title, required this.priceMinor, required this.currency, this.guestMin, this.guestMax, this.description, this.photo, this.vendor, final  List<EventType> eventTypes = const <EventType>[]}): _eventTypes = eventTypes;
  

@override final  String id;
@override final  String title;
@override final  int priceMinor;
@override final  String currency;
@override final  int? guestMin;
@override final  int? guestMax;
@override final  String? description;
@override final  Photo? photo;
@override final  VendorRef? vendor;
 final  List<EventType> _eventTypes;
@override@JsonKey() List<EventType> get eventTypes {
  if (_eventTypes is EqualUnmodifiableListView) return _eventTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventTypes);
}


/// Create a copy of PackageCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PackageCardCopyWith<_PackageCard> get copyWith => __$PackageCardCopyWithImpl<_PackageCard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PackageCard&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.priceMinor, priceMinor) || other.priceMinor == priceMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.guestMin, guestMin) || other.guestMin == guestMin)&&(identical(other.guestMax, guestMax) || other.guestMax == guestMax)&&(identical(other.description, description) || other.description == description)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&const DeepCollectionEquality().equals(other._eventTypes, _eventTypes));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,priceMinor,currency,guestMin,guestMax,description,photo,vendor,const DeepCollectionEquality().hash(_eventTypes));

@override
String toString() {
  return 'PackageCard(id: $id, title: $title, priceMinor: $priceMinor, currency: $currency, guestMin: $guestMin, guestMax: $guestMax, description: $description, photo: $photo, vendor: $vendor, eventTypes: $eventTypes)';
}


}

/// @nodoc
abstract mixin class _$PackageCardCopyWith<$Res> implements $PackageCardCopyWith<$Res> {
  factory _$PackageCardCopyWith(_PackageCard value, $Res Function(_PackageCard) _then) = __$PackageCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int priceMinor, String currency, int? guestMin, int? guestMax, String? description, Photo? photo, VendorRef? vendor, List<EventType> eventTypes
});


@override $PhotoCopyWith<$Res>? get photo;@override $VendorRefCopyWith<$Res>? get vendor;

}
/// @nodoc
class __$PackageCardCopyWithImpl<$Res>
    implements _$PackageCardCopyWith<$Res> {
  __$PackageCardCopyWithImpl(this._self, this._then);

  final _PackageCard _self;
  final $Res Function(_PackageCard) _then;

/// Create a copy of PackageCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? priceMinor = null,Object? currency = null,Object? guestMin = freezed,Object? guestMax = freezed,Object? description = freezed,Object? photo = freezed,Object? vendor = freezed,Object? eventTypes = null,}) {
  return _then(_PackageCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priceMinor: null == priceMinor ? _self.priceMinor : priceMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,guestMin: freezed == guestMin ? _self.guestMin : guestMin // ignore: cast_nullable_to_non_nullable
as int?,guestMax: freezed == guestMax ? _self.guestMax : guestMax // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as Photo?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as VendorRef?,eventTypes: null == eventTypes ? _self._eventTypes : eventTypes // ignore: cast_nullable_to_non_nullable
as List<EventType>,
  ));
}

/// Create a copy of PackageCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhotoCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $PhotoCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}/// Create a copy of PackageCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorRefCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $VendorRefCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}

/// @nodoc
mixin _$UpcomingEvent {

 String get id; String get title; DateTime get startsAt;/// Null for event types the app has no accent for (`other`).
 EventType? get type; String? get venueName; String? get venueCity; double? get lat; double? get lng; bool get isHost;
/// Create a copy of UpcomingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingEventCopyWith<UpcomingEvent> get copyWith => _$UpcomingEventCopyWithImpl<UpcomingEvent>(this as UpcomingEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.isHost, isHost) || other.isHost == isHost));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,type,venueName,venueCity,lat,lng,isHost);

@override
String toString() {
  return 'UpcomingEvent(id: $id, title: $title, startsAt: $startsAt, type: $type, venueName: $venueName, venueCity: $venueCity, lat: $lat, lng: $lng, isHost: $isHost)';
}


}

/// @nodoc
abstract mixin class $UpcomingEventCopyWith<$Res>  {
  factory $UpcomingEventCopyWith(UpcomingEvent value, $Res Function(UpcomingEvent) _then) = _$UpcomingEventCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime startsAt, EventType? type, String? venueName, String? venueCity, double? lat, double? lng, bool isHost
});




}
/// @nodoc
class _$UpcomingEventCopyWithImpl<$Res>
    implements $UpcomingEventCopyWith<$Res> {
  _$UpcomingEventCopyWithImpl(this._self, this._then);

  final UpcomingEvent _self;
  final $Res Function(UpcomingEvent) _then;

/// Create a copy of UpcomingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? type = freezed,Object? venueName = freezed,Object? venueCity = freezed,Object? lat = freezed,Object? lng = freezed,Object? isHost = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType?,venueName: freezed == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String?,venueCity: freezed == venueCity ? _self.venueCity : venueCity // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,isHost: null == isHost ? _self.isHost : isHost // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UpcomingEvent].
extension UpcomingEventPatterns on UpcomingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpcomingEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpcomingEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpcomingEvent value)  $default,){
final _that = this;
switch (_that) {
case _UpcomingEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpcomingEvent value)?  $default,){
final _that = this;
switch (_that) {
case _UpcomingEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsAt,  EventType? type,  String? venueName,  String? venueCity,  double? lat,  double? lng,  bool isHost)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.type,_that.venueName,_that.venueCity,_that.lat,_that.lng,_that.isHost);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsAt,  EventType? type,  String? venueName,  String? venueCity,  double? lat,  double? lng,  bool isHost)  $default,) {final _that = this;
switch (_that) {
case _UpcomingEvent():
return $default(_that.id,_that.title,_that.startsAt,_that.type,_that.venueName,_that.venueCity,_that.lat,_that.lng,_that.isHost);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime startsAt,  EventType? type,  String? venueName,  String? venueCity,  double? lat,  double? lng,  bool isHost)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.type,_that.venueName,_that.venueCity,_that.lat,_that.lng,_that.isHost);case _:
  return null;

}
}

}

/// @nodoc


class _UpcomingEvent extends UpcomingEvent {
  const _UpcomingEvent({required this.id, required this.title, required this.startsAt, this.type, this.venueName, this.venueCity, this.lat, this.lng, this.isHost = false}): super._();
  

@override final  String id;
@override final  String title;
@override final  DateTime startsAt;
/// Null for event types the app has no accent for (`other`).
@override final  EventType? type;
@override final  String? venueName;
@override final  String? venueCity;
@override final  double? lat;
@override final  double? lng;
@override@JsonKey() final  bool isHost;

/// Create a copy of UpcomingEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingEventCopyWith<_UpcomingEvent> get copyWith => __$UpcomingEventCopyWithImpl<_UpcomingEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.isHost, isHost) || other.isHost == isHost));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,type,venueName,venueCity,lat,lng,isHost);

@override
String toString() {
  return 'UpcomingEvent(id: $id, title: $title, startsAt: $startsAt, type: $type, venueName: $venueName, venueCity: $venueCity, lat: $lat, lng: $lng, isHost: $isHost)';
}


}

/// @nodoc
abstract mixin class _$UpcomingEventCopyWith<$Res> implements $UpcomingEventCopyWith<$Res> {
  factory _$UpcomingEventCopyWith(_UpcomingEvent value, $Res Function(_UpcomingEvent) _then) = __$UpcomingEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime startsAt, EventType? type, String? venueName, String? venueCity, double? lat, double? lng, bool isHost
});




}
/// @nodoc
class __$UpcomingEventCopyWithImpl<$Res>
    implements _$UpcomingEventCopyWith<$Res> {
  __$UpcomingEventCopyWithImpl(this._self, this._then);

  final _UpcomingEvent _self;
  final $Res Function(_UpcomingEvent) _then;

/// Create a copy of UpcomingEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? type = freezed,Object? venueName = freezed,Object? venueCity = freezed,Object? lat = freezed,Object? lng = freezed,Object? isHost = null,}) {
  return _then(_UpcomingEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType?,venueName: freezed == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String?,venueCity: freezed == venueCity ? _self.venueCity : venueCity // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,isHost: null == isHost ? _self.isHost : isHost // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$NeedVendor {

 VendorRef get vendor; int? get fromPriceMinor; String? get currency; double? get distanceKm;
/// Create a copy of NeedVendor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NeedVendorCopyWith<NeedVendor> get copyWith => _$NeedVendorCopyWithImpl<NeedVendor>(this as NeedVendor, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NeedVendor&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.fromPriceMinor, fromPriceMinor) || other.fromPriceMinor == fromPriceMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm));
}


@override
int get hashCode => Object.hash(runtimeType,vendor,fromPriceMinor,currency,distanceKm);

@override
String toString() {
  return 'NeedVendor(vendor: $vendor, fromPriceMinor: $fromPriceMinor, currency: $currency, distanceKm: $distanceKm)';
}


}

/// @nodoc
abstract mixin class $NeedVendorCopyWith<$Res>  {
  factory $NeedVendorCopyWith(NeedVendor value, $Res Function(NeedVendor) _then) = _$NeedVendorCopyWithImpl;
@useResult
$Res call({
 VendorRef vendor, int? fromPriceMinor, String? currency, double? distanceKm
});


$VendorRefCopyWith<$Res> get vendor;

}
/// @nodoc
class _$NeedVendorCopyWithImpl<$Res>
    implements $NeedVendorCopyWith<$Res> {
  _$NeedVendorCopyWithImpl(this._self, this._then);

  final NeedVendor _self;
  final $Res Function(NeedVendor) _then;

/// Create a copy of NeedVendor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vendor = null,Object? fromPriceMinor = freezed,Object? currency = freezed,Object? distanceKm = freezed,}) {
  return _then(_self.copyWith(
vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as VendorRef,fromPriceMinor: freezed == fromPriceMinor ? _self.fromPriceMinor : fromPriceMinor // ignore: cast_nullable_to_non_nullable
as int?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of NeedVendor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorRefCopyWith<$Res> get vendor {
  
  return $VendorRefCopyWith<$Res>(_self.vendor, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}


/// Adds pattern-matching-related methods to [NeedVendor].
extension NeedVendorPatterns on NeedVendor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NeedVendor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NeedVendor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NeedVendor value)  $default,){
final _that = this;
switch (_that) {
case _NeedVendor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NeedVendor value)?  $default,){
final _that = this;
switch (_that) {
case _NeedVendor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VendorRef vendor,  int? fromPriceMinor,  String? currency,  double? distanceKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NeedVendor() when $default != null:
return $default(_that.vendor,_that.fromPriceMinor,_that.currency,_that.distanceKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VendorRef vendor,  int? fromPriceMinor,  String? currency,  double? distanceKm)  $default,) {final _that = this;
switch (_that) {
case _NeedVendor():
return $default(_that.vendor,_that.fromPriceMinor,_that.currency,_that.distanceKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VendorRef vendor,  int? fromPriceMinor,  String? currency,  double? distanceKm)?  $default,) {final _that = this;
switch (_that) {
case _NeedVendor() when $default != null:
return $default(_that.vendor,_that.fromPriceMinor,_that.currency,_that.distanceKm);case _:
  return null;

}
}

}

/// @nodoc


class _NeedVendor implements NeedVendor {
  const _NeedVendor({required this.vendor, this.fromPriceMinor, this.currency, this.distanceKm});
  

@override final  VendorRef vendor;
@override final  int? fromPriceMinor;
@override final  String? currency;
@override final  double? distanceKm;

/// Create a copy of NeedVendor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NeedVendorCopyWith<_NeedVendor> get copyWith => __$NeedVendorCopyWithImpl<_NeedVendor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NeedVendor&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.fromPriceMinor, fromPriceMinor) || other.fromPriceMinor == fromPriceMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm));
}


@override
int get hashCode => Object.hash(runtimeType,vendor,fromPriceMinor,currency,distanceKm);

@override
String toString() {
  return 'NeedVendor(vendor: $vendor, fromPriceMinor: $fromPriceMinor, currency: $currency, distanceKm: $distanceKm)';
}


}

/// @nodoc
abstract mixin class _$NeedVendorCopyWith<$Res> implements $NeedVendorCopyWith<$Res> {
  factory _$NeedVendorCopyWith(_NeedVendor value, $Res Function(_NeedVendor) _then) = __$NeedVendorCopyWithImpl;
@override @useResult
$Res call({
 VendorRef vendor, int? fromPriceMinor, String? currency, double? distanceKm
});


@override $VendorRefCopyWith<$Res> get vendor;

}
/// @nodoc
class __$NeedVendorCopyWithImpl<$Res>
    implements _$NeedVendorCopyWith<$Res> {
  __$NeedVendorCopyWithImpl(this._self, this._then);

  final _NeedVendor _self;
  final $Res Function(_NeedVendor) _then;

/// Create a copy of NeedVendor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vendor = null,Object? fromPriceMinor = freezed,Object? currency = freezed,Object? distanceKm = freezed,}) {
  return _then(_NeedVendor(
vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as VendorRef,fromPriceMinor: freezed == fromPriceMinor ? _self.fromPriceMinor : fromPriceMinor // ignore: cast_nullable_to_non_nullable
as int?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of NeedVendor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorRefCopyWith<$Res> get vendor {
  
  return $VendorRefCopyWith<$Res>(_self.vendor, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}

/// @nodoc
mixin _$EventNeed {

 String get categoryId; String get categoryName; List<NeedVendor> get vendors;
/// Create a copy of EventNeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventNeedCopyWith<EventNeed> get copyWith => _$EventNeedCopyWithImpl<EventNeed>(this as EventNeed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventNeed&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&const DeepCollectionEquality().equals(other.vendors, vendors));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,categoryName,const DeepCollectionEquality().hash(vendors));

@override
String toString() {
  return 'EventNeed(categoryId: $categoryId, categoryName: $categoryName, vendors: $vendors)';
}


}

/// @nodoc
abstract mixin class $EventNeedCopyWith<$Res>  {
  factory $EventNeedCopyWith(EventNeed value, $Res Function(EventNeed) _then) = _$EventNeedCopyWithImpl;
@useResult
$Res call({
 String categoryId, String categoryName, List<NeedVendor> vendors
});




}
/// @nodoc
class _$EventNeedCopyWithImpl<$Res>
    implements $EventNeedCopyWith<$Res> {
  _$EventNeedCopyWithImpl(this._self, this._then);

  final EventNeed _self;
  final $Res Function(EventNeed) _then;

/// Create a copy of EventNeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? categoryName = null,Object? vendors = null,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,vendors: null == vendors ? _self.vendors : vendors // ignore: cast_nullable_to_non_nullable
as List<NeedVendor>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventNeed].
extension EventNeedPatterns on EventNeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventNeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventNeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventNeed value)  $default,){
final _that = this;
switch (_that) {
case _EventNeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventNeed value)?  $default,){
final _that = this;
switch (_that) {
case _EventNeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  String categoryName,  List<NeedVendor> vendors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventNeed() when $default != null:
return $default(_that.categoryId,_that.categoryName,_that.vendors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  String categoryName,  List<NeedVendor> vendors)  $default,) {final _that = this;
switch (_that) {
case _EventNeed():
return $default(_that.categoryId,_that.categoryName,_that.vendors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  String categoryName,  List<NeedVendor> vendors)?  $default,) {final _that = this;
switch (_that) {
case _EventNeed() when $default != null:
return $default(_that.categoryId,_that.categoryName,_that.vendors);case _:
  return null;

}
}

}

/// @nodoc


class _EventNeed implements EventNeed {
  const _EventNeed({required this.categoryId, required this.categoryName, final  List<NeedVendor> vendors = const <NeedVendor>[]}): _vendors = vendors;
  

@override final  String categoryId;
@override final  String categoryName;
 final  List<NeedVendor> _vendors;
@override@JsonKey() List<NeedVendor> get vendors {
  if (_vendors is EqualUnmodifiableListView) return _vendors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vendors);
}


/// Create a copy of EventNeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventNeedCopyWith<_EventNeed> get copyWith => __$EventNeedCopyWithImpl<_EventNeed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventNeed&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&const DeepCollectionEquality().equals(other._vendors, _vendors));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,categoryName,const DeepCollectionEquality().hash(_vendors));

@override
String toString() {
  return 'EventNeed(categoryId: $categoryId, categoryName: $categoryName, vendors: $vendors)';
}


}

/// @nodoc
abstract mixin class _$EventNeedCopyWith<$Res> implements $EventNeedCopyWith<$Res> {
  factory _$EventNeedCopyWith(_EventNeed value, $Res Function(_EventNeed) _then) = __$EventNeedCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, String categoryName, List<NeedVendor> vendors
});




}
/// @nodoc
class __$EventNeedCopyWithImpl<$Res>
    implements _$EventNeedCopyWith<$Res> {
  __$EventNeedCopyWithImpl(this._self, this._then);

  final _EventNeed _self;
  final $Res Function(_EventNeed) _then;

/// Create a copy of EventNeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? categoryName = null,Object? vendors = null,}) {
  return _then(_EventNeed(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,vendors: null == vendors ? _self._vendors : vendors // ignore: cast_nullable_to_non_nullable
as List<NeedVendor>,
  ));
}


}

/// @nodoc
mixin _$EventPlanGap {

 UpcomingEvent get event; List<EventNeed> get needs;
/// Create a copy of EventPlanGap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventPlanGapCopyWith<EventPlanGap> get copyWith => _$EventPlanGapCopyWithImpl<EventPlanGap>(this as EventPlanGap, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventPlanGap&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other.needs, needs));
}


@override
int get hashCode => Object.hash(runtimeType,event,const DeepCollectionEquality().hash(needs));

@override
String toString() {
  return 'EventPlanGap(event: $event, needs: $needs)';
}


}

/// @nodoc
abstract mixin class $EventPlanGapCopyWith<$Res>  {
  factory $EventPlanGapCopyWith(EventPlanGap value, $Res Function(EventPlanGap) _then) = _$EventPlanGapCopyWithImpl;
@useResult
$Res call({
 UpcomingEvent event, List<EventNeed> needs
});


$UpcomingEventCopyWith<$Res> get event;

}
/// @nodoc
class _$EventPlanGapCopyWithImpl<$Res>
    implements $EventPlanGapCopyWith<$Res> {
  _$EventPlanGapCopyWithImpl(this._self, this._then);

  final EventPlanGap _self;
  final $Res Function(EventPlanGap) _then;

/// Create a copy of EventPlanGap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? needs = null,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as UpcomingEvent,needs: null == needs ? _self.needs : needs // ignore: cast_nullable_to_non_nullable
as List<EventNeed>,
  ));
}
/// Create a copy of EventPlanGap
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpcomingEventCopyWith<$Res> get event {
  
  return $UpcomingEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventPlanGap].
extension EventPlanGapPatterns on EventPlanGap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventPlanGap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventPlanGap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventPlanGap value)  $default,){
final _that = this;
switch (_that) {
case _EventPlanGap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventPlanGap value)?  $default,){
final _that = this;
switch (_that) {
case _EventPlanGap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UpcomingEvent event,  List<EventNeed> needs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventPlanGap() when $default != null:
return $default(_that.event,_that.needs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UpcomingEvent event,  List<EventNeed> needs)  $default,) {final _that = this;
switch (_that) {
case _EventPlanGap():
return $default(_that.event,_that.needs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UpcomingEvent event,  List<EventNeed> needs)?  $default,) {final _that = this;
switch (_that) {
case _EventPlanGap() when $default != null:
return $default(_that.event,_that.needs);case _:
  return null;

}
}

}

/// @nodoc


class _EventPlanGap implements EventPlanGap {
  const _EventPlanGap({required this.event, required final  List<EventNeed> needs}): _needs = needs;
  

@override final  UpcomingEvent event;
 final  List<EventNeed> _needs;
@override List<EventNeed> get needs {
  if (_needs is EqualUnmodifiableListView) return _needs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_needs);
}


/// Create a copy of EventPlanGap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventPlanGapCopyWith<_EventPlanGap> get copyWith => __$EventPlanGapCopyWithImpl<_EventPlanGap>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPlanGap&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other._needs, _needs));
}


@override
int get hashCode => Object.hash(runtimeType,event,const DeepCollectionEquality().hash(_needs));

@override
String toString() {
  return 'EventPlanGap(event: $event, needs: $needs)';
}


}

/// @nodoc
abstract mixin class _$EventPlanGapCopyWith<$Res> implements $EventPlanGapCopyWith<$Res> {
  factory _$EventPlanGapCopyWith(_EventPlanGap value, $Res Function(_EventPlanGap) _then) = __$EventPlanGapCopyWithImpl;
@override @useResult
$Res call({
 UpcomingEvent event, List<EventNeed> needs
});


@override $UpcomingEventCopyWith<$Res> get event;

}
/// @nodoc
class __$EventPlanGapCopyWithImpl<$Res>
    implements _$EventPlanGapCopyWith<$Res> {
  __$EventPlanGapCopyWithImpl(this._self, this._then);

  final _EventPlanGap _self;
  final $Res Function(_EventPlanGap) _then;

/// Create a copy of EventPlanGap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? needs = null,}) {
  return _then(_EventPlanGap(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as UpcomingEvent,needs: null == needs ? _self._needs : needs // ignore: cast_nullable_to_non_nullable
as List<EventNeed>,
  ));
}

/// Create a copy of EventPlanGap
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpcomingEventCopyWith<$Res> get event {
  
  return $UpcomingEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}

/// @nodoc
mixin _$LookTag {

 String get id; double get x; double get y;/// `item`, `vendor` or `user`.
 String get targetType; String get targetId; ItemCard? get item;
/// Create a copy of LookTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LookTagCopyWith<LookTag> get copyWith => _$LookTagCopyWithImpl<LookTag>(this as LookTag, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LookTag&&(identical(other.id, id) || other.id == id)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,id,x,y,targetType,targetId,item);

@override
String toString() {
  return 'LookTag(id: $id, x: $x, y: $y, targetType: $targetType, targetId: $targetId, item: $item)';
}


}

/// @nodoc
abstract mixin class $LookTagCopyWith<$Res>  {
  factory $LookTagCopyWith(LookTag value, $Res Function(LookTag) _then) = _$LookTagCopyWithImpl;
@useResult
$Res call({
 String id, double x, double y, String targetType, String targetId, ItemCard? item
});


$ItemCardCopyWith<$Res>? get item;

}
/// @nodoc
class _$LookTagCopyWithImpl<$Res>
    implements $LookTagCopyWith<$Res> {
  _$LookTagCopyWithImpl(this._self, this._then);

  final LookTag _self;
  final $Res Function(LookTag) _then;

/// Create a copy of LookTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? x = null,Object? y = null,Object? targetType = null,Object? targetId = null,Object? item = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ItemCard?,
  ));
}
/// Create a copy of LookTag
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemCardCopyWith<$Res>? get item {
    if (_self.item == null) {
    return null;
  }

  return $ItemCardCopyWith<$Res>(_self.item!, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [LookTag].
extension LookTagPatterns on LookTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LookTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LookTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LookTag value)  $default,){
final _that = this;
switch (_that) {
case _LookTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LookTag value)?  $default,){
final _that = this;
switch (_that) {
case _LookTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  double x,  double y,  String targetType,  String targetId,  ItemCard? item)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LookTag() when $default != null:
return $default(_that.id,_that.x,_that.y,_that.targetType,_that.targetId,_that.item);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  double x,  double y,  String targetType,  String targetId,  ItemCard? item)  $default,) {final _that = this;
switch (_that) {
case _LookTag():
return $default(_that.id,_that.x,_that.y,_that.targetType,_that.targetId,_that.item);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  double x,  double y,  String targetType,  String targetId,  ItemCard? item)?  $default,) {final _that = this;
switch (_that) {
case _LookTag() when $default != null:
return $default(_that.id,_that.x,_that.y,_that.targetType,_that.targetId,_that.item);case _:
  return null;

}
}

}

/// @nodoc


class _LookTag implements LookTag {
  const _LookTag({required this.id, required this.x, required this.y, required this.targetType, required this.targetId, this.item});
  

@override final  String id;
@override final  double x;
@override final  double y;
/// `item`, `vendor` or `user`.
@override final  String targetType;
@override final  String targetId;
@override final  ItemCard? item;

/// Create a copy of LookTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LookTagCopyWith<_LookTag> get copyWith => __$LookTagCopyWithImpl<_LookTag>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LookTag&&(identical(other.id, id) || other.id == id)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,id,x,y,targetType,targetId,item);

@override
String toString() {
  return 'LookTag(id: $id, x: $x, y: $y, targetType: $targetType, targetId: $targetId, item: $item)';
}


}

/// @nodoc
abstract mixin class _$LookTagCopyWith<$Res> implements $LookTagCopyWith<$Res> {
  factory _$LookTagCopyWith(_LookTag value, $Res Function(_LookTag) _then) = __$LookTagCopyWithImpl;
@override @useResult
$Res call({
 String id, double x, double y, String targetType, String targetId, ItemCard? item
});


@override $ItemCardCopyWith<$Res>? get item;

}
/// @nodoc
class __$LookTagCopyWithImpl<$Res>
    implements _$LookTagCopyWith<$Res> {
  __$LookTagCopyWithImpl(this._self, this._then);

  final _LookTag _self;
  final $Res Function(_LookTag) _then;

/// Create a copy of LookTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? x = null,Object? y = null,Object? targetType = null,Object? targetId = null,Object? item = freezed,}) {
  return _then(_LookTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ItemCard?,
  ));
}

/// Create a copy of LookTag
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemCardCopyWith<$Res>? get item {
    if (_self.item == null) {
    return null;
  }

  return $ItemCardCopyWith<$Res>(_self.item!, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

/// @nodoc
mixin _$LookMedia {

 Photo get photo; bool get isVideo; List<LookTag> get tags;
/// Create a copy of LookMedia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LookMediaCopyWith<LookMedia> get copyWith => _$LookMediaCopyWithImpl<LookMedia>(this as LookMedia, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LookMedia&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.isVideo, isVideo) || other.isVideo == isVideo)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,photo,isVideo,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'LookMedia(photo: $photo, isVideo: $isVideo, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $LookMediaCopyWith<$Res>  {
  factory $LookMediaCopyWith(LookMedia value, $Res Function(LookMedia) _then) = _$LookMediaCopyWithImpl;
@useResult
$Res call({
 Photo photo, bool isVideo, List<LookTag> tags
});


$PhotoCopyWith<$Res> get photo;

}
/// @nodoc
class _$LookMediaCopyWithImpl<$Res>
    implements $LookMediaCopyWith<$Res> {
  _$LookMediaCopyWithImpl(this._self, this._then);

  final LookMedia _self;
  final $Res Function(LookMedia) _then;

/// Create a copy of LookMedia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? photo = null,Object? isVideo = null,Object? tags = null,}) {
  return _then(_self.copyWith(
photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as Photo,isVideo: null == isVideo ? _self.isVideo : isVideo // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<LookTag>,
  ));
}
/// Create a copy of LookMedia
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhotoCopyWith<$Res> get photo {
  
  return $PhotoCopyWith<$Res>(_self.photo, (value) {
    return _then(_self.copyWith(photo: value));
  });
}
}


/// Adds pattern-matching-related methods to [LookMedia].
extension LookMediaPatterns on LookMedia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LookMedia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LookMedia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LookMedia value)  $default,){
final _that = this;
switch (_that) {
case _LookMedia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LookMedia value)?  $default,){
final _that = this;
switch (_that) {
case _LookMedia() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Photo photo,  bool isVideo,  List<LookTag> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LookMedia() when $default != null:
return $default(_that.photo,_that.isVideo,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Photo photo,  bool isVideo,  List<LookTag> tags)  $default,) {final _that = this;
switch (_that) {
case _LookMedia():
return $default(_that.photo,_that.isVideo,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Photo photo,  bool isVideo,  List<LookTag> tags)?  $default,) {final _that = this;
switch (_that) {
case _LookMedia() when $default != null:
return $default(_that.photo,_that.isVideo,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _LookMedia implements LookMedia {
  const _LookMedia({required this.photo, this.isVideo = false, final  List<LookTag> tags = const <LookTag>[]}): _tags = tags;
  

@override final  Photo photo;
@override@JsonKey() final  bool isVideo;
 final  List<LookTag> _tags;
@override@JsonKey() List<LookTag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of LookMedia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LookMediaCopyWith<_LookMedia> get copyWith => __$LookMediaCopyWithImpl<_LookMedia>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LookMedia&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.isVideo, isVideo) || other.isVideo == isVideo)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,photo,isVideo,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'LookMedia(photo: $photo, isVideo: $isVideo, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$LookMediaCopyWith<$Res> implements $LookMediaCopyWith<$Res> {
  factory _$LookMediaCopyWith(_LookMedia value, $Res Function(_LookMedia) _then) = __$LookMediaCopyWithImpl;
@override @useResult
$Res call({
 Photo photo, bool isVideo, List<LookTag> tags
});


@override $PhotoCopyWith<$Res> get photo;

}
/// @nodoc
class __$LookMediaCopyWithImpl<$Res>
    implements _$LookMediaCopyWith<$Res> {
  __$LookMediaCopyWithImpl(this._self, this._then);

  final _LookMedia _self;
  final $Res Function(_LookMedia) _then;

/// Create a copy of LookMedia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? photo = null,Object? isVideo = null,Object? tags = null,}) {
  return _then(_LookMedia(
photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as Photo,isVideo: null == isVideo ? _self.isVideo : isVideo // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<LookTag>,
  ));
}

/// Create a copy of LookMedia
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhotoCopyWith<$Res> get photo {
  
  return $PhotoCopyWith<$Res>(_self.photo, (value) {
    return _then(_self.copyWith(photo: value));
  });
}
}

/// @nodoc
mixin _$LookPost {

 String get id; String get authorName; List<LookMedia> get media; String? get authorAvatarUrl; bool get authorIsVendor; EventType? get eventType; String get caption; int get likeCount;
/// Create a copy of LookPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LookPostCopyWith<LookPost> get copyWith => _$LookPostCopyWithImpl<LookPost>(this as LookPost, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LookPost&&(identical(other.id, id) || other.id == id)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&const DeepCollectionEquality().equals(other.media, media)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.authorIsVendor, authorIsVendor) || other.authorIsVendor == authorIsVendor)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,authorName,const DeepCollectionEquality().hash(media),authorAvatarUrl,authorIsVendor,eventType,caption,likeCount);

@override
String toString() {
  return 'LookPost(id: $id, authorName: $authorName, media: $media, authorAvatarUrl: $authorAvatarUrl, authorIsVendor: $authorIsVendor, eventType: $eventType, caption: $caption, likeCount: $likeCount)';
}


}

/// @nodoc
abstract mixin class $LookPostCopyWith<$Res>  {
  factory $LookPostCopyWith(LookPost value, $Res Function(LookPost) _then) = _$LookPostCopyWithImpl;
@useResult
$Res call({
 String id, String authorName, List<LookMedia> media, String? authorAvatarUrl, bool authorIsVendor, EventType? eventType, String caption, int likeCount
});




}
/// @nodoc
class _$LookPostCopyWithImpl<$Res>
    implements $LookPostCopyWith<$Res> {
  _$LookPostCopyWithImpl(this._self, this._then);

  final LookPost _self;
  final $Res Function(LookPost) _then;

/// Create a copy of LookPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorName = null,Object? media = null,Object? authorAvatarUrl = freezed,Object? authorIsVendor = null,Object? eventType = freezed,Object? caption = null,Object? likeCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<LookMedia>,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,authorIsVendor: null == authorIsVendor ? _self.authorIsVendor : authorIsVendor // ignore: cast_nullable_to_non_nullable
as bool,eventType: freezed == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventType?,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LookPost].
extension LookPostPatterns on LookPost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LookPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LookPost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LookPost value)  $default,){
final _that = this;
switch (_that) {
case _LookPost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LookPost value)?  $default,){
final _that = this;
switch (_that) {
case _LookPost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String authorName,  List<LookMedia> media,  String? authorAvatarUrl,  bool authorIsVendor,  EventType? eventType,  String caption,  int likeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LookPost() when $default != null:
return $default(_that.id,_that.authorName,_that.media,_that.authorAvatarUrl,_that.authorIsVendor,_that.eventType,_that.caption,_that.likeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String authorName,  List<LookMedia> media,  String? authorAvatarUrl,  bool authorIsVendor,  EventType? eventType,  String caption,  int likeCount)  $default,) {final _that = this;
switch (_that) {
case _LookPost():
return $default(_that.id,_that.authorName,_that.media,_that.authorAvatarUrl,_that.authorIsVendor,_that.eventType,_that.caption,_that.likeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String authorName,  List<LookMedia> media,  String? authorAvatarUrl,  bool authorIsVendor,  EventType? eventType,  String caption,  int likeCount)?  $default,) {final _that = this;
switch (_that) {
case _LookPost() when $default != null:
return $default(_that.id,_that.authorName,_that.media,_that.authorAvatarUrl,_that.authorIsVendor,_that.eventType,_that.caption,_that.likeCount);case _:
  return null;

}
}

}

/// @nodoc


class _LookPost extends LookPost {
  const _LookPost({required this.id, required this.authorName, required final  List<LookMedia> media, this.authorAvatarUrl, this.authorIsVendor = false, this.eventType, this.caption = '', this.likeCount = 0}): _media = media,super._();
  

@override final  String id;
@override final  String authorName;
 final  List<LookMedia> _media;
@override List<LookMedia> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}

@override final  String? authorAvatarUrl;
@override@JsonKey() final  bool authorIsVendor;
@override final  EventType? eventType;
@override@JsonKey() final  String caption;
@override@JsonKey() final  int likeCount;

/// Create a copy of LookPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LookPostCopyWith<_LookPost> get copyWith => __$LookPostCopyWithImpl<_LookPost>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LookPost&&(identical(other.id, id) || other.id == id)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&const DeepCollectionEquality().equals(other._media, _media)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.authorIsVendor, authorIsVendor) || other.authorIsVendor == authorIsVendor)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,authorName,const DeepCollectionEquality().hash(_media),authorAvatarUrl,authorIsVendor,eventType,caption,likeCount);

@override
String toString() {
  return 'LookPost(id: $id, authorName: $authorName, media: $media, authorAvatarUrl: $authorAvatarUrl, authorIsVendor: $authorIsVendor, eventType: $eventType, caption: $caption, likeCount: $likeCount)';
}


}

/// @nodoc
abstract mixin class _$LookPostCopyWith<$Res> implements $LookPostCopyWith<$Res> {
  factory _$LookPostCopyWith(_LookPost value, $Res Function(_LookPost) _then) = __$LookPostCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorName, List<LookMedia> media, String? authorAvatarUrl, bool authorIsVendor, EventType? eventType, String caption, int likeCount
});




}
/// @nodoc
class __$LookPostCopyWithImpl<$Res>
    implements _$LookPostCopyWith<$Res> {
  __$LookPostCopyWithImpl(this._self, this._then);

  final _LookPost _self;
  final $Res Function(_LookPost) _then;

/// Create a copy of LookPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorName = null,Object? media = null,Object? authorAvatarUrl = freezed,Object? authorIsVendor = null,Object? eventType = freezed,Object? caption = null,Object? likeCount = null,}) {
  return _then(_LookPost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<LookMedia>,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,authorIsVendor: null == authorIsVendor ? _self.authorIsVendor : authorIsVendor // ignore: cast_nullable_to_non_nullable
as bool,eventType: freezed == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventType?,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
