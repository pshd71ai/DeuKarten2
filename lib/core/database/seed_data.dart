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
      return;
    }

    await seedWordCards();
    await seedArticleCards();
    await seedSentenceCards();
    await seedDecks();
  }

  Future<void> seedWordCards() async {
    for (final card in mockWordCards) {
      await _db.into(_db.wordCards).insert(wordCardToData(card));
    }
  }

  Future<void> seedArticleCards() async {
    for (final card in mockArticleCards) {
      await _db.into(_db.articleCards).insert(articleCardToData(card));
    }
  }

  Future<void> seedSentenceCards() async {
    for (final card in mockSentenceCards) {
      await _db.into(_db.sentenceCards).insert(sentenceCardToData(card));
    }
  }

  Future<void> seedDecks() async {
    for (final deck in mockDecks) {
      await _db.into(_db.decks).insert(deckToData(deck));
    }
  }

  // Reset all data (for testing purposes)
  Future<void> clearAll() async {
    await _db.delete(_db.learningSessions).go();
    await _db.delete(_db.decks).go();
    await _db.delete(_db.sentenceCards).go();
    await _db.delete(_db.articleCards).go();
    await _db.delete(_db.wordCards).go();
    await _db.delete(_db.testSessions).go();
    await _db.delete(_db.tests).go();
    await _db.delete(_db.statistics).go();
    await _db.delete(_db.streakData).go();
    await _db.delete(_db.xpHistory).go();
    await _db.delete(_db.userProfiles).go();
  }

  // Re-seed all data
  Future<void> reseed() async {
    await clearAll();
    await seedAll();
  }
}