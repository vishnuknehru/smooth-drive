// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(summaryJourney)
final summaryJourneyProvider = SummaryJourneyFamily._();

final class SummaryJourneyProvider
    extends $FunctionalProvider<AsyncValue<Journey>, Journey, FutureOr<Journey>>
    with $FutureModifier<Journey>, $FutureProvider<Journey> {
  SummaryJourneyProvider._({
    required SummaryJourneyFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'summaryJourneyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$summaryJourneyHash();

  @override
  String toString() {
    return r'summaryJourneyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Journey> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Journey> create(Ref ref) {
    final argument = this.argument as String;
    return summaryJourney(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SummaryJourneyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$summaryJourneyHash() => r'8c2753312b67473877cefa90bac7a60b2de08cab';

final class SummaryJourneyFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Journey>, String> {
  SummaryJourneyFamily._()
    : super(
        retry: null,
        name: r'summaryJourneyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SummaryJourneyProvider call(String journeyId) =>
      SummaryJourneyProvider._(argument: journeyId, from: this);

  @override
  String toString() => r'summaryJourneyProvider';
}

@ProviderFor(recentJourneys)
final recentJourneysProvider = RecentJourneysProvider._();

final class RecentJourneysProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Journey>>,
          List<Journey>,
          FutureOr<List<Journey>>
        >
    with $FutureModifier<List<Journey>>, $FutureProvider<List<Journey>> {
  RecentJourneysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentJourneysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentJourneysHash();

  @$internal
  @override
  $FutureProviderElement<List<Journey>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Journey>> create(Ref ref) {
    return recentJourneys(ref);
  }
}

String _$recentJourneysHash() => r'a7e08ac77364aaa2e8b57d1bcde8ba9680b3ccdb';
