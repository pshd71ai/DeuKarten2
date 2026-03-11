import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/voice_service.dart';

part 'voice_provider.freezed.dart';

final voiceServiceProvider = Provider<VoiceService>((ref) {
  return VoiceService();
});

final voiceStateProvider = StateNotifierProvider<VoiceNotifier, VoiceState>((ref) {
  final voiceService = ref.watch(voiceServiceProvider);
  return VoiceNotifier(voiceService);
});

/// Voice state for UI
@freezed
class VoiceState with _$VoiceState {
  const factory VoiceState({
    @Default(false) bool isInitialized,
    @Default(false) bool isListening,
    @Default(false) bool isSpeaking,
    @Default(false) bool hasPermission,
    String? recognizedText,
    String? error,
    @Default(SpeechStatus.idle) SpeechStatus speechStatus,
    @Default(TtsStatus.idle) TtsStatus ttsStatus,
  }) = _VoiceState;
}

class VoiceNotifier extends StateNotifier<VoiceState> {
  final VoiceService _voiceService;
  StreamSubscription? _speechStatusSub;
  StreamSubscription? _speechResultSub;
  StreamSubscription? _ttsStatusSub;

  VoiceNotifier(this._voiceService) : super(const VoiceState()) {
    _init();
  }

  Future<void> _init() async {
    // Check permission
    final status = await Permission.microphone.status;
    state = state.copyWith(hasPermission: status.isGranted);

    // Initialize service
    final initialized = await _voiceService.initialize();
    state = state.copyWith(isInitialized: initialized);

    // Listen to streams
    _speechStatusSub = _voiceService.speechStatusStream.listen((status) {
      state = state.copyWith(
        speechStatus: status,
        isListening: status == SpeechStatus.listening,
      );
    });

    _speechResultSub = _voiceService.speechResultStream.listen((text) {
      state = state.copyWith(recognizedText: text);
    });

    _ttsStatusSub = _voiceService.ttsStatusStream.listen((status) {
      state = state.copyWith(
        ttsStatus: status,
        isSpeaking: status == TtsStatus.speaking,
      );
    });
  }

  Future<void> requestPermission() async {
    final result = await _voiceService.requestPermission();
    state = state.copyWith(hasPermission: result.isGranted);
  }

  Future<void> startListening() async {
    if (!state.hasPermission) {
      await requestPermission();
      if (!state.hasPermission) {
        state = state.copyWith(error: 'Microphone permission denied');
        return;
      }
    }

    state = state.copyWith(recognizedText: null, error: null);
    await _voiceService.startListening();
  }

  Future<void> stopListening() async {
    await _voiceService.stopListening();
  }

  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    await _voiceService.speak(text);
  }

  Future<void> stopSpeaking() async {
    await _voiceService.stopSpeaking();
  }

  @override
  void dispose() {
    _speechStatusSub?.cancel();
    _speechResultSub?.cancel();
    _ttsStatusSub?.cancel();
    // We don't dispose the service here because it's provided by a provider
    // and might be used elsewhere, or it should be disposed when the provider is disposed.
    // However, the ticket's code calls _voiceService.dispose().
    // Since voiceServiceProvider doesn't have an onDispose, I'll keep it as in the ticket.
    _voiceService.dispose();
    super.dispose();
  }
}
