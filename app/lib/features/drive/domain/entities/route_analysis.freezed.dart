// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_analysis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Coord {

 double get lat; double get lon;
/// Create a copy of Coord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoordCopyWith<Coord> get copyWith => _$CoordCopyWithImpl<Coord>(this as Coord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Coord&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon));
}


@override
int get hashCode => Object.hash(runtimeType,lat,lon);

@override
String toString() {
  return 'Coord(lat: $lat, lon: $lon)';
}


}

/// @nodoc
abstract mixin class $CoordCopyWith<$Res>  {
  factory $CoordCopyWith(Coord value, $Res Function(Coord) _then) = _$CoordCopyWithImpl;
@useResult
$Res call({
 double lat, double lon
});




}
/// @nodoc
class _$CoordCopyWithImpl<$Res>
    implements $CoordCopyWith<$Res> {
  _$CoordCopyWithImpl(this._self, this._then);

  final Coord _self;
  final $Res Function(Coord) _then;

/// Create a copy of Coord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lon = null,}) {
  return _then(_self.copyWith(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Coord].
extension CoordPatterns on Coord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Coord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Coord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Coord value)  $default,){
final _that = this;
switch (_that) {
case _Coord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Coord value)?  $default,){
final _that = this;
switch (_that) {
case _Coord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lat,  double lon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Coord() when $default != null:
return $default(_that.lat,_that.lon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lat,  double lon)  $default,) {final _that = this;
switch (_that) {
case _Coord():
return $default(_that.lat,_that.lon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lat,  double lon)?  $default,) {final _that = this;
switch (_that) {
case _Coord() when $default != null:
return $default(_that.lat,_that.lon);case _:
  return null;

}
}

}

/// @nodoc


class _Coord implements Coord {
  const _Coord({required this.lat, required this.lon});
  

@override final  double lat;
@override final  double lon;

/// Create a copy of Coord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoordCopyWith<_Coord> get copyWith => __$CoordCopyWithImpl<_Coord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Coord&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon));
}


@override
int get hashCode => Object.hash(runtimeType,lat,lon);

@override
String toString() {
  return 'Coord(lat: $lat, lon: $lon)';
}


}

/// @nodoc
abstract mixin class _$CoordCopyWith<$Res> implements $CoordCopyWith<$Res> {
  factory _$CoordCopyWith(_Coord value, $Res Function(_Coord) _then) = __$CoordCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lon
});




}
/// @nodoc
class __$CoordCopyWithImpl<$Res>
    implements _$CoordCopyWith<$Res> {
  __$CoordCopyWithImpl(this._self, this._then);

  final _Coord _self;
  final $Res Function(_Coord) _then;

/// Create a copy of Coord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lon = null,}) {
  return _then(_Coord(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$RouteEvent {

 EventType get type; double get distanceMeters; Coord get location;/// Legal sign value; only set for [EventType.speedLimit], and nullable
/// even then (unknown limits).
 int? get valueMph;
/// Create a copy of RouteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteEventCopyWith<RouteEvent> get copyWith => _$RouteEventCopyWithImpl<RouteEvent>(this as RouteEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.location, location) || other.location == location)&&(identical(other.valueMph, valueMph) || other.valueMph == valueMph));
}


@override
int get hashCode => Object.hash(runtimeType,type,distanceMeters,location,valueMph);

@override
String toString() {
  return 'RouteEvent(type: $type, distanceMeters: $distanceMeters, location: $location, valueMph: $valueMph)';
}


}

/// @nodoc
abstract mixin class $RouteEventCopyWith<$Res>  {
  factory $RouteEventCopyWith(RouteEvent value, $Res Function(RouteEvent) _then) = _$RouteEventCopyWithImpl;
@useResult
$Res call({
 EventType type, double distanceMeters, Coord location, int? valueMph
});


$CoordCopyWith<$Res> get location;

}
/// @nodoc
class _$RouteEventCopyWithImpl<$Res>
    implements $RouteEventCopyWith<$Res> {
  _$RouteEventCopyWithImpl(this._self, this._then);

  final RouteEvent _self;
  final $Res Function(RouteEvent) _then;

/// Create a copy of RouteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? distanceMeters = null,Object? location = null,Object? valueMph = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Coord,valueMph: freezed == valueMph ? _self.valueMph : valueMph // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of RouteEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get location {
  
  return $CoordCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [RouteEvent].
extension RouteEventPatterns on RouteEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteEvent value)  $default,){
final _that = this;
switch (_that) {
case _RouteEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteEvent value)?  $default,){
final _that = this;
switch (_that) {
case _RouteEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EventType type,  double distanceMeters,  Coord location,  int? valueMph)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteEvent() when $default != null:
return $default(_that.type,_that.distanceMeters,_that.location,_that.valueMph);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EventType type,  double distanceMeters,  Coord location,  int? valueMph)  $default,) {final _that = this;
switch (_that) {
case _RouteEvent():
return $default(_that.type,_that.distanceMeters,_that.location,_that.valueMph);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EventType type,  double distanceMeters,  Coord location,  int? valueMph)?  $default,) {final _that = this;
switch (_that) {
case _RouteEvent() when $default != null:
return $default(_that.type,_that.distanceMeters,_that.location,_that.valueMph);case _:
  return null;

}
}

}

/// @nodoc


class _RouteEvent implements RouteEvent {
  const _RouteEvent({required this.type, required this.distanceMeters, required this.location, this.valueMph});
  

@override final  EventType type;
@override final  double distanceMeters;
@override final  Coord location;
/// Legal sign value; only set for [EventType.speedLimit], and nullable
/// even then (unknown limits).
@override final  int? valueMph;

/// Create a copy of RouteEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteEventCopyWith<_RouteEvent> get copyWith => __$RouteEventCopyWithImpl<_RouteEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.location, location) || other.location == location)&&(identical(other.valueMph, valueMph) || other.valueMph == valueMph));
}


@override
int get hashCode => Object.hash(runtimeType,type,distanceMeters,location,valueMph);

@override
String toString() {
  return 'RouteEvent(type: $type, distanceMeters: $distanceMeters, location: $location, valueMph: $valueMph)';
}


}

/// @nodoc
abstract mixin class _$RouteEventCopyWith<$Res> implements $RouteEventCopyWith<$Res> {
  factory _$RouteEventCopyWith(_RouteEvent value, $Res Function(_RouteEvent) _then) = __$RouteEventCopyWithImpl;
@override @useResult
$Res call({
 EventType type, double distanceMeters, Coord location, int? valueMph
});


@override $CoordCopyWith<$Res> get location;

}
/// @nodoc
class __$RouteEventCopyWithImpl<$Res>
    implements _$RouteEventCopyWith<$Res> {
  __$RouteEventCopyWithImpl(this._self, this._then);

  final _RouteEvent _self;
  final $Res Function(_RouteEvent) _then;

/// Create a copy of RouteEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? distanceMeters = null,Object? location = null,Object? valueMph = freezed,}) {
  return _then(_RouteEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Coord,valueMph: freezed == valueMph ? _self.valueMph : valueMph // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of RouteEvent
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
mixin _$RouteAnalysis {

 String get routeId; double get distanceMeters; List<Coord> get geometry;/// Ordered by distance from route start.
 List<RouteEvent> get events;
/// Create a copy of RouteAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteAnalysisCopyWith<RouteAnalysis> get copyWith => _$RouteAnalysisCopyWithImpl<RouteAnalysis>(this as RouteAnalysis, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteAnalysis&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&const DeepCollectionEquality().equals(other.geometry, geometry)&&const DeepCollectionEquality().equals(other.events, events));
}


@override
int get hashCode => Object.hash(runtimeType,routeId,distanceMeters,const DeepCollectionEquality().hash(geometry),const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'RouteAnalysis(routeId: $routeId, distanceMeters: $distanceMeters, geometry: $geometry, events: $events)';
}


}

/// @nodoc
abstract mixin class $RouteAnalysisCopyWith<$Res>  {
  factory $RouteAnalysisCopyWith(RouteAnalysis value, $Res Function(RouteAnalysis) _then) = _$RouteAnalysisCopyWithImpl;
@useResult
$Res call({
 String routeId, double distanceMeters, List<Coord> geometry, List<RouteEvent> events
});




}
/// @nodoc
class _$RouteAnalysisCopyWithImpl<$Res>
    implements $RouteAnalysisCopyWith<$Res> {
  _$RouteAnalysisCopyWithImpl(this._self, this._then);

  final RouteAnalysis _self;
  final $Res Function(RouteAnalysis) _then;

/// Create a copy of RouteAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routeId = null,Object? distanceMeters = null,Object? geometry = null,Object? events = null,}) {
  return _then(_self.copyWith(
routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as List<Coord>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<RouteEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [RouteAnalysis].
extension RouteAnalysisPatterns on RouteAnalysis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteAnalysis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _RouteAnalysis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _RouteAnalysis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String routeId,  double distanceMeters,  List<Coord> geometry,  List<RouteEvent> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteAnalysis() when $default != null:
return $default(_that.routeId,_that.distanceMeters,_that.geometry,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String routeId,  double distanceMeters,  List<Coord> geometry,  List<RouteEvent> events)  $default,) {final _that = this;
switch (_that) {
case _RouteAnalysis():
return $default(_that.routeId,_that.distanceMeters,_that.geometry,_that.events);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String routeId,  double distanceMeters,  List<Coord> geometry,  List<RouteEvent> events)?  $default,) {final _that = this;
switch (_that) {
case _RouteAnalysis() when $default != null:
return $default(_that.routeId,_that.distanceMeters,_that.geometry,_that.events);case _:
  return null;

}
}

}

/// @nodoc


class _RouteAnalysis implements RouteAnalysis {
  const _RouteAnalysis({required this.routeId, required this.distanceMeters, required final  List<Coord> geometry, required final  List<RouteEvent> events}): _geometry = geometry,_events = events;
  

@override final  String routeId;
@override final  double distanceMeters;
 final  List<Coord> _geometry;
@override List<Coord> get geometry {
  if (_geometry is EqualUnmodifiableListView) return _geometry;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_geometry);
}

/// Ordered by distance from route start.
 final  List<RouteEvent> _events;
/// Ordered by distance from route start.
@override List<RouteEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of RouteAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteAnalysisCopyWith<_RouteAnalysis> get copyWith => __$RouteAnalysisCopyWithImpl<_RouteAnalysis>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteAnalysis&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&const DeepCollectionEquality().equals(other._geometry, _geometry)&&const DeepCollectionEquality().equals(other._events, _events));
}


@override
int get hashCode => Object.hash(runtimeType,routeId,distanceMeters,const DeepCollectionEquality().hash(_geometry),const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'RouteAnalysis(routeId: $routeId, distanceMeters: $distanceMeters, geometry: $geometry, events: $events)';
}


}

/// @nodoc
abstract mixin class _$RouteAnalysisCopyWith<$Res> implements $RouteAnalysisCopyWith<$Res> {
  factory _$RouteAnalysisCopyWith(_RouteAnalysis value, $Res Function(_RouteAnalysis) _then) = __$RouteAnalysisCopyWithImpl;
@override @useResult
$Res call({
 String routeId, double distanceMeters, List<Coord> geometry, List<RouteEvent> events
});




}
/// @nodoc
class __$RouteAnalysisCopyWithImpl<$Res>
    implements _$RouteAnalysisCopyWith<$Res> {
  __$RouteAnalysisCopyWithImpl(this._self, this._then);

  final _RouteAnalysis _self;
  final $Res Function(_RouteAnalysis) _then;

/// Create a copy of RouteAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routeId = null,Object? distanceMeters = null,Object? geometry = null,Object? events = null,}) {
  return _then(_RouteAnalysis(
routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,geometry: null == geometry ? _self._geometry : geometry // ignore: cast_nullable_to_non_nullable
as List<Coord>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<RouteEvent>,
  ));
}


}

// dart format on
