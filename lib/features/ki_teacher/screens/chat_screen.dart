import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/ki_teacher_providers.dart';
import '../models/chat_message_model.dart';
import '../widgets/quick_actions_widget.dart';
import '../widgets/chat_bubble_widget.dart';
import '../widgets/voice_input_button.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isVoiceListening = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    final messageText = text.trim();
    if (messageText.isEmpty) return;

    // Add user message
    ref.read(chatMessagesProvider.notifier).addMessage(
          ChatMessageModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: messageText,
            role: ChatMessageRole.user,
            timestamp: DateTime.now(),
          ),
        );

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response (replace with actual AI integration)
    Future.delayed(const Duration(seconds: 1), () {
      ref.read(chatMessagesProvider.notifier).addMessage(
            ChatMessageModel(
              id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
              content: _generateResponse(messageText),
              role: ChatMessageRole.assistant,
              timestamp: DateTime.now(),
              language: 'de',
              type: _determineMessageType(messageText),
            ),
          );
      _scrollToBottom();
    });
  }

  ChatMessageType _determineMessageType(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();
    if (lowerMessage.contains('grammatik') ||
        lowerMessage.contains('erkläre')) {
      return ChatMessageType.grammar;
    }
    if (lowerMessage.contains('korrigier') ||
        lowerMessage.contains('sätze')) {
      return ChatMessageType.correction;
    }
    if (lowerMessage.contains('wörter') ||
        lowerMessage.contains('vorschlag')) {
      return ChatMessageType.suggestions;
    }
    return ChatMessageType.text;
  }

  String _generateResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();

    // Grammar explanations
    if (lowerMessage.contains('grammatik')) {
      return 'Der Akkusativ wird für das direkte Objekt verwendet. Beispiel: "Ich sehe den Hund". Die Endungen sind: den, die, das.';
    }

    // Corrections
    if (lowerMessage.contains('korrigier')) {
      return 'Ich habe gehe|Ich bin gegangen';
    }

    // Suggestions
    if (lowerMessage.contains('wörter')) {
      return 'Haus\nAuto\nKatze\nHund';
    }

    // Default conversation responses
    final responses = [
      'Das ist gut! Mach weiter so!',
      'Interessant! Lass uns das genauer besprechen.',
      'Sehr gut gemacht! Noch eine Frage?',
      'Du machst Fortschritte! Hast du noch etwas anderes, über das du sprechen möchtest?',
      'Prima! Versuchen wir es mit einem anderen Thema.',
    ];
    return responses[(userMessage.length) % responses.length];
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toggleVoiceInput() {
    setState(() {
      _isVoiceListening = !_isVoiceListening;
    });

    // TODO: Integrate speech_to_text
    if (_isVoiceListening) {
      // Start listening
    } else {
      // Stop listening
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);
    final isAiTyping = ref.watch(isAiTypingProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'KI-Lehrer',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.textSecondary),
            onPressed: () {
              // TODO: Show settings menu
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Actions
          QuickActionsWidget(
            onActionSelected: (prompt) {
              _messageController.text = prompt;
              _sendMessage(prompt);
            },
          ),

          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: messages.length + (isAiTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && isAiTyping) {
                  return _buildTypingIndicator();
                }

                final message = messages[index];
                final isUser = message.isUser;
                return ChatBubbleWidget(
                  message: message,
                  isUser: isUser,
                );
              },
            ),
          ),

          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 400 + (index * 200)),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: AppColors.textTertiary,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Voice input button
            VoiceInputButton(
              isListening: _isVoiceListening,
              onPressed: _toggleVoiceInput,
            ),
            const SizedBox(width: 12),

            // Text input
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Schreibe auf Deutsch...',
                  hintStyle: AppTypography.body.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) => _sendMessage(_messageController.text),
              ),
            ),

            const SizedBox(width: 12),

            // Send button
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () => _sendMessage(_messageController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
