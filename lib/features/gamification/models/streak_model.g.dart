// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StreakDataImpl _$$StreakDataImplFromJson(Map<String, dynamic> json) =>
    _$StreakDataImpl(
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      lastStudyDate: DateTime.parse(json['lastStudyDate'] as String),
      studiedToday: json['studiedToday'] as bool,
      studyDates: (json['studyDates'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      lastMilestone:
          $enumDecodeNullable(_$StreakMilestoneEnumMap, json['lastMilestone']),
    );

Map<String, dynamic> _$$StreakDataImplToJson(_$StreakDataImpl instance) =>
    <String, dynamic>{
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'lastStudyDate': instance.lastStudyDate.toIso8601String(),
      'studiedToday': instance.studiedToday,
      'studyDates':
          instance.studyDates.map((e) => e.toIso8601String()).toList(),
      'lastMilestone': _$StreakMilestoneEnumMap[instance.lastMilestone],
    };

const _$StreakMilestoneEnumMap = {
  StreakMilestone.day3: 'day3',
  StreakMilestone.day7: 'day7',
  StreakMilestone.day14: 'day14',
  StreakMilestone.day30: 'day30',
  StreakMilestone.day60: 'day60',
  StreakMilestone.day100: 'day100',
};
