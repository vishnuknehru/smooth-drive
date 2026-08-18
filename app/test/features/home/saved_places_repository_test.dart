import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smoothdrive/features/drive/domain/entities/route_analysis.dart';
import 'package:smoothdrive/features/home/data/saved_places_repository.dart';
import 'package:smoothdrive/features/home/domain/saved_place.dart';

const _home = SavedPlace(name: 'Home', coord: Coord(lat: 51.5, lon: -0.1));
const _work = SavedPlace(name: 'Work', coord: Coord(lat: 51.52, lon: -0.08));

Future<SavedPlacesRepository> _repo([Map<String, Object> initial = const {}]) async {
  SharedPreferences.setMockInitialValues(initial);
  final prefs = await SharedPreferences.getInstance();
  return SavedPlacesRepository(prefs);
}

void main() {
  test('getAll returns empty list when nothing saved', () async {
    final repo = await _repo();
    expect(repo.getAll(), isEmpty);
  });

  test('add stores a place that getAll returns', () async {
    final repo = await _repo();
    await repo.add(_home);
    final places = repo.getAll();
    expect(places, hasLength(1));
    expect(places.single.name, 'Home');
    expect(places.single.coord.lat, closeTo(51.5, 0.001));
  });

  test('add deduplicates by name (replaces and moves to front)', () async {
    final repo = await _repo();
    await repo.add(_home);
    await repo.add(_work);
    // Re-add Home with a different coord — should replace.
    const homeUpdated = SavedPlace(name: 'Home', coord: Coord(lat: 51.6, lon: -0.2));
    await repo.add(homeUpdated);
    final places = repo.getAll();
    expect(places, hasLength(2));
    expect(places.first.name, 'Home');
    expect(places.first.coord.lat, closeTo(51.6, 0.001));
  });

  test('remove deletes a place by name', () async {
    final repo = await _repo();
    await repo.add(_home);
    await repo.add(_work);
    await repo.remove('Home');
    final places = repo.getAll();
    expect(places, hasLength(1));
    expect(places.single.name, 'Work');
  });

  test('remove on non-existent name is a no-op', () async {
    final repo = await _repo();
    await repo.add(_home);
    await repo.remove('Nowhere');
    expect(repo.getAll(), hasLength(1));
  });

  test('SavedPlace toJson / fromJson roundtrip', () async {
    const place = SavedPlace(name: 'Test', coord: Coord(lat: 51.1, lon: -0.05));
    final json = place.toJson();
    final restored = SavedPlace.fromJson(json);
    expect(restored.name, place.name);
    expect(restored.coord.lat, closeTo(place.coord.lat, 0.0001));
    expect(restored.coord.lon, closeTo(place.coord.lon, 0.0001));
  });
}
