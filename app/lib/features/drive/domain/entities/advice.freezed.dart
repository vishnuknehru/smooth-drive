// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Advice {

 AdviceAction get action;/// Seconds until the driver should start acting; null means act now
/// (or no action for [AdviceAction.maintain]).
 double? get actInSeconds;/// Target sign value; null for maintain.
 int? get targetMph;/// The event this advice addresses; null for maintain.
 UpcomingEvent? get event; String get message;
/// Create a copy of Advice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdviceCopyWith<Advice> get copyWith => _$AdviceCopyWithImpl<Advice>(this as Advice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Advice&&(identical(other.action, action) || other.action == action)&&(identical(other.actInSeconds, actInSeconds) || other.actInSeconds == actInSeconds)&&(identical(other.targetMph, targetMph) || other.targetMph == targetMph)&&(identical(other.event, event) || other.event == event)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,action,actInSeconds,targetMph,event,message);

@override
String toString() {
  return 'Advice(action: $action, actInSeconds: $actInSeconds, targetMph: $targetMph, event: $event, message: $message)';
}


}

/// @nodoc
abstract mixin class $AdviceCopyWith<$Res>  {
  factory $AdviceCopyWith(Advice value, $Res Function(Advice) _then) = _$AdviceCopyWithImpl;
@useResult
$Res call({
 AdviceAction action, double? actInSeconds, int? targetMph, UpcomingEvent? event, String message
});


$UpcomingEventCopyWith<$Res>? get event;

}
/// @nodoc
class _$AdviceCopyWithImpl<$Res>
    implements $AdviceCopyWith<$Res> {
  _$AdviceCopyWithImpl(this._self, this._then);

  final Advice _self;
  final $Res Function(Advice) _then;

/// Create a copy of Advice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? actInSeconds = freezed,Object? targetMph = freezed,Object? event = freezed,Object? message = null,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AdviceAction,actInSeconds: freezed == actInSeconds ? _self.actInSeconds : actInSeconds // ignore: cast_nullable_to_non_nullable
as double?,targetMph: freezed == targetMph ? _self.targetMph : targetMph // ignore: cast_nullable_to_non_nullable
as int?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as UpcomingEvent?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Advice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpcomingEventCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $UpcomingEventCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [Advice].
extension AdvicePatterns on Advice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Advice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Advice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Advice value)  $default,){
final _that = this;
switch (_that) {
case _Advice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Advice value)?  $default,){
final _that = this;
switch (_that) {
case _Advice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AdviceAction action,  double? actInSeconds,  int? targetMph,  UpcomingEvent? event,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Advice() when $default != null:
return $default(_that.action,_that.actInSeconds,_that.targetMph,_that.event,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AdviceAction action,  double? actInSeconds,  int? targetMph,  UpcomingEvent? event,  String message)  $default,) {final _that = this;
switch (_that) {
case _Advice():
return $default(_that.action,_that.actInSeconds,_that.targetMph,_that.event,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AdviceAction action,  double? actInSeconds,  int? targetMph,  UpcomingEvent? event,  String message)?  $default,) {final _that = this;
switch (_that) {
case _Advice() when $default != null:
return $default(_that.action,_that.actInSeconds,_that.targetMph,_that.event,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Advice implements Advice {
  const _Advice({required this.action, this.actInSeconds, this.targetMph, this.event, required this.message});
  

@override final  AdviceAction action;
/// Seconds until the driver should start acting; null means act now
/// (or no action for [AdviceAction.maintain]).
@override final  double? actInSeconds;
/// Target sign value; null for maintain.
@override final  int? targetMph;
/// The event this advice addresses; null for maintain.
@override final  UpcomingEvent? event;
@override final  String message;

/// Create a copy of Advice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdviceCopyWith<_Advice> get copyWith => __$AdviceCopyWithImpl<_Advice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Advice&&(identical(other.action, action) || other.action == action)&&(identical(other.actInSeconds, actInSeconds) || other.actInSeconds == actInSeconds)&&(identical(other.targetMph, targetMph) || other.targetMph == targetMph)&&(identical(other.event, event) || other.event == event)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,action,actInSeconds,targetMph,event,message);

@override
String toString() {
  return 'Advice(action: $action, actInSeconds: $actInSeconds, targetMph: $targetMph, event: $event, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AdviceCopyWith<$Res> implements $AdviceCopyWith<$Res> {
  factory _$AdviceCopyWith(_Advice value, $Res Function(_Advice) _then) = __$AdviceCopyWithImpl;
@override @useResult
$Res call({
 AdviceAction action, double? actInSeconds, int? targetMph, UpcomingEvent? event, String message
});


@override $UpcomingEventCopyWith<$Res>? get event;

}
/// @nodoc
class __$AdviceCopyWithImpl<$Res>
    implements _$AdviceCopyWith<$Res> {
  __$AdviceCopyWithImpl(this._self, this._then);

  final _Advice _self;
  final $Res Function(_Advice) _then;

/// Create a copy of Advice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? actInSeconds = freezed,Object? targetMph = freezed,Object? event = freezed,Object? message = null,}) {
  return _then(_Advice(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AdviceAction,actInSeconds: freezed == actInSeconds ? _self.actInSeconds : actInSeconds // ignore: cast_nullable_to_non_nullable
as double?,targetMph: freezed == targetMph ? _self.targetMph : targetMph // ignore: cast_nullable_to_non_nullable
as int?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as UpcomingEvent?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Advice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpcomingEventCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $UpcomingEventCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}

// dart format on
