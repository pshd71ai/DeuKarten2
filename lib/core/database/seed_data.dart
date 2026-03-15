import 'package:deu_karten/core/database/converters.dart';
import 'package:deu_karten/core/database/drift_database.dart';
import 'package:deu_karten/features/cards/data/mock_cards.dart';
import 'package:deu_karten/features/cards/data/mock_article_cards.dart';
import 'package:deu_karten/features/cards/data/mock_sentence_cards.dart';
import 'package:deu_karten/features/cards/data/mock_decks.dart';

class DatabaseSeeder {
  final AppDatabase _db;

  DatabaseSeeder(this._db);

  Future<void> seedAll() async {
    // Check if data already exists
    final existingDecks = await _db.getAllDecks();
    if (existingDecks.isNotEmpty) {
      // Database already seeded
      return;
    }

    await seedWordCards();
    await seedArticleCards();
    await seedSentenceCards();
    await seedDecks();
  }

  Future<void> seedWordCards() async {
    for (final card in mockWordCards) {
      await _db.into(wordCards).insert(wordCardToData(card));
    }
  }

  Future<void> seedArticleCards() async {
    for (final card in mockArticleCards) {
      await _db.into(articleCards).insert(articleCardToData(card));
    }
  }

  Future<void> seedSentenceCards() async {
    for (final card in mockSentenceCards) {
      await _db.into(sentenceCards).insert(sentenceCardToData(card));
    }
  }

  Future<void> seedDecks() async {
    for (final deck in mockDecks) {
      await _db.into(decks).insert(deckToData(deck));
    }
  }

  // Reset all data (for testing purposes)
  Future<void> clearAll() async {
    await _db.delete(learningSessions).go();
    await _db.delete(decks).go();
    await _db.delete(sentenceCards).go();
    await _db.delete(articleCards).go();
    await _db.delete(wordCards).go();
    await _db.delete(testSessions).go();
    await _db.delete(tests).go();
    await _db.delete(statistics).go();
    await _db.delete(streakData).go();
    await _db.delete(xpHistory).go();
    await _db.delete(userProfiles).go();
  }

  // Re-seed all data
  Future<void> reseed() async {
    await clearAll();
    await seedAll();
  }
}
