import 'package:flutter/services.dart' show rootBundle;

import '../../../core/utils/geo.dart';
import '../domain/entities/geo_sample.dart';
import '../domain/entities/route_analysis.dart';
import '../domain/services/location_service.dart';

/// Dev-only: replays a bundled GPX track as if it were live GPS, so drives
/// can be exercised on the emulator deterministically — same workflow as
/// the backend's tools/gpx_replay.py.
class ReplayLocationService implements LocationService {
  ReplayLocationService({
    this.assetPath = 'assets/dev/sample_drive.gpx',
    this.speedup = 4.0,
  });

  final String assetPath;

  /// Wall-clock acceleration; 4x turns a 15-minute drive into ~4 minutes.
  final double speedup;

  List<GeoSample>? _cache;

  // Matches GPSLogger/OSMTracker output as well as our synthetic fixtures.
  static final _trkpt = RegExp(
    r'<trkpt\s+lat="([\d.-]+)"\s+lon="([\d.-]+)">.*?<time>([^<]+)</time>.*?</trkpt>',
    dotAll: true,
  );

  Future<List<GeoSample>> _samples() async {
    if (_cache case final cached?) return cached;
    final xml = await rootBundle.loadString(assetPath);
    final points = <(DateTime, Coord)>[
      for (final m in _trkpt.allMatches(xml))
        (
          DateTime.parse(m.group(3)!),
          Coord(lat: double.parse(m.group(1)!), lon: double.parse(m.group(2)!)),
        ),
    ];
    final samples = <GeoSample>[];
    for (var i = 0; i < points.length; i++) {
      var speed = 0.0;
      if (i > 0) {
        final (t1, p1) = points[i - 1];
        final (t2, p2) = points[i];
        final dt = t2.difference(t1).inMicroseconds / 1e6;
        if (dt > 0) {
          speed =
              haversineMeters(
                lat1: p1.lat,
                lon1: p1.lon,
                lat2: p2.lat,
                lon2: p2.lon,
              ) /
              dt;
        }
      }
      samples.add(
        GeoSample(
          time: points[i].$1,
          coord: points[i].$2,
          speedMps: speed,
          accuracyM: 5,
        ),
      );
    }
    return _cache = samples;
  }

  @override
  Future<LocationPermissionStatus> ensurePermission() async =>
      LocationPermissionStatus.granted;

  @override
  Future<GeoSample> currentPosition() async => (await _samples()).first;

  @override
  Stream<GeoSample> positionStream() async* {
    final samples = await _samples();
    for (var i = 0; i < samples.length; i++) {
      if (i > 0) {
        final gap = samples[i].time.difference(samples[i - 1].time);
        await Future<void>.delayed(
          Duration(microseconds: gap.inMicroseconds ~/ speedup),
        );
      }
      yield samples[i];
    }
  }
}
