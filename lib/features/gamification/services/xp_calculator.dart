import 'dart:math';

import 'package:deu_karten/features/cards/models/enums.dart';
import '../models/xp_models.dart';

class XpCalculator {
  static XpReward calculateCardXp({
    required bool isCorrect,
    required DifficultyLevel difficulty,
    required bool isNewCard,
    int streak = 1,
  }) {
    if (!isCorrect) {
      return const XpReward(
        amount: 0,
        reason: 'Card answered incorrectly',
        type: XpRewardType.cardLearned,
      );
    }

    int baseXp = switch (difficulty) {
      DifficultyLevel.a1 => 5,
      DifficultyLevel.a2 => 8,
      DifficultyLevel.b1 => 12,
      DifficultyLevel.b2 => 15,
      DifficultyLevel.c1 => 20,
    };

    // Bonus for new cards
    if (isNewCard) baseXp += 2;

    // Streak multiplier
    final streakMultiplier = 1.0 + (streak - 1) * 0.1;
    baseXp = (baseXp * streakMultiplier).round();

    return XpReward(
      amount: baseXp,
      reason: 'Card learned successfully',
      type: XpRewardType.cardLearned,
    );
  }

  static XpReward calculateSessionXp({
    required int cardsLearned,
    required int correctAnswers,
    required int streak,
  }) {
    int baseXp = cardsLearned * 10;

    // Accuracy bonus
    final accuracy = correctAnswers / cardsLearned;
    if (accuracy == 1.0) {
      baseXp += 50; // Perfect session bonus
      return XpReward(
        amount: baseXp,
        reason: 'Perfect session completed!',
        type: XpRewardType.perfectSession,
        isBonus: true,
      );
    } else if (accuracy >= 0.8) {
      baseXp += 20;
    }

    // Streak bonus
    if (streak > 0) {
      baseXp += streak * 5;
    }

    return XpReward(
      amount: baseXp,
      reason: 'Session completed',
      type: XpRewardType.sessionCompleted,
    );
  }

  static int xpForLevel(int level) {
    // Exponential XP curve
    return (100 * pow(1.5, level - 1)).round();
  }

  static int calculateLevel(int totalXp) {
    int level = 1;
    int xpNeeded = 100;

    while (totalXp >= xpNeeded) {
      totalXp -= xpNeeded;
      level++;
      xpNeeded = (xpNeeded * 1.5).round();
    }

    return level;
  }
}
