import '../models/chat_message_model.dart';

class MessageProcessor {
  static const Map<String, List<String>> _grammarKeywords = {
    'artikel': ['der', 'die', 'das', 'artikel', 'geschlecht', 'genus'],
    'kasus': ['kasus', 'nominativ', 'akkusativ', 'dativ', 'genitiv', 'fall'],
    'zeitform': ['zeit', 'präsens', 'präteritum', 'perfekt', 'futur', 'vergangenheit'],
    'konjugation': ['verb', 'konjugieren', 'flektieren'],
    'pronomen': ['pronomen', 'ich', 'du', 'er', 'wir', 'ihr', 'sie'],
    'adjektiv': ['adjektiv', 'eigenschaft'],
  };

  static const List<String> _correctionKeywords = [
    'korrigier', 'richtig', 'verbesser', 'falsch', 'wie sagt man',
    'wie schreibt man', 'stimmt das', 'korrekt',
  ];

  static const List<String> _suggestionKeywords = [
    'vorschlag', 'andere wörter', 'alternativen', 'ähnlich', 'synonym',
    'neue wörter', 'beispiele', 'übungen',
  ];

  ChatMessageType detectMessageType(String message) {
    final lowerMessage = message.toLowerCase();

    // Check for correction first (more specific)
    if (_correctionKeywords.any((kw) => lowerMessage.contains(kw))) {
      return ChatMessageType.correction;
    }

    // Check for suggestions
    if (_suggestionKeywords.any((kw) => lowerMessage.contains(kw))) {
      return ChatMessageType.suggestions;
    }

    // Check for grammar topics
    for (final topic in _grammarKeywords.values) {
      if (topic.any((kw) => lowerMessage.contains(kw))) {
        return ChatMessageType.grammar;
      }
    }

    // Default to text
    return ChatMessageType.text;
  }

  String extractTopic(String message) {
    final lowerMessage = message.toLowerCase();

    for (final entry in _grammarKeywords.entries) {
      for (final keyword in entry.value) {
        if (lowerMessage.contains(keyword)) {
          return entry.key;
        }
      }
    }

    return 'general';
  }

  String normalizeMessage(String message) {
    return message
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(RegExp(r'[^\w\säöüÄÖÜß.,!?]'), '');
  }

  bool isValidMessage(String message) {
    final normalized = normalizeMessage(message);
    return normalized.length >= 2 && normalized.length <= 500;
  }

  List<String> extractSentences(String text) {
    return text
        .split(RegExp(r'[.!?]+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }
}
