enum ChatMessageRole {
  user,
  assistant,
  system,
}

enum ChatMessageType {
  text,
  grammar,
  correction,
  suggestions,
}

class ChatMessageModel {
  final String id;
  final String content;
  final ChatMessageRole role;
  final DateTime timestamp;
  final String? language;
  final ChatMessageType type;

  ChatMessageModel({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
    this.language,
    this.type = ChatMessageType.text,
  });

  ChatMessageModel copyWith({
    String? id,
    String? content,
    ChatMessageRole? role,
    DateTime? timestamp,
    String? language,
    ChatMessageType? type,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      role: role ?? this.role,
      timestamp: timestamp ?? this.timestamp,
      language: language ?? this.language,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'role': role.name,
      'timestamp': timestamp.toIso8601String(),
      'language': language,
      'type': type.name,
    };
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      content: json['content'] as String,
      role: ChatMessageRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => ChatMessageRole.user,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      language: json['language'] as String?,
      type: ChatMessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ChatMessageType.text,
      ),
    );
  }

  bool get isUser => role == ChatMessageRole.user;
  bool get isAssistant => role == ChatMessageRole.assistant;
}
