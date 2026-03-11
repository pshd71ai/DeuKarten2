import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/xp_models.dart';
import '../models/streak_model.dart';
import '../services/gamification_service.dart';
import '../services/xp_calculator.dart';

final gamificationServiceProvider = Provider<GamificationService>((ref) {
  return GamificationService();
});

final xpDataProvider = StateNotifierProvider<XpNotifier, XpData?>((ref) {
  return XpNotifier();
});

final streakDataProvider =
    StateNotifierProvider<StreakNotifier, StreakData?>((ref) {
  return StreakNotifier();
});

class XpNotifier extends StateNotifier<XpData?> {
  XpNotifier()
      : super(XpData(
          currentXp: 0,
          level: 1,
          xpForNextLevel: 100,
          xpInCurrentLevel: 0,
          totalXpEarned: 0,
          history: [],
        ));

  void addXp(XpReward reward) {
    if (state == null) return;

    final newTotalXp = state!.currentXp + reward.amount;
    final newLevel = XpCalculator.calculateLevel(newTotalXp);
    final xpForNextLevel = XpCalculator.xpForLevel(newLevel);
    final xpForCurrentLevel = XpCalculator.xpForLevel(newLevel - 1);

    state = state!.copyWith(
      currentXp: newTotalXp,
      level: newLevel,
      xpForNextLevel: xpForNextLevel,
      xpInCurrentLevel: newTotalXp - xpForCurrentLevel,
      totalXpEarned: state!.totalXpEarned + reward.amount,
      history: [
        ...state!.history,
        XpHistoryEntry(
          amount: reward.amount,
          source: reward.reason,
          timestamp: DateTime.now(),
        ),
      ],
    );
  }

  void loadFromStorage(XpData data) {
    state = data;
  }

  bool didLevelUp() {
    if (state == null || state!.history.length < 2) return false;

    final previousEntry = state!.history[state!.history.length - 2];
    final previousLevel = XpCalculator.calculateLevel(
      state!.currentXp - previousEntry.amount,
    );

    return state!.level > previousLevel;
  }
}

class StreakNotifier extends StateNotifier<StreakData?> {
  StreakNotifier()
      : super(StreakData(
          currentStreak: 0,
          longestStreak: 0,
          lastStudyDate: DateTime.now().subtract(const Duration(days: 1)),
          studiedToday: false,
          studyDates: [],
        ));

  void checkIn() {
    if (state == null) return;

    final now = DateTime.now();
    final lastStudy = state!.lastStudyDate;
    final difference = now.difference(lastStudy).inDays;

    if (state!.studiedToday) return;

    int newStreak = state!.currentStreak;
    List<DateTime> newStudyDates = [...state!.studyDates, now];

    if (difference == 1) {
      newStreak++;
    } else if (difference > 1) {
      newStreak = 1;
    }

    StreakMilestone? milestone;
    if (newStreak == 3) milestone = StreakMilestone.day3;
    if (newStreak == 7) milestone = StreakMilestone.day7;
    if (newStreak == 14) milestone = StreakMilestone.day14;
    if (newStreak == 30) milestone = StreakMilestone.day30;
    if (newStreak == 60) milestone = StreakMilestone.day60;
    if (newStreak == 100) milestone = StreakMilestone.day100;

    state = state!.copyWith(
      currentStreak: newStreak,
      longestStreak: newStreak > state!.longestStreak
          ? newStreak
          : state!.longestStreak,
      lastStudyDate: now,
      studiedToday: true,
      studyDates: newStudyDates,
      lastMilestone: milestone,
    );
  }

  void loadFromStorage(StreakData data) {
    state = data;
  }

  void resetDaily() {
    if (state == null) return;
    state = state!.copyWith(studiedToday: false);
  }
}

// Computed providers
final currentLevelProvider = Provider<int>((ref) {
  final xpData = ref.watch(xpDataProvider);
  return xpData?.level ?? 1;
});

final levelProgressProvider = Provider<double>((ref) {
  final xpData = ref.watch(xpDataProvider);
  if (xpData == null) return 0.0;
  return xpData.xpInCurrentLevel / xpData.xpForNextLevel;
});

final currentStreakProvider = Provider<int>((ref) {
  final streakData = ref.watch(streakDataProvider);
  return streakData?.currentStreak ?? 0;
});

final milestoneReachedProvider = Provider<StreakMilestone?>((ref) {
  final streakData = ref.watch(streakDataProvider);
  return streakData?.lastMilestone;
});
