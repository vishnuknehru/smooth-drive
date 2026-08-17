// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_tts_voice_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(voiceService)
final voiceServiceProvider = VoiceServiceProvider._();

final class VoiceServiceProvider
    extends $FunctionalProvider<VoiceService, VoiceService, VoiceService>
    with $Provider<VoiceService> {
  VoiceServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceServiceHash();

  @$internal
  @override
  $ProviderElement<VoiceService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VoiceService create(Ref ref) {
    return voiceService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceService>(value),
    );
  }
}

String _$voiceServiceHash() => r'c02ae6c19df96b6fd9c96ac7d57c59b0b513698f';
