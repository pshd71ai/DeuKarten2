import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/ai_service_provider.dart';
import '../providers/voice_provider.dart';
import '../widgets/voice_input_button.dart';
import '../widgets/voice_wave_animation.dart';
import '../services/voice_service.dart';

class SpeakingModeScreen extends ConsumerStatefulWidget {
  const SpeakingModeScreen({super.key});

  @override
  ConsumerState<SpeakingModeScreen> createState() => _SpeakingModeScreenState();
}

class _SpeakingModeScreenState extends ConsumerState<SpeakingModeScreen> {
  final List<ConversationMessage> _messages = [];
  bool _isAIThinking = false;

  @override
  void initState() {
    super.initState();
    // Schedule the initial greeting after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startConversation();
    });
  }

  void _startConversation() async {
    final aiService = ref.read(aiServiceProvider);
    final response = await aiService.startDialog('Greetings');
    
    if (mounted) {
      setState(() {
        _messages.add(ConversationMessage(
          text: response.aiMessage,
          isUser: false,
        ));
      });
      
      // Speak the greeting
      await ref.read(voiceStateProvider.notifier).speak(response.aiMessage);
    }
  }

  void _handleVoiceInput(String text) async {
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ConversationMessage(text: text, isUser: true));
      _isAIThinking = true;
    });

    // Get AI response
    final aiService = ref.read(aiServiceProvider);
    final aiResponse = await aiService.startDialog('Conversation');

    if (mounted) {
      setState(() {
        _isAIThinking = false;
        _messages.add(ConversationMessage(
          text: aiResponse.aiMessage,
          isUser: false,
        ));
      });

      // Speak AI response
      await ref.read(voiceStateProvider.notifier).speak(aiResponse.aiMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final voiceState = ref.watch(voiceStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sprachübung'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showVoiceSettings(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Conversation history
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),

          // AI thinking indicator
          if (_isAIThinking)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),

          // Voice wave animation when listening
          VoiceWaveAnimation(isListening: voiceState.isListening),

          // Recognized text preview
          if (voiceState.recognizedText != null && voiceState.isListening)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                voiceState.recognizedText!,
                style: AppTypography.body,
              ),
            ),

          // Voice input button
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  voiceState.isListening
                      ? 'Zuhören...'
                      : 'Halte gedrückt zum Sprechen',
                  style: AppTypography.caption,
                ),
                const SizedBox(height: 16),
                VoiceInputButton(
                  onSpeechResult: () {
                    final text = ref.read(voiceStateProvider).recognizedText;
                    if (text != null) {
                      _handleVoiceInput(text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ConversationMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                message.text,
                style: AppTypography.body.copyWith(
                  color: message.isUser ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
            if (!message.isUser) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.volume_up, size: 20),
                color: AppColors.primary,
                onPressed: () {
                  ref.read(voiceStateProvider.notifier).speak(message.text);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showVoiceSettings(BuildContext context) {
    // Show TTS speed, language settings
  }
}

class ConversationMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ConversationMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
