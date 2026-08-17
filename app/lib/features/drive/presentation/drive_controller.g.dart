// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drive_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriveController)
final driveControllerProvider = DriveControllerProvider._();

final class DriveControllerProvider
    extends $NotifierProvider<DriveController, DriveState> {
  DriveControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driveControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driveControllerHash();

  @$internal
  @override
  DriveController create() => DriveController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriveState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriveState>(value),
    );
  }
}

String _$driveControllerHash() => r'9ef29ce506df128c7c52ee1a8a1a873790fb0b61';

abstract class _$DriveController extends $Notifier<DriveState> {
  DriveState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DriveState, DriveState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DriveState, DriveState>,
              DriveState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
