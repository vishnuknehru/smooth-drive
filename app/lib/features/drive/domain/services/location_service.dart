import '../entities/geo_sample.dart';

enum LocationPermissionStatus {
  granted,
  denied,
  deniedForever,
  serviceDisabled,
}

abstract interface class LocationService {
  /// Runs the platform permission flow if needed.
  Future<LocationPermissionStatus> ensurePermission();

  Future<GeoSample> currentPosition();

  /// High-accuracy fixes at ~1 Hz while the drive screen is open.
  Stream<GeoSample> positionStream();
}
