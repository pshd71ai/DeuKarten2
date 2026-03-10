// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LearningSessionImpl _$$LearningSessionImplFromJson(
        Map<String, dynamic> json) =>
    _$LearningSessionImpl(
      id: json['id'] as String,
      deckId: json['deckId'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      cards: (json['cards'] as List<dynamic>)
          .map((e) => SessionCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      cardsStudied: json['cardsStudied'] as int?,
      correctAnswers: json['correctAnswers'] as int?,
      xpEarned: json['xpEarned'] as int?,
      status: $enumDecodeNullable(_$SessionStatusEnumMap, json['status']) ??
          SessionStatus.inProgress,
    );

Map<String, dynamic> _$$LearningSessionImplToJson(
        _$LearningSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deckId': instance.deckId,
      'startedAt': instance.startedAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'cardsStudied': instance.cardsStudied,
      'correctAnswers': instance.correctAnswers,
      'xpEarned': instance.xpEarned,
      'status': _$SessionStatusEnumMap[instance.status]!,
    };

const _$SessionStatusEnumMap = {
  SessionStatus.inProgress: 'inProgress',
  SessionStatus.completed: 'completed',
  SessionStatus.paused: 'paused',
};

_$SessionCardImpl _$$SessionCardImplFromJson(Map<String, dynamic> json) =>
    _$SessionCardImpl(
      cardId: json['cardId'] as String,
      type: $enumDecode(_$CardTypeEnumMap, json['type']),
      status: $enumDecodeNullable(_$CardStatusEnumMap, json['status']) ??
          CardStatus.new_card,
      attempts: json['attempts'] as int?,
      wasCorrect: json['wasCorrect'] as bool?,
      shownAt: json['shownAt'] == null
          ? null
          : DateTime.parse(json['shownAt'] as String),
      answeredAt: json['answeredAt'] == null
          ? null
          : DateTime.parse(json['answeredAt'] as String),
    );

Map<String, dynamic> _$$SessionCardImplToJson(_$SessionCardImpl instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'type': _$CardTypeEnumMap[instance.type]!,
      'status': _$CardStatusEnumMap[instance.status]!,
      'attempts': instance.attempts,
      'wasCorrect': instance.wasCorrect,
      'shownAt': instance.shownAt?.toIso8601String(),
      'answeredAt': instance.answeredAt?.toIso8601String(),
    };

const _$CardTypeEnumMap = {
  CardType.noun: 'noun',
  CardType.verb: 'verb',
  CardType.adjective: 'adjective',
  CardType.article: 'article',
  CardType.sentence: 'sentence',
};

const _$CardStatusEnumMap = {
  CardStatus.new_card: 'new_card',
  CardStatus.learning: 'learning',
  CardStatus.review: 'review',
  CardStatus.mastered: 'mastered',
};

T $enumDecode<T extends Enum>(Map<T, dynamic> enumValues, dynamic source) {
  for (final entry in enumValues.entries) {
    if (entry.value == source) {
      return entry.key;
    }
  }
  throw ArgumentError('`$source` is not one of the supported values: '
      '${enumValues.values.join(', ')}');
}

T? $enumDecodeNullable<T extends Enum>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return $enumDecode(enumValues, source);
}
