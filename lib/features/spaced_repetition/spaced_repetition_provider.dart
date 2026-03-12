import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../cards/models/card_progress.dart';
import '../cards/data/mock_cards.dart';
import '../cards/data/mock_article_cards.dart';
import '../cards/data/mock_sentence_cards.dart';
import '../profile/providers/profile_provider.dart';
import 'spaced_repetition_repository.dart';
import 'sm2_algorithm.dart';

final spacedRepetitionRepositoryProvider =
    Provider<SpacedRepetitionRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SpacedRepetitionRepositoryImpl(prefs);
});

/// All known card IDs across all card types.
final _allCardIdsProvider = Provider<List<String>>((ref) {
  return [
    ...mockWordCards.map((c) => c.id),
    ...mockArticleCards.map((c) => c.id),
    ...mockSentenceCards.map((c) => c.id),
  ];
});

/// Count of cards due for review today.
final dueCardCountProvider = FutureProvider<int>((ref) async {
  final repo = ref.watch(spacedRepetitionRepositoryProvider);
  final allIds = ref.watch(_allCardIdsProvider);
  return repo.getDueCount(allIds);
});

/// List of card IDs that are due for review today.
final dueCardIdsProvider = FutureProvider<List<String>>((ref) async {
  final repo = ref.watch(spacedRepetitionRepositoryProvider);
  final allIds = ref.watch(_allCardIdsProvider);
  return repo.getDueCardIds(allIds);
});

/// Progress for a single card.
final cardProgressProvider =
    FutureProvider.family<CardProgress, String>((ref, cardId) async {
  final repo = ref.watch(spacedRepetitionRepositoryProvider);
  return repo.getProgress(cardId);
});

/// All card progress records.
final allCardProgressProvider =
    FutureProvider<Map<String, CardProgress>>((ref) async {
  final repo = ref.watch(spacedRepetitionRepositoryProvider);
  return repo.getAllProgress();
});

/// Notifier that lets the session layer apply SM-2 reviews and
/// exposes a "due today" counter for the UI.
class SpacedRepetitionNotifier extends StateNotifier<AsyncValue<int>> {
  final SpacedRepetitionRepository _repo;
  final List<String> _allCardIds;
  final Ref _ref;

  SpacedRepetitionNotifier(this._repo, this._allCardIds, this._ref)
      : super(const AsyncValue.loading()) {
    _refreshDueCount();
  }

  Future<void> _refreshDueCount() async {
    try {
      final count = await _repo.getDueCount(_allCardIds);
      state = AsyncValue.data(count);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Applies SM-2 logic for a single card review and refreshes the due count.
  Future<void> recordReview({
    required String cardId,
    required bool wasCorrect,
  }) async {
    await _repo.applyReview(cardId: cardId, wasCorrect: wasCorrect);
    _ref.invalidate(cardProgressProvider(cardId));
    await _refreshDueCount();
    _ref.invalidate(dueCardCountProvider);
    _ref.invalidate(dueCardIdsProvider);
    _ref.invalidate(allCardProgressProvider);
  }

  /// Applies SM-2 for a batch of reviews (after completing a session).
  Future<void> recordBatchReviews(Map<String, bool> reviews) async {
    for (final entry in reviews.entries) {
      await _repo.applyReview(
        cardId: entry.key,
        wasCorrect: entry.value,
      );
    }
    await _refreshDueCount();
    _ref.invalidate(dueCardCountProvider);
    _ref.invalidate(dueCardIdsProvider);
    _ref.invalidate(allCardProgressProvider);
  }
}

final spacedRepetitionNotifierProvider =
    StateNotifierProvider<SpacedRepetitionNotifier, AsyncValue<int>>((ref) {
  final repo = ref.watch(spacedRepetitionRepositoryProvider);
  final allIds = ref.watch(_allCardIdsProvider);
  return SpacedRepetitionNotifier(repo, allIds, ref);
});
