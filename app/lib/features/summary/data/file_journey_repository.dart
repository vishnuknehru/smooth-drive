import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/entities/journey.dart';
import '../domain/repositories/journey_repository.dart';

part 'file_journey_repository.g.dart';

@Riverpod(keepAlive: true)
JourneyRepository journeyRepository(Ref ref) => FileJourneyRepository();

class FileJourneyRepository implements JourneyRepository {
  FileJourneyRepository({this.overrideDir});

  // Injected in tests to avoid needing the path_provider platform channel.
  final Directory? overrideDir;

  Future<Directory> _dir() async {
    final base = overrideDir ?? await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/journeys');
    if (!dir.existsSync()) dir.createSync(recursive: true);
    return dir;
  }

  @override
  Future<void> save(Journey journey) async {
    final dir = await _dir();
    final file = File('${dir.path}/${journey.id}.json');
    await file.writeAsString(jsonEncode(journey.toJson()));
  }

  @override
  Future<Journey?> load(String id) async {
    final dir = await _dir();
    final file = File('${dir.path}/$id.json');
    if (!file.existsSync()) return null;
    final raw = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    return Journey.fromJson(raw);
  }

  @override
  Future<List<Journey>> recent({int limit = 10}) async {
    final dir = await _dir();
    final files = dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.json'))
        .toList();

    final journeys = <Journey>[];
    for (final file in files) {
      try {
        final raw =
            jsonDecode(await file.readAsString()) as Map<String, dynamic>;
        journeys.add(Journey.fromJson(raw));
      } catch (_) {
        // Skip corrupt files silently.
      }
    }

    journeys.sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return journeys.take(limit).toList();
  }
}
