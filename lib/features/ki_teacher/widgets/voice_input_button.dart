import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/voice_provider.dart';
import '../services/voice_service.dart';

class VoiceInputButton extends ConsumerWidget {
  final VoidCallback? onSpeechResult;
  final double size;

  const VoiceInputButton({
    super.key,
    this.onSpeechResult,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceState = ref.watch(voiceStateProvider);
    final voiceNotifier = ref.read(voiceStateProvider.notifier);

    // Handle permission denied
    if (voiceState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPermissionDialog(context);
      });
    }

    return GestureDetector(
      onTapDown: (_) => voiceNotifier.startListening(),
      onTapUp: (_) => _handleTapUp(voiceNotifier, voiceState),
      onTapCancel: () => voiceNotifier.stopListening(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getButtonColor(voiceState),
          boxShadow: voiceState.isListening
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _buildIcon(voiceState),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(VoiceState state) {
    if (state.isListening) {
      return const Icon(
        Icons.mic,
        color: Colors.white,
        size: 32,
        key: ValueKey('mic_active'),
      );
    }
    return const Icon(
      Icons.mic_none,
      color: Colors.white,
      size: 32,
      key: ValueKey('mic_inactive'),
    );
  }

  Color _getButtonColor(VoiceState state) {
    if (state.isListening) return AppColors.primary;
    if (state.isSpeaking) return AppColors.success;
    return AppColors.textTertiary;
  }

  void _handleTapUp(VoiceNotifier notifier, VoiceState state) async {
    await notifier.stopListening();
    if (state.recognizedText?.isNotEmpty == true) {
      onSpeechResult?.call();
    }
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mikrofon-Zugriff erforderlich'),
        content: const Text(
          'Um die Spracherkennung zu nutzen, benötigt die App Zugriff auf dein Mikrofon.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Einstellungen öffnen'),
          ),
        ],
      ),
    );
  }
}
