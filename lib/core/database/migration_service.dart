import 'package:deu_karten/core/database/converters.dart';
import 'package:deu_karten/core/database/drift_database.dart';
import 'package:deu_karten/features/cards/models/deck.dart';
import 'package:deu_karten/features/cards/models/enums.dart';
import 'package:deu_karten/features/cards/repositories/decks_repository.dart';

class DecksRepositoryDrift implements DecksRepository {
  final AppDatabase _db;

  DecksRepositoryDrift(this._db);

  @override
  Future<List<Deck>> getAllDecks() async {
    final data = await _db.getAllDecks();
    return data.map(deckFromData).toList();
  }

  @override
  Future<Deck?> getDeckById(String id) async {
    final data = await _db.getDeckById(id);
    return data != null ? deckFromData(data) : null;
  }

  @override
  Future<List<Deck>> getDecksByLevel(DifficultyLevel level) async {
    final data = await _db.getDecksByLevel(difficultyLevelToString(level));
    return data.map(deckFromData).toList();
  }

  @override
  Future<List<Deck>> getRecentDecks({int limit = 5}) async {
    final data = await _db.getRecentDecks(limit: limit);
    return data.map(deckFromData).toList();
  }

  @override
  Future<void> updateDeckProgress(String deckId, double progress) async {
    final deckData = await _db.getDeckById(deckId);
    if (deckData != null) {
      final deck = deckFromData(deckData);
      await _db.update(_db.decks).replace(
        deckToData(
          deck.copyWith(
            progress: progress,
            lastStudied: DateTime.now(),
          ),
        ),
      );
    }
  }
}