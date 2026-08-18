import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../summary/data/file_journey_repository.dart';
import '../../summary/domain/entities/journey.dart';

part 'summary_controller.g.dart';

@riverpod
Future<Journey> summaryJourney(Ref ref, String journeyId) async {
  final journey = await ref.watch(journeyRepositoryProvider).load(journeyId);
  if (journey == null) throw StateError('Journey $journeyId not found');
  return journey;
}

@riverpod
Future<List<Journey>> recentJourneys(Ref ref) =>
    ref.watch(journeyRepositoryProvider).recent(limit: 5);
