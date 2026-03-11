import 'package:flutter_test/flutter_test.dart';
import 'package:deu_karten/features/ki_teacher/services/ai_service.dart';
import 'package:deu_karten/features/ki_teacher/services/mock_ai_service.dart';

void main() {
  group('AIService', () {
    late MockAIService aiService;

    setUp(() {
      aiService = MockAIService();
    });

    test('explainGrammar returns GrammarExplanationResponse', () async {
      final response = await aiService.explainGrammar('der die das');
      
      expect(response, isA<GrammarExplanationResponse>());
      expect(response.success, isTrue);
      expect(response.content, isNotEmpty);
      expect(response.topic, equals('der die das'));
      expect(response.examples, isNotEmpty);
      expect(response.rules, isNotEmpty);
    });

    test('explainGrammar works for all specified topics', () async {
      final topics = ['der die das', 'Perfekt', 'Präteritum', 'Dativ', 'Akkusativ'];
      
      for (final topic in topics) {
        final response = await aiService.explainGrammar(topic);
        expect(response, isA<GrammarExplanationResponse>());
        expect(response.topic, isNotEmpty);
      }
    });

    test('correctSentence returns CorrectionResponse', () async {
      final response = await aiService.correctSentence('Ich gehen nach Hause');
      
      expect(response, isA<CorrectionResponse>());
      expect(response.success, isTrue);
      expect(response.originalSentence, equals('Ich gehen nach Hause'));
      expect(response.correctedSentence, isNotEmpty);
      expect(response.errors, isNotEmpty);
    });

    test('correctSentence handles Perfekt errors', () async {
      final response = await aiService.correctSentence('Ich habe ein Buch lesen');
      
      expect(response, isA<CorrectionResponse>());
      expect(response.correctedSentence, contains('gelesen'));
      expect(response.errors, isNotEmpty);
    });

    test('startDialog returns DialogResponse', () async {
      final response = await aiService.startDialog('Greetings');
      
      expect(response, isA<DialogResponse>());
      expect(response.success, isTrue);
      expect(response.aiMessage, isNotEmpty);
      expect(response.suggestedUserResponse, isNotEmpty);
      expect(response.followUpQuestions, isNotEmpty);
      expect(response.topic, equals('Greetings'));
    });

    test('startDialog works for various topics', () async {
      final topics = ['Restaurant', 'Einkaufen', 'Reisen', 'Familie'];
      
      for (final topic in topics) {
        final response = await aiService.startDialog(topic);
        expect(response, isA<DialogResponse>());
        expect(response.aiMessage, isNotEmpty);
        expect(response.topic, isNotEmpty);
      }
    });

    test('generateVocabulary returns VocabularyResponse', () async {
      final response = await aiService.generateVocabulary('A1');
      
      expect(response, isA<VocabularyResponse>());
      expect(response.success, isTrue);
      expect(response.level, equals('A1'));
      expect(response.words, isNotEmpty);
      expect(response.theme, isNotEmpty);
    });

    test('generateVocabulary works for all CEFR levels', () async {
      final levels = ['A1', 'A2', 'B1', 'B2', 'C1'];
      
      for (final level in levels) {
        final response = await aiService.generateVocabulary(level);
        expect(response, isA<VocabularyResponse>());
        expect(response.level, equals(level));
        expect(response.words, isNotEmpty);
        expect(response.words.first.german, isNotEmpty);
        expect(response.words.first.translation, isNotEmpty);
        expect(response.words.first.exampleSentence, isNotEmpty);
        expect(response.words.first.tags, isNotEmpty);
      }
    });

    test('getLearningRecommendations returns RecommendationsResponse', () async {
      final response = await aiService.getLearningRecommendations();
      
      expect(response, isA<RecommendationsResponse>());
      expect(response.success, isTrue);
      expect(response.weakAreas, isNotEmpty);
      expect(response.suggestedTopics, isNotEmpty);
      expect(response.practiceExercises, isNotEmpty);
      expect(response.dailyGoalSuggestion, isNotEmpty);
    });

    test('all responses have timestamp', () async {
      final grammarResponse = await aiService.explainGrammar('Perfekt');
      final correctionResponse = await aiService.correctSentence('Test');
      final dialogResponse = await aiService.startDialog('Test');
      final vocabResponse = await aiService.generateVocabulary('A1');
      final recommendationsResponse = await aiService.getLearningRecommendations();
      
      expect(grammarResponse.timestamp, isNotNull);
      expect(correctionResponse.timestamp, isNotNull);
      expect(dialogResponse.timestamp, isNotNull);
      expect(vocabResponse.timestamp, isNotNull);
      expect(recommendationsResponse.timestamp, isNotNull);
    });

    test('GrammarError has required fields', () async {
      final response = await aiService.correctSentence('Ich gehen nach Hause');
      final error = response.errors.first;
      
      expect(error.error, isNotEmpty);
      expect(error.correction, isNotEmpty);
      expect(error.explanation, isNotEmpty);
      expect(error.position, greaterThanOrEqualTo(0));
    });

    test('VocabularyWord has required fields', () async {
      final response = await aiService.generateVocabulary('A1');
      final word = response.words.first;
      
      expect(word.german, isNotEmpty);
      expect(word.translation, isNotEmpty);
      expect(word.exampleSentence, isNotEmpty);
      expect(word.tags, isNotEmpty);
    });
  });
}
