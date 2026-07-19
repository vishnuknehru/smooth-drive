// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoordinateDto {

 double get lat; double get lon;
/// Create a copy of CoordinateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoordinateDtoCopyWith<CoordinateDto> get copyWith => _$CoordinateDtoCopyWithImpl<CoordinateDto>(this as CoordinateDto, _$identity);

  /// Serializes this CoordinateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoordinateDto&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lon);

@override
String toString() {
  return 'CoordinateDto(lat: $lat, lon: $lon)';
}


}

/// @nodoc
abstract mixin class $CoordinateDtoCopyWith<$Res>  {
  factory $CoordinateDtoCopyWith(CoordinateDto value, $Res Function(CoordinateDto) _then) = _$CoordinateDtoCopyWithImpl;
@useResult
$Res call({
 double lat, double lon
});




}
/// @nodoc
class _$CoordinateDtoCopyWithImpl<$Res>
    implements $CoordinateDtoCopyWith<$Res> {
  _$CoordinateDtoCopyWithImpl(this._self, this._then);

  final CoordinateDto _self;
  final $Res Function(CoordinateDto) _then;

/// Create a copy of CoordinateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lon = null,}) {
  return _then(_self.copyWith(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CoordinateDto].
extension CoordinateDtoPatterns on CoordinateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoordinateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoordinateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoordinateDto value)  $default,){
final _that = this;
switch (_that) {
case _CoordinateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoordinateDto value)?  $default,){
final _that = this;
switch (_that) {
case _CoordinateDto() when $default != null:
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
case _CoordinateDto() when $default != null:
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
case _CoordinateDto():
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
case _CoordinateDto() when $default != null:
return $default(_that.lat,_that.lon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoordinateDto implements CoordinateDto {
  const _CoordinateDto({required this.lat, required this.lon});
  factory _CoordinateDto.fromJson(Map<String, dynamic> json) => _$CoordinateDtoFromJson(json);

@override final  double lat;
@override final  double lon;

/// Create a copy of CoordinateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoordinateDtoCopyWith<_CoordinateDto> get copyWith => __$CoordinateDtoCopyWithImpl<_CoordinateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoordinateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoordinateDto&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lon);

@override
String toString() {
  return 'CoordinateDto(lat: $lat, lon: $lon)';
}


}

/// @nodoc
abstract mixin class _$CoordinateDtoCopyWith<$Res> implements $CoordinateDtoCopyWith<$Res> {
  factory _$CoordinateDtoCopyWith(_CoordinateDto value, $Res Function(_CoordinateDto) _then) = __$CoordinateDtoCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lon
});




}
/// @nodoc
class __$CoordinateDtoCopyWithImpl<$Res>
    implements _$CoordinateDtoCopyWith<$Res> {
  __$CoordinateDtoCopyWithImpl(this._self, this._then);

  final _CoordinateDto _self;
  final $Res Function(_CoordinateDto) _then;

/// Create a copy of CoordinateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lon = null,}) {
  return _then(_CoordinateDto(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$EventDto {

@JsonKey(unknownEnumValue: EventTypeDto.unknown) EventTypeDto get type; double get distanceMeters; CoordinateDto get location; int? get valueMph;
/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDtoCopyWith<EventDto> get copyWith => _$EventDtoCopyWithImpl<EventDto>(this as EventDto, _$identity);

  /// Serializes this EventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDto&&(identical(other.type, type) || other.type == type)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.location, location) || other.location == location)&&(identical(other.valueMph, valueMph) || other.valueMph == valueMph));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,distanceMeters,location,valueMph);

@override
String toString() {
  return 'EventDto(type: $type, distanceMeters: $distanceMeters, location: $location, valueMph: $valueMph)';
}


}

/// @nodoc
abstract mixin class $EventDtoCopyWith<$Res>  {
  factory $EventDtoCopyWith(EventDto value, $Res Function(EventDto) _then) = _$EventDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: EventTypeDto.unknown) EventTypeDto type, double distanceMeters, CoordinateDto location, int? valueMph
});


$CoordinateDtoCopyWith<$Res> get location;

}
/// @nodoc
class _$EventDtoCopyWithImpl<$Res>
    implements $EventDtoCopyWith<$Res> {
  _$EventDtoCopyWithImpl(this._self, this._then);

  final EventDto _self;
  final $Res Function(EventDto) _then;

/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? distanceMeters = null,Object? location = null,Object? valueMph = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventTypeDto,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CoordinateDto,valueMph: freezed == valueMph ? _self.valueMph : valueMph // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinateDtoCopyWith<$Res> get location {
  
  return $CoordinateDtoCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventDto].
extension EventDtoPatterns on EventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDto value)  $default,){
final _that = this;
switch (_that) {
case _EventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: EventTypeDto.unknown)  EventTypeDto type,  double distanceMeters,  CoordinateDto location,  int? valueMph)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: EventTypeDto.unknown)  EventTypeDto type,  double distanceMeters,  CoordinateDto location,  int? valueMph)  $default,) {final _that = this;
switch (_that) {
case _EventDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: EventTypeDto.unknown)  EventTypeDto type,  double distanceMeters,  CoordinateDto location,  int? valueMph)?  $default,) {final _that = this;
switch (_that) {
case _EventDto() when $default != null:
return $default(_that.type,_that.distanceMeters,_that.location,_that.valueMph);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDto implements EventDto {
  const _EventDto({@JsonKey(unknownEnumValue: EventTypeDto.unknown) required this.type, required this.distanceMeters, required this.location, this.valueMph});
  factory _EventDto.fromJson(Map<String, dynamic> json) => _$EventDtoFromJson(json);

@override@JsonKey(unknownEnumValue: EventTypeDto.unknown) final  EventTypeDto type;
@override final  double distanceMeters;
@override final  CoordinateDto location;
@override final  int? valueMph;

/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDtoCopyWith<_EventDto> get copyWith => __$EventDtoCopyWithImpl<_EventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDto&&(identical(other.type, type) || other.type == type)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.location, location) || other.location == location)&&(identical(other.valueMph, valueMph) || other.valueMph == valueMph));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,distanceMeters,location,valueMph);

@override
String toString() {
  return 'EventDto(type: $type, distanceMeters: $distanceMeters, location: $location, valueMph: $valueMph)';
}


}

/// @nodoc
abstract mixin class _$EventDtoCopyWith<$Res> implements $EventDtoCopyWith<$Res> {
  factory _$EventDtoCopyWith(_EventDto value, $Res Function(_EventDto) _then) = __$EventDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: EventTypeDto.unknown) EventTypeDto type, double distanceMeters, CoordinateDto location, int? valueMph
});


@override $CoordinateDtoCopyWith<$Res> get location;

}
/// @nodoc
class __$EventDtoCopyWithImpl<$Res>
    implements _$EventDtoCopyWith<$Res> {
  __$EventDtoCopyWithImpl(this._self, this._then);

  final _EventDto _self;
  final $Res Function(_EventDto) _then;

/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? distanceMeters = null,Object? location = null,Object? valueMph = freezed,}) {
  return _then(_EventDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventTypeDto,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CoordinateDto,valueMph: freezed == valueMph ? _self.valueMph : valueMph // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinateDtoCopyWith<$Res> get location {
  
  return $CoordinateDtoCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$RouteAnalysisDto {

 String get routeId; double get distanceMeters; List<CoordinateDto> get geometry; List<EventDto> get events;
/// Create a copy of RouteAnalysisDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteAnalysisDtoCopyWith<RouteAnalysisDto> get copyWith => _$RouteAnalysisDtoCopyWithImpl<RouteAnalysisDto>(this as RouteAnalysisDto, _$identity);

  /// Serializes this RouteAnalysisDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteAnalysisDto&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&const DeepCollectionEquality().equals(other.geometry, geometry)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,routeId,distanceMeters,const DeepCollectionEquality().hash(geometry),const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'RouteAnalysisDto(routeId: $routeId, distanceMeters: $distanceMeters, geometry: $geometry, events: $events)';
}


}

/// @nodoc
abstract mixin class $RouteAnalysisDtoCopyWith<$Res>  {
  factory $RouteAnalysisDtoCopyWith(RouteAnalysisDto value, $Res Function(RouteAnalysisDto) _then) = _$RouteAnalysisDtoCopyWithImpl;
@useResult
$Res call({
 String routeId, double distanceMeters, List<CoordinateDto> geometry, List<EventDto> events
});




}
/// @nodoc
class _$RouteAnalysisDtoCopyWithImpl<$Res>
    implements $RouteAnalysisDtoCopyWith<$Res> {
  _$RouteAnalysisDtoCopyWithImpl(this._self, this._then);

  final RouteAnalysisDto _self;
  final $Res Function(RouteAnalysisDto) _then;

/// Create a copy of RouteAnalysisDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routeId = null,Object? distanceMeters = null,Object? geometry = null,Object? events = null,}) {
  return _then(_self.copyWith(
routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as List<CoordinateDto>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<EventDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [RouteAnalysisDto].
extension RouteAnalysisDtoPatterns on RouteAnalysisDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteAnalysisDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteAnalysisDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteAnalysisDto value)  $default,){
final _that = this;
switch (_that) {
case _RouteAnalysisDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteAnalysisDto value)?  $default,){
final _that = this;
switch (_that) {
case _RouteAnalysisDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String routeId,  double distanceMeters,  List<CoordinateDto> geometry,  List<EventDto> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteAnalysisDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String routeId,  double distanceMeters,  List<CoordinateDto> geometry,  List<EventDto> events)  $default,) {final _that = this;
switch (_that) {
case _RouteAnalysisDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String routeId,  double distanceMeters,  List<CoordinateDto> geometry,  List<EventDto> events)?  $default,) {final _that = this;
switch (_that) {
case _RouteAnalysisDto() when $default != null:
return $default(_that.routeId,_that.distanceMeters,_that.geometry,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RouteAnalysisDto implements RouteAnalysisDto {
  const _RouteAnalysisDto({required this.routeId, required this.distanceMeters, required final  List<CoordinateDto> geometry, required final  List<EventDto> events}): _geometry = geometry,_events = events;
  factory _RouteAnalysisDto.fromJson(Map<String, dynamic> json) => _$RouteAnalysisDtoFromJson(json);

@override final  String routeId;
@override final  double distanceMeters;
 final  List<CoordinateDto> _geometry;
@override List<CoordinateDto> get geometry {
  if (_geometry is EqualUnmodifiableListView) return _geometry;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_geometry);
}

 final  List<EventDto> _events;
@override List<EventDto> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of RouteAnalysisDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteAnalysisDtoCopyWith<_RouteAnalysisDto> get copyWith => __$RouteAnalysisDtoCopyWithImpl<_RouteAnalysisDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RouteAnalysisDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteAnalysisDto&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&const DeepCollectionEquality().equals(other._geometry, _geometry)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,routeId,distanceMeters,const DeepCollectionEquality().hash(_geometry),const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'RouteAnalysisDto(routeId: $routeId, distanceMeters: $distanceMeters, geometry: $geometry, events: $events)';
}


}

/// @nodoc
abstract mixin class _$RouteAnalysisDtoCopyWith<$Res> implements $RouteAnalysisDtoCopyWith<$Res> {
  factory _$RouteAnalysisDtoCopyWith(_RouteAnalysisDto value, $Res Function(_RouteAnalysisDto) _then) = __$RouteAnalysisDtoCopyWithImpl;
@override @useResult
$Res call({
 String routeId, double distanceMeters, List<CoordinateDto> geometry, List<EventDto> events
});




}
/// @nodoc
class __$RouteAnalysisDtoCopyWithImpl<$Res>
    implements _$RouteAnalysisDtoCopyWith<$Res> {
  __$RouteAnalysisDtoCopyWithImpl(this._self, this._then);

  final _RouteAnalysisDto _self;
  final $Res Function(_RouteAnalysisDto) _then;

/// Create a copy of RouteAnalysisDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routeId = null,Object? distanceMeters = null,Object? geometry = null,Object? events = null,}) {
  return _then(_RouteAnalysisDto(
routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,geometry: null == geometry ? _self._geometry : geometry // ignore: cast_nullable_to_non_nullable
as List<CoordinateDto>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<EventDto>,
  ));
}


}


/// @nodoc
mixin _$UpcomingEventDto {

@JsonKey(unknownEnumValue: EventTypeDto.unknown) EventTypeDto get type; double get distanceAheadMeters; CoordinateDto get location; int? get valueMph;
/// Create a copy of UpcomingEventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingEventDtoCopyWith<UpcomingEventDto> get copyWith => _$UpcomingEventDtoCopyWithImpl<UpcomingEventDto>(this as UpcomingEventDto, _$identity);

  /// Serializes this UpcomingEventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingEventDto&&(identical(other.type, type) || other.type == type)&&(identical(other.distanceAheadMeters, distanceAheadMeters) || other.distanceAheadMeters == distanceAheadMeters)&&(identical(other.location, location) || other.location == location)&&(identical(other.valueMph, valueMph) || other.valueMph == valueMph));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,distanceAheadMeters,location,valueMph);

@override
String toString() {
  return 'UpcomingEventDto(type: $type, distanceAheadMeters: $distanceAheadMeters, location: $location, valueMph: $valueMph)';
}


}

/// @nodoc
abstract mixin class $UpcomingEventDtoCopyWith<$Res>  {
  factory $UpcomingEventDtoCopyWith(UpcomingEventDto value, $Res Function(UpcomingEventDto) _then) = _$UpcomingEventDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: EventTypeDto.unknown) EventTypeDto type, double distanceAheadMeters, CoordinateDto location, int? valueMph
});


$CoordinateDtoCopyWith<$Res> get location;

}
/// @nodoc
class _$UpcomingEventDtoCopyWithImpl<$Res>
    implements $UpcomingEventDtoCopyWith<$Res> {
  _$UpcomingEventDtoCopyWithImpl(this._self, this._then);

  final UpcomingEventDto _self;
  final $Res Function(UpcomingEventDto) _then;

/// Create a copy of UpcomingEventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? distanceAheadMeters = null,Object? location = null,Object? valueMph = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventTypeDto,distanceAheadMeters: null == distanceAheadMeters ? _self.distanceAheadMeters : distanceAheadMeters // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CoordinateDto,valueMph: freezed == valueMph ? _self.valueMph : valueMph // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of UpcomingEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinateDtoCopyWith<$Res> get location {
  
  return $CoordinateDtoCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [UpcomingEventDto].
extension UpcomingEventDtoPatterns on UpcomingEventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpcomingEventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpcomingEventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpcomingEventDto value)  $default,){
final _that = this;
switch (_that) {
case _UpcomingEventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpcomingEventDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpcomingEventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: EventTypeDto.unknown)  EventTypeDto type,  double distanceAheadMeters,  CoordinateDto location,  int? valueMph)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingEventDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: EventTypeDto.unknown)  EventTypeDto type,  double distanceAheadMeters,  CoordinateDto location,  int? valueMph)  $default,) {final _that = this;
switch (_that) {
case _UpcomingEventDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: EventTypeDto.unknown)  EventTypeDto type,  double distanceAheadMeters,  CoordinateDto location,  int? valueMph)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingEventDto() when $default != null:
return $default(_that.type,_that.distanceAheadMeters,_that.location,_that.valueMph);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpcomingEventDto implements UpcomingEventDto {
  const _UpcomingEventDto({@JsonKey(unknownEnumValue: EventTypeDto.unknown) required this.type, required this.distanceAheadMeters, required this.location, this.valueMph});
  factory _UpcomingEventDto.fromJson(Map<String, dynamic> json) => _$UpcomingEventDtoFromJson(json);

@override@JsonKey(unknownEnumValue: EventTypeDto.unknown) final  EventTypeDto type;
@override final  double distanceAheadMeters;
@override final  CoordinateDto location;
@override final  int? valueMph;

/// Create a copy of UpcomingEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingEventDtoCopyWith<_UpcomingEventDto> get copyWith => __$UpcomingEventDtoCopyWithImpl<_UpcomingEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpcomingEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingEventDto&&(identical(other.type, type) || other.type == type)&&(identical(other.distanceAheadMeters, distanceAheadMeters) || other.distanceAheadMeters == distanceAheadMeters)&&(identical(other.location, location) || other.location == location)&&(identical(other.valueMph, valueMph) || other.valueMph == valueMph));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,distanceAheadMeters,location,valueMph);

@override
String toString() {
  return 'UpcomingEventDto(type: $type, distanceAheadMeters: $distanceAheadMeters, location: $location, valueMph: $valueMph)';
}


}

/// @nodoc
abstract mixin class _$UpcomingEventDtoCopyWith<$Res> implements $UpcomingEventDtoCopyWith<$Res> {
  factory _$UpcomingEventDtoCopyWith(_UpcomingEventDto value, $Res Function(_UpcomingEventDto) _then) = __$UpcomingEventDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: EventTypeDto.unknown) EventTypeDto type, double distanceAheadMeters, CoordinateDto location, int? valueMph
});


@override $CoordinateDtoCopyWith<$Res> get location;

}
/// @nodoc
class __$UpcomingEventDtoCopyWithImpl<$Res>
    implements _$UpcomingEventDtoCopyWith<$Res> {
  __$UpcomingEventDtoCopyWithImpl(this._self, this._then);

  final _UpcomingEventDto _self;
  final $Res Function(_UpcomingEventDto) _then;

/// Create a copy of UpcomingEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? distanceAheadMeters = null,Object? location = null,Object? valueMph = freezed,}) {
  return _then(_UpcomingEventDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventTypeDto,distanceAheadMeters: null == distanceAheadMeters ? _self.distanceAheadMeters : distanceAheadMeters // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CoordinateDto,valueMph: freezed == valueMph ? _self.valueMph : valueMph // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of UpcomingEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinateDtoCopyWith<$Res> get location {
  
  return $CoordinateDtoCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$AdviceDto {

@JsonKey(unknownEnumValue: AdviceActionDto.maintain) AdviceActionDto get action; double? get actInSeconds; int? get targetMph; UpcomingEventDto? get event; String get message;
/// Create a copy of AdviceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdviceDtoCopyWith<AdviceDto> get copyWith => _$AdviceDtoCopyWithImpl<AdviceDto>(this as AdviceDto, _$identity);

  /// Serializes this AdviceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdviceDto&&(identical(other.action, action) || other.action == action)&&(identical(other.actInSeconds, actInSeconds) || other.actInSeconds == actInSeconds)&&(identical(other.targetMph, targetMph) || other.targetMph == targetMph)&&(identical(other.event, event) || other.event == event)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,actInSeconds,targetMph,event,message);

@override
String toString() {
  return 'AdviceDto(action: $action, actInSeconds: $actInSeconds, targetMph: $targetMph, event: $event, message: $message)';
}


}

/// @nodoc
abstract mixin class $AdviceDtoCopyWith<$Res>  {
  factory $AdviceDtoCopyWith(AdviceDto value, $Res Function(AdviceDto) _then) = _$AdviceDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: AdviceActionDto.maintain) AdviceActionDto action, double? actInSeconds, int? targetMph, UpcomingEventDto? event, String message
});


$UpcomingEventDtoCopyWith<$Res>? get event;

}
/// @nodoc
class _$AdviceDtoCopyWithImpl<$Res>
    implements $AdviceDtoCopyWith<$Res> {
  _$AdviceDtoCopyWithImpl(this._self, this._then);

  final AdviceDto _self;
  final $Res Function(AdviceDto) _then;

/// Create a copy of AdviceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? actInSeconds = freezed,Object? targetMph = freezed,Object? event = freezed,Object? message = null,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AdviceActionDto,actInSeconds: freezed == actInSeconds ? _self.actInSeconds : actInSeconds // ignore: cast_nullable_to_non_nullable
as double?,targetMph: freezed == targetMph ? _self.targetMph : targetMph // ignore: cast_nullable_to_non_nullable
as int?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as UpcomingEventDto?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of AdviceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpcomingEventDtoCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $UpcomingEventDtoCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdviceDto].
extension AdviceDtoPatterns on AdviceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdviceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdviceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdviceDto value)  $default,){
final _that = this;
switch (_that) {
case _AdviceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdviceDto value)?  $default,){
final _that = this;
switch (_that) {
case _AdviceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: AdviceActionDto.maintain)  AdviceActionDto action,  double? actInSeconds,  int? targetMph,  UpcomingEventDto? event,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdviceDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: AdviceActionDto.maintain)  AdviceActionDto action,  double? actInSeconds,  int? targetMph,  UpcomingEventDto? event,  String message)  $default,) {final _that = this;
switch (_that) {
case _AdviceDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: AdviceActionDto.maintain)  AdviceActionDto action,  double? actInSeconds,  int? targetMph,  UpcomingEventDto? event,  String message)?  $default,) {final _that = this;
switch (_that) {
case _AdviceDto() when $default != null:
return $default(_that.action,_that.actInSeconds,_that.targetMph,_that.event,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdviceDto implements AdviceDto {
  const _AdviceDto({@JsonKey(unknownEnumValue: AdviceActionDto.maintain) required this.action, this.actInSeconds, this.targetMph, this.event, required this.message});
  factory _AdviceDto.fromJson(Map<String, dynamic> json) => _$AdviceDtoFromJson(json);

@override@JsonKey(unknownEnumValue: AdviceActionDto.maintain) final  AdviceActionDto action;
@override final  double? actInSeconds;
@override final  int? targetMph;
@override final  UpcomingEventDto? event;
@override final  String message;

/// Create a copy of AdviceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdviceDtoCopyWith<_AdviceDto> get copyWith => __$AdviceDtoCopyWithImpl<_AdviceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdviceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdviceDto&&(identical(other.action, action) || other.action == action)&&(identical(other.actInSeconds, actInSeconds) || other.actInSeconds == actInSeconds)&&(identical(other.targetMph, targetMph) || other.targetMph == targetMph)&&(identical(other.event, event) || other.event == event)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,actInSeconds,targetMph,event,message);

@override
String toString() {
  return 'AdviceDto(action: $action, actInSeconds: $actInSeconds, targetMph: $targetMph, event: $event, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AdviceDtoCopyWith<$Res> implements $AdviceDtoCopyWith<$Res> {
  factory _$AdviceDtoCopyWith(_AdviceDto value, $Res Function(_AdviceDto) _then) = __$AdviceDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: AdviceActionDto.maintain) AdviceActionDto action, double? actInSeconds, int? targetMph, UpcomingEventDto? event, String message
});


@override $UpcomingEventDtoCopyWith<$Res>? get event;

}
/// @nodoc
class __$AdviceDtoCopyWithImpl<$Res>
    implements _$AdviceDtoCopyWith<$Res> {
  __$AdviceDtoCopyWithImpl(this._self, this._then);

  final _AdviceDto _self;
  final $Res Function(_AdviceDto) _then;

/// Create a copy of AdviceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? actInSeconds = freezed,Object? targetMph = freezed,Object? event = freezed,Object? message = null,}) {
  return _then(_AdviceDto(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AdviceActionDto,actInSeconds: freezed == actInSeconds ? _self.actInSeconds : actInSeconds // ignore: cast_nullable_to_non_nullable
as double?,targetMph: freezed == targetMph ? _self.targetMph : targetMph // ignore: cast_nullable_to_non_nullable
as int?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as UpcomingEventDto?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of AdviceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpcomingEventDtoCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $UpcomingEventDtoCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// @nodoc
mixin _$UpcomingResponseDto {

 String get routeId; double get positionOnRouteMeters; bool get offRoute; List<UpcomingEventDto> get events; AdviceDto? get advice;
/// Create a copy of UpcomingResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingResponseDtoCopyWith<UpcomingResponseDto> get copyWith => _$UpcomingResponseDtoCopyWithImpl<UpcomingResponseDto>(this as UpcomingResponseDto, _$identity);

  /// Serializes this UpcomingResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingResponseDto&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.positionOnRouteMeters, positionOnRouteMeters) || other.positionOnRouteMeters == positionOnRouteMeters)&&(identical(other.offRoute, offRoute) || other.offRoute == offRoute)&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.advice, advice) || other.advice == advice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,routeId,positionOnRouteMeters,offRoute,const DeepCollectionEquality().hash(events),advice);

@override
String toString() {
  return 'UpcomingResponseDto(routeId: $routeId, positionOnRouteMeters: $positionOnRouteMeters, offRoute: $offRoute, events: $events, advice: $advice)';
}


}

/// @nodoc
abstract mixin class $UpcomingResponseDtoCopyWith<$Res>  {
  factory $UpcomingResponseDtoCopyWith(UpcomingResponseDto value, $Res Function(UpcomingResponseDto) _then) = _$UpcomingResponseDtoCopyWithImpl;
@useResult
$Res call({
 String routeId, double positionOnRouteMeters, bool offRoute, List<UpcomingEventDto> events, AdviceDto? advice
});


$AdviceDtoCopyWith<$Res>? get advice;

}
/// @nodoc
class _$UpcomingResponseDtoCopyWithImpl<$Res>
    implements $UpcomingResponseDtoCopyWith<$Res> {
  _$UpcomingResponseDtoCopyWithImpl(this._self, this._then);

  final UpcomingResponseDto _self;
  final $Res Function(UpcomingResponseDto) _then;

/// Create a copy of UpcomingResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routeId = null,Object? positionOnRouteMeters = null,Object? offRoute = null,Object? events = null,Object? advice = freezed,}) {
  return _then(_self.copyWith(
routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,positionOnRouteMeters: null == positionOnRouteMeters ? _self.positionOnRouteMeters : positionOnRouteMeters // ignore: cast_nullable_to_non_nullable
as double,offRoute: null == offRoute ? _self.offRoute : offRoute // ignore: cast_nullable_to_non_nullable
as bool,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<UpcomingEventDto>,advice: freezed == advice ? _self.advice : advice // ignore: cast_nullable_to_non_nullable
as AdviceDto?,
  ));
}
/// Create a copy of UpcomingResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdviceDtoCopyWith<$Res>? get advice {
    if (_self.advice == null) {
    return null;
  }

  return $AdviceDtoCopyWith<$Res>(_self.advice!, (value) {
    return _then(_self.copyWith(advice: value));
  });
}
}


/// Adds pattern-matching-related methods to [UpcomingResponseDto].
extension UpcomingResponseDtoPatterns on UpcomingResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpcomingResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpcomingResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpcomingResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _UpcomingResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpcomingResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpcomingResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String routeId,  double positionOnRouteMeters,  bool offRoute,  List<UpcomingEventDto> events,  AdviceDto? advice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingResponseDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String routeId,  double positionOnRouteMeters,  bool offRoute,  List<UpcomingEventDto> events,  AdviceDto? advice)  $default,) {final _that = this;
switch (_that) {
case _UpcomingResponseDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String routeId,  double positionOnRouteMeters,  bool offRoute,  List<UpcomingEventDto> events,  AdviceDto? advice)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingResponseDto() when $default != null:
return $default(_that.routeId,_that.positionOnRouteMeters,_that.offRoute,_that.events,_that.advice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpcomingResponseDto implements UpcomingResponseDto {
  const _UpcomingResponseDto({required this.routeId, required this.positionOnRouteMeters, required this.offRoute, required final  List<UpcomingEventDto> events, this.advice}): _events = events;
  factory _UpcomingResponseDto.fromJson(Map<String, dynamic> json) => _$UpcomingResponseDtoFromJson(json);

@override final  String routeId;
@override final  double positionOnRouteMeters;
@override final  bool offRoute;
 final  List<UpcomingEventDto> _events;
@override List<UpcomingEventDto> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override final  AdviceDto? advice;

/// Create a copy of UpcomingResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingResponseDtoCopyWith<_UpcomingResponseDto> get copyWith => __$UpcomingResponseDtoCopyWithImpl<_UpcomingResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpcomingResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingResponseDto&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.positionOnRouteMeters, positionOnRouteMeters) || other.positionOnRouteMeters == positionOnRouteMeters)&&(identical(other.offRoute, offRoute) || other.offRoute == offRoute)&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.advice, advice) || other.advice == advice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,routeId,positionOnRouteMeters,offRoute,const DeepCollectionEquality().hash(_events),advice);

@override
String toString() {
  return 'UpcomingResponseDto(routeId: $routeId, positionOnRouteMeters: $positionOnRouteMeters, offRoute: $offRoute, events: $events, advice: $advice)';
}


}

/// @nodoc
abstract mixin class _$UpcomingResponseDtoCopyWith<$Res> implements $UpcomingResponseDtoCopyWith<$Res> {
  factory _$UpcomingResponseDtoCopyWith(_UpcomingResponseDto value, $Res Function(_UpcomingResponseDto) _then) = __$UpcomingResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String routeId, double positionOnRouteMeters, bool offRoute, List<UpcomingEventDto> events, AdviceDto? advice
});


@override $AdviceDtoCopyWith<$Res>? get advice;

}
/// @nodoc
class __$UpcomingResponseDtoCopyWithImpl<$Res>
    implements _$UpcomingResponseDtoCopyWith<$Res> {
  __$UpcomingResponseDtoCopyWithImpl(this._self, this._then);

  final _UpcomingResponseDto _self;
  final $Res Function(_UpcomingResponseDto) _then;

/// Create a copy of UpcomingResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routeId = null,Object? positionOnRouteMeters = null,Object? offRoute = null,Object? events = null,Object? advice = freezed,}) {
  return _then(_UpcomingResponseDto(
routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,positionOnRouteMeters: null == positionOnRouteMeters ? _self.positionOnRouteMeters : positionOnRouteMeters // ignore: cast_nullable_to_non_nullable
as double,offRoute: null == offRoute ? _self.offRoute : offRoute // ignore: cast_nullable_to_non_nullable
as bool,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<UpcomingEventDto>,advice: freezed == advice ? _self.advice : advice // ignore: cast_nullable_to_non_nullable
as AdviceDto?,
  ));
}

/// Create a copy of UpcomingResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdviceDtoCopyWith<$Res>? get advice {
    if (_self.advice == null) {
    return null;
  }

  return $AdviceDtoCopyWith<$Res>(_self.advice!, (value) {
    return _then(_self.copyWith(advice: value));
  });
}
}

// dart format on
