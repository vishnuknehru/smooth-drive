import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/entities/geo_sample.dart';
import '../domain/entities/route_analysis.dart';
import '../domain/services/location_service.dart';

part 'geolocator_location_service.g.dart';

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) => GeolocatorLocationService();

/// Thin adapter over geolocator; excluded from coverage, its contract is
/// exercised through fakes everywhere else.
class GeolocatorLocationService implements LocationService {
  @override
  Future<LocationPermissionStatus> ensurePermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return LocationPermissionStatus.serviceDisabled;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return switch (permission) {
      LocationPermission.always ||
      LocationPermission.whileInUse => LocationPermissionStatus.granted,
      LocationPermission.deniedForever =>
        LocationPermissionStatus.deniedForever,
      _ => LocationPermissionStatus.denied,
    };
  }

  @override
  Future<GeoSample> currentPosition() async =>
      _toSample(await Geolocator.getCurrentPosition());

  @override
  Stream<GeoSample> positionStream() {
    final settings = Platform.isAndroid
        ? AndroidSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            intervalDuration: const Duration(seconds: 1),
            distanceFilter: 0,
          )
        : const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 0,
          );
    return Geolocator.getPositionStream(
      locationSettings: settings,
    ).map(_toSample);
  }

  GeoSample _toSample(Position position) => GeoSample(
    time: position.timestamp,
    coord: Coord(lat: position.latitude, lon: position.longitude),
    speedMps: position.speed.isFinite && position.speed >= 0
        ? position.speed
        : 0,
    accuracyM: position.accuracy,
  );
}
