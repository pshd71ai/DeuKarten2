import '../models/word_card.dart';
import '../models/article_card.dart';
import '../models/sentence_card.dart';
import '../models/enums.dart';

abstract class CardsRepository {
  // Word cards
  Future<List<WordCard>> getWordCards();
  Future<WordCard?> getWordCardById(String id);
  Future<List<WordCard>> getWordCardsByLevel(DifficultyLevel level);
  Future<List<WordCard>> getWordCardsByTag(String tag);

  // Article cards
  Future<List<ArticleCard>> getArticleCards();
  Future<ArticleCard?> getArticleCardById(String id);

  // Sentence cards
  Future<List<SentenceCard>> getSentenceCards();
  Future<SentenceCard?> getSentenceCardById(String id);

  // Mixed - get cards for session
  // [dueCardIds] optional list of card IDs already filtered by spaced repetition
  Future<List<dynamic>> getCardsForSession(
    String deckId, {
    int? limit,
    List<String>? dueCardIds,
  });

  // Update card progress (spaced repetition)
  Future<void> updateCardProgress(String cardId, bool wasCorrect);
}

class CardsRepositoryImpl implements CardsRepository {
  List<WordCard> _wordCards = [];
  List<ArticleCard> _articleCards = [];
  List<SentenceCard> _sentenceCards = [];

  void setMockData({
    required List<WordCard> wordCards,
    required List<ArticleCard> articleCards,
    required List<SentenceCard> sentenceCards,
  }) {
    _wordCards = wordCards;
    _articleCards = articleCards;
    _sentenceCards = sentenceCards;
  }

  @override
  Future<List<WordCard>> getWordCards() async {
    return _wordCards;
  }

  @override
  Future<WordCard?> getWordCardById(String id) async {
    try {
      return _wordCards.firstWhere((card) => card.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<WordCard>> getWordCardsByLevel(DifficultyLevel level) async {
    return _wordCards.where((card) => card.level == level).toList();
  }

  @override
  Future<List<WordCard>> getWordCardsByTag(String tag) async {
    return _wordCards.where((card) => card.tags.contains(tag)).toList();
  }

  @override
  Future<List<ArticleCard>> getArticleCards() async {
    return _articleCards;
  }

  @override
  Future<ArticleCard?> getArticleCardById(String id) async {
    try {
      return _articleCards.firstWhere((card) => card.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<SentenceCard>> getSentenceCards() async {
    return _sentenceCards;
  }

  @override
  Future<SentenceCard?> getSentenceCardById(String id) async {
    try {
      return _sentenceCards.firstWhere((card) => card.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<dynamic>> getCardsForSession(
    String deckId, {
    int? limit,
    List<String>? dueCardIds,
  }) async {
    List<dynamic> allCards = <dynamic>[
      ..._wordCards,
      ..._articleCards,
      ..._sentenceCards,
    ];

    if (dueCardIds != null && dueCardIds.isNotEmpty) {
      final dueSet = dueCardIds.toSet();
      final dueCards =
          allCards.where((c) => dueSet.contains(c.id as String)).toList();
      // If no cards are due, fall back to the full list so the session isn't empty
      if (dueCards.isNotEmpty) {
        allCards = dueCards;
      }
    }

    if (limit != null && limit > 0) {
      return allCards.take(limit).toList();
    }

    return allCards;
  }

  @override
  Future<void> updateCardProgress(String cardId, bool wasCorrect) async {
    // Find the card and update its progress
    final wordCardIndex = _wordCards.indexWhere((card) => card.id == cardId);
    if (wordCardIndex != -1) {
      final card = _wordCards[wordCardIndex];
      _wordCards[wordCardIndex] = card.copyWith(
        repetitionCount: card.repetitionCount + 1,
        lastReviewed: DateTime.now(),
      );
      return;
    }

    // Note: Article and Sentence cards don't have repetition tracking in the current model
    // This would be extended in a real implementation
  }
}
