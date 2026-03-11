// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$ChatSession implements _ChatSession {
  const _$ChatSession({
    required this.id,
    required this.startTime,
    this.endTime,
    @Default([]) this.messages,
    @Default('general') this.topic,
    @Default('de') this.language,
    @Default('A1') this.proficiencyLevel,
    @Default(0) this.messageCount,
  }) : super._();

  @override
  final String id;

  @override
  final DateTime startTime;

  @override
  final DateTime? endTime;

  @override
  final List<ChatMessageModel> messages;

  @override
  final String topic;

  @override
  final String language;

  @override
  final String proficiencyLevel;

  @override
  final int messageCount;

  @override
  String toString() {
    return 'ChatSession(id: $id, startTime: $startTime, endTime: $endTime, messages: $messages, topic: $topic, language: $language, proficiencyLevel: $proficiencyLevel, messageCount: $messageCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatSession &&
            (identical(other.id, id) || other.id == id) &&
            const ListEquality().equals(other.messages, messages) &&
            (identical(other.startTime, startTime) || other.startTime == startTime) &&
            other.endTime == endTime &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.language, language) || other.language == language) &&
            (identical(other.proficiencyLevel, proficiencyLevel) || other.proficiencyLevel == proficiencyLevel) &&
            other.messageCount == messageCount);
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, messages, startTime, endTime, topic, language, proficiencyLevel, messageCount);

  @override
  @optionalTypeArgs
  TResult? map<TResult>({
    TResult Function(_$ChatSession value)? _$,
  }) {
    return _$?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult>({
    TResult Function(_$ChatSession value)? _$,
  }) {
    return _$?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult>({
    TResult Function(_$ChatSession value)? _$,
    required TResult orElse(),
  }) {
    return _$?.call(this) ?? orElse();
  }
}

class $_ChatSession with _$ChatSession {
  const $_ChatSession({
    required super.id,
    required super.startTime,
    super.endTime,
    @Default([]) super.messages,
    @Default('general') super.topic,
    @Default('de') super.language,
    @Default('A1') super.proficiencyLevel,
    @Default(0) super.messageCount,
  }) : super._();

  @override
  ChatSession copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    List<ChatMessageModel>? messages,
    String? topic,
    String? language,
    String? proficiencyLevel,
    int? messageCount,
  }) {
    return ChatSession(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      messages: messages ?? this.messages,
      topic: topic ?? this.topic,
      language: language ?? this.language,
      proficiencyLevel: proficiencyLevel ?? this.proficiencyLevel,
      messageCount: messageCount ?? this.messageCount,
    );
  }
}
