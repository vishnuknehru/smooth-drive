// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drive_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriveTick {

 GeoSample get sample;/// Latest backend response; null until the first poll completes.
 PositionUpdate? get update;/// Sign value in force at the current position, derived locally from
/// the cached route events — no extra API call.
 int? get currentLimitMph; bool get offRoute;/// Set while the latest poll failed; the drive keeps running on GPS.
 Failure? get failure;
/// Create a copy of DriveTick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveTickCopyWith<DriveTick> get copyWith => _$DriveTickCopyWithImpl<DriveTick>(this as DriveTick, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveTick&&(identical(other.sample, sample) || other.sample == sample)&&(identical(other.update, update) || other.update == update)&&(identical(other.currentLimitMph, currentLimitMph) || other.currentLimitMph == currentLimitMph)&&(identical(other.offRoute, offRoute) || other.offRoute == offRoute)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,sample,update,currentLimitMph,offRoute,failure);

@override
String toString() {
  return 'DriveTick(sample: $sample, update: $update, currentLimitMph: $currentLimitMph, offRoute: $offRoute, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $DriveTickCopyWith<$Res>  {
  factory $DriveTickCopyWith(DriveTick value, $Res Function(DriveTick) _then) = _$DriveTickCopyWithImpl;
@useResult
$Res call({
 GeoSample sample, PositionUpdate? update, int? currentLimitMph, bool offRoute, Failure? failure
});


$GeoSampleCopyWith<$Res> get sample;$PositionUpdateCopyWith<$Res>? get update;

}
/// @nodoc
class _$DriveTickCopyWithImpl<$Res>
    implements $DriveTickCopyWith<$Res> {
  _$DriveTickCopyWithImpl(this._self, this._then);

  final DriveTick _self;
  final $Res Function(DriveTick) _then;

/// Create a copy of DriveTick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sample = null,Object? update = freezed,Object? currentLimitMph = freezed,Object? offRoute = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
sample: null == sample ? _self.sample : sample // ignore: cast_nullable_to_non_nullable
as GeoSample,update: freezed == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as PositionUpdate?,currentLimitMph: freezed == currentLimitMph ? _self.currentLimitMph : currentLimitMph // ignore: cast_nullable_to_non_nullable
as int?,offRoute: null == offRoute ? _self.offRoute : offRoute // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of DriveTick
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoSampleCopyWith<$Res> get sample {
  
  return $GeoSampleCopyWith<$Res>(_self.sample, (value) {
    return _then(_self.copyWith(sample: value));
  });
}/// Create a copy of DriveTick
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PositionUpdateCopyWith<$Res>? get update {
    if (_self.update == null) {
    return null;
  }

  return $PositionUpdateCopyWith<$Res>(_self.update!, (value) {
    return _then(_self.copyWith(update: value));
  });
}
}


/// Adds pattern-matching-related methods to [DriveTick].
extension DriveTickPatterns on DriveTick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveTick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveTick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveTick value)  $default,){
final _that = this;
switch (_that) {
case _DriveTick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveTick value)?  $default,){
final _that = this;
switch (_that) {
case _DriveTick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeoSample sample,  PositionUpdate? update,  int? currentLimitMph,  bool offRoute,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveTick() when $default != null:
return $default(_that.sample,_that.update,_that.currentLimitMph,_that.offRoute,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeoSample sample,  PositionUpdate? update,  int? currentLimitMph,  bool offRoute,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _DriveTick():
return $default(_that.sample,_that.update,_that.currentLimitMph,_that.offRoute,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeoSample sample,  PositionUpdate? update,  int? currentLimitMph,  bool offRoute,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _DriveTick() when $default != null:
return $default(_that.sample,_that.update,_that.currentLimitMph,_that.offRoute,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _DriveTick implements DriveTick {
  const _DriveTick({required this.sample, this.update, this.currentLimitMph, required this.offRoute, this.failure});
  

@override final  GeoSample sample;
/// Latest backend response; null until the first poll completes.
@override final  PositionUpdate? update;
/// Sign value in force at the current position, derived locally from
/// the cached route events — no extra API call.
@override final  int? currentLimitMph;
@override final  bool offRoute;
/// Set while the latest poll failed; the drive keeps running on GPS.
@override final  Failure? failure;

/// Create a copy of DriveTick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveTickCopyWith<_DriveTick> get copyWith => __$DriveTickCopyWithImpl<_DriveTick>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveTick&&(identical(other.sample, sample) || other.sample == sample)&&(identical(other.update, update) || other.update == update)&&(identical(other.currentLimitMph, currentLimitMph) || other.currentLimitMph == currentLimitMph)&&(identical(other.offRoute, offRoute) || other.offRoute == offRoute)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,sample,update,currentLimitMph,offRoute,failure);

@override
String toString() {
  return 'DriveTick(sample: $sample, update: $update, currentLimitMph: $currentLimitMph, offRoute: $offRoute, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$DriveTickCopyWith<$Res> implements $DriveTickCopyWith<$Res> {
  factory _$DriveTickCopyWith(_DriveTick value, $Res Function(_DriveTick) _then) = __$DriveTickCopyWithImpl;
@override @useResult
$Res call({
 GeoSample sample, PositionUpdate? update, int? currentLimitMph, bool offRoute, Failure? failure
});


@override $GeoSampleCopyWith<$Res> get sample;@override $PositionUpdateCopyWith<$Res>? get update;

}
/// @nodoc
class __$DriveTickCopyWithImpl<$Res>
    implements _$DriveTickCopyWith<$Res> {
  __$DriveTickCopyWithImpl(this._self, this._then);

  final _DriveTick _self;
  final $Res Function(_DriveTick) _then;

/// Create a copy of DriveTick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sample = null,Object? update = freezed,Object? currentLimitMph = freezed,Object? offRoute = null,Object? failure = freezed,}) {
  return _then(_DriveTick(
sample: null == sample ? _self.sample : sample // ignore: cast_nullable_to_non_nullable
as GeoSample,update: freezed == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as PositionUpdate?,currentLimitMph: freezed == currentLimitMph ? _self.currentLimitMph : currentLimitMph // ignore: cast_nullable_to_non_nullable
as int?,offRoute: null == offRoute ? _self.offRoute : offRoute // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of DriveTick
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoSampleCopyWith<$Res> get sample {
  
  return $GeoSampleCopyWith<$Res>(_self.sample, (value) {
    return _then(_self.copyWith(sample: value));
  });
}/// Create a copy of DriveTick
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PositionUpdateCopyWith<$Res>? get update {
    if (_self.update == null) {
    return null;
  }

  return $PositionUpdateCopyWith<$Res>(_self.update!, (value) {
    return _then(_self.copyWith(update: value));
  });
}
}

// dart format on
