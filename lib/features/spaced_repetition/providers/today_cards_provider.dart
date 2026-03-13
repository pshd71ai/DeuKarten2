import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../profile/providers/profile_provider.dart';
import '../models/card_progress.dart';
import '../models/study_schedule.dart';
import '../repositories/progress_repository.dart';
import '../services/spaced_repetition_service.dart';

part 'today_cards_provider.freezed.dart';
part 'today_cards_provider.g.dart';

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ProgressRepositoryImpl(prefs);
});

final srsServiceProvider = Provider<SpacedRepetitionService>((ref) {
  return SpacedRepetitionService();
});

final todayCardsProvider = FutureProvider<TodayCardsState>((ref) async {
  final progressRepo = ref.watch(progressRepositoryProvider);
  final userPrefs = ref.watch(userProfileProvider);
  final srsService = ref.watch(srsServiceProvider);
  
  final allProgress = await progressRepo.getAllProgress();
  final today = DateTime.now();
  
  // Get user's daily goal
  final dailyGoal = userPrefs.valueOrNull?.learningPrefs.dailyGoal ?? 20;
  
  // Calculate due cards
  final dueCards = srsService.getDueCards(
    allProgress,
    today,
    maxNewCards: dailyGoal,
    maxReviews: 100,
  );
  
  // Categorize cards
  final newCards = <String>[];
  final reviewCards = <String>[];
  final learningCards = <String>[];
  
  for (final cardId in dueCards) {
    final progress = allProgress[cardId];
    if (progress == null) {
      newCards.add(cardId);
    } else {
      switch (progress.status) {
        case SRSStatus.newCard:
          newCards.add(cardId);
        case SRSStatus.learning:
          learningCards.add(cardId);
        case SRSStatus.review:
        case SRSStatus.mastered:
          reviewCards.add(cardId);
        case SRSStatus.suspended:
          break;
      }
    }
  }
  
  // Calculate forecast
  final forecast = srsService.getReviewForecast(allProgress, 7);
  
  return TodayCardsState(
    newCards: newCards,
    reviewCards: reviewCards,
    learningCards: learningCards,
    totalDue: dueCards.length,
    forecast: forecast,
  );
});

@riverpod
class CardProgressNotifier extends _$CardProgressNotifier {
  @override
  Future<CardProgress?> build(String cardId) async {
    final repo = ref.watch(progressRepositoryProvider);
    return repo.getCardProgress(cardId);
  }
  
  Future<void> updateProgress(CardProgress progress) async {
    final repo = ref.read(progressRepositoryProvider);
    await repo.saveCardProgress(progress);
    state = AsyncData(progress);
  }
}

@freezed
class TodayCardsState with _$TodayCardsState {
  const factory TodayCardsState({
    required List<String> newCards,
    required List<String> reviewCards,
    required List<String> learningCards,
    required int totalDue,
    required Map<DateTime, int> forecast,
  }) = _TodayCardsState;
}
