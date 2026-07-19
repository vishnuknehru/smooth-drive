import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:smoothdrive/features/drive/data/dto/route_dtos.dart';
import 'package:smoothdrive/features/drive/domain/entities/advice.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';

Map<String, dynamic> fixture(String name) =>
    jsonDecode(File('test/fixtures/$name').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  test('decodes analyze response captured from the real backend', () {
    final dto = RouteAnalysisDto.fromJson(fixture('analyze_response.json'));
    final entity = dto.toEntity();

    expect(entity.routeId, hasLength(12));
    expect(entity.distanceMeters, greaterThan(0));
    expect(entity.geometry, isNotEmpty);
    expect(entity.events, isNotEmpty);
    // Events are ordered by distance from the route start.
    final distances = [for (final e in entity.events) e.distanceMeters];
    expect(distances, orderedEquals(List.of(distances)..sort()));

    final limits = entity.events
        .where((e) => e.type == EventType.speedLimit)
        .toList();
    expect(limits.first.valueMph, isNotNull);
    final signals = entity.events.where(
      (e) => e.type == EventType.trafficSignal,
    );
    // Signals never carry a sign value.
    expect(signals.every((e) => e.valueMph == null), isTrue);
  });

  test('decodes upcoming response with ease_off advice', () {
    final dto = UpcomingResponseDto.fromJson(
      fixture('upcoming_advice_response.json'),
    );
    final entity = dto.toEntity();

    expect(entity.offRoute, isFalse);
    expect(entity.advice, isNotNull);
    final advice = entity.advice!;
    expect(advice.action, AdviceAction.easeOff);
    expect(advice.targetMph, 30);
    expect(advice.event, isNotNull);
    expect(advice.message, contains('ease off'));
  });

  test(
    'decodes upcoming response without speed: advice is maintain or null',
    () {
      final dto = UpcomingResponseDto.fromJson(
        fixture('upcoming_no_speed_response.json'),
      );
      final entity = dto.toEntity();
      expect(entity.advice?.event, isNull);
    },
  );

  test('decodes off-route response', () {
    final dto = UpcomingResponseDto.fromJson(
      fixture('upcoming_off_route_response.json'),
    );
    expect(dto.toEntity().offRoute, isTrue);
  });

  test('unknown event type decodes to EventType.unknown, not a crash', () {
    final json = fixture('analyze_response.json');
    (json['events'] as List).insert(0, {
      'type': 'zebra_crossing',
      'distance_meters': 10.0,
      'location': {'lat': 51.0, 'lon': 0.0},
      'value_mph': null,
    });
    final entity = RouteAnalysisDto.fromJson(json).toEntity();
    expect(entity.events.first.type, EventType.unknown);
  });

  test('unknown advice action falls back to maintain', () {
    final json = fixture('upcoming_advice_response.json');
    (json['advice'] as Map<String, dynamic>)['action'] = 'deploy_parachute';
    final entity = UpcomingResponseDto.fromJson(json).toEntity();
    expect(entity.advice!.action, AdviceAction.maintain);
  });
}
