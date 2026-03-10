import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/word_card.dart';
import '../models/deck.dart';
import '../models/article_card.dart';
import '../models/sentence_card.dart';
import '../models/learning_session.dart';
import '../models/enums.dart';
import '../repositories/cards_repository.dart';
import '../repositories/decks_repository.dart';
import '../repositories/session_repository.dart';
import '../data/mock_cards.dart';
import '../data/mock_decks.dart';
import '../data/mock_article_cards.dart';
import '../data/mock_sentence_cards.dart';

// Cards Repository Provider
final cardsRepositoryProvider = Provider<CardsRepository>((ref) {
  final repository = CardsRepositoryImpl();
  repository.setMockData(
    wordCards: mockWordCards,
    articleCards: mockArticleCards,
    sentenceCards: mockSentenceCards,
  );
  return repository;
});

// Decks Repository Provider
final decksRepositoryProvider = Provider<DecksRepository>((ref) {
  final repository = DecksRepositoryImpl();
  repository.setMockData(mockDecks);
  return repository;
});

// Session Repository Provider
final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepositoryImpl();
});

// Future providers for async data
final allDecksProvider = FutureProvider<List<Deck>>((ref) async {
  final repo = ref.watch(decksRepositoryProvider);
  return repo.getAllDecks();
});

final deckByIdProvider = FutureProvider.family<Deck?, String>((ref, id) async {
  final repo = ref.watch(decksRepositoryProvider);
  return repo.getDeckById(id);
});

final decksByLevelProvider = FutureProvider.family<List<Deck>, DifficultyLevel>((ref, level) async {
  final repo = ref.watch(decksRepositoryProvider);
  return repo.getDecksByLevel(level);
});

final recentDecksProvider = FutureProvider<List<Deck>>((ref) async {
  final repo = ref.watch(decksRepositoryProvider);
  return repo.getRecentDecks(limit: 5);
});

final allWordCardsProvider = FutureProvider<List<WordCard>>((ref) async {
  final repo = ref.watch(cardsRepositoryProvider);
  return repo.getWordCards();
});

final wordCardByIdProvider = FutureProvider.family<WordCard?, String>((ref, id) async {
  final repo = ref.watch(cardsRepositoryProvider);
  return repo.getWordCardById(id);
});

final wordCardsByLevelProvider = FutureProvider.family<List<WordCard>, DifficultyLevel>((ref, level) async {
  final repo = ref.watch(cardsRepositoryProvider);
  return repo.getWordCardsByLevel(level);
});

final wordCardsByTagProvider = FutureProvider.family<List<WordCard>, String>((ref, tag) async {
  final repo = ref.watch(cardsRepositoryProvider);
  return repo.getWordCardsByTag(tag);
});

final allArticleCardsProvider = FutureProvider<List<ArticleCard>>((ref) async {
  final repo = ref.watch(cardsRepositoryProvider);
  return repo.getArticleCards();
});

final allSentenceCardsProvider = FutureProvider<List<SentenceCard>>((ref) async {
  final repo = ref.watch(cardsRepositoryProvider);
  return repo.getSentenceCards();
});

final cardsForSessionProvider = FutureProvider.family<List<dynamic>, String>((ref, deckId) async {
  final repo = ref.watch(cardsRepositoryProvider);
  return repo.getCardsForSession(deckId);
});

final currentSessionDataProvider = FutureProvider<LearningSession?>((ref) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.getCurrentSession();
});

final sessionHistoryProvider = FutureProvider<List<LearningSession>>((ref) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.getSessionHistory();
});
