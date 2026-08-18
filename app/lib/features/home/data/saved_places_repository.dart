import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/providers.dart';
import '../domain/saved_place.dart';

part 'saved_places_repository.g.dart';

const _kSavedPlaces = 'saved_places';

@Riverpod(keepAlive: true)
SavedPlacesRepository savedPlacesRepository(Ref ref) =>
    SavedPlacesRepository(ref.watch(sharedPreferencesProvider));

class SavedPlacesRepository {
  SavedPlacesRepository(this._prefs);

  final SharedPreferences _prefs;

  List<SavedPlace> getAll() {
    final raw = _prefs.getStringList(_kSavedPlaces) ?? [];
    return raw
        .map((s) => SavedPlace.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  Future<void> add(SavedPlace place) async {
    final current = getAll()..removeWhere((p) => p.name == place.name);
    current.insert(0, place);
    await _prefs.setStringList(
      _kSavedPlaces,
      current.map((p) => jsonEncode(p.toJson())).toList(),
    );
  }

  Future<void> remove(String name) async {
    final current = getAll()..removeWhere((p) => p.name == name);
    await _prefs.setStringList(
      _kSavedPlaces,
      current.map((p) => jsonEncode(p.toJson())).toList(),
    );
  }
}
