/// Abstract interface for AI-powered German learning features
abstract class AIService {
  /// Explains German grammar topics with examples
  ///
  /// Example topics: "der die das", "Perfekt", "Präteritum", "Dativ", "Akkusativ"
  Future<AIResponse> explainGrammar(String topic);

  /// Corrects German sentences and provides explanations
  ///
  /// Input: "Ich gehen nach Hause"
  /// Response: Correction + explanation
  Future<CorrectionResponse> correctSentence(String sentence);

  /// Starts a German conversation/dialog on a specific topic
  ///
  /// Topics: "Einkaufen", "Restaurant", "Reisen", etc.
  Future<DialogResponse> startDialog(String topic);

  /// Generates personalized vocabulary based on user level and progress
  ///
  /// Level: A1, A2, B1, B2, C1
  Future<VocabularyResponse> generateVocabulary(String level);

  /// Provides personalized learning recommendations
  ///
  /// Based on user progress, mistakes, and goals
  Future<RecommendationsResponse> getLearningRecommendations();
}

/// Base response class for AI operations
abstract class AIResponse {
  final String content;
  final bool success;
  final String? error;
  final DateTime timestamp;

  AIResponse({
    required this.content,
    this.success = true,
    this.error,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// Grammar explanation response
class GrammarExplanationResponse extends AIResponse {
  final String topic;
  final String explanation;
  final List<String> examples;
  final List<String> rules;

  GrammarExplanationResponse({
    required this.topic,
    required this.explanation,
    required this.examples,
    required this.rules,
    required super.content,
    super.success,
    super.error,
    super.timestamp,
  });
}

/// Sentence correction response
class CorrectionResponse extends AIResponse {
  final String originalSentence;
  final String correctedSentence;
  final String explanation;
  final List<GrammarError> errors;

  CorrectionResponse({
    required this.originalSentence,
    required this.correctedSentence,
    required this.explanation,
    required this.errors,
    required super.content,
    super.success,
    super.error,
    super.timestamp,
  });
}

/// Individual grammar error details
class GrammarError {
  final String error;
  final String correction;
  final String explanation;
  final int position; // Position in sentence

  GrammarError({
    required this.error,
    required this.correction,
    required this.explanation,
    required this.position,
  });
}

/// Dialog/conversation response
class DialogResponse extends AIResponse {
  final String aiMessage;
  final String suggestedUserResponse;
  final List<String> followUpQuestions;
  final String topic;

  DialogResponse({
    required this.aiMessage,
    required this.suggestedUserResponse,
    required this.followUpQuestions,
    required this.topic,
    required super.content,
    super.success,
    super.error,
    super.timestamp,
  });
}

/// Vocabulary generation response
class VocabularyResponse extends AIResponse {
  final String level;
  final List<VocabularyWord> words;
  final String theme;

  VocabularyResponse({
    required this.level,
    required this.words,
    required this.theme,
    required super.content,
    super.success,
    super.error,
    super.timestamp,
  });
}

/// Individual vocabulary word
class VocabularyWord {
  final String german;
  final String translation;
  final String article; // der, die, das or empty
  final String exampleSentence;
  final List<String> tags;

  VocabularyWord({
    required this.german,
    required this.translation,
    this.article = '',
    required this.exampleSentence,
    required this.tags,
  });
}

/// Learning recommendations response
class RecommendationsResponse extends AIResponse {
  final List<String> weakAreas;
  final List<String> suggestedTopics;
  final List<String> practiceExercises;
  final String dailyGoalSuggestion;

  RecommendationsResponse({
    required this.weakAreas,
    required this.suggestedTopics,
    required this.practiceExercises,
    required this.dailyGoalSuggestion,
    required super.content,
    super.success,
    super.error,
    super.timestamp,
  });
}
