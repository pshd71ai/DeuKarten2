// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatSessionImpl _$$ChatSessionImplFromJson(Map<String, dynamic> json) =>
    _$ChatSessionImpl(
      id: json['id'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      topic: json['topic'] as String? ?? 'general',
      language: json['language'] as String? ?? 'de',
      proficiencyLevel: json['proficiencyLevel'] as String? ?? 'A1',
      messageCount: (json['messageCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ChatSessionImplToJson(_$ChatSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'messages': instance.messages,
      'topic': instance.topic,
      'language': instance.language,
      'proficiencyLevel': instance.proficiencyLevel,
      'messageCount': instance.messageCount,
    };
