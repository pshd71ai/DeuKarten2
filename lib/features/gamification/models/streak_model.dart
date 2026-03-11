import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'streak_model.freezed.dart';
part 'streak_model.g.dart';

@freezed
class StreakData with _$StreakData {
  const factory StreakData({
    required int currentStreak,
    required int longestStreak,
    required DateTime lastStudyDate,
    required bool studiedToday,
    required List<DateTime> studyDates,
    StreakMilestone? lastMilestone,
  }) = _StreakData;

  factory StreakData.fromJson(Map<String, dynamic> json) =>
      _$StreakDataFromJson(json);
}

enum StreakMilestone {
  day3,
  day7,
  day14,
  day30,
  day60,
  day100,
}

extension StreakMilestoneExtension on StreakMilestone {
  int get days {
    return switch (this) {
      StreakMilestone.day3 => 3,
      StreakMilestone.day7 => 7,
      StreakMilestone.day14 => 14,
      StreakMilestone.day30 => 30,
      StreakMilestone.day60 => 60,
      StreakMilestone.day100 => 100,
    };
  }

  String get title {
    return switch (this) {
      StreakMilestone.day3 => 'Guter Start!',
      StreakMilestone.day7 => 'Wöchentlich!',
      StreakMilestone.day14 => 'Zwei Wochen!',
      StreakMilestone.day30 => 'Monatlich!',
      StreakMilestone.day60 => 'Zwei Monate!',
      StreakMilestone.day100 => '100 Tage! 🏆',
    };
  }

  int get bonusXp {
    return switch (this) {
      StreakMilestone.day3 => 10,
      StreakMilestone.day7 => 25,
      StreakMilestone.day14 => 50,
      StreakMilestone.day30 => 100,
      StreakMilestone.day60 => 200,
      StreakMilestone.day100 => 500,
    };
  }
}
