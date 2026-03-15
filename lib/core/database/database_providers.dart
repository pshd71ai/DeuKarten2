import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'drift_database.dart';

part 'database_providers.g.dart';

// Provider for the database instance
@Riverpod(keepAlive: true)
Future<AppDatabase> database(DatabaseRef ref) async {
  await AppDatabase.initialize();
  return AppDatabase.instance;
}

// Provider for database access (non-async, assumes initialized)
@Riverpod(keepAlive: true)
AppDatabase db(DbRef ref) {
  // Watch the async provider to ensure it's initialized
  final asyncValue = ref.watch(databaseProvider);
  return asyncValue.value ?? (throw Exception('Database not initialized'));
}

// Convenience providers for common database operations
@Riverpod(keepAlive: true)
Future<List<WordCardData>> allWordCards(AllWordCardsRef ref) async {
  final db = await ref.watch(databaseProvider.future);
  return db.getAllWordCards();
}

@Riverpod(keepAlive: true)
Future<List<ArticleCardData>> allArticleCards(AllArticleCardsRef ref) async {
  final db = await ref.watch(databaseProvider.future);
  return db.getAllArticleCards();
}

@Riverpod(keepAlive: true)
Future<List<SentenceCardData>> allSentenceCards(AllSentenceCardsRef ref) async {
  final db = await ref.watch(databaseProvider.future);
  return db.getAllSentenceCards();
}

@Riverpod(keepAlive: true)
Future<List<DeckData>> allDecks(AllDecksRef ref) async {
  final db = await ref.watch(databaseProvider.future);
  return db.getAllDecks();
}

@Riverpod(keepAlive: true)
Future<LearningSessionData?> currentSession(CurrentSessionRef ref) async {
  final db = await ref.watch(databaseProvider.future);
  return db.getCurrentSession();
}

@Riverpod(keepAlive: true)
Future<List<LearningSessionData>> sessionHistory(SessionHistoryRef ref) async {
  final db = await ref.watch(databaseProvider.future);
  return db.getSessionHistory();
}
