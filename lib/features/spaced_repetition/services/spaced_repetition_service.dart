import '../models/card_progress.dart';
import '../models/study_schedule.dart';

/// Implementation of the SuperMemo-2 (SM-2) algorithm
/// 
/// Algorithm overview:
/// 1. Split knowledge into smallest possible items
/// 2. With each item associate an E-Factor (easiness factor) equal to 2.5
/// 3. Repeat items using the following intervals:
///    - I(1) = 1 day
///    - I(2) = 6 days
///    - I(n) = I(n-1) * EF
/// 4. After each repetition, modify EF based on quality of response (q):
///    - EF' = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
///    - If EF' < 1.3, set EF' = 1.3
/// 5. If q < 3, start repetitions for the item from the beginning
class SpacedRepetitionService {
  /// Calculate next review data based on SM-2 algorithm
  /// 
  /// [progress] - Current card progress
  /// [quality] - Quality of response (0-5)
  /// Returns updated CardProgress
  CardProgress calculateNextReview(CardProgress progress, int quality) {
    // Ensure quality is in valid range
    final clampedQuality = quality.clamp(0, 5);
    
    // Get current values
    int repetitions = progress.repetitions;
    double easeFactor = progress.easeFactor;
    int intervalDays = progress.intervalDays;
    
    // Calculate new EF
    double newEaseFactor = _calculateNewEaseFactor(easeFactor, clampedQuality);
    
    // If quality < 3, reset repetitions
    if (clampedQuality < 3) {
      repetitions = 0;
      intervalDays = 0;
    } else {
      // Increment repetitions
      repetitions++;
      
      // Calculate new interval
      if (repetitions == 1) {
        intervalDays = 1;
      } else if (repetitions == 2) {
        intervalDays = 6;
      } else {
        intervalDays = (intervalDays * easeFactor).round();
      }
    }
    
    // Calculate next review date
    final nextReview = DateTime.now().add(Duration(days: intervalDays));
    
    // Determine status
    final status = _determineStatus(repetitions, newEaseFactor);
    
    return progress.copyWith(
      lastReviewed: DateTime.now(),
      nextReview: nextReview,
      repetitions: repetitions,
      easeFactor: newEaseFactor,
      intervalDays: intervalDays,
      lastQuality: clampedQuality,
      totalReviews: progress.totalReviews + 1,
      correctReviews: clampedQuality >= 3 
          ? progress.correctReviews + 1 
          : progress.correctReviews,
      consecutiveCorrect: clampedQuality >= 3 
          ? progress.consecutiveCorrect + 1 
          : 0,
      status: status,
    );
  }
  
  /// Calculate new ease factor based on quality
  double _calculateNewEaseFactor(double currentEF, int quality) {
    // SM-2 formula: EF' = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    double newEF = currentEF + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    
    // EF should not be less than 1.3
    if (newEF < 1.3) {
      newEF = 1.3;
    }
    
    return newEF;
  }
  
  /// Determine card status based on progress
  SRSStatus _determineStatus(int repetitions, double easeFactor) {
    if (repetitions == 0) {
      return SRSStatus.newCard;
    } else if (repetitions < 3) {
      return SRSStatus.learning;
    } else if (easeFactor >= 2.5 && repetitions > 5) {
      return SRSStatus.mastered;
    } else {
      return SRSStatus.review;
    }
  }
  
  /// Get quality rating from user's answer
  /// 
  /// [isCorrect] - Whether the answer was correct
  /// [difficulty] - User's subjective difficulty (easy, medium, hard)
  int getQualityRating(bool isCorrect, Difficulty difficulty) {
    if (!isCorrect) {
      return switch (difficulty) {
        Difficulty.blackout => 0,
        Difficulty.hard => 1,
        Difficulty.medium => 2,
        Difficulty.easy => 2, // Shouldn't happen for incorrect
      };
    } else {
      return switch (difficulty) {
        Difficulty.hard => 3,
        Difficulty.medium => 4,
        Difficulty.easy => 5,
        Difficulty.blackout => 3, // Shouldn't happen for correct
      };
    }
  }
  
  /// Calculate cards due for today
  List<String> getDueCards(
    Map<String, CardProgress> allProgress,
    DateTime today, {
    int maxNewCards = 20,
    int maxReviews = 100,
  }) {
    final List<String> newCards = [];
    final List<String> reviewCards = [];
    final List<String> learningCards = [];
    
    for (final entry in allProgress.entries) {
      final cardId = entry.key;
      final progress = entry.value;
      
      // Check if card is suspended
      if (progress.status == SRSStatus.suspended) continue;
      
      if (progress.status == SRSStatus.newCard) {
        // New cards
        if (newCards.length < maxNewCards) {
          newCards.add(cardId);
        }
      } else if (progress.nextReview != null && 
                 progress.nextReview!.isBefore(today.add(const Duration(days: 1)))) {
        // Due for review
        if (progress.status == SRSStatus.learning) {
          if (learningCards.length < 10) { // Limit learning cards
            learningCards.add(cardId);
          }
        } else {
          if (reviewCards.length < maxReviews) {
            reviewCards.add(cardId);
          }
        }
      }
    }
    
    // Priority: Learning > Review > New
    return [...learningCards, ...reviewCards, ...newCards];
  }
  
  /// Calculate optimal new cards per day based on user's history
  int calculateOptimalNewCards(List<DailyStats> last30Days) {
    if (last30Days.isEmpty) return 20;
    
    // Calculate average reviews per day
    final avgReviews = last30Days
        .map((d) => d.reviewsCompleted)
        .reduce((a, b) => a + b) / last30Days.length;
    
    // Calculate average accuracy
    final avgAccuracy = last30Days
        .map((d) => d.averageQuality)
        .reduce((a, b) => a + b) / last30Days.length;
    
    // Adjust new cards based on performance
    int optimal = 20;
    
    if (avgReviews > 80 && avgAccuracy > 4.0) {
      optimal = 30; // User can handle more
    } else if (avgReviews > 50 || avgAccuracy < 3.0) {
      optimal = 15; // Reduce load
    } else if (avgAccuracy < 2.5) {
      optimal = 10; // Heavy reduction needed
    }
    
    return optimal;
  }
  
  /// Get review forecast for next N days
  Map<DateTime, int> getReviewForecast(
    Map<String, CardProgress> allProgress,
    int days,
  ) {
    final Map<DateTime, int> forecast = {};
    final now = DateTime.now();
    
    for (int i = 0; i < days; i++) {
      final date = DateTime(now.year, now.month, now.day + i);
      forecast[date] = 0;
    }
    
    for (final progress in allProgress.values) {
      if (progress.nextReview == null) continue;
      
      final reviewDate = DateTime(
        progress.nextReview!.year,
        progress.nextReview!.month,
        progress.nextReview!.day,
      );
      
      if (forecast.containsKey(reviewDate)) {
        forecast[reviewDate] = forecast[reviewDate]! + 1;
      }
    }
    
    return forecast;
  }
}

enum Difficulty {
  blackout,  // Complete failure
  hard,      // Hard to recall
  medium,    // Some hesitation
  easy,      // Easy recall
}
