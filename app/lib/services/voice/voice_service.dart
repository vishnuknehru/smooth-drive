abstract class VoiceService {
  Future<void> speak(String text);
  Future<void> stop();
  void dispose();
}
