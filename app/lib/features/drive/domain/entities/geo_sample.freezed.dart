// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geo_sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeoSample {

 DateTime get time; Coord get coord;/// Device-reported speed, m/s; 0 when the fix has no usable speed.
 double get speedMps; double get accuracyM;
/// Create a copy of GeoSample
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeoSampleCopyWith<GeoSample> get copyWith => _$GeoSampleCopyWithImpl<GeoSample>(this as GeoSample, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoSample&&(identical(other.time, time) || other.time == time)&&(identical(other.coord, coord) || other.coord == coord)&&(identical(other.speedMps, speedMps) || other.speedMps == speedMps)&&(identical(other.accuracyM, accuracyM) || other.accuracyM == accuracyM));
}


@override
int get hashCode => Object.hash(runtimeType,time,coord,speedMps,accuracyM);

@override
String toString() {
  return 'GeoSample(time: $time, coord: $coord, speedMps: $speedMps, accuracyM: $accuracyM)';
}


}

/// @nodoc
abstract mixin class $GeoSampleCopyWith<$Res>  {
  factory $GeoSampleCopyWith(GeoSample value, $Res Function(GeoSample) _then) = _$GeoSampleCopyWithImpl;
@useResult
$Res call({
 DateTime time, Coord coord, double speedMps, double accuracyM
});


$CoordCopyWith<$Res> get coord;

}
/// @nodoc
class _$GeoSampleCopyWithImpl<$Res>
    implements $GeoSampleCopyWith<$Res> {
  _$GeoSampleCopyWithImpl(this._self, this._then);

  final GeoSample _self;
  final $Res Function(GeoSample) _then;

/// Create a copy of GeoSample
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? coord = null,Object? speedMps = null,Object? accuracyM = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,coord: null == coord ? _self.coord : coord // ignore: cast_nullable_to_non_nullable
as Coord,speedMps: null == speedMps ? _self.speedMps : speedMps // ignore: cast_nullable_to_non_nullable
as double,accuracyM: null == accuracyM ? _self.accuracyM : accuracyM // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of GeoSample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get coord {
  
  return $CoordCopyWith<$Res>(_self.coord, (value) {
    return _then(_self.copyWith(coord: value));
  });
}
}


/// Adds pattern-matching-related methods to [GeoSample].
extension GeoSamplePatterns on GeoSample {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeoSample value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeoSample() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeoSample value)  $default,){
final _that = this;
switch (_that) {
case _GeoSample():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeoSample value)?  $default,){
final _that = this;
switch (_that) {
case _GeoSample() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime time,  Coord coord,  double speedMps,  double accuracyM)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeoSample() when $default != null:
return $default(_that.time,_that.coord,_that.speedMps,_that.accuracyM);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime time,  Coord coord,  double speedMps,  double accuracyM)  $default,) {final _that = this;
switch (_that) {
case _GeoSample():
return $default(_that.time,_that.coord,_that.speedMps,_that.accuracyM);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime time,  Coord coord,  double speedMps,  double accuracyM)?  $default,) {final _that = this;
switch (_that) {
case _GeoSample() when $default != null:
return $default(_that.time,_that.coord,_that.speedMps,_that.accuracyM);case _:
  return null;

}
}

}

/// @nodoc


class _GeoSample implements GeoSample {
  const _GeoSample({required this.time, required this.coord, required this.speedMps, required this.accuracyM});
  

@override final  DateTime time;
@override final  Coord coord;
/// Device-reported speed, m/s; 0 when the fix has no usable speed.
@override final  double speedMps;
@override final  double accuracyM;

/// Create a copy of GeoSample
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeoSampleCopyWith<_GeoSample> get copyWith => __$GeoSampleCopyWithImpl<_GeoSample>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeoSample&&(identical(other.time, time) || other.time == time)&&(identical(other.coord, coord) || other.coord == coord)&&(identical(other.speedMps, speedMps) || other.speedMps == speedMps)&&(identical(other.accuracyM, accuracyM) || other.accuracyM == accuracyM));
}


@override
int get hashCode => Object.hash(runtimeType,time,coord,speedMps,accuracyM);

@override
String toString() {
  return 'GeoSample(time: $time, coord: $coord, speedMps: $speedMps, accuracyM: $accuracyM)';
}


}

/// @nodoc
abstract mixin class _$GeoSampleCopyWith<$Res> implements $GeoSampleCopyWith<$Res> {
  factory _$GeoSampleCopyWith(_GeoSample value, $Res Function(_GeoSample) _then) = __$GeoSampleCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, Coord coord, double speedMps, double accuracyM
});


@override $CoordCopyWith<$Res> get coord;

}
/// @nodoc
class __$GeoSampleCopyWithImpl<$Res>
    implements _$GeoSampleCopyWith<$Res> {
  __$GeoSampleCopyWithImpl(this._self, this._then);

  final _GeoSample _self;
  final $Res Function(_GeoSample) _then;

/// Create a copy of GeoSample
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? coord = null,Object? speedMps = null,Object? accuracyM = null,}) {
  return _then(_GeoSample(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,coord: null == coord ? _self.coord : coord // ignore: cast_nullable_to_non_nullable
as Coord,speedMps: null == speedMps ? _self.speedMps : speedMps // ignore: cast_nullable_to_non_nullable
as double,accuracyM: null == accuracyM ? _self.accuracyM : accuracyM // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of GeoSample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get coord {
  
  return $CoordCopyWith<$Res>(_self.coord, (value) {
    return _then(_self.copyWith(coord: value));
  });
}
}

// dart format on
