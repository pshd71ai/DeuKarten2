import 'package:deu_karten/features/cards/models/enums.dart';
import '../models/xp_models.dart';
import '../models/streak_model.dart';
import 'xp_calculator.dart';

class GamificationService {
  XpData _xpData = XpData(
    currentXp: 0,
    level: 1,
    xpForNextLevel: 100,
    xpInCurrentLevel: 0,
    totalXpEarned: 0,
    history: [],
  );

  StreakData _streakData = StreakData(
    currentStreak: 0,
    longestStreak: 0,
    lastStudyDate: DateTime.now().subtract(const Duration(days: 1)),
    studiedToday: false,
    studyDates: [],
  );

  XpData get xpData => _xpData;
  StreakData get streakData => _streakData;

  XpReward awardCardXp({
    required bool isCorrect,
    required DifficultyLevel difficulty,
    required bool isNewCard,
    int streak = 1,
  }) {
    final reward = XpCalculator.calculateCardXp(
      isCorrect: isCorrect,
      difficulty: difficulty,
      isNewCard: isNewCard,
      streak: streak,
    );

    _addXp(reward);
    return reward;
  }

  XpReward awardSessionXp({
    required int cardsLearned,
    required int correctAnswers,
    required int streak,
  }) {
    final reward = XpCalculator.calculateSessionXp(
      cardsLearned: cardsLearned,
      correctAnswers: correctAnswers,
      streak: streak,
    );

    _addXp(reward);
    return reward;
  }

  void _addXp(XpReward reward) {
    if (reward.amount <= 0) return;

    final newTotalXp = _xpData.currentXp + reward.amount;
    final newLevel = XpCalculator.calculateLevel(newTotalXp);
    final xpForCurrentLevel = XpCalculator.xpForLevel(newLevel - 1);
    final xpForNextLevel = XpCalculator.xpForLevel(newLevel);
    final xpInCurrentLevel = newTotalXp - xpForCurrentLevel;

    _xpData = _xpData.copyWith(
      currentXp: newTotalXp,
      level: newLevel,
      xpForNextLevel: xpForNextLevel,
      xpInCurrentLevel: xpInCurrentLevel,
      totalXpEarned: _xpData.totalXpEarned + reward.amount,
      history: [
        ..._xpData.history,
        XpHistoryEntry(
          amount: reward.amount,
          source: reward.reason,
          timestamp: DateTime.now(),
        ),
      ],
    );
  }

  StreakMilestone? checkIn() {
    final now = DateTime.now();
    final lastStudy = _streakData.lastStudyDate;
    final difference = now.difference(lastStudy).inDays;

    if (_streakData.studiedToday) {
      return null; // Already studied today
    }

    int newStreak = _streakData.currentStreak;
    List<DateTime> newStudyDates = [..._streakData.studyDates, now];

    if (difference == 0) {
      // Same day - shouldn't happen due to studiedToday check
      return null;
    } else if (difference == 1) {
      // Consecutive day - streak continues
      newStreak++;
    } else if (difference > 1) {
      // Streak broken
      newStreak = 1;
    }

    StreakMilestone? milestone;
    if (newStreak == 3) milestone = StreakMilestone.day3;
    if (newStreak == 7) milestone = StreakMilestone.day7;
    if (newStreak == 14) milestone = StreakMilestone.day14;
    if (newStreak == 30) milestone = StreakMilestone.day30;
    if (newStreak == 60) milestone = StreakMilestone.day60;
    if (newStreak == 100) milestone = StreakMilestone.day100;

    _streakData = _streakData.copyWith(
      currentStreak: newStreak,
      longestStreak: newStreak > _streakData.longestStreak
          ? newStreak
          : _streakData.longestStreak,
      lastStudyDate: now,
      studiedToday: true,
      studyDates: newStudyDates,
      lastMilestone: milestone,
    );

    return milestone;
  }

  int getXpForNextLevel() {
    return _xpData.xpForNextLevel - _xpData.xpInCurrentLevel;
  }

  double getLevelProgress() {
    return _xpData.xpInCurrentLevel / _xpData.xpForNextLevel;
  }

  bool isLevelUpPending(int previousXp, int currentXp) {
    final previousLevel = XpCalculator.calculateLevel(previousXp);
    final currentLevel = XpCalculator.calculateLevel(currentXp);
    return currentLevel > previousLevel;
  }
}
