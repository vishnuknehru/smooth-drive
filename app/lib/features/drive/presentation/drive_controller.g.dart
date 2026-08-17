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

String _$driveControllerHash() => r'02b6105798db210681495f17c21a4078720f1a94';

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
