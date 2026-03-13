// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleCardImpl _$$ArticleCardImplFromJson(Map<String, dynamic> json) =>
    _$ArticleCardImpl(
      id: json['id'] as String,
      word: json['word'] as String,
      correctArticle: json['correctArticle'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      translation: json['translation'] as String,
      exampleSentence: json['exampleSentence'] as String?,
      level: $enumDecode(_$DifficultyLevelEnumMap, json['level']),
    );

Map<String, dynamic> _$$ArticleCardImplToJson(_$ArticleCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'correctArticle': instance.correctArticle,
      'options': instance.options,
      'translation': instance.translation,
      'exampleSentence': instance.exampleSentence,
      'level': _$DifficultyLevelEnumMap[instance.level]!,
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.a1: 'a1',
  DifficultyLevel.a2: 'a2',
  DifficultyLevel.b1: 'b1',
  DifficultyLevel.b2: 'b2',
  DifficultyLevel.c1: 'c1',
};
