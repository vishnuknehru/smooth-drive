import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'voice_service.dart';

part 'flutter_tts_voice_service.g.dart';

@Riverpod(keepAlive: true)
VoiceService voiceService(Ref ref) {
  final svc = FlutterTtsVoiceService();
  ref.onDispose(svc.dispose);
  return svc;
}

/// Thin adapter over flutter_tts; excluded from coverage (platform channel).
class FlutterTtsVoiceService implements VoiceService {
  FlutterTtsVoiceService() {
    _tts
      ..setLanguage('en-GB')
      ..setSpeechRate(0.5)
      ..setVolume(1.0);
  }

  final _tts = FlutterTts();

  @override
  Future<void> speak(String text) async => _tts.speak(text);

  @override
  Future<void> stop() async => _tts.stop();

  @override
  void dispose() => _tts.stop();
}
