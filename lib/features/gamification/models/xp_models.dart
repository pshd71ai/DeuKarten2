import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'xp_models.freezed.dart';
part 'xp_models.g.dart';

@freezed
class XpData with _$XpData {
  const factory XpData({
    required int currentXp,
    required int level,
    required int xpForNextLevel,
    required int xpInCurrentLevel,
    required int totalXpEarned,
    required List<XpHistoryEntry> history,
  }) = _XpData;

  factory XpData.fromJson(Map<String, dynamic> json) => _$XpDataFromJson(json);
}

@freezed
class XpHistoryEntry with _$XpHistoryEntry {
  const factory XpHistoryEntry({
    required int amount,
    required String source,
    required DateTime timestamp,
    String? description,
  }) = _XpHistoryEntry;

  factory XpHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$XpHistoryEntryFromJson(json);
}

@freezed
class XpReward with _$XpReward {
  const factory XpReward({
    required int amount,
    required String reason,
    required XpRewardType type,
    @Default(false) bool isBonus,
  }) = _XpReward;
}

enum XpRewardType {
  cardLearned,
  sessionCompleted,
  streakMaintained,
  perfectSession,
  firstStudyOfDay,
  grammarExplained,
  sentenceCorrected,
}
