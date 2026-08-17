// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_places_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(savedPlacesRepository)
final savedPlacesRepositoryProvider = SavedPlacesRepositoryProvider._();

final class SavedPlacesRepositoryProvider
    extends
        $FunctionalProvider<
          SavedPlacesRepository,
          SavedPlacesRepository,
          SavedPlacesRepository
        >
    with $Provider<SavedPlacesRepository> {
  SavedPlacesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedPlacesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedPlacesRepositoryHash();

  @$internal
  @override
  $ProviderElement<SavedPlacesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SavedPlacesRepository create(Ref ref) {
    return savedPlacesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SavedPlacesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SavedPlacesRepository>(value),
    );
  }
}

String _$savedPlacesRepositoryHash() =>
    r'876169e72af45481a137e9f791bd8069d02ba5bc';
