// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentence_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SentenceCardImpl _$$SentenceCardImplFromJson(Map<String, dynamic> json) =>
    _$SentenceCardImpl(
      id: json['id'] as String,
      incompleteSentence: json['incompleteSentence'] as String,
      wordOptions: (json['wordOptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      correctAnswer: json['correctAnswer'] as String,
      completeSentence: json['completeSentence'] as String,
      translation: json['translation'] as String,
      level: $enumDecode(_$DifficultyLevelEnumMap, json['level']),
      grammarTopic: json['grammarTopic'] as String?,
    );

Map<String, dynamic> _$$SentenceCardImplToJson(_$SentenceCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'incompleteSentence': instance.incompleteSentence,
      'wordOptions': instance.wordOptions,
      'correctAnswer': instance.correctAnswer,
      'completeSentence': instance.completeSentence,
      'translation': instance.translation,
      'level': _$DifficultyLevelEnumMap[instance.level]!,
      'grammarTopic': instance.grammarTopic,
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.a1: 'a1',
  DifficultyLevel.a2: 'a2',
  DifficultyLevel.b1: 'b1',
  DifficultyLevel.b2: 'b2',
  DifficultyLevel.c1: 'c1',
};
