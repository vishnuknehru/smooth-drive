import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failure.dart';
import '../../../summary/domain/entities/journey.dart';
import '../services/drive_session.dart';
import 'route_analysis.dart';

part 'drive_state.freezed.dart';

@freezed
sealed class DriveState with _$DriveState {
  const factory DriveState.idle() = DriveIdle;

  const factory DriveState.acquiringGps() = DriveAcquiringGps;

  const factory DriveState.analyzing() = DriveAnalyzing;

  const factory DriveState.driving({
    required RouteAnalysis route,
    required DateTime startedAt,
    DriveTick? tick,
  }) = DriveDriving;

  const factory DriveState.saving() = DriveSaving;

  const factory DriveState.done({required Journey journey}) = DriveDone;

  const factory DriveState.error({required Failure failure}) = DriveError;
}
