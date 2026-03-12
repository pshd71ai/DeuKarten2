import 'package:flutter_test/flutter_test.dart';
import 'package:deu_karten/features/cards/models/card_progress.dart';
import 'package:deu_karten/features/spaced_repetition/sm2_algorithm.dart';

void main() {
  group('SM2Algorithm', () {
    test('newProgress creates default SM-2 state', () {
      final progress = SM2Algorithm.newProgress('card1');
      expect(progress.cardId, 'card1');
      expect(progress.repetitions, 0);
      expect(progress.easeFactor, 2.5);
      expect(progress.intervalDays, 0);
      expect(progress.lastReviewedAt, isNull);
      expect(progress.nextReviewAt, isNull);
    });

    test('isDueToday returns true for new card with no nextReviewAt', () {
      final progress = SM2Algorithm.newProgress('card1');
      expect(SM2Algorithm.isDueToday(progress), isTrue);
    });

    test('isDueToday returns false for card reviewed today with future interval', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final progress = CardProgress(
        cardId: 'card1',
        repetitions: 1,
        easeFactor: 2.5,
        intervalDays: 1,
        lastReviewedAt: DateTime.now(),
        nextReviewAt: tomorrow,
      );
      expect(SM2Algorithm.isDueToday(progress), isFalse);
    });

    test('isDueToday returns true for overdue card', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final progress = CardProgress(
        cardId: 'card1',
        repetitions: 1,
        easeFactor: 2.5,
        intervalDays: 1,
        lastReviewedAt: DateTime.now().subtract(const Duration(days: 2)),
        nextReviewAt: yesterday,
      );
      expect(SM2Algorithm.isDueToday(progress), isTrue);
    });

    test('correct answer on first repetition sets interval to 1 day', () {
      final initial = SM2Algorithm.newProgress('card1');
      final result = SM2Algorithm.calculate(progress: initial, quality: 4);
      expect(result.repetitions, 1);
      expect(result.intervalDays, 1);
    });

    test('correct answer on second repetition sets interval to 6 days', () {
      final afterFirst = CardProgress(
        cardId: 'card1',
        repetitions: 1,
        easeFactor: 2.5,
        intervalDays: 1,
        lastReviewedAt: DateTime.now().subtract(const Duration(days: 1)),
        nextReviewAt: DateTime.now(),
      );
      final result = SM2Algorithm.calculate(progress: afterFirst, quality: 4);
      expect(result.repetitions, 2);
      expect(result.intervalDays, 6);
    });

    test('incorrect answer resets repetitions to 0', () {
      final afterSeveral = CardProgress(
        cardId: 'card1',
        repetitions: 5,
        easeFactor: 2.5,
        intervalDays: 15,
        lastReviewedAt: DateTime.now().subtract(const Duration(days: 15)),
        nextReviewAt: DateTime.now(),
      );
      final result = SM2Algorithm.calculate(progress: afterSeveral, quality: 1);
      expect(result.repetitions, 0);
      expect(result.intervalDays, 1);
    });

    test('ease factor does not drop below 1.3', () {
      final progress = CardProgress(
        cardId: 'card1',
        repetitions: 3,
        easeFactor: 1.4,
        intervalDays: 8,
        lastReviewedAt: DateTime.now().subtract(const Duration(days: 8)),
        nextReviewAt: DateTime.now(),
      );
      final result = SM2Algorithm.calculate(progress: progress, quality: 0);
      expect(result.easeFactor, greaterThanOrEqualTo(1.3));
    });

    test('boolToQuality maps true to 4 and false to 1', () {
      expect(SM2Algorithm.boolToQuality(true), 4);
      expect(SM2Algorithm.boolToQuality(false), 1);
    });

    test('nextReviewAt is set to today + intervalDays', () {
      final initial = SM2Algorithm.newProgress('card1');
      final result = SM2Algorithm.calculate(progress: initial, quality: 5);
      final today = DateTime.now();
      final expected = DateTime(today.year, today.month, today.day)
          .add(Duration(days: result.intervalDays));
      final actual = result.nextReviewAt!;
      expect(
        DateTime(actual.year, actual.month, actual.day),
        expected,
      );
    });
  });
}
