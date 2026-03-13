// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyScheduleImpl _$$StudyScheduleImplFromJson(Map<String, dynamic> json) =>
    _$StudyScheduleImpl(
      date: DateTime.parse(json['date'] as String),
      newCards: (json['newCards'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      reviewCards: (json['reviewCards'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      learningCards: (json['learningCards'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      completedCount: (json['completedCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$StudyScheduleImplToJson(
        _$StudyScheduleImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'newCards': instance.newCards,
      'reviewCards': instance.reviewCards,
      'learningCards': instance.learningCards,
      'completedCount': instance.completedCount,
    };

_$DailyStatsImpl _$$DailyStatsImplFromJson(Map<String, dynamic> json) =>
    _$DailyStatsImpl(
      date: DateTime.parse(json['date'] as String),
      newCardsStudied: (json['newCardsStudied'] as num).toInt(),
      reviewsCompleted: (json['reviewsCompleted'] as num).toInt(),
      cardsLearned: (json['cardsLearned'] as num).toInt(),
      xpEarned: (json['xpEarned'] as num).toInt(),
      averageQuality: (json['averageQuality'] as num).toDouble(),
    );

Map<String, dynamic> _$$DailyStatsImplToJson(_$DailyStatsImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'newCardsStudied': instance.newCardsStudied,
      'reviewsCompleted': instance.reviewsCompleted,
      'cardsLearned': instance.cardsLearned,
      'xpEarned': instance.xpEarned,
      'averageQuality': instance.averageQuality,
    };
