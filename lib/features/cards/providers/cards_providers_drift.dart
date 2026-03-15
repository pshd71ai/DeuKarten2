import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/word_card.dart';
import '../models/deck.dart';
import '../models/article_card.dart';
import '../models/sentence_card.dart';
import '../models/learning_session.dart';
import '../models/enums.dart';
import '../repositories/cards_repository.dart';
import '../repositories/cards_repository_drift.dart';
import '../repositories/decks_repository.dart';
import '../repositories/decks_repository_drift.dart';
import '../repositories/session_repository.dart';
import '../repositories/session_repository_drift.dart';
import 'package:deu_karten/core/database/database_providers.dart';

part 'cards_providers_drift.g.dart';

// Use the Drift database directly in repository providers
@Riverpod(keepAlive: true)
CardsRepository cardsRepository(CardsRepositoryRef ref) {
  // Wait for database to be initialized
  final dbAsync = ref.watch(databaseProvider);
  
  // Create a proxy repository that will use the database once ready
  // This is a workaround - in production, you'd want to handle the async nature better
  throw UnimplementedError('Use cardsRepositoryDriftProvider for Drift implementation');
}

@Riverpod(keepAlive: true)
Future<CardsRepository> cardsRepositoryDrift(CardsRepositoryDriftRef ref) async {
  final db = await ref.watch(databaseProvider.future);
  return CardsRepositoryDrift(db);
}

@Riverpod(keepAlive: true)
Future<DecksRepository> decksRepositoryDrift(DecksRepositoryDriftRef ref) async {
  final db = await ref.watch(databaseProvider.future);
  return DecksRepositoryDrift(db);
}

@Riverpod(keepAlive: true)
Future<SessionRepository> sessionRepositoryDrift(SessionRepositoryDriftRef ref) async {
  final db = await ref.watch(databaseProvider.future);
  return SessionRepositoryDrift(db);
}

// Future providers for async data using Drift repositories
@Riverpod(keepAlive: true)
Future<List<Deck>> allDecksDrift(AllDecksDriftRef ref) async {
  final repo = await ref.watch(decksRepositoryDriftProvider.future);
  return repo.getAllDecks();
}

@Riverpod(keepAlive: true)
Future<Deck?> deckByIdDrift(DeckByIdDriftRef ref, String id) async {
  final repo = await ref.watch(decksRepositoryDriftProvider.future);
  return repo.getDeckById(id);
}

@Riverpod(keepAlive: true)
Future<List<Deck>> decksByLevelDrift(DecksByLevelDriftRef ref, DifficultyLevel level) async {
  final repo = await ref.watch(decksRepositoryDriftProvider.future);
  return repo.getDecksByLevel(level);
}

@Riverpod(keepAlive: true)
Future<List<Deck>> recentDecksDrift(RecentDecksDriftRef ref) async {
  final repo = await ref.watch(decksRepositoryDriftProvider.future);
  return repo.getRecentDecks(limit: 5);
}

@Riverpod(keepAlive: true)
Future<List<WordCard>> allWordCardsDrift(AllWordCardsDriftRef ref) async {
  final repo = await ref.watch(cardsRepositoryDriftProvider.future);
  return repo.getWordCards();
}

@Riverpod(keepAlive: true)
Future<WordCard?> wordCardByIdDrift(WordCardByIdDriftRef ref, String id) async {
  final repo = await ref.watch(cardsRepositoryDriftProvider.future);
  return repo.getWordCardById(id);
}

@Riverpod(keepAlive: true)
Future<List<WordCard>> wordCardsByLevelDrift(WordCardsByLevelDriftRef ref, DifficultyLevel level) async {
  final repo = await ref.watch(cardsRepositoryDriftProvider.future);
  return repo.getWordCardsByLevel(level);
}

@Riverpod(keepAlive: true)
Future<List<WordCard>> wordCardsByTagDrift(WordCardsByTagDriftRef ref, String tag) async {
  final repo = await ref.watch(cardsRepositoryDriftProvider.future);
  return repo.getWordCardsByTag(tag);
}

@Riverpod(keepAlive: true)
Future<List<ArticleCard>> allArticleCardsDrift(AllArticleCardsDriftRef ref) async {
  final repo = await ref.watch(cardsRepositoryDriftProvider.future);
  return repo.getArticleCards();
}

@Riverpod(keepAlive: true)
Future<List<SentenceCard>> allSentenceCardsDrift(AllSentenceCardsDriftRef ref) async {
  final repo = await ref.watch(cardsRepositoryDriftProvider.future);
  return repo.getSentenceCards();
}

@Riverpod(keepAlive: true)
Future<List<dynamic>> cardsForSessionDrift(CardsForSessionDriftRef ref, String deckId) async {
  final repo = await ref.watch(cardsRepositoryDriftProvider.future);
  return repo.getCardsForSession(deckId);
}

@Riverpod(keepAlive: true)
Future<LearningSession?> currentSessionDrift(CurrentSessionDriftRef ref) async {
  final repo = await ref.watch(sessionRepositoryDriftProvider.future);
  return repo.getCurrentSession();
}

@Riverpod(keepAlive: true)
Future<List<LearningSession>> sessionHistoryDrift(SessionHistoryDriftRef ref) async {
  final repo = await ref.watch(sessionRepositoryDriftProvider.future);
  return repo.getSessionHistory();
}
