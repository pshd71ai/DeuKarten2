import '../cards/models/card_progress.dart';

/// SM-2 Spaced Repetition Algorithm
///
/// Rating scale (quality of response):
///   0 - complete blackout
///   1 - incorrect response, but remembered after seeing answer
///   2 - incorrect response, but answer was easy to recall
///   3 - correct response with serious difficulty
///   4 - correct response after a hesitation
///   5 - perfect response
class SM2Algorithm {
  static const double _minEaseFactor = 1.3;
  static const double _initialEaseFactor = 2.5;

  /// Calculates the next review date and updates SM-2 fields.
  ///
  /// [progress] current card progress state
  /// [quality] response quality 0–5
  static CardProgress calculate({
    required CardProgress progress,
    required int quality,
  }) {
    assert(quality >= 0 && quality <= 5, 'Quality must be between 0 and 5');

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    int newRepetitions = progress.repetitions;
    double newEaseFactor = progress.easeFactor;
    int newIntervalDays;

    if (quality >= 3) {
      // Correct response
      if (newRepetitions == 0) {
        newIntervalDays = 1;
      } else if (newRepetitions == 1) {
        newIntervalDays = 6;
      } else {
        newIntervalDays = (progress.intervalDays * newEaseFactor).round();
      }
      newRepetitions++;
    } else {
      // Incorrect response – reset repetition counter, short interval
      newRepetitions = 0;
      newIntervalDays = 1;
    }

    // Update ease factor
    newEaseFactor = newEaseFactor +
        (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (newEaseFactor < _minEaseFactor) {
      newEaseFactor = _minEaseFactor;
    }

    final nextReviewDate = today.add(Duration(days: newIntervalDays));

    return progress.copyWith(
      repetitions: newRepetitions,
      easeFactor: newEaseFactor,
      intervalDays: newIntervalDays,
      lastReviewedAt: now,
      nextReviewAt: nextReviewDate,
    );
  }

  /// Converts a boolean "knew it" answer to SM-2 quality rating.
  ///
  /// [wasCorrect] whether the user knew the card
  static int boolToQuality(bool wasCorrect) => wasCorrect ? 4 : 1;

  /// Returns a [CardProgress] with default SM-2 values for a new card.
  static CardProgress newProgress(String cardId) {
    return CardProgress(
      cardId: cardId,
      repetitions: 0,
      easeFactor: _initialEaseFactor,
      intervalDays: 0,
      lastReviewedAt: null,
      nextReviewAt: null,
    );
  }

  /// Returns true when the card is due for review today or overdue.
  static bool isDueToday(CardProgress progress) {
    if (progress.nextReviewAt == null) return true;
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final dueDate = DateTime(
      progress.nextReviewAt!.year,
      progress.nextReviewAt!.month,
      progress.nextReviewAt!.day,
    );
    return !dueDate.isAfter(todayDate);
  }
}
