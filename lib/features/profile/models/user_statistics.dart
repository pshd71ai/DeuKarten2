import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_statistics.freezed.dart';
part 'user_statistics.g.dart';

@freezed
class UserStatistics with _$UserStatistics {
  const factory UserStatistics({
    required int totalCardsLearned,
    required int totalSessionsCompleted,
    required int totalStudyTimeMinutes,
    required int currentStreak,
    required int longestStreak,
    required double averageAccuracy,
    required int totalXp,
    required int currentLevel,
    required List<DailyActivity> last30Days,
    required Map<String, int> cardsByLevel,
    required Map<String, int> weakAreas,
  }) = _UserStatistics;
  
  factory UserStatistics.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticsFromJson(json);
}

@freezed
class DailyActivity with _$DailyActivity {
  const factory DailyActivity({
    required DateTime date,
    required int cardsStudied,
    required int xpEarned,
    required int studyTimeMinutes,
    required double accuracy,
  }) = _DailyActivity;
  
  factory DailyActivity.fromJson(Map<String, dynamic> json) =>
      _$DailyActivityFromJson(json);
}
