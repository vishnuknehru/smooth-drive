import 'package:freezed_annotation/freezed_annotation.dart';

import 'route_analysis.dart';

part 'geo_sample.freezed.dart';

/// One GPS reading during a drive.
@freezed
abstract class GeoSample with _$GeoSample {
  const factory GeoSample({
    required DateTime time,
    required Coord coord,

    /// Device-reported speed, m/s; 0 when the fix has no usable speed.
    required double speedMps,
    required double accuracyM,
  }) = _GeoSample;
}
