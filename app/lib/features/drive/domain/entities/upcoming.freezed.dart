// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upcoming.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpcomingEvent {

 EventType get type; double get distanceAheadMeters; Coord get location; int? get valueMph;
/// Create a copy of UpcomingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingEventCopyWith<UpcomingEvent> get copyWith => _$UpcomingEventCopyWithImpl<UpcomingEvent>(this as UpcomingEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.distanceAheadMeters, distanceAheadMeters) || other.distanceAheadMeters == distanceAheadMeters)&&(identical(other.location, location) || other.location == location)&&(identical(other.valueMph, valueMph) || other.valueMph == valueMph));
}


@override
int get hashCode => Object.hash(runtimeType,type,distanceAheadMeters,location,valueMph);

@override
String toString() {
  return 'UpcomingEvent(type: $type, distanceAheadMeters: $distanceAheadMeters, location: $location, valueMph: $valueMph)';
}


}

/// @nodoc
abstract mixin class $UpcomingEventCopyWith<$Res>  {
  factory $UpcomingEventCopyWith(UpcomingEvent value, $Res Function(UpcomingEvent) _then) = _$UpcomingEventCopyWithImpl;
@useResult
$Res call({
 EventType type, double distanceAheadMeters, Coord location, int? valueMph
});


$CoordCopyWith<$Res> get location;

}
/// @nodoc
class _$UpcomingEventCopyWithImpl<$Res>
    implements $UpcomingEventCopyWith<$Res> {
  _$UpcomingEventCopyWithImpl(this._self, this._then);

  final UpcomingEvent _self;
  final $Res Function(UpcomingEvent) _then;

/// Create a copy of UpcomingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? distanceAheadMeters = null,Object? location = null,Object? valueMph = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,distanceAheadMeters: null == distanceAheadMeters ? _self.distanceAheadMeters : distanceAheadMeters // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Coord,valueMph: freezed == valueMph ? _self.valueMph : valueMph // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of UpcomingEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get location {
  
  return $CoordCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EventType type,  double distanceAheadMeters,  Coord location,  int? valueMph)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingEvent() when $default != null:
return $default(_that.type,_that.distanceAheadMeters,_that.location,_that.valueMph);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EventType type,  double distanceAheadMeters,  Coord location,  int? valueMph)  $default,) {final _that = this;
switch (_that) {
case _UpcomingEvent():
return $default(_that.type,_that.distanceAheadMeters,_that.location,_that.valueMph);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EventType type,  double distanceAheadMeters,  Coord location,  int? valueMph)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingEvent() when $default != null:
return $default(_that.type,_that.distanceAheadMeters,_that.location,_that.valueMph);case _:
  return null;

}
}

}

/// @nodoc


class _UpcomingEvent implements UpcomingEvent {
  const _UpcomingEvent({required this.type, required this.distanceAheadMeters, required this.location, this.valueMph});
  

@override final  EventType type;
@override final  double distanceAheadMeters;
@override final  Coord location;
@override final  int? valueMph;

/// Create a copy of UpcomingEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingEventCopyWith<_UpcomingEvent> get copyWith => __$UpcomingEventCopyWithImpl<_UpcomingEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.distanceAheadMeters, distanceAheadMeters) || other.distanceAheadMeters == distanceAheadMeters)&&(identical(other.location, location) || other.location == location)&&(identical(other.valueMph, valueMph) || other.valueMph == valueMph));
}


@override
int get hashCode => Object.hash(runtimeType,type,distanceAheadMeters,location,valueMph);

@override
String toString() {
  return 'UpcomingEvent(type: $type, distanceAheadMeters: $distanceAheadMeters, location: $location, valueMph: $valueMph)';
}


}

/// @nodoc
abstract mixin class _$UpcomingEventCopyWith<$Res> implements $UpcomingEventCopyWith<$Res> {
  factory _$UpcomingEventCopyWith(_UpcomingEvent value, $Res Function(_UpcomingEvent) _then) = __$UpcomingEventCopyWithImpl;
@override @useResult
$Res call({
 EventType type, double distanceAheadMeters, Coord location, int? valueMph
});


@override $CoordCopyWith<$Res> get location;

}
/// @nodoc
class __$UpcomingEventCopyWithImpl<$Res>
    implements _$UpcomingEventCopyWith<$Res> {
  __$UpcomingEventCopyWithImpl(this._self, this._then);

  final _UpcomingEvent _self;
  final $Res Function(_UpcomingEvent) _then;

/// Create a copy of UpcomingEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? distanceAheadMeters = null,Object? location = null,Object? valueMph = freezed,}) {
  return _then(_UpcomingEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,distanceAheadMeters: null == distanceAheadMeters ? _self.distanceAheadMeters : distanceAheadMeters // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Coord,valueMph: freezed == valueMph ? _self.valueMph : valueMph // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of UpcomingEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get location {
  
  return $CoordCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

/// @nodoc
mixin _$PositionUpdate {

 String get routeId; double get positionOnRouteMeters; bool get offRoute;/// Events ahead of the current position, sorted by distance.
 List<UpcomingEvent> get events;/// Present only when the request included a speed.
 Advice? get advice;
/// Create a copy of PositionUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PositionUpdateCopyWith<PositionUpdate> get copyWith => _$PositionUpdateCopyWithImpl<PositionUpdate>(this as PositionUpdate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PositionUpdate&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.positionOnRouteMeters, positionOnRouteMeters) || other.positionOnRouteMeters == positionOnRouteMeters)&&(identical(other.offRoute, offRoute) || other.offRoute == offRoute)&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.advice, advice) || other.advice == advice));
}


@override
int get hashCode => Object.hash(runtimeType,routeId,positionOnRouteMeters,offRoute,const DeepCollectionEquality().hash(events),advice);

@override
String toString() {
  return 'PositionUpdate(routeId: $routeId, positionOnRouteMeters: $positionOnRouteMeters, offRoute: $offRoute, events: $events, advice: $advice)';
}


}

/// @nodoc
abstract mixin class $PositionUpdateCopyWith<$Res>  {
  factory $PositionUpdateCopyWith(PositionUpdate value, $Res Function(PositionUpdate) _then) = _$PositionUpdateCopyWithImpl;
@useResult
$Res call({
 String routeId, double positionOnRouteMeters, bool offRoute, List<UpcomingEvent> events, Advice? advice
});


$AdviceCopyWith<$Res>? get advice;

}
/// @nodoc
class _$PositionUpdateCopyWithImpl<$Res>
    implements $PositionUpdateCopyWith<$Res> {
  _$PositionUpdateCopyWithImpl(this._self, this._then);

  final PositionUpdate _self;
  final $Res Function(PositionUpdate) _then;

/// Create a copy of PositionUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routeId = null,Object? positionOnRouteMeters = null,Object? offRoute = null,Object? events = null,Object? advice = freezed,}) {
  return _then(_self.copyWith(
routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,positionOnRouteMeters: null == positionOnRouteMeters ? _self.positionOnRouteMeters : positionOnRouteMeters // ignore: cast_nullable_to_non_nullable
as double,offRoute: null == offRoute ? _self.offRoute : offRoute // ignore: cast_nullable_to_non_nullable
as bool,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<UpcomingEvent>,advice: freezed == advice ? _self.advice : advice // ignore: cast_nullable_to_non_nullable
as Advice?,
  ));
}
/// Create a copy of PositionUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdviceCopyWith<$Res>? get advice {
    if (_self.advice == null) {
    return null;
  }

  return $AdviceCopyWith<$Res>(_self.advice!, (value) {
    return _then(_self.copyWith(advice: value));
  });
}
}


/// Adds pattern-matching-related methods to [PositionUpdate].
extension PositionUpdatePatterns on PositionUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PositionUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PositionUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PositionUpdate value)  $default,){
final _that = this;
switch (_that) {
case _PositionUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PositionUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _PositionUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String routeId,  double positionOnRouteMeters,  bool offRoute,  List<UpcomingEvent> events,  Advice? advice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PositionUpdate() when $default != null:
return $default(_that.routeId,_that.positionOnRouteMeters,_that.offRoute,_that.events,_that.advice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String routeId,  double positionOnRouteMeters,  bool offRoute,  List<UpcomingEvent> events,  Advice? advice)  $default,) {final _that = this;
switch (_that) {
case _PositionUpdate():
return $default(_that.routeId,_that.positionOnRouteMeters,_that.offRoute,_that.events,_that.advice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String routeId,  double positionOnRouteMeters,  bool offRoute,  List<UpcomingEvent> events,  Advice? advice)?  $default,) {final _that = this;
switch (_that) {
case _PositionUpdate() when $default != null:
return $default(_that.routeId,_that.positionOnRouteMeters,_that.offRoute,_that.events,_that.advice);case _:
  return null;

}
}

}

/// @nodoc


class _PositionUpdate implements PositionUpdate {
  const _PositionUpdate({required this.routeId, required this.positionOnRouteMeters, required this.offRoute, required final  List<UpcomingEvent> events, this.advice}): _events = events;
  

@override final  String routeId;
@override final  double positionOnRouteMeters;
@override final  bool offRoute;
/// Events ahead of the current position, sorted by distance.
 final  List<UpcomingEvent> _events;
/// Events ahead of the current position, sorted by distance.
@override List<UpcomingEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

/// Present only when the request included a speed.
@override final  Advice? advice;

/// Create a copy of PositionUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PositionUpdateCopyWith<_PositionUpdate> get copyWith => __$PositionUpdateCopyWithImpl<_PositionUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PositionUpdate&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.positionOnRouteMeters, positionOnRouteMeters) || other.positionOnRouteMeters == positionOnRouteMeters)&&(identical(other.offRoute, offRoute) || other.offRoute == offRoute)&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.advice, advice) || other.advice == advice));
}


@override
int get hashCode => Object.hash(runtimeType,routeId,positionOnRouteMeters,offRoute,const DeepCollectionEquality().hash(_events),advice);

@override
String toString() {
  return 'PositionUpdate(routeId: $routeId, positionOnRouteMeters: $positionOnRouteMeters, offRoute: $offRoute, events: $events, advice: $advice)';
}


}

/// @nodoc
abstract mixin class _$PositionUpdateCopyWith<$Res> implements $PositionUpdateCopyWith<$Res> {
  factory _$PositionUpdateCopyWith(_PositionUpdate value, $Res Function(_PositionUpdate) _then) = __$PositionUpdateCopyWithImpl;
@override @useResult
$Res call({
 String routeId, double positionOnRouteMeters, bool offRoute, List<UpcomingEvent> events, Advice? advice
});


@override $AdviceCopyWith<$Res>? get advice;

}
/// @nodoc
class __$PositionUpdateCopyWithImpl<$Res>
    implements _$PositionUpdateCopyWith<$Res> {
  __$PositionUpdateCopyWithImpl(this._self, this._then);

  final _PositionUpdate _self;
  final $Res Function(_PositionUpdate) _then;

/// Create a copy of PositionUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routeId = null,Object? positionOnRouteMeters = null,Object? offRoute = null,Object? events = null,Object? advice = freezed,}) {
  return _then(_PositionUpdate(
routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,positionOnRouteMeters: null == positionOnRouteMeters ? _self.positionOnRouteMeters : positionOnRouteMeters // ignore: cast_nullable_to_non_nullable
as double,offRoute: null == offRoute ? _self.offRoute : offRoute // ignore: cast_nullable_to_non_nullable
as bool,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<UpcomingEvent>,advice: freezed == advice ? _self.advice : advice // ignore: cast_nullable_to_non_nullable
as Advice?,
  ));
}

/// Create a copy of PositionUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdviceCopyWith<$Res>? get advice {
    if (_self.advice == null) {
    return null;
  }

  return $AdviceCopyWith<$Res>(_self.advice!, (value) {
    return _then(_self.copyWith(advice: value));
  });
}
}

// dart format on
