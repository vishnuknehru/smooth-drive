// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Settings {

 Units get units; bool get voiceEnabled; AppThemeMode get themeMode; double get alertDistanceMeters; String get baseUrl;
/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsCopyWith<Settings> get copyWith => _$SettingsCopyWithImpl<Settings>(this as Settings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Settings&&(identical(other.units, units) || other.units == units)&&(identical(other.voiceEnabled, voiceEnabled) || other.voiceEnabled == voiceEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.alertDistanceMeters, alertDistanceMeters) || other.alertDistanceMeters == alertDistanceMeters)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl));
}


@override
int get hashCode => Object.hash(runtimeType,units,voiceEnabled,themeMode,alertDistanceMeters,baseUrl);

@override
String toString() {
  return 'Settings(units: $units, voiceEnabled: $voiceEnabled, themeMode: $themeMode, alertDistanceMeters: $alertDistanceMeters, baseUrl: $baseUrl)';
}


}

/// @nodoc
abstract mixin class $SettingsCopyWith<$Res>  {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) _then) = _$SettingsCopyWithImpl;
@useResult
$Res call({
 Units units, bool voiceEnabled, AppThemeMode themeMode, double alertDistanceMeters, String baseUrl
});




}
/// @nodoc
class _$SettingsCopyWithImpl<$Res>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._self, this._then);

  final Settings _self;
  final $Res Function(Settings) _then;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? units = null,Object? voiceEnabled = null,Object? themeMode = null,Object? alertDistanceMeters = null,Object? baseUrl = null,}) {
  return _then(_self.copyWith(
units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as Units,voiceEnabled: null == voiceEnabled ? _self.voiceEnabled : voiceEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,alertDistanceMeters: null == alertDistanceMeters ? _self.alertDistanceMeters : alertDistanceMeters // ignore: cast_nullable_to_non_nullable
as double,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Settings].
extension SettingsPatterns on Settings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Settings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Settings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Settings value)  $default,){
final _that = this;
switch (_that) {
case _Settings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Settings value)?  $default,){
final _that = this;
switch (_that) {
case _Settings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Units units,  bool voiceEnabled,  AppThemeMode themeMode,  double alertDistanceMeters,  String baseUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that.units,_that.voiceEnabled,_that.themeMode,_that.alertDistanceMeters,_that.baseUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Units units,  bool voiceEnabled,  AppThemeMode themeMode,  double alertDistanceMeters,  String baseUrl)  $default,) {final _that = this;
switch (_that) {
case _Settings():
return $default(_that.units,_that.voiceEnabled,_that.themeMode,_that.alertDistanceMeters,_that.baseUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Units units,  bool voiceEnabled,  AppThemeMode themeMode,  double alertDistanceMeters,  String baseUrl)?  $default,) {final _that = this;
switch (_that) {
case _Settings() when $default != null:
return $default(_that.units,_that.voiceEnabled,_that.themeMode,_that.alertDistanceMeters,_that.baseUrl);case _:
  return null;

}
}

}

/// @nodoc


class _Settings implements Settings {
  const _Settings({this.units = Units.imperial, this.voiceEnabled = true, this.themeMode = AppThemeMode.system, this.alertDistanceMeters = AppConfig.defaultAlertDistanceMeters, this.baseUrl = AppConfig.defaultBaseUrl});
  

@override@JsonKey() final  Units units;
@override@JsonKey() final  bool voiceEnabled;
@override@JsonKey() final  AppThemeMode themeMode;
@override@JsonKey() final  double alertDistanceMeters;
@override@JsonKey() final  String baseUrl;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsCopyWith<_Settings> get copyWith => __$SettingsCopyWithImpl<_Settings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Settings&&(identical(other.units, units) || other.units == units)&&(identical(other.voiceEnabled, voiceEnabled) || other.voiceEnabled == voiceEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.alertDistanceMeters, alertDistanceMeters) || other.alertDistanceMeters == alertDistanceMeters)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl));
}


@override
int get hashCode => Object.hash(runtimeType,units,voiceEnabled,themeMode,alertDistanceMeters,baseUrl);

@override
String toString() {
  return 'Settings(units: $units, voiceEnabled: $voiceEnabled, themeMode: $themeMode, alertDistanceMeters: $alertDistanceMeters, baseUrl: $baseUrl)';
}


}

/// @nodoc
abstract mixin class _$SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$SettingsCopyWith(_Settings value, $Res Function(_Settings) _then) = __$SettingsCopyWithImpl;
@override @useResult
$Res call({
 Units units, bool voiceEnabled, AppThemeMode themeMode, double alertDistanceMeters, String baseUrl
});




}
/// @nodoc
class __$SettingsCopyWithImpl<$Res>
    implements _$SettingsCopyWith<$Res> {
  __$SettingsCopyWithImpl(this._self, this._then);

  final _Settings _self;
  final $Res Function(_Settings) _then;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? units = null,Object? voiceEnabled = null,Object? themeMode = null,Object? alertDistanceMeters = null,Object? baseUrl = null,}) {
  return _then(_Settings(
units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as Units,voiceEnabled: null == voiceEnabled ? _self.voiceEnabled : voiceEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,alertDistanceMeters: null == alertDistanceMeters ? _self.alertDistanceMeters : alertDistanceMeters // ignore: cast_nullable_to_non_nullable
as double,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
