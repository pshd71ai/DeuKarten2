import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service managing speech-to-text and text-to-speech functionality
class VoiceService {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  
  bool _isInitialized = false;
  bool _isListening = false;
  bool _isSpeaking = false;
  
  // Streams for UI updates
  final _speechStatusController = StreamController<SpeechStatus>.broadcast();
  final _speechResultController = StreamController<String>.broadcast();
  final _ttsStatusController = StreamController<TtsStatus>.broadcast();
  
  Stream<SpeechStatus> get speechStatusStream => _speechStatusController.stream;
  Stream<String> get speechResultStream => _speechResultController.stream;
  Stream<TtsStatus> get ttsStatusStream => _ttsStatusController.stream;
  
  bool get isInitialized => _isInitialized;
  bool get isListening => _isListening;
  bool get isSpeaking => _isSpeaking;

  /// Initialize both STT and TTS
  Future<bool> initialize() async {
    if (_isInitialized) return true;
    
    try {
      // Initialize Speech-to-Text
      final speechAvailable = await _speechToText.initialize(
        onStatus: (status) => _onSpeechStatus(status),
        onError: (error) => _onSpeechError(error),
      );
      
      if (!speechAvailable) {
        debugPrint('Speech recognition not available');
        return false;
      }
      
      // Initialize Text-to-Speech
      await _flutterTts.setLanguage('de-DE');  // German
      await _flutterTts.setSpeechRate(0.5);    // Slightly slower for learners
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      
      // TTS handlers
      _flutterTts.setStartHandler(() {
        _isSpeaking = true;
        _ttsStatusController.add(TtsStatus.speaking);
      });
      
      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
        _ttsStatusController.add(TtsStatus.completed);
      });
      
      _flutterTts.setErrorHandler((msg) {
        _isSpeaking = false;
        _ttsStatusController.add(TtsStatus.error);
        debugPrint('TTS Error: $msg');
      });
      
      _isInitialized = true;
      return true;
    } catch (e) {
      debugPrint('VoiceService initialization error: $e');
      return false;
    }
  }

  /// Start listening for speech
  Future<void> startListening({
    Duration listenDuration = const Duration(seconds: 30),
    String localeId = 'de_DE',  // German locale
  }) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) return;
    }
    
    if (_isListening) {
      await stopListening();
    }
    
    _speechStatusController.add(SpeechStatus.listening);
    
    await _speechToText.listen(
      onResult: (result) {
        _speechResultController.add(result.recognizedWords);
        if (result.finalResult) {
          _speechStatusController.add(SpeechStatus.done);
          _isListening = false;
        }
      },
      localeId: localeId,
      listenMode: ListenMode.confirmation,
      pauseFor: const Duration(seconds: 3),
      listenFor: listenDuration,
    );
    
    _isListening = true;
  }

  /// Stop listening
  Future<void> stopListening() async {
    if (!_isListening) return;
    
    await _speechToText.stop();
    _isListening = false;
    _speechStatusController.add(SpeechStatus.stopped);
  }

  /// Cancel listening (without processing results)
  Future<void> cancelListening() async {
    await _speechToText.cancel();
    _isListening = false;
    _speechStatusController.add(SpeechStatus.cancelled);
  }

  /// Speak text in German
  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    
    if (_isSpeaking) {
      await stopSpeaking();
    }
    
    await _flutterTts.speak(text);
  }

  /// Stop speaking
  Future<void> stopSpeaking() async {
    await _flutterTts.stop();
    _isSpeaking = false;
    _ttsStatusController.add(TtsStatus.stopped);
  }

  /// Check if speech recognition is available
  Future<bool> isSpeechAvailable() async {
    return await _speechToText.initialize();
  }

  /// Request microphone permission
  Future<PermissionStatus> requestPermission() async {
    return await Permission.microphone.request();
  }

  void _onSpeechStatus(String status) {
    debugPrint('Speech status: $status');
    switch (status) {
      case 'listening':
        _speechStatusController.add(SpeechStatus.listening);
        break;
      case 'notListening':
        _speechStatusController.add(SpeechStatus.notListening);
        _isListening = false;
        break;
      case 'done':
        _speechStatusController.add(SpeechStatus.done);
        _isListening = false;
        break;
    }
  }

  void _onSpeechError(SpeechRecognitionError error) {
    debugPrint('Speech error: ${error.errorMsg}');
    _speechStatusController.add(SpeechStatus.error);
    _isListening = false;
  }

  void dispose() {
    _speechToText.cancel();
    _flutterTts.stop();
    _speechStatusController.close();
    _speechResultController.close();
    _ttsStatusController.close();
  }
}

/// Speech recognition status
enum SpeechStatus {
  idle,
  listening,
  notListening,
  done,
  error,
  stopped,
  cancelled,
}

/// Text-to-speech status
enum TtsStatus {
  idle,
  speaking,
  completed,
  error,
  stopped,
}
