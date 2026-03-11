import 'package:freezed_annotation/freezed_annotation.dart';
import 'chat_message_model.dart';

part 'chat_session.freezed.dart';
part 'chat_session.g.dart';

@freezed
class ChatSession with _$ChatSession {
  const factory ChatSession({
    required String id,
    required DateTime startTime,
    DateTime? endTime,
    @Default([]) List<ChatMessageModel> messages,
    @Default('general') String topic,
    @Default('de') String language,
    @Default('A1') String proficiencyLevel,
    @Default(0) int messageCount,
  }) = _ChatSession;

  factory ChatSession.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionFromJson(json);

  const ChatSession._();

  int get durationMinutes => endTime != null
      ? endTime!.difference(startTime).inMinutes
      : DateTime.now().difference(startTime).inMinutes;

  List<ChatMessageModel> get userMessages =>
      messages.where((m) => m.isUser).toList();

  List<ChatMessageModel> get assistantMessages =>
      messages.where((m) => m.isAssistant).toList();
}
