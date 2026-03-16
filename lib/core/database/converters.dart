import 'dart:convert';

import 'package:deu_karten/features/cards/models/article_card.dart';
import 'package:deu_karten/features/cards/models/deck.dart';
import 'package:deu_karten/features/cards/models/enums.dart';
import 'package:deu_karten/features/cards/models/learning_session.dart';
import 'package:deu_karten/features/cards/models/sentence_card.dart';
import 'package:deu_karten/features/cards/models/word_card.dart';
import 'package:deu_karten/features/gamification/models/streak_model.dart';
import 'package:deu_karten/features/gamification/models/xp_models.dart';
import 'package:deu_karten/features/profile/models/user_profile.dart';
import 'package:deu_karten/features/statistics/models/statistics_model.dart';
import 'package:deu_karten/features/tests/models/question_model.dart';
import 'package:deu_karten/features/tests/models/test_model.dart';
// Звідси прибрано test_session.dart, бо він був Unused

import 'drift_database.dart' as db;

// Enum converters
String difficultyLevelToString(DifficultyLevel level) => level.name;

DifficultyLevel difficultyLevelFromString(String value) =>
    DifficultyLevel.values.firstWhere((e) => e.name == value);

String cardTypeToString(CardType type) => type.name;

CardType cardTypeFromString(String value) =>
    CardType.values.firstWhere((e) => e.name == value);

String sessionStatusToString(SessionStatus status) => status.name;

SessionStatus sessionStatusFromString(String value) =>
    SessionStatus.values.firstWhere((e) => e.name == value);

String xpRewardTypeToString(XpRewardType type) => type.name;

XpRewardType xpRewardTypeFromString(String value) =>
    XpRewardType.values.firstWhere((e) => e.name == value);

String streakMilestoneToString(StreakMilestone? milestone) {
  return milestone?.name ?? '';
}

StreakMilestone? streakMilestoneFromString(String? value) {
  if (value == null || value.isEmpty) return null;
  try {
    return StreakMilestone.values.firstWhere((e) => e.name == value);
  } catch (_) {
    return null;
  }
}

// JSON list converters
List<String> decodeStringList(String? json) {
  if (json == null) return [];
  try {
    final list = jsonDecode(json) as List;
    return list.cast<String>();
  } catch (_) {
    return [];
  }
}

String encodeStringList(List<String> list) => jsonEncode(list);

List<SessionCard> decodeSessionCardList(String? json) {
  if (json == null) return [];
  try {
    final list = jsonDecode(json) as List;
    return list
        .map((e) => SessionCard.fromJson(e as Map<String, dynamic>))
        .toList();
  } catch (_) {
    return [];
  }
}

String encodeSessionCardList(List<SessionCard> list) {
  return jsonEncode(list.map((e) => e.toJson()).toList());
}

List<QuestionModel> decodeQuestionList(String? json) {
  if (json == null) return [];
  try {
    final list = jsonDecode(json) as List;
    return list
        .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  } catch (_) {
    return [];
  }
}

String encodeQuestionList(List<QuestionModel> list) {
  return jsonEncode(list.map((e) => e.toJson()).toList());
}

List<int> decodeIntList(String? json) {
  if (json == null) return [];
  try {
    final list = jsonDecode(json) as List;
    return list.cast<int>();
  } catch (_) {
    return [];
  }
}

String encodeIntList(List<int> list) => jsonEncode(list);

List<DateTime> decodeDateTimeList(String? json) {
  if (json == null) return [];
  try {
    final list = jsonDecode(json) as List;
    return list.map((e) => DateTime.parse(e as String)).toList();
  } catch (_) {
    return [];
  }
}

String encodeDateTimeList(List<DateTime> list) {
  return jsonEncode(list.map((e) => e.toIso8601String()).toList());
}

// WordCard converters
WordCard wordCardFromData(db.WordCardData data) {
  return WordCard(
    id: data.id,
    germanWord: data.germanWord,
    translation: data.translation,
    article: data.article,
    pluralForm: data.pluralForm,
    exampleSentence: data.exampleSentence,
    exampleTranslation: data.exampleTranslation,
    imageUrl: data.imageUrl,
    level: difficultyLevelFromString(data.level),
    type: cardTypeFromString(data.type),
    tags: decodeStringList(data.tags),
    lastReviewed: data.lastReviewed,
    nextReview: data.nextReview,
    intervalDays: data.intervalDays,
    repetitionCount: data.repetitionCount,
    easeFactor: data.easeFactor,
  );
}

db.WordCardData wordCardToData(WordCard card) {
  return db.WordCardData(
    id: card.id,
    germanWord: card.germanWord,
    translation: card.translation,
    article: card.article,
    pluralForm: card.pluralForm,
    exampleSentence: card.exampleSentence,
    exampleTranslation: card.exampleTranslation,
    imageUrl: card.imageUrl,
    level: difficultyLevelToString(card.level),
    type: cardTypeToString(card.type),
    tags: encodeStringList(card.tags),
    lastReviewed: card.lastReviewed,
    nextReview: card.nextReview,
    intervalDays: card.intervalDays,
    repetitionCount: card.repetitionCount,
    easeFactor: card.easeFactor,
  );
}

// ArticleCard converters
ArticleCard articleCardFromData(db.ArticleCardData data) {
  return ArticleCard(
    id: data.id,
    word: data.word,
    correctArticle: data.correctArticle,
    options: decodeStringList(data.options),
    translation: data.translation,
    exampleSentence: data.exampleSentence,
    level: difficultyLevelFromString(data.level),
  );
}

db.ArticleCardData articleCardToData(ArticleCard card) {
  return db.ArticleCardData(
    id: card.id,
    word: card.word,
    correctArticle: card.correctArticle,
    options: encodeStringList(card.options),
    translation: card.translation,
    exampleSentence: card.exampleSentence ?? '',
    level: difficultyLevelToString(card.level),
  );
}

// SentenceCard converters
SentenceCard sentenceCardFromData(db.SentenceCardData data) {
  return SentenceCard(
    id: data.id,
    incompleteSentence: data.incompleteSentence,
    wordOptions: decodeStringList(data.wordOptions),
    correctAnswer: data.correctAnswer,
    completeSentence: data.completeSentence,
    translation: data.translation,
    level: difficultyLevelFromString(data.level),
    grammarTopic: data.grammarTopic,
  );
}

db.SentenceCardData sentenceCardToData(SentenceCard card) {
  return db.SentenceCardData(
    id: card.id,
    incompleteSentence: card.incompleteSentence,
    wordOptions: encodeStringList(card.wordOptions),
    correctAnswer: card.correctAnswer,
    completeSentence: card.completeSentence,
    translation: card.translation,
    level: difficultyLevelToString(card.level),
    grammarTopic: card.grammarTopic ?? '',
  );
}

// Deck converters
Deck deckFromData(db.DeckData data) {
  return Deck(
    id: data.id,
    name: data.name,
    description: data.description ?? '', // ✅ Виправлено Nullable String? to String
    category: data.category ?? '',       // ✅ Виправлено Nullable String? to String
    level: difficultyLevelFromString(data.level),
    cardIds: decodeStringList(data.cardIds),
    totalCards: data.totalCards,
    cardsLearned: data.cardsLearned,
    progress: data.progress,
    thumbnailEmoji: data.thumbnailEmoji,
    createdAt: data.createdAt,
    lastStudied: data.lastStudied,
  );
}

db.DeckData deckToData(Deck deck) {
  return db.DeckData(
    id: deck.id,
    name: deck.name,
    description: deck.description,
    category: deck.category,
    level: difficultyLevelToString(deck.level),
    cardIds: encodeStringList(deck.cardIds),
    totalCards: deck.totalCards,
    cardsLearned: deck.cardsLearned ?? 0,
    progress: deck.progress ?? 0.0,
    thumbnailEmoji: deck.thumbnailEmoji ?? '',
    createdAt: deck.createdAt,
    lastStudied: deck.lastStudied,
  );
}

// LearningSession converters
LearningSession learningSessionFromData(db.LearningSessionData data) {
  return LearningSession(
    id: data.id,
    deckId: data.deckId ?? '', // ✅ Виправлено Nullable String? to String
    startedAt: data.startedAt,
    completedAt: data.completedAt,
    cards: decodeSessionCardList(data.cards),
    cardsStudied: data.cardsStudied,
    correctAnswers: data.correctAnswers,
    xpEarned: data.xpEarned,
    status: sessionStatusFromString(data.status),
  );
}

db.LearningSessionData learningSessionToData(LearningSession session) {
  return db.LearningSessionData(
    id: session.id,
    deckId: session.deckId,
    startedAt: session.startedAt,
    completedAt: session.completedAt,
    cards: encodeSessionCardList(session.cards),
    cardsStudied: session.cardsStudied ?? 0,
    correctAnswers: session.correctAnswers ?? 0,
    xpEarned: session.xpEarned ?? 0,
    status: sessionStatusToString(session.status),
  );
}

// Statistics converters
StatisticsModel statisticsFromData(db.StatisticsData data) {
  return StatisticsModel(
    id: data.id,
    date: data.date,
    cardsLearned: data.cardsLearned, // Модель має дефолт 0, тож прийме і не-nullable
    cardsReviewed: data.cardsReviewed,
    testsTaken: data.testsTaken,
    averageScore: data.averageScore,
    studyTimeMinutes: data.studyTimeMinutes,
    xpEarned: data.xpEarned,
    retentionCards: data.retentionCards,
  );
}

db.StatisticsData statisticsToData(StatisticsModel stats) {
  return db.StatisticsData(
    id: stats.id,
    date: stats.date,
    cardsLearned: stats.cardsLearned,
    cardsReviewed: stats.cardsReviewed,
    testsTaken: stats.testsTaken,
    averageScore: stats.averageScore,
    studyTimeMinutes: stats.studyTimeMinutes,
    xpEarned: stats.xpEarned,
    retentionCards: stats.retentionCards,
  );
}

// TestModel converters
TestModel testFromData(db.TestData data) {
  return TestModel(
    id: data.id,
    title: data.title,
    description: data.description,
    questions: decodeQuestionList(data.questions),
    duration: data.duration,
    category: data.category,
    minPassingScore: data.minPassingScore,
  );
}

db.TestData testToData(TestModel test) {
  return db.TestData(
    id: test.id,
    title: test.title,
    description: test.description,
    questions: encodeQuestionList(test.questions),
    duration: test.duration,
    category: test.category,
    minPassingScore: test.minPassingScore,
  );
}

// UserProfile converters
UserProfile userProfileFromData(db.UserProfileData data) {
  return UserProfile(
    id: data.id,
    name: data.name,
    email: data.email,
    avatarUrl: data.avatarUrl,
    joinedDate: data.joinedDate,
    settings: AppSettings.fromJson(
      jsonDecode(data.settings) as Map<String, dynamic>,
    ),
    learningPrefs: LearningPreferences.fromJson(
      jsonDecode(data.learningPrefs) as Map<String, dynamic>,
    ),
  );
}

db.UserProfileData userProfileToData(UserProfile profile) {
  return db.UserProfileData(
    id: profile.id,
    name: profile.name,
    email: profile.email,
    avatarUrl: profile.avatarUrl,
    joinedDate: profile.joinedDate,
    settings: jsonEncode(profile.settings.toJson()),
    learningPrefs: jsonEncode(profile.learningPrefs.toJson()),
  );
}

// XP History converters
XpHistoryEntry xpHistoryFromData(db.XpHistoryEntryData data) {
  return XpHistoryEntry(
    // ❌ В XpHistoryEntry НЕМАЄ id!
    amount: data.amount,
    source: data.source,
    timestamp: data.timestamp,
    description: data.description,
  );
}

db.XpHistoryEntryData xpHistoryToData(XpHistoryEntry entry) {
  return db.XpHistoryEntryData(
    id: 0,
    // ❌ В XpHistoryEntry НЕМАЄ id! А в Drift таблиці є autoIncrement, тому id генерується при insert
    amount: entry.amount,
    source: entry.source,
    timestamp: entry.timestamp,
    description: entry.description,
  );
}

// StreakData converters
StreakData streakDataFromData(db.StreakDataData data) {
  return StreakData(
    // ❌ В StreakData НЕМАЄ id!
    currentStreak: data.currentStreak,
    longestStreak: data.longestStreak,
    lastStudyDate: data.lastStudyDate,
    studiedToday: data.studiedToday,
    studyDates: decodeDateTimeList(data.studyDates),
    lastMilestone: streakMilestoneFromString(data.lastMilestone),
  );
}

db.StreakDataData streakDataToData(StreakData streak) {
  return db.StreakDataData(
    id: 0,
    // ❌ В StreakData НЕМАЄ id! А в Drift таблиці є autoIncrement, тому id генерується при insert
    currentStreak: streak.currentStreak,
    longestStreak: streak.longestStreak,
    lastStudyDate: streak.lastStudyDate,
    studiedToday: streak.studiedToday,
    studyDates: encodeDateTimeList(streak.studyDates),
    lastMilestone: streakMilestoneToString(streak.lastMilestone),
  );
}