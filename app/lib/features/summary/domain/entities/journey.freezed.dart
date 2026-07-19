// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HarshEvent {

 DateTime get time; Coord get location; double get fromMps; double get toMps; double get peakDecelMs2;
/// Create a copy of HarshEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HarshEventCopyWith<HarshEvent> get copyWith => _$HarshEventCopyWithImpl<HarshEvent>(this as HarshEvent, _$identity);

  /// Serializes this HarshEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HarshEvent&&(identical(other.time, time) || other.time == time)&&(identical(other.location, location) || other.location == location)&&(identical(other.fromMps, fromMps) || other.fromMps == fromMps)&&(identical(other.toMps, toMps) || other.toMps == toMps)&&(identical(other.peakDecelMs2, peakDecelMs2) || other.peakDecelMs2 == peakDecelMs2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,location,fromMps,toMps,peakDecelMs2);

@override
String toString() {
  return 'HarshEvent(time: $time, location: $location, fromMps: $fromMps, toMps: $toMps, peakDecelMs2: $peakDecelMs2)';
}


}

/// @nodoc
abstract mixin class $HarshEventCopyWith<$Res>  {
  factory $HarshEventCopyWith(HarshEvent value, $Res Function(HarshEvent) _then) = _$HarshEventCopyWithImpl;
@useResult
$Res call({
 DateTime time, Coord location, double fromMps, double toMps, double peakDecelMs2
});


$CoordCopyWith<$Res> get location;

}
/// @nodoc
class _$HarshEventCopyWithImpl<$Res>
    implements $HarshEventCopyWith<$Res> {
  _$HarshEventCopyWithImpl(this._self, this._then);

  final HarshEvent _self;
  final $Res Function(HarshEvent) _then;

/// Create a copy of HarshEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? location = null,Object? fromMps = null,Object? toMps = null,Object? peakDecelMs2 = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Coord,fromMps: null == fromMps ? _self.fromMps : fromMps // ignore: cast_nullable_to_non_nullable
as double,toMps: null == toMps ? _self.toMps : toMps // ignore: cast_nullable_to_non_nullable
as double,peakDecelMs2: null == peakDecelMs2 ? _self.peakDecelMs2 : peakDecelMs2 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of HarshEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get location {
  
  return $CoordCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [HarshEvent].
extension HarshEventPatterns on HarshEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HarshEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HarshEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HarshEvent value)  $default,){
final _that = this;
switch (_that) {
case _HarshEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HarshEvent value)?  $default,){
final _that = this;
switch (_that) {
case _HarshEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime time,  Coord location,  double fromMps,  double toMps,  double peakDecelMs2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HarshEvent() when $default != null:
return $default(_that.time,_that.location,_that.fromMps,_that.toMps,_that.peakDecelMs2);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime time,  Coord location,  double fromMps,  double toMps,  double peakDecelMs2)  $default,) {final _that = this;
switch (_that) {
case _HarshEvent():
return $default(_that.time,_that.location,_that.fromMps,_that.toMps,_that.peakDecelMs2);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime time,  Coord location,  double fromMps,  double toMps,  double peakDecelMs2)?  $default,) {final _that = this;
switch (_that) {
case _HarshEvent() when $default != null:
return $default(_that.time,_that.location,_that.fromMps,_that.toMps,_that.peakDecelMs2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HarshEvent implements HarshEvent {
  const _HarshEvent({required this.time, required this.location, required this.fromMps, required this.toMps, required this.peakDecelMs2});
  factory _HarshEvent.fromJson(Map<String, dynamic> json) => _$HarshEventFromJson(json);

@override final  DateTime time;
@override final  Coord location;
@override final  double fromMps;
@override final  double toMps;
@override final  double peakDecelMs2;

/// Create a copy of HarshEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HarshEventCopyWith<_HarshEvent> get copyWith => __$HarshEventCopyWithImpl<_HarshEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HarshEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HarshEvent&&(identical(other.time, time) || other.time == time)&&(identical(other.location, location) || other.location == location)&&(identical(other.fromMps, fromMps) || other.fromMps == fromMps)&&(identical(other.toMps, toMps) || other.toMps == toMps)&&(identical(other.peakDecelMs2, peakDecelMs2) || other.peakDecelMs2 == peakDecelMs2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,location,fromMps,toMps,peakDecelMs2);

@override
String toString() {
  return 'HarshEvent(time: $time, location: $location, fromMps: $fromMps, toMps: $toMps, peakDecelMs2: $peakDecelMs2)';
}


}

/// @nodoc
abstract mixin class _$HarshEventCopyWith<$Res> implements $HarshEventCopyWith<$Res> {
  factory _$HarshEventCopyWith(_HarshEvent value, $Res Function(_HarshEvent) _then) = __$HarshEventCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, Coord location, double fromMps, double toMps, double peakDecelMs2
});


@override $CoordCopyWith<$Res> get location;

}
/// @nodoc
class __$HarshEventCopyWithImpl<$Res>
    implements _$HarshEventCopyWith<$Res> {
  __$HarshEventCopyWithImpl(this._self, this._then);

  final _HarshEvent _self;
  final $Res Function(_HarshEvent) _then;

/// Create a copy of HarshEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? location = null,Object? fromMps = null,Object? toMps = null,Object? peakDecelMs2 = null,}) {
  return _then(_HarshEvent(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Coord,fromMps: null == fromMps ? _self.fromMps : fromMps // ignore: cast_nullable_to_non_nullable
as double,toMps: null == toMps ? _self.toMps : toMps // ignore: cast_nullable_to_non_nullable
as double,peakDecelMs2: null == peakDecelMs2 ? _self.peakDecelMs2 : peakDecelMs2 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of HarshEvent
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
mixin _$JourneySample {

 DateTime get time; Coord get coord; double get speedMps;/// Sign value in force at this point, when known.
 int? get limitMph;
/// Create a copy of JourneySample
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JourneySampleCopyWith<JourneySample> get copyWith => _$JourneySampleCopyWithImpl<JourneySample>(this as JourneySample, _$identity);

  /// Serializes this JourneySample to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneySample&&(identical(other.time, time) || other.time == time)&&(identical(other.coord, coord) || other.coord == coord)&&(identical(other.speedMps, speedMps) || other.speedMps == speedMps)&&(identical(other.limitMph, limitMph) || other.limitMph == limitMph));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,coord,speedMps,limitMph);

@override
String toString() {
  return 'JourneySample(time: $time, coord: $coord, speedMps: $speedMps, limitMph: $limitMph)';
}


}

/// @nodoc
abstract mixin class $JourneySampleCopyWith<$Res>  {
  factory $JourneySampleCopyWith(JourneySample value, $Res Function(JourneySample) _then) = _$JourneySampleCopyWithImpl;
@useResult
$Res call({
 DateTime time, Coord coord, double speedMps, int? limitMph
});


$CoordCopyWith<$Res> get coord;

}
/// @nodoc
class _$JourneySampleCopyWithImpl<$Res>
    implements $JourneySampleCopyWith<$Res> {
  _$JourneySampleCopyWithImpl(this._self, this._then);

  final JourneySample _self;
  final $Res Function(JourneySample) _then;

/// Create a copy of JourneySample
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? coord = null,Object? speedMps = null,Object? limitMph = freezed,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,coord: null == coord ? _self.coord : coord // ignore: cast_nullable_to_non_nullable
as Coord,speedMps: null == speedMps ? _self.speedMps : speedMps // ignore: cast_nullable_to_non_nullable
as double,limitMph: freezed == limitMph ? _self.limitMph : limitMph // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of JourneySample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get coord {
  
  return $CoordCopyWith<$Res>(_self.coord, (value) {
    return _then(_self.copyWith(coord: value));
  });
}
}


/// Adds pattern-matching-related methods to [JourneySample].
extension JourneySamplePatterns on JourneySample {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JourneySample value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JourneySample() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JourneySample value)  $default,){
final _that = this;
switch (_that) {
case _JourneySample():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JourneySample value)?  $default,){
final _that = this;
switch (_that) {
case _JourneySample() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime time,  Coord coord,  double speedMps,  int? limitMph)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JourneySample() when $default != null:
return $default(_that.time,_that.coord,_that.speedMps,_that.limitMph);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime time,  Coord coord,  double speedMps,  int? limitMph)  $default,) {final _that = this;
switch (_that) {
case _JourneySample():
return $default(_that.time,_that.coord,_that.speedMps,_that.limitMph);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime time,  Coord coord,  double speedMps,  int? limitMph)?  $default,) {final _that = this;
switch (_that) {
case _JourneySample() when $default != null:
return $default(_that.time,_that.coord,_that.speedMps,_that.limitMph);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JourneySample implements JourneySample {
  const _JourneySample({required this.time, required this.coord, required this.speedMps, this.limitMph});
  factory _JourneySample.fromJson(Map<String, dynamic> json) => _$JourneySampleFromJson(json);

@override final  DateTime time;
@override final  Coord coord;
@override final  double speedMps;
/// Sign value in force at this point, when known.
@override final  int? limitMph;

/// Create a copy of JourneySample
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JourneySampleCopyWith<_JourneySample> get copyWith => __$JourneySampleCopyWithImpl<_JourneySample>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JourneySampleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JourneySample&&(identical(other.time, time) || other.time == time)&&(identical(other.coord, coord) || other.coord == coord)&&(identical(other.speedMps, speedMps) || other.speedMps == speedMps)&&(identical(other.limitMph, limitMph) || other.limitMph == limitMph));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,coord,speedMps,limitMph);

@override
String toString() {
  return 'JourneySample(time: $time, coord: $coord, speedMps: $speedMps, limitMph: $limitMph)';
}


}

/// @nodoc
abstract mixin class _$JourneySampleCopyWith<$Res> implements $JourneySampleCopyWith<$Res> {
  factory _$JourneySampleCopyWith(_JourneySample value, $Res Function(_JourneySample) _then) = __$JourneySampleCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, Coord coord, double speedMps, int? limitMph
});


@override $CoordCopyWith<$Res> get coord;

}
/// @nodoc
class __$JourneySampleCopyWithImpl<$Res>
    implements _$JourneySampleCopyWith<$Res> {
  __$JourneySampleCopyWithImpl(this._self, this._then);

  final _JourneySample _self;
  final $Res Function(_JourneySample) _then;

/// Create a copy of JourneySample
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? coord = null,Object? speedMps = null,Object? limitMph = freezed,}) {
  return _then(_JourneySample(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,coord: null == coord ? _self.coord : coord // ignore: cast_nullable_to_non_nullable
as Coord,speedMps: null == speedMps ? _self.speedMps : speedMps // ignore: cast_nullable_to_non_nullable
as double,limitMph: freezed == limitMph ? _self.limitMph : limitMph // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of JourneySample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get coord {
  
  return $CoordCopyWith<$Res>(_self.coord, (value) {
    return _then(_self.copyWith(coord: value));
  });
}
}


/// @nodoc
mixin _$Journey {

 String get id; DateTime get startedAt; DateTime get endedAt; Coord get start; Coord get end; double get distanceMeters; double get durationSeconds; List<HarshEvent> get harshEvents; int get lateReactions;/// 0–100, matching the backend replay tool's scoring.
 int get score;/// Fraction of samples at or under the limit (+2 mph tolerance);
/// null when no limit was ever known.
 double? get speedComplianceRatio; List<JourneySample> get samples;
/// Create a copy of Journey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JourneyCopyWith<Journey> get copyWith => _$JourneyCopyWithImpl<Journey>(this as Journey, _$identity);

  /// Serializes this Journey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Journey&&(identical(other.id, id) || other.id == id)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&const DeepCollectionEquality().equals(other.harshEvents, harshEvents)&&(identical(other.lateReactions, lateReactions) || other.lateReactions == lateReactions)&&(identical(other.score, score) || other.score == score)&&(identical(other.speedComplianceRatio, speedComplianceRatio) || other.speedComplianceRatio == speedComplianceRatio)&&const DeepCollectionEquality().equals(other.samples, samples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startedAt,endedAt,start,end,distanceMeters,durationSeconds,const DeepCollectionEquality().hash(harshEvents),lateReactions,score,speedComplianceRatio,const DeepCollectionEquality().hash(samples));

@override
String toString() {
  return 'Journey(id: $id, startedAt: $startedAt, endedAt: $endedAt, start: $start, end: $end, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, harshEvents: $harshEvents, lateReactions: $lateReactions, score: $score, speedComplianceRatio: $speedComplianceRatio, samples: $samples)';
}


}

/// @nodoc
abstract mixin class $JourneyCopyWith<$Res>  {
  factory $JourneyCopyWith(Journey value, $Res Function(Journey) _then) = _$JourneyCopyWithImpl;
@useResult
$Res call({
 String id, DateTime startedAt, DateTime endedAt, Coord start, Coord end, double distanceMeters, double durationSeconds, List<HarshEvent> harshEvents, int lateReactions, int score, double? speedComplianceRatio, List<JourneySample> samples
});


$CoordCopyWith<$Res> get start;$CoordCopyWith<$Res> get end;

}
/// @nodoc
class _$JourneyCopyWithImpl<$Res>
    implements $JourneyCopyWith<$Res> {
  _$JourneyCopyWithImpl(this._self, this._then);

  final Journey _self;
  final $Res Function(Journey) _then;

/// Create a copy of Journey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startedAt = null,Object? endedAt = null,Object? start = null,Object? end = null,Object? distanceMeters = null,Object? durationSeconds = null,Object? harshEvents = null,Object? lateReactions = null,Object? score = null,Object? speedComplianceRatio = freezed,Object? samples = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: null == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Coord,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Coord,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double,harshEvents: null == harshEvents ? _self.harshEvents : harshEvents // ignore: cast_nullable_to_non_nullable
as List<HarshEvent>,lateReactions: null == lateReactions ? _self.lateReactions : lateReactions // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,speedComplianceRatio: freezed == speedComplianceRatio ? _self.speedComplianceRatio : speedComplianceRatio // ignore: cast_nullable_to_non_nullable
as double?,samples: null == samples ? _self.samples : samples // ignore: cast_nullable_to_non_nullable
as List<JourneySample>,
  ));
}
/// Create a copy of Journey
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get start {
  
  return $CoordCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of Journey
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get end {
  
  return $CoordCopyWith<$Res>(_self.end, (value) {
    return _then(_self.copyWith(end: value));
  });
}
}


/// Adds pattern-matching-related methods to [Journey].
extension JourneyPatterns on Journey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Journey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Journey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Journey value)  $default,){
final _that = this;
switch (_that) {
case _Journey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Journey value)?  $default,){
final _that = this;
switch (_that) {
case _Journey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime startedAt,  DateTime endedAt,  Coord start,  Coord end,  double distanceMeters,  double durationSeconds,  List<HarshEvent> harshEvents,  int lateReactions,  int score,  double? speedComplianceRatio,  List<JourneySample> samples)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Journey() when $default != null:
return $default(_that.id,_that.startedAt,_that.endedAt,_that.start,_that.end,_that.distanceMeters,_that.durationSeconds,_that.harshEvents,_that.lateReactions,_that.score,_that.speedComplianceRatio,_that.samples);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime startedAt,  DateTime endedAt,  Coord start,  Coord end,  double distanceMeters,  double durationSeconds,  List<HarshEvent> harshEvents,  int lateReactions,  int score,  double? speedComplianceRatio,  List<JourneySample> samples)  $default,) {final _that = this;
switch (_that) {
case _Journey():
return $default(_that.id,_that.startedAt,_that.endedAt,_that.start,_that.end,_that.distanceMeters,_that.durationSeconds,_that.harshEvents,_that.lateReactions,_that.score,_that.speedComplianceRatio,_that.samples);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime startedAt,  DateTime endedAt,  Coord start,  Coord end,  double distanceMeters,  double durationSeconds,  List<HarshEvent> harshEvents,  int lateReactions,  int score,  double? speedComplianceRatio,  List<JourneySample> samples)?  $default,) {final _that = this;
switch (_that) {
case _Journey() when $default != null:
return $default(_that.id,_that.startedAt,_that.endedAt,_that.start,_that.end,_that.distanceMeters,_that.durationSeconds,_that.harshEvents,_that.lateReactions,_that.score,_that.speedComplianceRatio,_that.samples);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Journey implements Journey {
  const _Journey({required this.id, required this.startedAt, required this.endedAt, required this.start, required this.end, required this.distanceMeters, required this.durationSeconds, required final  List<HarshEvent> harshEvents, required this.lateReactions, required this.score, this.speedComplianceRatio, required final  List<JourneySample> samples}): _harshEvents = harshEvents,_samples = samples;
  factory _Journey.fromJson(Map<String, dynamic> json) => _$JourneyFromJson(json);

@override final  String id;
@override final  DateTime startedAt;
@override final  DateTime endedAt;
@override final  Coord start;
@override final  Coord end;
@override final  double distanceMeters;
@override final  double durationSeconds;
 final  List<HarshEvent> _harshEvents;
@override List<HarshEvent> get harshEvents {
  if (_harshEvents is EqualUnmodifiableListView) return _harshEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_harshEvents);
}

@override final  int lateReactions;
/// 0–100, matching the backend replay tool's scoring.
@override final  int score;
/// Fraction of samples at or under the limit (+2 mph tolerance);
/// null when no limit was ever known.
@override final  double? speedComplianceRatio;
 final  List<JourneySample> _samples;
@override List<JourneySample> get samples {
  if (_samples is EqualUnmodifiableListView) return _samples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_samples);
}


/// Create a copy of Journey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JourneyCopyWith<_Journey> get copyWith => __$JourneyCopyWithImpl<_Journey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JourneyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Journey&&(identical(other.id, id) || other.id == id)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&const DeepCollectionEquality().equals(other._harshEvents, _harshEvents)&&(identical(other.lateReactions, lateReactions) || other.lateReactions == lateReactions)&&(identical(other.score, score) || other.score == score)&&(identical(other.speedComplianceRatio, speedComplianceRatio) || other.speedComplianceRatio == speedComplianceRatio)&&const DeepCollectionEquality().equals(other._samples, _samples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startedAt,endedAt,start,end,distanceMeters,durationSeconds,const DeepCollectionEquality().hash(_harshEvents),lateReactions,score,speedComplianceRatio,const DeepCollectionEquality().hash(_samples));

@override
String toString() {
  return 'Journey(id: $id, startedAt: $startedAt, endedAt: $endedAt, start: $start, end: $end, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, harshEvents: $harshEvents, lateReactions: $lateReactions, score: $score, speedComplianceRatio: $speedComplianceRatio, samples: $samples)';
}


}

/// @nodoc
abstract mixin class _$JourneyCopyWith<$Res> implements $JourneyCopyWith<$Res> {
  factory _$JourneyCopyWith(_Journey value, $Res Function(_Journey) _then) = __$JourneyCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime startedAt, DateTime endedAt, Coord start, Coord end, double distanceMeters, double durationSeconds, List<HarshEvent> harshEvents, int lateReactions, int score, double? speedComplianceRatio, List<JourneySample> samples
});


@override $CoordCopyWith<$Res> get start;@override $CoordCopyWith<$Res> get end;

}
/// @nodoc
class __$JourneyCopyWithImpl<$Res>
    implements _$JourneyCopyWith<$Res> {
  __$JourneyCopyWithImpl(this._self, this._then);

  final _Journey _self;
  final $Res Function(_Journey) _then;

/// Create a copy of Journey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startedAt = null,Object? endedAt = null,Object? start = null,Object? end = null,Object? distanceMeters = null,Object? durationSeconds = null,Object? harshEvents = null,Object? lateReactions = null,Object? score = null,Object? speedComplianceRatio = freezed,Object? samples = null,}) {
  return _then(_Journey(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: null == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Coord,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Coord,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double,harshEvents: null == harshEvents ? _self._harshEvents : harshEvents // ignore: cast_nullable_to_non_nullable
as List<HarshEvent>,lateReactions: null == lateReactions ? _self.lateReactions : lateReactions // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,speedComplianceRatio: freezed == speedComplianceRatio ? _self.speedComplianceRatio : speedComplianceRatio // ignore: cast_nullable_to_non_nullable
as double?,samples: null == samples ? _self._samples : samples // ignore: cast_nullable_to_non_nullable
as List<JourneySample>,
  ));
}

/// Create a copy of Journey
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get start {
  
  return $CoordCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of Journey
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordCopyWith<$Res> get end {
  
  return $CoordCopyWith<$Res>(_self.end, (value) {
    return _then(_self.copyWith(end: value));
  });
}
}

// dart format on
