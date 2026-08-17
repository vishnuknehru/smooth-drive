// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SettingsRepository,
          SettingsRepository,
          SettingsRepository
        >
    with $Provider<SettingsRepository> {
  SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'5faff3edf0c98ea2ba83899dde6c175aa28288fb';

/// Derived so dependents (the Dio client) rebuild only when the URL
/// actually changes, not on every settings edit.

@ProviderFor(baseUrl)
final baseUrlProvider = BaseUrlProvider._();

/// Derived so dependents (the Dio client) rebuild only when the URL
/// actually changes, not on every settings edit.

final class BaseUrlProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Derived so dependents (the Dio client) rebuild only when the URL
  /// actually changes, not on every settings edit.
  BaseUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'baseUrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$baseUrlHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return baseUrl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$baseUrlHash() => r'e431bddcc3fee4ddf47607db76e6673fc5d3d3d8';

@ProviderFor(unitsFormatter)
final unitsFormatterProvider = UnitsFormatterProvider._();

final class UnitsFormatterProvider
    extends $FunctionalProvider<UnitsFormatter, UnitsFormatter, UnitsFormatter>
    with $Provider<UnitsFormatter> {
  UnitsFormatterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unitsFormatterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unitsFormatterHash();

  @$internal
  @override
  $ProviderElement<UnitsFormatter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UnitsFormatter create(Ref ref) {
    return unitsFormatter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UnitsFormatter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UnitsFormatter>(value),
    );
  }
}

String _$unitsFormatterHash() => r'dcdcdc16cee07b8c4629b64065eef26f46071970';

@ProviderFor(SettingsController)
final settingsControllerProvider = SettingsControllerProvider._();

final class SettingsControllerProvider
    extends $NotifierProvider<SettingsController, Settings> {
  SettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Settings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Settings>(value),
    );
  }
}

String _$settingsControllerHash() =>
    r'5d1f12f0efdab97cf07ed4eaf798b7d92a415ae7';

abstract class _$SettingsController extends $Notifier<Settings> {
  Settings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Settings, Settings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Settings, Settings>,
              Settings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
