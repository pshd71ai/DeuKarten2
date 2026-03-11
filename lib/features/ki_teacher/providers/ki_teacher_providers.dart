import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat_message_model.dart';
import '../models/chat_session.dart';
import '../services/chat_service.dart';

part 'ki_teacher_providers.g.dart';

// Chat Messages Provider
final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<ChatMessageModel>>((ref) {
  return ChatMessagesNotifier();
});

// AI Typing State Provider
final isAiTypingProvider = StateProvider<bool>((ref) => false);

// Chat Session Provider
final chatSessionProvider = StateNotifierProvider<ChatSessionNotifier, ChatSession?>((ref) {
  return ChatSessionNotifier();
});

// Chat Service Provider
final chatServiceProvider = Provider<ChatService>((ref) {
  return ChatService();
});

@riverpod
class ChatSession extends _$ChatSession {
  @override
  ChatSession? build() => null;

  void startSession() {
    state = ChatSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startTime: DateTime.now(),
      topic: 'general',
      language: 'de',
      proficiencyLevel: 'A1',
    );
  }

  void addMessage(ChatMessageModel message) {
    if (state == null) return;

    state = state!.copyWith(
      messages: [...state!.messages, message],
      messageCount: state!.messageCount + 1,
    );
  }

  void endSession() {
    if (state == null) return;

    state = state!.copyWith(
      endTime: DateTime.now(),
    );
  }

  void clearSession() {
    state = null;
  }
}

class ChatMessagesNotifier extends StateNotifier<List<ChatMessageModel>> {
  ChatMessagesNotifier() : super(_sampleMessages);

  void addMessage(ChatMessageModel message) {
    state = [...state, message];
  }

  void clearMessages() {
    state = [];
  }

  List<ChatMessageModel> getMessagesByRole(ChatMessageRole role) {
    return state.where((message) => message.role == role).toList();
  }
}

class ChatSessionNotifier extends StateNotifier<ChatSession?> {
  ChatSessionNotifier() : super(null);

  void startSession() {
    state = ChatSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startTime: DateTime.now(),
      topic: 'general',
      language: 'de',
      proficiencyLevel: 'A1',
    );
  }

  void addMessage(ChatMessageModel message) {
    if (state == null) return;

    state = state!.copyWith(
      messages: [...state!.messages, message],
      messageCount: state!.messageCount + 1,
    );
  }

  void endSession() {
    if (state == null) return;

    state = state!.copyWith(
      endTime: DateTime.now(),
    );
  }

  void clearSession() {
    state = null;
  }
}

final _sampleMessages = <ChatMessageModel>[
  ChatMessageModel(
    id: '1',
    content: 'Hallo! Ich bin dein KI-Lehrer. Wie kann ich dir heute beim Deutschlernen helfen?',
    role: ChatMessageRole.assistant,
    timestamp: DateTime.now(),
    language: 'de',
  ),
];
