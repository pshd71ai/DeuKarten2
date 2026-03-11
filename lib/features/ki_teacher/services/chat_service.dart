import '../models/chat_message_model.dart';
import '../models/chat_session.dart';
import 'message_processor.dart';
import 'chat_cache_service.dart';

class ChatService {
  final MessageProcessor _messageProcessor;
  final ChatCacheService _cacheService;

  ChatService({
    MessageProcessor? messageProcessor,
    ChatCacheService? cacheService,
  })  : _messageProcessor = messageProcessor ?? MessageProcessor(),
       _cacheService = cacheService ?? ChatCacheService();

  Future<ChatMessageModel> getAIResponse({
    required String userMessage,
    required ChatSession session,
  }) async {
    // Check cache first
    final cached = _cacheService.getCachedResponse(userMessage);
    if (cached != null) {
      return cached.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
      );
    }

    // Process message and determine type
    final messageType = _messageProcessor.detectMessageType(userMessage);

    // Generate response based on type
    final response = await _generateResponse(userMessage, messageType);

    // Cache the response
    _cacheService.cacheResponse(userMessage, response);

    return response;
  }

  Future<ChatMessageModel> _generateResponse(
    String userMessage,
    ChatMessageType type,
  ) async {
    // Simulate AI delay
    await Future.delayed(const Duration(milliseconds: 800));

    switch (type) {
      case ChatMessageType.grammar:
        return _generateGrammarResponse(userMessage);
      case ChatMessageType.correction:
        return _generateCorrectionResponse(userMessage);
      case ChatMessageType.suggestions:
        return _generateSuggestionsResponse(userMessage);
      case ChatMessageType.text:
      default:
        return _generateConversationResponse(userMessage);
    }
  }

  ChatMessageModel _generateGrammarResponse(String message) {
    final explanations = {
      'artikel': '''
In der deutschen Sprache haben Nomen einen Artikel: der, die oder das.
- Maskulinum (männlich): der Mann, der Hund
- Femininum (weiblich): die Frau, die Katze
- Neutrum (sächlich): das Kind, das Buch
      ''',
      'kasus': '''
Die vier Fälle im Deutschen:
1. Nominativ (Wer?): Der Mann
2. Akkusativ (Was?): Ich sehe den Mann
3. Dativ (Wem?): Ich helfe dem Mann
4. Genitiv (Wessen?): Das ist das Auto des Mannes
      ''',
      'zeitform': '''
Das Präteritum ist die Vergangenheitsform im Deutschen.
Regelmäßige Verben: ich lerne → ich lernte
Unregelmäßige Verben: ich gehe → ich ging
      ''',
    };

    final content = explanations.entries
        .firstWhere(
          (e) => message.toLowerCase().contains(e.key),
          orElse: () => MapEntry('', '''
Es gibt viele wichtige Themen in der deutschen Grammatik.
Wollen wir über einen speziellen Aspekt sprechen?

Mögliche Themen:
- Artikel (der, die, das)
- Verbkonjugation
- Kasus (Nominativ, Akkusativ, Dativ, Genitiv)
- Zeitformen (Präsens, Präteritum, Perfekt)
          '''),
        )
        .value;

    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content.trim(),
      role: ChatMessageRole.assistant,
      timestamp: DateTime.now(),
      language: 'de',
      type: ChatMessageType.grammar,
    );
  }

  ChatMessageModel _generateCorrectionResponse(String message) {
    // Extract sentence after "Korrigiere diesen Satz: "
    final sentence = message.replaceAll(
      RegExp(r'(?i)korrigiere diesen\s*satz:\s*'),
      '',
    );

    if (sentence.isEmpty) {
      return ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: 'Bitte geben Sie einen Satz ein, den ich korrigieren soll.',
        role: ChatMessageRole.assistant,
        timestamp: DateTime.now(),
        language: 'de',
        type: ChatMessageType.text,
      );
    }

    // Simulated corrections
    final corrections = [
      {'before': 'Ich habe gegangen', 'after': 'Ich bin gegangen'},
      {'before': 'Ich bin gegangen (falsch)', 'after': 'Ich bin gegangen (korrekt)'},
      {'before': 'Der Mann ist hier', 'after': 'Der Mann ist hier (korrekt)'},
      {'before': 'Die Buch ist neu', 'after': 'Das Buch ist neu'},
      {'before': 'Ein Hund laufen', 'after': 'Ein Hund läuft'},
    ];

    final correction = corrections.firstWhere(
      (c) => sentence.contains(c['before']!),
      orElse: () => {
        'before': sentence,
        'after': '$sentence (korrekt)',
      },
    );

    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: '${correction['before']}|${correction['after']}',
      role: ChatMessageRole.assistant,
      timestamp: DateTime.now(),
      language: 'de',
      type: ChatMessageType.correction,
    );
  }

  ChatMessageModel _generateSuggestionsResponse(String message) {
    final suggestions = {
      'grüße': ['Hallo', 'Guten Morgen', 'Guten Tag', 'Guten Abend', 'Auf Wiedersehen'],
      'zahlen': ['eins', 'zwei', 'drei', 'vier', 'fünf', 'sechs', 'sieben', 'acht', 'neun', 'zehn'],
      'farben': ['rot', 'blau', 'grün', 'gelb', 'schwarz', 'weiß', 'grau'],
      'familie': ['Vater', 'Mutter', 'Bruder', 'Schwester', 'Großvater', 'Großmutter'],
      'essen': ['das Brot', 'der Apfel', 'das Wasser', 'die Milch', 'der Käse', 'das Ei'],
    };

    final key = suggestions.entries
        .firstWhere(
          (e) => message.toLowerCase().contains(e.key),
          orElse: () => MapEntry('', [
            'danke', 'bitte', 'ja', 'nein', 'vielleicht', 'genau', 'nicht',
          ]),
        )
        .key;

    final suggestionList = key.isEmpty ? suggestions.entries.first.value : suggestions[key]!;
    final content = suggestionList.join('\n');

    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      role: ChatMessageRole.assistant,
      timestamp: DateTime.now(),
      language: 'de',
      type: ChatMessageType.suggestions,
    );
  }

  ChatMessageModel _generateConversationResponse(String message) {
    final responses = [
      'Das verstehe ich! Hast du noch weitere Fragen?',
      'Sehr gut! Mach weiter so. Noch etwas anderes?',
      'Interessante Frage! Lass uns das genauer besprechen.',
      'Du machst Fortschritte im Deutsch! Ich helfe dir gerne weiter.',
      'Gut gemacht! Möchtest du ein anderes Thema üben?',
      'Prima! Lass uns weitermachen. Hast du noch Fragen?',
    ];

    final response = responses[
        message.hashCode.abs() % responses.length
    ];

    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: response,
      role: ChatMessageRole.assistant,
      timestamp: DateTime.now(),
      language: 'de',
      type: ChatMessageType.text,
    );
  }

  void clearCache() {
    _cacheService.clearCache();
  }
}
