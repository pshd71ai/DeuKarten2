// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordCardImpl _$$WordCardImplFromJson(Map<String, dynamic> json) =>
    _$WordCardImpl(
      id: json['id'] as String,
      germanWord: json['germanWord'] as String,
      translation: json['translation'] as String,
      article: json['article'] as String,
      pluralForm: json['pluralForm'] as String,
      exampleSentence: json['exampleSentence'] as String?,
      exampleTranslation: json['exampleTranslation'] as String?,
      imageUrl: json['imageUrl'] as String?,
      level: $enumDecode(_$DifficultyLevelEnumMap, json['level']),
      type: $enumDecode(_$CardTypeEnumMap, json['type']),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      lastReviewed: json['lastReviewed'] == null
          ? null
          : DateTime.parse(json['lastReviewed'] as String),
      nextReview: json['nextReview'] == null
          ? null
          : DateTime.parse(json['nextReview'] as String),
      intervalDays: (json['intervalDays'] as num?)?.toInt(),
      repetitionCount: (json['repetitionCount'] as num?)?.toInt() ?? 0,
      easeFactor: (json['easeFactor'] as num?)?.toDouble() ?? 2.5,
    );

Map<String, dynamic> _$$WordCardImplToJson(_$WordCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'germanWord': instance.germanWord,
      'translation': instance.translation,
      'article': instance.article,
      'pluralForm': instance.pluralForm,
      'exampleSentence': instance.exampleSentence,
      'exampleTranslation': instance.exampleTranslation,
      'imageUrl': instance.imageUrl,
      'level': _$DifficultyLevelEnumMap[instance.level]!,
      'type': _$CardTypeEnumMap[instance.type]!,
      'tags': instance.tags,
      'lastReviewed': instance.lastReviewed?.toIso8601String(),
      'nextReview': instance.nextReview?.toIso8601String(),
      'intervalDays': instance.intervalDays,
      'repetitionCount': instance.repetitionCount,
      'easeFactor': instance.easeFactor,
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.a1: 'a1',
  DifficultyLevel.a2: 'a2',
  DifficultyLevel.b1: 'b1',
  DifficultyLevel.b2: 'b2',
  DifficultyLevel.c1: 'c1',
};

const _$CardTypeEnumMap = {
  CardType.noun: 'noun',
  CardType.verb: 'verb',
  CardType.adjective: 'adjective',
  CardType.article: 'article',
  CardType.sentence: 'sentence',
};
