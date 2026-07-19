import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:smoothdrive/core/utils/units.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/summary/domain/smoothness_analyzer.dart';

/// Parity check against backend services/smoothness.py: expectations were
/// produced by running build_report on this exact GPX file (see Sprint 9).
/// If this test fails after touching the analyzer, the two implementations
/// have drifted.
void main() {
  test('sample_drive.gpx scores identically to the backend', () {
    final text = File('assets/dev/sample_drive.gpx').readAsStringSync();
    final matches = RegExp(
      r'<trkpt lat="([\d.-]+)" lon="([\d.-]+)"><time>([^<]+)</time></trkpt>',
    ).allMatches(text);
    final samples = <(DateTime, Coord)>[
      for (final m in matches)
        (
          DateTime.parse(m.group(3)!),
          Coord(lat: double.parse(m.group(1)!), lon: double.parse(m.group(2)!)),
        ),
    ];
    expect(samples, hasLength(206));

    final report = buildReport(samples);
    expect(report.score, 50);
    expect(report.harshEvents, hasLength(5));
    expect(report.distanceMeters, closeTo(11947.1, 1));
    expect(report.durationSeconds, closeTo(820, 1));
    // Peak decelerations, in order, from the backend run.
    final peaks = [6.940, 3.122, 4.490, 8.073, 3.764];
    for (var i = 0; i < peaks.length; i++) {
      expect(report.harshEvents[i].peakDecelMs2, closeTo(peaks[i], 0.01));
    }
    expect(report.harshEvents.first.fromMps / mpsPerMph, closeTo(86.75, 0.1));
  });
}
