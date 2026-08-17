import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoothdrive/core/error/failure.dart';
import 'package:smoothdrive/core/providers.dart';
import 'package:smoothdrive/core/theme/app_theme.dart';
import 'package:smoothdrive/features/drive/domain/entities/advice.dart';
import 'package:smoothdrive/features/drive/domain/entities/drive_state.dart';
import 'package:smoothdrive/features/drive/domain/entities/geo_sample.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/drive/domain/entities/upcoming.dart';
import 'package:smoothdrive/features/drive/domain/services/drive_session.dart';
import 'package:smoothdrive/features/drive/presentation/drive_controller.dart';
import 'package:smoothdrive/features/drive/presentation/drive_screen.dart';
import 'package:smoothdrive/features/drive/presentation/widgets/advice_banner.dart';
import 'package:smoothdrive/features/summary/domain/entities/journey.dart';

final t0 = DateTime.utc(2026, 7, 1, 9);

const route = RouteAnalysis(
  routeId: 'route-one',
  distanceMeters: 2224,
  geometry: [Coord(lat: 51.0, lon: 0.0)],
  events: [],
);

class StubDriveController extends DriveController {
  StubDriveController(this._initial);

  final DriveState _initial;

  @override
  DriveState build() => _initial;
}

DriveTick tick({
  Advice? advice,
  int? limit,
  bool offRoute = false,
  Failure? failure,
}) =>
    DriveTick(
      sample: GeoSample(
        time: t0.add(const Duration(minutes: 5)),
        coord: const Coord(lat: 51.005, lon: 0.0),
        speedMps: 13.4112, // 30 mph
        accuracyM: 5,
      ),
      update: PositionUpdate(
        routeId: 'route-one',
        positionOnRouteMeters: 500,
        offRoute: offRoute,
        events: const [
          UpcomingEvent(
            type: EventType.speedLimit,
            distanceAheadMeters: 643.7,
            location: Coord(lat: 51.01, lon: 0.0),
            valueMph: 60,
          ),
          UpcomingEvent(
            type: EventType.trafficSignal,
            distanceAheadMeters: 1931.2,
            location: Coord(lat: 51.014, lon: 0.0),
          ),
        ],
        advice: advice,
      ),
      currentLimitMph: limit,
      offRoute: offRoute,
      failure: failure,
    );

Future<void> pumpDrive(WidgetTester tester, DriveState state) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      // UniqueKey forces a fresh ProviderContainer on every call so provider
      // overrides (especially the stub DriveController) are always replaced.
      key: UniqueKey(),
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        driveControllerProvider.overrideWith(() => StubDriveController(state)),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        home: const DriveScreen(),
      ),
    ),
  );
}

DriveState driving({DriveTick? t}) =>
    DriveState.driving(route: route, startedAt: t0, tick: t);

void main() {
  testWidgets('shows speed, limit roundel and events while driving',
      (tester) async {
    await pumpDrive(tester, driving(t: tick(limit: 40)));
    expect(find.text('30'), findsOneWidget); // current speed in mph
    expect(find.text('40'), findsOneWidget); // limit roundel
    expect(find.text('Traffic signal'), findsOneWidget);
    expect(find.textContaining('0.4 mi'), findsOneWidget);
  });

  testWidgets('advice banner colors and titles per action', (tester) async {
    const cases = {
      AdviceAction.easeOff: 'Ease off the accelerator',
      AdviceAction.brakeGently: 'Brake gently',
      AdviceAction.brake: 'Brake now',
      AdviceAction.prepareSignal: 'Signal ahead — be ready',
    };
    for (final MapEntry(key: action, value: title) in cases.entries) {
      await pumpDrive(
        tester,
        driving(
          t: tick(
            advice: Advice(action: action, message: 'do the thing'),
          ),
        ),
      );
      expect(find.text(title), findsOneWidget, reason: '$action title');
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(AdviceBanner),
          matching: find.byType(Container),
        ),
      );
      final expected = AdviceColors.light.of(action).bg;
      expect((container.decoration! as BoxDecoration).color, expected,
          reason: '$action color');
    }
  });

  testWidgets('no advice renders the maintain banner', (tester) async {
    await pumpDrive(tester, driving(t: tick()));
    expect(find.text('All clear'), findsOneWidget);
  });

  testWidgets('unknown limit shows a dash roundel', (tester) async {
    await pumpDrive(tester, driving(t: tick()));
    expect(find.text('—'), findsOneWidget);
  });

  testWidgets('connection-lost strip appears on failure', (tester) async {
    await pumpDrive(
      tester,
      driving(t: tick(failure: const NetworkFailure())),
    );
    expect(find.textContaining('Connection lost'), findsOneWidget);
  });

  testWidgets('off-route strip appears', (tester) async {
    await pumpDrive(tester, driving(t: tick(offRoute: true)));
    expect(find.text('Off route'), findsOneWidget);
  });

  testWidgets('progress copy for acquiring and analyzing states',
      (tester) async {
    await pumpDrive(tester, const DriveState.acquiringGps());
    expect(find.textContaining('GPS fix'), findsOneWidget);

    await pumpDrive(tester, const DriveState.analyzing());
    expect(find.textContaining('Analyzing'), findsOneWidget);
  });

  testWidgets('done state shows the score', (tester) async {
    final journey = Journey(
      id: 'j1',
      startedAt: t0,
      endedAt: t0.add(const Duration(minutes: 10)),
      start: const Coord(lat: 51.0, lon: 0.0),
      end: const Coord(lat: 51.02, lon: 0.0),
      distanceMeters: 5000,
      durationSeconds: 600,
      harshEvents: const [],
      lateReactions: 1,
      score: 95,
      samples: const [],
    );
    await pumpDrive(tester, DriveState.done(journey: journey));
    expect(find.text('Smoothness score: 95'), findsOneWidget);
  });

  testWidgets('error state shows the failure message', (tester) async {
    await pumpDrive(
      tester,
      const DriveState.error(failure: UpstreamFailure()),
    );
    expect(
      find.text('Route service is temporarily unavailable'),
      findsOneWidget,
    );
  });
}
