import 'package:freezed_annotation/freezed_annotation.dart';

import 'upcoming.dart';

part 'advice.freezed.dart';

enum AdviceAction { maintain, easeOff, brakeGently, brake, prepareSignal }

@freezed
abstract class Advice with _$Advice {
  const factory Advice({
    required AdviceAction action,

    /// Seconds until the driver should start acting; null means act now
    /// (or no action for [AdviceAction.maintain]).
    double? actInSeconds,

    /// Target sign value; null for maintain.
    int? targetMph,

    /// The event this advice addresses; null for maintain.
    UpcomingEvent? event,
    required String message,
  }) = _Advice;
}
