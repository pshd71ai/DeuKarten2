import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_database.g.dart';

// Word Cards Table
@DataClassName('WordCardData')
class WordCards extends Table {
  TextColumn get id => text()();
  TextColumn get germanWord => text()();
  TextColumn get translation => text()();
  TextColumn get article => text()();
  TextColumn get pluralForm => text()();
  TextColumn get exampleSentence => text().nullable()();
  TextColumn get exampleTranslation => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get level => text()(); // Stored as string for DifficultyLevel enum
  TextColumn get type => text()(); // Stored as string for CardType enum
  TextColumn get tags => text()(); // Stored as JSON string
  TextColumn get deckId => text().references(Decks, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get lastReviewed => dateTime().nullable()();
  DateTimeColumn get nextReview => dateTime().nullable()();
  IntColumn get intervalDays => integer().nullable()();
  IntColumn get repetitionCount => integer().withDefault(const Constant(0))();
  RealColumn get easeFactor => real().withDefault(const Constant(2.5))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [{deckId}];

  @override
  Set<Column>? get indices => {deckId};
}

// Article Cards Table
@DataClassName('ArticleCardData')
class ArticleCards extends Table {
  TextColumn get id => text()();
  TextColumn get word => text()();
  TextColumn get correctArticle => text()();
  TextColumn get options => text()(); // Stored as JSON string
  TextColumn get translation => text()();
  TextColumn get exampleSentence => text()();
  TextColumn get level => text()();
  TextColumn get wordCardId => text().references(WordCards, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  Set<Column>? get indices => {wordCardId};
}

// Sentence Cards Table
@DataClassName('SentenceCardData')
class SentenceCards extends Table {
  TextColumn get id => text()();
  TextColumn get incompleteSentence => text()();
  TextColumn get wordOptions => text()(); // Stored as JSON string
  TextColumn get correctAnswer => text()();
  TextColumn get completeSentence => text()();
  TextColumn get translation => text()();
  TextColumn get level => text()();
  TextColumn get grammarTopic => text()();
  TextColumn get deckId => text().references(Decks, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  Set<Column>? get indices => {deckId};
}

// Decks Table
@DataClassName('DeckData')
class Decks extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get category => text()();
  TextColumn get level => text()();
  TextColumn get cardIds => text()(); // Stored as JSON string
  IntColumn get totalCards => integer()();
  IntColumn get cardsLearned => integer().withDefault(const Constant(0))();
  RealColumn get progress => real().withDefault(const Constant(0.0))();
  TextColumn get thumbnailEmoji => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastStudied => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Learning Sessions Table
@DataClassName('LearningSessionData')
class LearningSessions extends Table {
  TextColumn get id => text()();
  TextColumn get deckId => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get cards => text()(); // Stored as JSON string of SessionCard
  IntColumn get cardsStudied => integer().withDefault(const Constant(0))();
  IntColumn get correctAnswers => integer().withDefault(const Constant(0))();
  IntColumn get xpEarned => integer().withDefault(const Constant(0))();
  TextColumn get status => text()(); // Stored as string for SessionStatus enum

  @override
  Set<Column> get primaryKey => {id};
}

// User Profile Table
@DataClassName('UserProfileData')
class UserProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  DateTimeColumn get joinedDate => dateTime()();
  TextColumn get settings => text()(); // Stored as JSON string
  TextColumn get learningPrefs => text()(); // Stored as JSON string

  @override
  Set<Column> get primaryKey => {id};
}

// XP History Table
@DataClassName('XpHistoryEntryData')
class XpHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer()();
  TextColumn get source => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get description => text().nullable()();
}

// Streak Data Table
@DataClassName('StreakDataData')
class StreakData extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get currentStreak => integer()();
  IntColumn get longestStreak => integer()();
  DateTimeColumn get lastStudyDate => dateTime()();
  BoolColumn get studiedToday => boolean()();
  TextColumn get studyDates => text()(); // Stored as JSON string
  TextColumn get lastMilestone => text().nullable()(); // Stored as string for StreakMilestone enum
}

// Tests Table
@DataClassName('TestData')
class Tests extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get questions => text()(); // Stored as JSON string
  IntColumn get duration => integer()();
  TextColumn get category => text()();
  IntColumn get minPassingScore => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Test Sessions Table
@DataClassName('TestSessionData')
class TestSessions extends Table {
  TextColumn get id => text()();
  TextColumn get testId => text()();
  TextColumn get userAnswers => text()(); // Stored as JSON string
  IntColumn get currentQuestionIndex => integer()();
  DateTimeColumn get startTime => dateTime().nullable()();
  IntColumn get timeLeft => integer().nullable()();
  IntColumn get timeElapsed => integer().nullable()();
  BoolColumn get isComplete => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get score => integer().nullable()();
  BoolColumn get isPassed => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Statistics Table
@DataClassName('StatisticsData')
class Statistics extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get cardsLearned => integer().withDefault(const Constant(0))();
  IntColumn get cardsReviewed => integer().withDefault(const Constant(0))();
  IntColumn get testsTaken => integer().withDefault(const Constant(0))();
  RealColumn get averageScore => real().withDefault(const Constant(0.0))();
  IntColumn get studyTimeMinutes => integer().withDefault(const Constant(0))();
  IntColumn get xpEarned => integer().withDefault(const Constant(0))();
  IntColumn get retentionCards => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

// Main Database Class
@DriftDatabase(tables: [
  WordCards,
  ArticleCards,
  SentenceCards,
  Decks,
  LearningSessions,
  UserProfiles,
  XpHistory,
  StreakData,
  Tests,
  TestSessions,
  Statistics,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1 && to == 2) {
          // Add deckId to WordCards
          await m.addColumn(wordCards, wordCards.deckId);
          
          // Add wordCardId to ArticleCards
          await m.addColumn(articleCards, articleCards.wordCardId);
          
          // Add deckId to SentenceCards
          await m.addColumn(sentenceCards, sentenceCards.deckId);
        }
      },
    );
  }

  // Database initialization
  static AppDatabase? _instance;

  static AppDatabase get instance {
    if (_instance != null) return _instance!;
    throw Exception('Database not initialized. Call initialize() first.');
  }

  static Future<void> initialize() async {
    if (_instance != null) return;

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'deu_karten.db'));

    print('DB FILE PATH: ${file.path}');
    print('DB EXISTS BEFORE OPEN: ${await file.exists()}');

    _instance = AppDatabase(NativeDatabase.createInBackground(file));

    // Форсуємо реальне відкриття/створення
    await _instance!.customSelect('SELECT 1').get();

    print('DB EXISTS AFTER OPEN: ${await file.exists()}');
    print('DB INITIALIZED');
  }

  // Convenience methods for common operations

  // Word Cards
  Future<List<WordCardData>> getAllWordCards() {
    return select(wordCards).get();
  }

  Future<WordCardData?> getWordCardById(String id) {
    final query = select(wordCards)..where((tbl) => tbl.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<List<WordCardData>> getWordCardsByLevel(String level) {
    final query = select(wordCards)..where((tbl) => tbl.level.equals(level));
    return query.get();
  }

  // Article Cards
  Future<List<ArticleCardData>> getAllArticleCards() {
    return select(articleCards).get();
  }

  Future<ArticleCardData?> getArticleCardById(String id) {
    final query = select(articleCards)..where((tbl) => tbl.id.equals(id));
    return query.getSingleOrNull();
  }

  // Sentence Cards
  Future<List<SentenceCardData>> getAllSentenceCards() {
    return select(sentenceCards).get();
  }

  Future<SentenceCardData?> getSentenceCardById(String id) {
    final query = select(sentenceCards)..where((tbl) => tbl.id.equals(id));
    return query.getSingleOrNull();
  }

  // Decks
  Future<List<DeckData>> getAllDecks() {
    return select(decks).get();
  }

  Future<DeckData?> getDeckById(String id) {
    final query = select(decks)..where((tbl) => tbl.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<List<DeckData>> getDecksByLevel(String level) {
    final query = select(decks)..where((tbl) => tbl.level.equals(level));
    return query.get();
  }

  Future<List<DeckData>> getRecentDecks({int limit = 5}) {
    final query = select(decks)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.lastStudied)])
      ..limit(limit);

    return query.get();
  }

  // Learning Sessions
  Future<LearningSessionData?> getCurrentSession() async {
    final query = select(learningSessions)
      ..where((tbl) => tbl.status.equals('inProgress'))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.startedAt)])
      ..limit(1);

    final sessions = await query.get();
    return sessions.isEmpty ? null : sessions.first;
  }

  Future<List<LearningSessionData>> getSessionHistory() {
    final query = select(learningSessions)
      ..where((tbl) => tbl.status.equals('completed'))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.completedAt)]);

    return query.get();
  }

  // Statistics
  Future<List<StatisticsData>> getStatisticsByDateRange(
      DateTime start,
      DateTime end,
      ) {
    final query = select(statistics)
      ..where((tbl) =>
      tbl.date.isBiggerOrEqualValue(start) &
      tbl.date.isSmallerOrEqualValue(end))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.date)]);

    return query.get();
  }

  // Test Sessions
  Future<List<TestSessionData>> getTestHistory() {
    final query = select(testSessions)
      ..where((tbl) => tbl.isComplete.equals(true))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.completedAt)]);

    return query.get();
  }

  // Deck-related card queries
  Future<List<WordCardData>> getWordCardsByDeck(String deckId) {
    final query = select(wordCards)..where((tbl) => tbl.deckId.equals(deckId));
    return query.get();
  }

  Stream<List<WordCardData>> watchWordCardsByDeck(String deckId) {
    final query = select(wordCards)..where((tbl) => tbl.deckId.equals(deckId));
    return query.watch();
  }

  Future<List<SentenceCardData>> getSentenceCardsByDeck(String deckId) {
    final query = select(sentenceCards)..where((tbl) => tbl.deckId.equals(deckId));
    return query.get();
  }

  Stream<List<SentenceCardData>> watchSentenceCardsByDeck(String deckId) {
    final query = select(sentenceCards)..where((tbl) => tbl.deckId.equals(deckId));
    return query.watch();
  }

  Future<List<ArticleCardData>> getArticleCardsByWordCard(String wordCardId) {
    final query = select(articleCards)..where((tbl) => tbl.wordCardId.equals(wordCardId));
    return query.get();
  }
}