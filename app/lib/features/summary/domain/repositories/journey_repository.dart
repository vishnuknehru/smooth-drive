import '../entities/journey.dart';

abstract class JourneyRepository {
  Future<void> save(Journey journey);
  Future<Journey?> load(String id);
  Future<List<Journey>> recent({int limit = 10});
}
