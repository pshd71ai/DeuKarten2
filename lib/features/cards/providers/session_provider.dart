import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../spaced_repetition/models/card_progress.dart';
import '../../spaced_repetition/models/study_schedule.dart';
import '../../spaced_repetition/providers/today_cards_provider.dart';
import '../../spaced_repetition/services/spaced_repetition_service.dart';
import '../models/learning_session.dart';
import '../models/enums.dart';
import '../repositories/session_repository.dart';
import '../../spaced_repetition/spaced_repetition_provider.dart';
import 'cards_providers.dart';

part 'session_provider.g.dart';

@riverpod
class CurrentSession extends _$CurrentSession {
  @override
  Future<LearningSession?> build() async {
    final repo = ref.read(sessionRepositoryProvider);
    return repo.getCurrentSession();
  }

  Future<void> startSession(String deckId) async {
    state = const AsyncLoading();

    final repo = ref.read(sessionRepositoryProvider);
    final cardsRepo = ref.read(cardsRepositoryProvider);
    final srRepo = ref.read(spacedRepetitionRepositoryProvider);

    // Retrieve card IDs that are due for review today via SM-2
    final allIds = [
      ...await cardsRepo.getWordCards().then((l) => l.map((c) => c.id)),
      ...await cardsRepo.getArticleCards().then((l) => l.map((c) => c.id)),
      ...await cardsRepo.getSentenceCards().then((l) => l.map((c) => c.id)),
    ];
    final dueIds = await srRepo.getDueCardIds(allIds);

    // Load cards filtered by SM-2 due list (fallback to full set if nothing is due)
    final cardsData = await cardsRepo.getCardsForSession(
      deckId,
      limit: 20,
      dueCardIds: dueIds.isNotEmpty ? dueIds : null,
    );

    final sessionCards = cardsData.map((card) {
      return SessionCard(
        cardId: card.id as String,
        type: _getCardType(card),
        status: CardStatus.new_card,
      );
    }).toList();

    final session = await repo.createSession(deckId);
    final sessionWithCards = session.copyWith(cards: sessionCards);

    await repo.saveSessionProgress(sessionWithCards);
    state = AsyncData(sessionWithCards);
  }

  Future<void> answerCard(String cardId, bool knewIt, Difficulty difficulty) async {
    final srsService = ref.read(srsServiceProvider);
    final progressRepo = ref.read(progressRepositoryProvider);
    
    // Get current progress
    var progress = await progressRepo.getCardProgress(cardId);
    if (progress == null) {
      progress = CardProgress(
        cardId: cardId,
        createdAt: DateTime.now(),
      );
    }
    
    // Calculate quality rating
    final quality = srsService.getQualityRating(knewIt, difficulty);
    
    // Calculate next review
    final updatedProgress = srsService.calculateNextReview(progress, quality);
    
    // Save progress
    await progressRepo.saveCardProgress(updatedProgress);
    
    // Update session stats
    state.whenData((session) {
      if (session == null) return;
      
      final updatedCards = session.cards.map((card) {
        if (card.cardId == cardId) {
          return card.copyWith(
            wasCorrect: knewIt,
            answeredAt: DateTime.now(),
          );
        }
        return card;
      }).toList();
      
      final cardsStudied = (session.cardsStudied ?? 0) + 1;
      final correctAnswers = knewIt
          ? (session.correctAnswers ?? 0) + 1
          : (session.correctAnswers ?? 0);
      
      // Calculate XP: 10 XP per correct answer
      final xpEarned = correctAnswers * 10;
      
      final updatedSession = session.copyWith(
        cards: updatedCards,
        cardsStudied: cardsStudied,
        correctAnswers: correctAnswers,
        xpEarned: xpEarned,
      );
      
      // Save progress asynchronously
      ref.read(sessionRepositoryProvider).saveSessionProgress(updatedSession);
      
      state = AsyncData(updatedSession);
    });
    
    // Update daily stats
    await _updateDailyStats(knewIt, quality);
  }

  Future<void> _updateDailyStats(bool isCorrect, int quality) async {
    final repo = ref.read(progressRepositoryProvider);
    final today = DateTime.now();
    
    var stats = await repo.getDailyStats(today);
    if (stats == null) {
      stats = DailyStats(
        date: today,
        newCardsStudied: 0,
        reviewsCompleted: 0,
        cardsLearned: 0,
        xpEarned: 0,
        averageQuality: 0,
      );
    }
    
    // Calculate running average of quality
    final totalReviews = stats.reviewsCompleted + 1;
    final newAvgQuality = ((stats.averageQuality * stats.reviewsCompleted) + quality) / totalReviews;
    
    await repo.saveDailyStats(stats.copyWith(
      reviewsCompleted: totalReviews,
      cardsLearned: isCorrect ? stats.cardsLearned + 1 : stats.cardsLearned,
      averageQuality: newAvgQuality,
    ));
  }

  Future<void> completeSession() async {
    final session = state.value;
    if (session == null) return;

    final repo = ref.read(sessionRepositoryProvider);
    await repo.completeSession(session.id);

    // Apply SM-2 for every answered card in the session
    final srNotifier = ref.read(spacedRepetitionNotifierProvider.notifier);
    final reviews = <String, bool>{};
    for (final card in session.cards) {
      if (card.wasCorrect != null) {
        reviews[card.cardId] = card.wasCorrect!;
      }
    }
    if (reviews.isNotEmpty) {
      await srNotifier.recordBatchReviews(reviews);
    }

    state = const AsyncData(null);
  }

  void resetSession() {
    state = const AsyncData(null);
  }

  CardType _getCardType(dynamic card) {
    if (card.runtimeType.toString().contains('WordCard')) {
      return CardType.noun;
    } else if (card.runtimeType.toString().contains('ArticleCard')) {
      return CardType.article;
    } else if (card.runtimeType.toString().contains('SentenceCard')) {
      return CardType.sentence;
    }
    return CardType.noun;
  }
}

// Current card index provider
final currentCardIndexProvider = StateProvider<int>((ref) => 0);

// Provider to get the current card data with full details
final currentCardDataProvider =
    FutureProvider.family<CardData?, String>((ref, cardId) async {
  final cardsRepo = ref.watch(cardsRepositoryProvider);

  final wordCard = await cardsRepo.getWordCardById(cardId);
  if (wordCard != null) {
    return CardData(
      id: wordCard.id,
      type: CardType.noun,
      germanWord: wordCard.germanWord,
      translation: wordCard.translation,
      article: wordCard.article,
      pluralForm: wordCard.pluralForm,
      exampleSentence: wordCard.exampleSentence,
      exampleTranslation: wordCard.exampleTranslation,
      imageUrl: wordCard.imageUrl,
    );
  }

  final articleCard = await cardsRepo.getArticleCardById(cardId);
  if (articleCard != null) {
    return CardData(
      id: articleCard.id,
      type: CardType.article,
      germanWord: articleCard.word,
      translation: articleCard.translation,
      article: articleCard.correctArticle,
      exampleSentence: articleCard.exampleSentence,
      articleOptions: articleCard.options,
    );
  }

  final sentenceCard = await cardsRepo.getSentenceCardById(cardId);
  if (sentenceCard != null) {
    return CardData(
      id: sentenceCard.id,
      type: CardType.sentence,
      incompleteSentence: sentenceCard.incompleteSentence,
      completeSentence: sentenceCard.completeSentence,
      translation: sentenceCard.translation,
      wordOptions: sentenceCard.wordOptions,
      grammarTopic: sentenceCard.grammarTopic,
    );
  }

  return null;
});

// Data class to hold card information for the session
class CardData {
  final String id;
  final CardType type;
  final String? germanWord;
  final String translation;
  final String? article;
  final String? pluralForm;
  final String? exampleSentence;
  final String? exampleTranslation;
  final String? imageUrl;
  final String? incompleteSentence;
  final String? completeSentence;
  final List<String>? wordOptions;
  final List<String>? articleOptions;
  final String? grammarTopic;

  CardData({
    required this.id,
    required this.type,
    this.germanWord,
    required this.translation,
    this.article,
    this.pluralForm,
    this.exampleSentence,
    this.exampleTranslation,
    this.imageUrl,
    this.incompleteSentence,
    this.completeSentence,
    this.wordOptions,
    this.articleOptions,
    this.grammarTopic,
  });
}
