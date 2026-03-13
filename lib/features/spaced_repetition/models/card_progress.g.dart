// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardProgressImpl _$$CardProgressImplFromJson(Map<String, dynamic> json) =>
    _$CardProgressImpl(
      cardId: json['cardId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastReviewed: json['lastReviewed'] == null
          ? null
          : DateTime.parse(json['lastReviewed'] as String),
      nextReview: json['nextReview'] == null
          ? null
          : DateTime.parse(json['nextReview'] as String),
      repetitions: (json['repetitions'] as num?)?.toInt() ?? 0,
      easeFactor: (json['easeFactor'] as num?)?.toDouble() ?? 2.5,
      intervalDays: (json['intervalDays'] as num?)?.toInt() ?? 0,
      lastQuality: (json['lastQuality'] as num?)?.toInt(),
      totalReviews: (json['totalReviews'] as num?)?.toInt() ?? 0,
      correctReviews: (json['correctReviews'] as num?)?.toInt() ?? 0,
      consecutiveCorrect: (json['consecutiveCorrect'] as num?)?.toInt() ?? 0,
      status: $enumDecodeNullable(_$SRSStatusEnumMap, json['status']) ??
          SRSStatus.newCard,
    );

Map<String, dynamic> _$$CardProgressImplToJson(_$CardProgressImpl instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastReviewed': instance.lastReviewed?.toIso8601String(),
      'nextReview': instance.nextReview?.toIso8601String(),
      'repetitions': instance.repetitions,
      'easeFactor': instance.easeFactor,
      'intervalDays': instance.intervalDays,
      'lastQuality': instance.lastQuality,
      'totalReviews': instance.totalReviews,
      'correctReviews': instance.correctReviews,
      'consecutiveCorrect': instance.consecutiveCorrect,
      'status': _$SRSStatusEnumMap[instance.status]!,
    };

const _$SRSStatusEnumMap = {
  SRSStatus.newCard: 'newCard',
  SRSStatus.learning: 'learning',
  SRSStatus.review: 'review',
  SRSStatus.mastered: 'mastered',
  SRSStatus.suspended: 'suspended',
};
