// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drive_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriveState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriveState()';
}


}

/// @nodoc
class $DriveStateCopyWith<$Res>  {
$DriveStateCopyWith(DriveState _, $Res Function(DriveState) __);
}


/// Adds pattern-matching-related methods to [DriveState].
extension DriveStatePatterns on DriveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DriveIdle value)?  idle,TResult Function( DriveAcquiringGps value)?  acquiringGps,TResult Function( DriveAnalyzing value)?  analyzing,TResult Function( DriveDriving value)?  driving,TResult Function( DriveSaving value)?  saving,TResult Function( DriveDone value)?  done,TResult Function( DriveError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DriveIdle() when idle != null:
return idle(_that);case DriveAcquiringGps() when acquiringGps != null:
return acquiringGps(_that);case DriveAnalyzing() when analyzing != null:
return analyzing(_that);case DriveDriving() when driving != null:
return driving(_that);case DriveSaving() when saving != null:
return saving(_that);case DriveDone() when done != null:
return done(_that);case DriveError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DriveIdle value)  idle,required TResult Function( DriveAcquiringGps value)  acquiringGps,required TResult Function( DriveAnalyzing value)  analyzing,required TResult Function( DriveDriving value)  driving,required TResult Function( DriveSaving value)  saving,required TResult Function( DriveDone value)  done,required TResult Function( DriveError value)  error,}){
final _that = this;
switch (_that) {
case DriveIdle():
return idle(_that);case DriveAcquiringGps():
return acquiringGps(_that);case DriveAnalyzing():
return analyzing(_that);case DriveDriving():
return driving(_that);case DriveSaving():
return saving(_that);case DriveDone():
return done(_that);case DriveError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DriveIdle value)?  idle,TResult? Function( DriveAcquiringGps value)?  acquiringGps,TResult? Function( DriveAnalyzing value)?  analyzing,TResult? Function( DriveDriving value)?  driving,TResult? Function( DriveSaving value)?  saving,TResult? Function( DriveDone value)?  done,TResult? Function( DriveError value)?  error,}){
final _that = this;
switch (_that) {
case DriveIdle() when idle != null:
return idle(_that);case DriveAcquiringGps() when acquiringGps != null:
return acquiringGps(_that);case DriveAnalyzing() when analyzing != null:
return analyzing(_that);case DriveDriving() when driving != null:
return driving(_that);case DriveSaving() when saving != null:
return saving(_that);case DriveDone() when done != null:
return done(_that);case DriveError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  acquiringGps,TResult Function()?  analyzing,TResult Function( RouteAnalysis route,  DateTime startedAt,  DriveTick? tick)?  driving,TResult Function()?  saving,TResult Function( Journey journey)?  done,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DriveIdle() when idle != null:
return idle();case DriveAcquiringGps() when acquiringGps != null:
return acquiringGps();case DriveAnalyzing() when analyzing != null:
return analyzing();case DriveDriving() when driving != null:
return driving(_that.route,_that.startedAt,_that.tick);case DriveSaving() when saving != null:
return saving();case DriveDone() when done != null:
return done(_that.journey);case DriveError() when error != null:
return error(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  acquiringGps,required TResult Function()  analyzing,required TResult Function( RouteAnalysis route,  DateTime startedAt,  DriveTick? tick)  driving,required TResult Function()  saving,required TResult Function( Journey journey)  done,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case DriveIdle():
return idle();case DriveAcquiringGps():
return acquiringGps();case DriveAnalyzing():
return analyzing();case DriveDriving():
return driving(_that.route,_that.startedAt,_that.tick);case DriveSaving():
return saving();case DriveDone():
return done(_that.journey);case DriveError():
return error(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  acquiringGps,TResult? Function()?  analyzing,TResult? Function( RouteAnalysis route,  DateTime startedAt,  DriveTick? tick)?  driving,TResult? Function()?  saving,TResult? Function( Journey journey)?  done,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case DriveIdle() when idle != null:
return idle();case DriveAcquiringGps() when acquiringGps != null:
return acquiringGps();case DriveAnalyzing() when analyzing != null:
return analyzing();case DriveDriving() when driving != null:
return driving(_that.route,_that.startedAt,_that.tick);case DriveSaving() when saving != null:
return saving();case DriveDone() when done != null:
return done(_that.journey);case DriveError() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class DriveIdle implements DriveState {
  const DriveIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriveState.idle()';
}


}




/// @nodoc


class DriveAcquiringGps implements DriveState {
  const DriveAcquiringGps();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveAcquiringGps);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriveState.acquiringGps()';
}


}




/// @nodoc


class DriveAnalyzing implements DriveState {
  const DriveAnalyzing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveAnalyzing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriveState.analyzing()';
}


}




/// @nodoc


class DriveDriving implements DriveState {
  const DriveDriving({required this.route, required this.startedAt, this.tick});
  

 final  RouteAnalysis route;
 final  DateTime startedAt;
 final  DriveTick? tick;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveDrivingCopyWith<DriveDriving> get copyWith => _$DriveDrivingCopyWithImpl<DriveDriving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveDriving&&(identical(other.route, route) || other.route == route)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.tick, tick) || other.tick == tick));
}


@override
int get hashCode => Object.hash(runtimeType,route,startedAt,tick);

@override
String toString() {
  return 'DriveState.driving(route: $route, startedAt: $startedAt, tick: $tick)';
}


}

/// @nodoc
abstract mixin class $DriveDrivingCopyWith<$Res> implements $DriveStateCopyWith<$Res> {
  factory $DriveDrivingCopyWith(DriveDriving value, $Res Function(DriveDriving) _then) = _$DriveDrivingCopyWithImpl;
@useResult
$Res call({
 RouteAnalysis route, DateTime startedAt, DriveTick? tick
});


$RouteAnalysisCopyWith<$Res> get route;$DriveTickCopyWith<$Res>? get tick;

}
/// @nodoc
class _$DriveDrivingCopyWithImpl<$Res>
    implements $DriveDrivingCopyWith<$Res> {
  _$DriveDrivingCopyWithImpl(this._self, this._then);

  final DriveDriving _self;
  final $Res Function(DriveDriving) _then;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? route = null,Object? startedAt = null,Object? tick = freezed,}) {
  return _then(DriveDriving(
route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as RouteAnalysis,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,tick: freezed == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as DriveTick?,
  ));
}

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RouteAnalysisCopyWith<$Res> get route {
  
  return $RouteAnalysisCopyWith<$Res>(_self.route, (value) {
    return _then(_self.copyWith(route: value));
  });
}/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriveTickCopyWith<$Res>? get tick {
    if (_self.tick == null) {
    return null;
  }

  return $DriveTickCopyWith<$Res>(_self.tick!, (value) {
    return _then(_self.copyWith(tick: value));
  });
}
}

/// @nodoc


class DriveSaving implements DriveState {
  const DriveSaving();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveSaving);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriveState.saving()';
}


}




/// @nodoc


class DriveDone implements DriveState {
  const DriveDone({required this.journey});
  

 final  Journey journey;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveDoneCopyWith<DriveDone> get copyWith => _$DriveDoneCopyWithImpl<DriveDone>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveDone&&(identical(other.journey, journey) || other.journey == journey));
}


@override
int get hashCode => Object.hash(runtimeType,journey);

@override
String toString() {
  return 'DriveState.done(journey: $journey)';
}


}

/// @nodoc
abstract mixin class $DriveDoneCopyWith<$Res> implements $DriveStateCopyWith<$Res> {
  factory $DriveDoneCopyWith(DriveDone value, $Res Function(DriveDone) _then) = _$DriveDoneCopyWithImpl;
@useResult
$Res call({
 Journey journey
});


$JourneyCopyWith<$Res> get journey;

}
/// @nodoc
class _$DriveDoneCopyWithImpl<$Res>
    implements $DriveDoneCopyWith<$Res> {
  _$DriveDoneCopyWithImpl(this._self, this._then);

  final DriveDone _self;
  final $Res Function(DriveDone) _then;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? journey = null,}) {
  return _then(DriveDone(
journey: null == journey ? _self.journey : journey // ignore: cast_nullable_to_non_nullable
as Journey,
  ));
}

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JourneyCopyWith<$Res> get journey {
  
  return $JourneyCopyWith<$Res>(_self.journey, (value) {
    return _then(_self.copyWith(journey: value));
  });
}
}

/// @nodoc


class DriveError implements DriveState {
  const DriveError({required this.failure});
  

 final  Failure failure;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveErrorCopyWith<DriveError> get copyWith => _$DriveErrorCopyWithImpl<DriveError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'DriveState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $DriveErrorCopyWith<$Res> implements $DriveStateCopyWith<$Res> {
  factory $DriveErrorCopyWith(DriveError value, $Res Function(DriveError) _then) = _$DriveErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$DriveErrorCopyWithImpl<$Res>
    implements $DriveErrorCopyWith<$Res> {
  _$DriveErrorCopyWithImpl(this._self, this._then);

  final DriveError _self;
  final $Res Function(DriveError) _then;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(DriveError(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
