import '../models/deck.dart';
import '../models/enums.dart';

abstract class DecksRepository {
  Future<List<Deck>> getAllDecks();
  Future<Deck?> getDeckById(String id);
  Future<List<Deck>> getDecksByLevel(DifficultyLevel level);
  Future<List<Deck>> getRecentDecks({int limit = 5});
  Future<void> updateDeckProgress(String deckId, double progress);
}

class DecksRepositoryImpl implements DecksRepository {
  List<Deck> _decks = [];

  void setMockData(List<Deck> decks) {
    _decks = decks;
  }

  @override
  Future<List<Deck>> getAllDecks() async {
    return _decks;
  }

  @override
  Future<Deck?> getDeckById(String id) async {
    try {
      return _decks.firstWhere((deck) => deck.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Deck>> getDecksByLevel(DifficultyLevel level) async {
    return _decks.where((deck) => deck.level == level).toList();
  }

  @override
  Future<List<Deck>> getRecentDecks({int limit = 5}) async {
    final sortedDecks = List<Deck>.from(_decks)
      ..sort((a, b) {
        final lastStudiedA = a.lastStudied ?? DateTime(0);
        final lastStudiedB = b.lastStudied ?? DateTime(0);
        return lastStudiedB.compareTo(lastStudiedA);
      });
    return sortedDecks.take(limit).toList();
  }

  @override
  Future<void> updateDeckProgress(String deckId, double progress) async {
    final index = _decks.indexWhere((deck) => deck.id == deckId);
    if (index != -1) {
      _decks[index] = _decks[index].copyWith(
        progress: progress.clamp(0.0, 1.0),
        lastStudied: DateTime.now(),
      );
    }
  }
}
