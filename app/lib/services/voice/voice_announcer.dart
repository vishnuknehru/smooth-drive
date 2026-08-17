import '../../features/drive/domain/entities/advice.dart';
import '../../features/drive/domain/entities/route_analysis.dart';
import '../../features/drive/domain/entities/upcoming.dart';
import '../../features/drive/domain/services/drive_session.dart';
import 'voice_service.dart';

typedef _AdviceKey = (AdviceAction, int?, Coord?);

/// Pure-Dart policy class: decides what to speak and when.
///
/// Rules:
/// - Speaks `advice.message` when the advice key changes and action ≠ maintain.
/// - Announces events once they enter within `alertDistanceMeters`.
/// - Enforces a minimum 5-second gap between consecutive announcements.
/// - No-ops when voiceEnabled is false.
class VoiceAnnouncer {
  VoiceAnnouncer({required this.voice, this.now = DateTime.now});

  final VoiceService voice;
  final DateTime Function() now;

  static const _minGap = Duration(seconds: 5);

  _AdviceKey? _lastAdviceKey;
  final _announcedLocations = <Coord>{};
  DateTime? _lastAt;

  Future<void> onTick(
    DriveTick tick, {
    required bool voiceEnabled,
    required double alertDistanceMeters,
  }) async {
    if (!voiceEnabled) return;

    final update = tick.update;
    if (update == null) return;

    // Advice change takes priority.
    final advice = update.advice;
    final newKey = advice == null
        ? null
        : (advice.action, advice.targetMph, advice.event?.location);

    if (newKey != _lastAdviceKey) {
      _lastAdviceKey = newKey;
      if (advice != null && advice.action != AdviceAction.maintain) {
        if (_canAnnounce()) {
          await voice.speak(advice.message);
          _lastAt = now();
          return; // one announcement per tick
        }
      }
    }

    // Event alert threshold (one announcement per location).
    for (final event in update.events) {
      if (event.distanceAheadMeters <= alertDistanceMeters &&
          !_announcedLocations.contains(event.location)) {
        if (_canAnnounce()) {
          await voice.speak(_eventText(event));
          _lastAt = now();
          _announcedLocations.add(event.location);
          break; // one event announcement per tick
        }
      }
    }
  }

  bool _canAnnounce() {
    final last = _lastAt;
    return last == null || now().difference(last) >= _minGap;
  }

  String _eventText(UpcomingEvent event) => switch (event.type) {
        EventType.speedLimit => event.valueMph != null
            ? 'Speed limit changing to ${event.valueMph} miles per hour'
            : 'Speed limit change ahead',
        EventType.trafficSignal => 'Traffic signal ahead',
        EventType.roundabout => 'Roundabout ahead',
        EventType.unknown => 'Hazard ahead',
      };

  void reset() {
    _lastAdviceKey = null;
    _announcedLocations.clear();
    _lastAt = null;
  }

  void dispose() => voice.dispose();
}
