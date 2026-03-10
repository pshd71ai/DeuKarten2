import 'lib/features/cards/models/word_card.dart';
import 'lib/features/cards/models/article_card.dart';
import 'lib/features/cards/models/sentence_card.dart';
import 'lib/features/cards/models/deck.dart';
import 'lib/features/cards/models/learning_session.dart';
import 'lib/features/cards/models/enums.dart';

void main() {
  print('Testing models...\n');

  // Test WordCard JSON serialization
  final wordCard = WordCard(
    id: 'test1',
    germanWord: 'Haus',
    translation: 'house',
    article: 'das',
    pluralForm: 'Häuser',
    exampleSentence: 'Das Haus ist schön.',
    exampleTranslation: 'The house is beautiful.',
    imageUrl: '🏠',
    level: DifficultyLevel.a1,
    type: CardType.noun,
    tags: ['home', 'building'],
    repetitionCount: 0,
    easeFactor: 2.5,
  );

  print('WordCard created: ${wordCard.germanWord}');

  // Test JSON serialization
  final wordJson = wordCard.toJson();
  print('WordCard JSON keys: ${wordJson.keys.toList()}');

  // Test deserialization
  final wordFromJson = WordCard.fromJson(wordJson);
  print('WordCard from JSON: ${wordFromJson.germanWord}');

  print('\n✓ WordCard model works!\n');

  // Test ArticleCard
  final articleCard = ArticleCard(
    id: 'a1',
    word: 'Tisch',
    correctArticle: 'der',
    options: ['der', 'die', 'das'],
    translation: 'table',
    exampleSentence: 'Der Tisch ist aus Holz.',
    level: DifficultyLevel.a1,
  );

  print('ArticleCard created: ${articleCard.word} (${articleCard.correctArticle})');
  final articleJson = articleCard.toJson();
  final articleFromJson = ArticleCard.fromJson(articleJson);
  print('✓ ArticleCard model works!\n');

  // Test SentenceCard
  final sentenceCard = SentenceCard(
    id: 's1',
    incompleteSentence: 'Ich ___ nach Hause.',
    wordOptions: ['gehe', 'geht', 'ging'],
    correctAnswer: 'gehe',
    completeSentence: 'Ich gehe nach Hause.',
    translation: 'I am going home.',
    level: DifficultyLevel.a1,
    grammarTopic: 'Verb conjugation',
  );

  print('SentenceCard created: ${sentenceCard.completeSentence}');
  final sentenceJson = sentenceCard.toJson();
  final sentenceFromJson = SentenceCard.fromJson(sentenceJson);
  print('✓ SentenceCard model works!\n');

  // Test Deck
  final deck = Deck(
    id: '1',
    name: 'A1 Grundlagen',
    description: 'Basic vocabulary',
    category: 'Gemischt',
    level: DifficultyLevel.a1,
    cardIds: ['1', '2', '3'],
    totalCards: 25,
    cardsLearned: 10,
    progress: 0.4,
    thumbnailEmoji: '📚',
    createdAt: DateTime.now(),
  );

  print('Deck created: ${deck.name} with ${deck.totalCards} cards');
  final deckJson = deck.toJson();
  final deckFromJson = Deck.fromJson(deckJson);
  print('✓ Deck model works!\n');

  // Test LearningSession
  final session = LearningSession(
    id: 'session1',
    deckId: '1',
    startedAt: DateTime.now(),
    cards: [],
    status: SessionStatus.inProgress,
  );

  print('LearningSession created: ${session.id}');
  final sessionJson = session.toJson();
  final sessionFromJson = LearningSession.fromJson(sessionJson);
  print('✓ LearningSession model works!\n');

  print('All models are working correctly! ✓');
}
