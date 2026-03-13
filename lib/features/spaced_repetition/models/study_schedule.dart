import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_schedule.freezed.dart';
part 'study_schedule.g.dart';

@freezed
class StudySchedule with _$StudySchedule {
  const factory StudySchedule({
    required DateTime date,
    required List<String> newCards,
    required List<String> reviewCards,
    required List<String> learningCards,
    @Default(0) int completedCount,
  }) = _StudySchedule;
  
  factory StudySchedule.fromJson(Map<String, dynamic> json) =>
      _$StudyScheduleFromJson(json);
}

@freezed
class DailyStats with _$DailyStats {
  const factory DailyStats({
    required DateTime date,
    required int newCardsStudied,
    required int reviewsCompleted,
    required int cardsLearned,
    required int xpEarned,
    required double averageQuality,
  }) = _DailyStats;
  
  factory DailyStats.fromJson(Map<String, dynamic> json) =>
      _$DailyStatsFromJson(json);
}
