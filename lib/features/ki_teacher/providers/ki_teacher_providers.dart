import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message_model.dart';

final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<ChatMessageModel>>((ref) {
  return ChatMessagesNotifier();
});

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

final _sampleMessages = <ChatMessageModel>[
  ChatMessageModel(
    id: '1',
    content: 'Hallo! Ich bin dein KI-Lehrer. Wie kann ich dir heute beim Deutschlernen helfen?',
    role: ChatMessageRole.assistant,
    timestamp: DateTime.now(),
    language: 'de',
  ),
];
