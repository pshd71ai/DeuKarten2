// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeckImpl _$$DeckImplFromJson(Map<String, dynamic> json) => _$DeckImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      level: $enumDecode(_$DifficultyLevelEnumMap, json['level']),
      cardIds:
          (json['cardIds'] as List<dynamic>).map((e) => e as String).toList(),
      totalCards: (json['totalCards'] as num).toInt(),
      cardsLearned: (json['cardsLearned'] as num?)?.toInt(),
      progress: (json['progress'] as num?)?.toDouble(),
      thumbnailEmoji: json['thumbnailEmoji'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastStudied: json['lastStudied'] == null
          ? null
          : DateTime.parse(json['lastStudied'] as String),
    );

Map<String, dynamic> _$$DeckImplToJson(_$DeckImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'level': _$DifficultyLevelEnumMap[instance.level]!,
      'cardIds': instance.cardIds,
      'totalCards': instance.totalCards,
      'cardsLearned': instance.cardsLearned,
      'progress': instance.progress,
      'thumbnailEmoji': instance.thumbnailEmoji,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastStudied': instance.lastStudied?.toIso8601String(),
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.a1: 'a1',
  DifficultyLevel.a2: 'a2',
  DifficultyLevel.b1: 'b1',
  DifficultyLevel.b2: 'b2',
  DifficultyLevel.c1: 'c1',
};
