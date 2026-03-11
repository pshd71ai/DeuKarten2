import 'dart:math';
import 'ai_service.dart';

/// Mock implementation of AIService for development and testing
class MockAIService implements AIService {
  final Random _random = Random();

  @override
  Future<AIResponse> explainGrammar(String topic) async {
    await _simulateDelay();

    final lowerTopic = topic.toLowerCase();

    switch (lowerTopic) {
      case 'der die das':
      case 'artikel':
        return GrammarExplanationResponse(
          topic: 'der die das',
          explanation:
              'In German, every noun has a grammatical gender: masculine (der), feminine (die), or neuter (das). Unfortunately, there are no absolute rules, but there are some patterns that can help.',
          examples: [
            'der Tisch (the table) - masculine',
            'die Tür (the door) - feminine',
            'das Haus (the house) - neuter',
          ],
          rules: [
            'Most male persons and animals are masculine: der Vater, der Hund',
            'Most female persons and animals are feminine: die Mutter, die Katze',
            'Diminutives ending in -chen or -lein are neuter: das Mädchen, das Bächlein',
            'Nouns ending in -ung, -heit, -keit, -schaft are feminine: die Übung, die Freiheit',
          ],
          content: '''
## Artikel in Deutsch

In der deutschen Sprache hat jedes Nomen ein grammatikalisches Geschlecht:

### Der (Maskulin)
- die meisten männlichen Personen und Tiere
- Tage, Monate, Jahreszeiten
- Automarken

### Die (Feminin)  
- die meisten weiblichen Personen und Tiere
- Nomen auf -ung, -heit, -keit, -schaft
- Flüsse (außer Rhein)

### Das (Neutrum)
- Diminutive auf -chen, -lein
- Infinitive als Nomen
- Länder, Städte (meist)
''',
        );

      case 'perfekt':
        return GrammarExplanationResponse(
          topic: 'Perfekt',
          explanation:
              'The Perfekt is used to describe completed actions in the past. It is formed with the auxiliary verb (haben or sein) + past participle (Partizip II).',
          examples: [
            'Ich habe ein Buch gelesen.',
            'Er ist nach Hause gegangen.',
            'Wir haben Deutsch gelernt.',
          ],
          rules: [
            'Most verbs use "haben" as auxiliary verb',
            'Verbs of movement use "sein": gehen, kommen, fahren',
            'Partizip II formation: ge- + stem + -t (for weak verbs)',
            'Strong verbs have irregular forms: gelesen, gegangen, geschrieben',
          ],
          content: '''
## Das Perfekt

Das Perfekt wird verwendet, um abgeschlossene Handlungen in der Vergangenheit zu beschreiben.

### Bildung
**haben** oder **sein** (im Präsens) + **Partizip II**

### wann verwenden wir "haben"?
- die meisten Verben
- reflexive Verben
- Verben der Wahrnehmung

### wann verwenden wir "sein"?
- Verben der Bewegung (gehen, kommen, fahren)
- Verben der Zustandsänderung (werden, einschlafen, aufwachen)

### Beispiele
- Ich **habe** gegessen.
- Er **ist** gegangen.
- Wir **sind** gekommen.
- Sie **haben** geschrieben.
''',
        );

      case 'präteritum':
        return GrammarExplanationResponse(
          topic: 'Präteritum',
          explanation:
              'The Präteritum is primarily used in written German and formal contexts to describe past events. It is formed by adding specific endings to the verb stem.',
          examples: [
            'Ich ging nach Hause.',
            'Er arbeitete viel.',
            'Wir lernten Deutsch.',
          ],
          rules: [
            'Regular verbs: stem + -te + endings (-, -st, -, -en, -t, -en)',
            'Irregular verbs have stem vowel changes',
            'Modal verbs and "sein", "haben" are commonly used in Präteritum',
            'More common in written than spoken German',
          ],
          content: '''
## Das Präteritum

Das Präteritum wird hauptsächlich in der geschriebenen Sprache und in formellen Situationen verwendet.

### Bildung bei regelmäßigen Verben
Stamm + **-te** + Endungen

| Person | Endung | Beispiel (lernen) |
|--------|--------|-------------------|
| ich    | -      | ich lernte        |
| du     | -st    | du lerntest       |
| er/sie/es | -   | er lernte         |
| wir    | -en    | wir lernten       |
| ihr    | -t     | ihr lerntet       |
| sie    | -en    | sie lernten       |

### Wichtige unregelmäßige Verben
- **sein**: ich war, du warst, er war...
- **haben**: ich hatte, du hattest, er hatte...
- **werden**: ich wurde, du wurdest, er wurde...

### Modalverben
- **können**: ich konnte, du konntest...
- **müssen**: ich musste, du musstest...
- **dürfen**: ich durfte, du durftest...
''',
        );

      case 'dativ':
        return GrammarExplanationResponse(
          topic: 'Dativ',
          explanation:
              'The Dativ case indicates the indirect object (to whom/what something is given) or is used after certain prepositions.',
          examples: [
            'Ich gebe dem Mann das Buch.',
            'Sie hilft der Frau.',
            'Wir schreiben dem Lehrer.',
          ],
          rules: [
            'Use "to whom/what" to identify dative: Ich gebe **wem**?',
            'Articles: der → dem, die → der, das → dem, die (plural) → den',
            'After dative prepositions: aus, bei, mit, nach, seit, von, zu',
            'With certain verbs: helfen, danken, folgen, gratulieren',
          ],
          content: '''
## Der Dativ

Der Dativ zeigt oft an, wem etwas gegeben oder zugewendet wird.

### Frage: **Wem?**

### Artikel im Dativ

| Kasus | Maskulin | Feminin | Neutrum | Plural |
|-------|----------|---------|---------|--------|
| Nominativ | der | die | das | die |
| Akkusativ | den | die | das | die |
| Dativ | **dem** | **der** | **dem** | **den** |
| Genitiv | des | der | des | der |

### Präpositionen mit Dativ
- **aus** (aus dem Haus)
- **bei** (bei mir)
- **mit** (mit dem Freund)
- **nach** (nach Deutschland)
- **seit** (seit einer Woche)
- **von** (von der Arbeit)
- **zu** (zum Arzt)

### Verben mit Dativ
- **helfen**: Ich helfe **dem** Kind.
- **danken**: Ich danke **der** Frau.
- **folgen**: Er folgt **dem** Weg.
- **gratulieren**: Wir gratulieren **dem** Gewinner.
''',
        );

      case 'akkusativ':
        return GrammarExplanationResponse(
          topic: 'Akkusativ',
          explanation:
              'The Akkusativ case indicates the direct object (what is being acted upon) and is used after certain prepositions.',
          examples: [
            'Ich sehe den Mann.',
            'Er kauft das Buch.',
            'Wir besuchen die Stadt.',
          ],
          rules: [
            'Use "what" to identify accusative: Ich sehe **was**?',
            'Articles: der → den, die → die, das → das (only der changes)',
            'After accusative prepositions: durch, für, gegen, ohne, um',
            'With verbs of movement in some contexts',
          ],
          content: '''
## Der Akkusativ

Der Akkusativ kennzeichnet meist das direkte Objekt im Satz (wen oder was?).

### Frage: **Wen oder was?**

### Artikel im Akkusativ

| Kasus | Maskulin | Feminin | Neutrum | Plural |
|-------|----------|---------|---------|--------|
| Nominativ | der | die | das | die |
| Akkusativ | **den** | **die** | **das** | **die** |
| Dativ | dem | der | dem | den |
| Genitiv | des | der | des | der |

### Präpositionen mit Akkusativ
- **durch** (durch den Park)
- **für** (für dich)
- **gegen** (gegen den Widerstand)
- **ohne** (ohne Geld)
- **um** (um die Ecke)

### Wechselpräpositionen (je nach Kontext)
- auf, in, an, vor, hinter, über, unter, neben, zwischen

**Regel:**
- Bewegung → Akkusativ (ich gehe **in den** Park)
- Position → Dativ (ich bin **im** Park)

### Beispiele
- Ich sehe **den** Mann. (direktes Objekt)
- Ich kaufe **ein** Auto. (direktes Objekt)
- Ich gehe **in den** Laden. (Bewegung → Akkusativ)
''',
        );

      default:
        return GrammarExplanationResponse(
          topic: topic,
          explanation:
              'This is a general grammar topic. Let me provide some basic information.',
          examples: [
            'Example 1 related to $topic',
            'Example 2 related to $topic',
            'Example 3 related to $topic',
          ],
          rules: [
            'Rule 1 for $topic',
            'Rule 2 for $topic',
            'Rule 3 for $topic',
          ],
          content: '''
## $topic

Dies ist ein allgemeines Thema zur deutschen Grammatik.

### Grundlegende Informationen
- Erklärung zu $topic
- Wichtige Regeln
- Häufige Fehler

### Beispiele
1. Beispiel 1
2. Beispiel 2
3. Beispiel 3

### Tipps
- Tipp 1
- Tipp 2
- Tipp 3
''',
        );
    }
  }

  @override
  Future<CorrectionResponse> correctSentence(String sentence) async {
    await _simulateDelay();

    final lowerSentence = sentence.toLowerCase();

    if (lowerSentence.contains('gehen') &&
        !lowerSentence.contains('gehe') &&
        !lowerSentence.contains('gehst') &&
        !lowerSentence.contains('geht')) {
      return CorrectionResponse(
        originalSentence: sentence,
        correctedSentence: 'Ich gehe nach Hause',
        explanation:
            'The verb "gehen" must be conjugated in the first person singular: "gehe".',
        errors: [
          GrammarError(
            error: 'gehen',
            correction: 'gehe',
            explanation: 'Verb conjugation: ich gehe, du gehst, er/sie/es geht',
            position: sentence.indexOf('gehen'),
          ),
        ],
        content:
            'Richtig ist: Ich gehe nach Hause\n\nErklärung: Das Verb "gehen" wird im Präsens konjugiert:\n- ich gehe\n- du gehst\n- er/sie/es geht\n- wir gehen\n- ihr geht\n- sie/Sie gehen',
      );
    }

    if (lowerSentence.contains('haben') &&
        lowerSentence.contains('lesen') &&
        !lowerSentence.contains('gelesen')) {
      return CorrectionResponse(
        originalSentence: sentence,
        correctedSentence: 'Ich habe ein Buch gelesen',
        explanation:
            'In Perfekt, the second verb must be in Partizip II form (gelesen), not infinitive.',
        errors: [
          GrammarError(
            error: 'lesen',
            correction: 'gelesen',
            explanation: 'Partizip II of lesen: gelesen (strong verb)',
            position: sentence.indexOf('lesen'),
          ),
        ],
        content:
            'Richtig ist: Ich habe ein Buch gelesen.\n\nErklärung: Im Perfekt steht das Vollverb im Partizip II. "Lesen" ist ein unregelmäßiges Verb: lesen - las - gelesen.',
      );
    }

    if (lowerSentence.contains('die buch') || lowerSentence.contains('die tisch')) {
      final wrongWord = lowerSentence.contains('buch') ? 'Buch' : 'Tisch';
      final correctArticle = wrongWord == 'Buch' ? 'das' : 'der';
      return CorrectionResponse(
        originalSentence: sentence,
        correctedSentence: sentence.replaceFirst('Die', 'Das').replaceFirst('die', correctArticle),
        explanation:
            'The article for "$wrongWord" is "$correctArticle", not "die".',
        errors: [
          GrammarError(
            error: 'die',
            correction: correctArticle,
            explanation: 'Article correction: ${correctArticle.toLowerCase()} $wrongWord',
            position: sentence.toLowerCase().indexOf('die'),
          ),
        ],
        content:
            'Richtig ist: ${sentence.replaceFirst('Die', 'Das').replaceFirst('die', correctArticle)}\n\nErklärung: Der Artikel für "$wrongWord" ist "$correctArticle".\n- Der Tisch (männlich)\n- Das Buch (sächlich)\n- Die Tür (weiblich)',
      );
    }

    if (lowerSentence.contains('ein ') && lowerSentence.contains('laufen')) {
      return CorrectionResponse(
        originalSentence: sentence,
        correctedSentence: sentence.replaceFirst('laufen', 'läuft'),
        explanation:
            'The verb "laufen" is a strong verb. In third person singular, it is "läuft".',
        errors: [
          GrammarError(
            error: 'laufen',
            correction: 'läuft',
            explanation: 'Verb conjugation: er/sie/es läuft (stem change)',
            position: sentence.indexOf('laufen'),
          ),
        ],
        content:
            'Richtig ist: ${sentence.replaceFirst('laufen', 'läuft')}\n\nErklärung: "Laufen" ist ein starkes Verb mit Stammvokalwechsel:\n- ich laufe\n- du läufst\n- er/sie/es läuft\n- wir laufen\n- ihr lauft\n- sie laufen',
      );
    }

    // Default response for correct or unknown sentences
    return CorrectionResponse(
      originalSentence: sentence,
      correctedSentence: sentence,
      explanation: 'The sentence is grammatically correct.',
      errors: [],
      content: '$sentence\n\nDieser Satz ist grammatikalisch korrekt! Gut gemacht!',
    );
  }

  @override
  Future<DialogResponse> startDialog(String topic) async {
    await _simulateDelay();

    final lowerTopic = topic.toLowerCase();

    switch (lowerTopic) {
      case 'greetings':
      case 'grüße':
      case 'begrüßung':
        return DialogResponse(
          aiMessage: 'Guten Morgen! Wie geht es dir heute?',
          suggestedUserResponse: 'Mir geht es gut, danke! Und dir?',
          followUpQuestions: [
            'Was hast du heute vor?',
            'Wie war dein Wochenende?',
            'Hast du schon gefrühstückt?',
          ],
          topic: 'Greetings',
          content: 'Guten Morgen! Wie geht es dir heute?',
        );

      case 'restaurant':
        return DialogResponse(
          aiMessage: 'Guten Abend! Haben Sie einen Tisch für zwei Personen reserviert?',
          suggestedUserResponse: 'Ja, ich habe auf den Namen Müller reserviert.',
          followUpQuestions: [
            'Möchten Sie die Speisekarte sehen?',
            'Was können Sie empfehlen?',
            'Haben Sie vegetarische Gerichte?',
          ],
          topic: 'Restaurant',
          content: 'Guten Abend! Haben Sie einen Tisch für zwei Personen reserviert?',
        );

      case 'einkaufen':
        return DialogResponse(
          aiMessage: 'Guten Tag! Kann ich Ihnen helfen? Suchen Sie etwas Bestimmtes?',
          suggestedUserResponse: 'Ja, ich suche Brot und Käse.',
          followUpQuestions: [
            'Brauchen Sie noch etwas anderes?',
            'Haben Sie auch Milch?',
            'Wie viel kostet das?',
          ],
          topic: 'Einkaufen',
          content: 'Guten Tag! Kann ich Ihnen helfen? Suchen Sie etwas Bestimmtes?',
        );

      case 'reisen':
        return DialogResponse(
          aiMessage: 'Reisen ist toll! Wohin möchtest du reisen?',
          suggestedUserResponse: 'Ich möchte nach Deutschland reisen.',
          followUpQuestions: [
            'Welche Stadt möchtest du besuchen?',
            'Wann möchtest du reisen?',
            'Hast du schon ein Flugticket?',
          ],
          topic: 'Reisen',
          content: 'Reisen ist toll! Wohin möchtest du reisen?',
        );

      case 'familie':
        return DialogResponse(
          aiMessage: 'Erzähl mir ein bisschen über deine Familie!',
          suggestedUserResponse: 'Ich habe eine Schwester und einen Bruder.',
          followUpQuestions: [
            'Wie alt sind sie?',
            'Was machen deine Eltern?',
            'Hast du auch Haustiere?',
          ],
          topic: 'Familie',
          content: 'Erzähl mir ein bisschen über deine Familie!',
        );

      case 'hobby':
      case 'freizeit':
        return DialogResponse(
          aiMessage: 'Was machst du gerne in deiner Freizeit?',
          suggestedUserResponse: 'Ich lese gerne und gehe spazieren.',
          followUpQuestions: [
            'Welche Bücher liest du gerne?',
            'Gehst du auch gerne Sport treiben?',
            'Hast du noch andere Hobbys?',
          ],
          topic: 'Hobby',
          content: 'Was machst du gerne in deiner Freizeit?',
        );

      default:
        return DialogResponse(
          aiMessage: 'Hallo! Lass uns über $topic sprechen. Was möchtest du wissen?',
          suggestedUserResponse: 'Erzähl mir mehr über $topic.',
          followUpQuestions: [
            'Hast du Fragen zu $topic?',
            'Möchtest du Beispiele hören?',
            'Was möchtest du noch wissen?',
          ],
          topic: topic,
          content: 'Hallo! Lass uns über $topic sprechen. Was möchtest du wissen?',
        );
    }
  }

  @override
  Future<VocabularyResponse> generateVocabulary(String level) async {
    await _simulateDelay();

    final upperLevel = level.toUpperCase();

    switch (upperLevel) {
      case 'A1':
        return VocabularyResponse(
          level: 'A1',
          theme: 'Daily Basics',
          words: [
            VocabularyWord(
              german: 'Haus',
              article: 'das',
              translation: 'house',
              exampleSentence: 'Das Haus ist groß.',
              tags: ['home', 'building', 'basic'],
            ),
            VocabularyWord(
              german: 'essen',
              article: '',
              translation: 'to eat',
              exampleSentence: 'Ich esse Brot.',
              tags: ['verb', 'food', 'basic'],
            ),
            VocabularyWord(
              german: 'Wasser',
              article: 'das',
              translation: 'water',
              exampleSentence: 'Ich trinke Wasser.',
              tags: ['drink', 'food', 'basic'],
            ),
            VocabularyWord(
              german: 'Tisch',
              article: 'der',
              translation: 'table',
              exampleSentence: 'Der Tisch ist schön.',
              tags: ['home', 'furniture', 'basic'],
            ),
            VocabularyWord(
              german: 'lernen',
              article: '',
              translation: 'to learn',
              exampleSentence: 'Ich lerne Deutsch.',
              tags: ['verb', 'education', 'basic'],
            ),
            VocabularyWord(
              german: 'Freund',
              article: 'der',
              translation: 'friend',
              exampleSentence: 'Das ist mein Freund.',
              tags: ['people', 'family', 'basic'],
            ),
            VocabularyWord(
              german: 'gehen',
              article: '',
              translation: 'to go',
              exampleSentence: 'Ich gehe nach Hause.',
              tags: ['verb', 'movement', 'basic'],
            ),
            VocabularyWord(
              german: 'Katze',
              article: 'die',
              translation: 'cat',
              exampleSentence: 'Die Katze ist süß.',
              tags: ['animal', 'pet', 'basic'],
            ),
            VocabularyWord(
              german: 'Buch',
              article: 'das',
              translation: 'book',
              exampleSentence: 'Ich lese ein Buch.',
              tags: ['object', 'reading', 'basic'],
            ),
            VocabularyWord(
              german: 'sprechen',
              article: '',
              translation: 'to speak',
              exampleSentence: 'Ich spreche Deutsch.',
              tags: ['verb', 'communication', 'basic'],
            ),
          ],
          content: 'Generated 10 A1 vocabulary words for theme: Daily Basics',
        );

      case 'A2':
        return VocabularyResponse(
          level: 'A2',
          theme: 'Travel and Transport',
          words: [
            VocabularyWord(
              german: 'Bahnhof',
              article: 'der',
              translation: 'train station',
              exampleSentence: 'Der Bahnhof ist nah.',
              tags: ['transport', 'travel', 'public'],
            ),
            VocabularyWord(
              german: 'Fahrkarte',
              article: 'die',
              translation: 'ticket',
              exampleSentence: 'Ich brauche eine Fahrkarte.',
              tags: ['transport', 'document', 'travel'],
            ),
            VocabularyWord(
              german: 'reisen',
              article: '',
              translation: 'to travel',
              exampleSentence: 'Ich reise nach Berlin.',
              tags: ['verb', 'travel', 'movement'],
            ),
            VocabularyWord(
              german: 'Flughafen',
              article: 'der',
              translation: 'airport',
              exampleSentence: 'Wir fahren zum Flughafen.',
              tags: ['transport', 'travel', 'building'],
            ),
            VocabularyWord(
              german: 'Koffer',
              article: 'der',
              translation: 'suitcase',
              exampleSentence: 'Ich packe meinen Koffer.',
              tags: ['object', 'travel', 'luggage'],
            ),
            VocabularyWord(
              german: 'Zug',
              article: 'der',
              translation: 'train',
              exampleSentence: 'Der Zug kommt um 10 Uhr.',
              tags: ['transport', 'public', 'vehicle'],
            ),
            VocabularyWord(
              german: 'Fahrrad',
              article: 'das',
              translation: 'bicycle',
              exampleSentence: 'Ich fahre mit dem Fahrrad.',
              tags: ['transport', 'vehicle', 'sport'],
            ),
            VocabularyWord(
              german: 'Reservierung',
              article: 'die',
              translation: 'reservation',
              exampleSentence: 'Ich habe eine Reservierung.',
              tags: ['document', 'formal', 'travel'],
            ),
            VocabularyWord(
              german: 'ankommen',
              article: '',
              translation: 'to arrive',
              exampleSentence: 'Wir kommen um 12 Uhr an.',
              tags: ['verb', 'travel', 'movement'],
            ),
            VocabularyWord(
              german: 'abfahren',
              article: '',
              translation: 'to depart',
              exampleSentence: 'Der Zug fährt in 10 Minuten ab.',
              tags: ['verb', 'travel', 'movement'],
            ),
          ],
          content: 'Generated 10 A2 vocabulary words for theme: Travel and Transport',
        );

      case 'B1':
        return VocabularyResponse(
          level: 'B1',
          theme: 'Work and Career',
          words: [
            VocabularyWord(
              german: 'Bewerbung',
              article: 'die',
              translation: 'application',
              exampleSentence: 'Ich schicke meine Bewerbung morgen.',
              tags: ['work', 'formal', 'document'],
            ),
            VocabularyWord(
              german: 'verantwortlich',
              article: '',
              translation: 'responsible',
              exampleSentence: 'Er ist für das Projekt verantwortlich.',
              tags: ['adjective', 'work', 'character'],
            ),
            VocabularyWord(
              german: 'Karriere',
              article: 'die',
              translation: 'career',
              exampleSentence: 'Sie macht Karriere bei der Firma.',
              tags: ['work', 'professional', 'life'],
            ),
            VocabularyWord(
              german: 'stellenanzeige',
              article: 'die',
              translation: 'job advertisement',
              exampleSentence: 'Ich habe die Stellenanzeige gelesen.',
              tags: ['work', 'document', 'search'],
            ),
            VocabularyWord(
              german: 'Vorstellungsgespräch',
              article: 'das',
              translation: 'job interview',
              exampleSentence: 'Das Vorstellungsgespräch war gut.',
              tags: ['work', 'formal', 'meeting'],
            ),
            VocabularyWord(
              german: 'Teamwork',
              article: 'der',
              translation: 'teamwork',
              exampleSentence: 'Teamwork ist wichtig für den Erfolg.',
              tags: ['work', 'collaboration', 'concept'],
            ),
            VocabularyWord(
              german: 'Gehalt',
              article: 'das',
              translation: 'salary',
              exampleSentence: 'Mein Gehalt ist fair.',
              tags: ['work', 'money', 'formal'],
            ),
            VocabularyWord(
              german: 'Kündigung',
              article: 'die',
              translation: 'resignation',
              exampleSentence: 'Sie hat ihre Kündigung geschrieben.',
              tags: ['work', 'formal', 'document'],
            ),
            VocabularyWord(
              german: 'unternehmen',
              article: 'das',
              translation: 'company',
              exampleSentence: 'Das Unternehmen ist international.',
              tags: ['work', 'business', 'organization'],
            ),
            VocabularyWord(
              german: 'erfahren',
              article: '',
              translation: 'experienced',
              exampleSentence: 'Er ist ein erfahrener Arzt.',
              tags: ['adjective', 'skill', 'professional'],
            ),
          ],
          content: 'Generated 10 B1 vocabulary words for theme: Work and Career',
        );

      case 'B2':
        return VocabularyResponse(
          level: 'B2',
          theme: 'Politics and Society',
          words: [
            VocabularyWord(
              german: 'Wahl',
              article: 'die',
              translation: 'election',
              exampleSentence: 'Die Wahl findet im Herbst statt.',
              tags: ['politics', 'society', 'formal'],
            ),
            VocabularyWord(
              german: 'Meinungsfreiheit',
              article: 'die',
              translation: 'freedom of speech',
              exampleSentence: 'Die Meinungsfreiheit ist ein Grundrecht.',
              tags: ['politics', 'society', 'rights'],
            ),
            VocabularyWord(
              german: 'Regierung',
              article: 'die',
              translation: 'government',
              exampleSentence: 'Die Regierung entscheidet über Gesetze.',
              tags: ['politics', 'state', 'formal'],
            ),
            VocabularyWord(
              german: 'sozial',
              article: '',
              translation: 'social',
              exampleSentence: 'Soziale Probleme sind wichtig.',
              tags: ['adjective', 'society', 'concept'],
            ),
            VocabularyWord(
              german: 'Demonstration',
              article: 'die',
              translation: 'demonstration',
              exampleSentence: 'Die Demonstration war friedlich.',
              tags: ['politics', 'protest', 'event'],
            ),
            VocabularyWord(
              german: 'Demokratie',
              article: 'die',
              translation: 'democracy',
              exampleSentence: 'Wir leben in einer Demokratie.',
              tags: ['politics', 'system', 'formal'],
            ),
            VocabularyWord(
              german: 'Gesetz',
              article: 'das',
              translation: 'law',
              exampleSentence: 'Das Gesetz gilt für alle.',
              tags: ['politics', 'legal', 'formal'],
            ),
            VocabularyWord(
              german: 'Stimme',
              article: 'die',
              translation: 'vote / voice',
              exampleSentence: 'Jede Stimme ist wichtig.',
              tags: ['politics', 'participation', 'rights'],
            ),
            VocabularyWord(
              german: 'Partei',
              article: 'die',
              translation: 'political party',
              exampleSentence: 'Die Partei hat gewonnen.',
              tags: ['politics', 'organization', 'formal'],
            ),
            VocabularyWord(
              german: 'Umweltschutz',
              article: 'der',
              translation: 'environmental protection',
              exampleSentence: 'Umweltschutz ist eine globale Aufgabe.',
              tags: ['society', 'environment', 'topic'],
            ),
          ],
          content: 'Generated 10 B2 vocabulary words for theme: Politics and Society',
        );

      case 'C1':
        return VocabularyResponse(
          level: 'C1',
          theme: 'Academic and Scientific',
          words: [
            VocabularyWord(
              german: 'Hypothese',
              article: 'die',
              translation: 'hypothesis',
              exampleSentence: 'Die Hypothese muss noch bewiesen werden.',
              tags: ['academic', 'science', 'theory'],
            ),
            VocabularyWord(
              german: 'empirisch',
              article: '',
              translation: 'empirical',
              exampleSentence: 'Die empirischen Daten sind wichtig.',
              tags: ['academic', 'science', 'method'],
            ),
            VocabularyWord(
              german: 'Abhandlung',
              article: 'die',
              translation: 'treatise',
              exampleSentence: 'Diese Abhandlung veröffentlichte er 2020.',
              tags: ['academic', 'document', 'formal'],
            ),
            VocabularyWord(
              german: 'Methodologie',
              article: 'die',
              translation: 'methodology',
              exampleSentence: 'Die Methodologie der Studie ist klar.',
              tags: ['academic', 'research', 'process'],
            ),
            VocabularyWord(
              german: 'Theorie',
              article: 'die',
              translation: 'theory',
              exampleSentence: 'Die Theorie wird in der Praxis bestätigt.',
              tags: ['academic', 'concept', 'science'],
            ),
            VocabularyWord(
              german: 'Synthese',
              article: 'die',
              translation: 'synthesis',
              exampleSentence: 'Die Synthese verschiedener Ideen ist wichtig.',
              tags: ['academic', 'process', 'thinking'],
            ),
            VocabularyWord(
              german: 'Analyse',
              article: 'die',
              translation: 'analysis',
              exampleSentence: 'Die Analyse zeigt interessante Ergebnisse.',
              tags: ['academic', 'research', 'method'],
            ),
            VocabularyWord(
              german: 'interdisziplinär',
              article: '',
              translation: 'interdisciplinary',
              exampleSentence: 'Das Projekt ist interdisziplinär.',
              tags: ['academic', 'research', 'collaboration'],
            ),
            VocabularyWord(
              german: 'validieren',
              article: '',
              translation: 'to validate',
              exampleSentence: 'Wir müssen die Ergebnisse validieren.',
              tags: ['academic', 'verb', 'research'],
            ),
            VocabularyWord(
              german: 'Korrelation',
              article: 'die',
              translation: 'correlation',
              exampleSentence: 'Es gibt eine starke Korrelation.',
              tags: ['academic', 'statistics', 'research'],
            ),
          ],
          content: 'Generated 10 C1 vocabulary words for theme: Academic and Scientific',
        );

      default:
        return VocabularyResponse(
          level: level,
          theme: 'General',
          words: [
            VocabularyWord(
              german: 'Wort',
              article: 'das',
              translation: 'word',
              exampleSentence: 'Das Wort ist kurz.',
              tags: ['basic', 'language'],
            ),
            VocabularyWord(
              german: 'Satz',
              article: 'der',
              translation: 'sentence',
              exampleSentence: 'Der Satz ist lang.',
              tags: ['basic', 'grammar'],
            ),
            VocabularyWord(
              german: 'verstehen',
              article: '',
              translation: 'to understand',
              exampleSentence: 'Ich verstehe das Wort.',
              tags: ['verb', 'basic'],
            ),
          ],
          content: 'Generated 3 vocabulary words for level: $level',
        );
    }
  }

  @override
  Future<RecommendationsResponse> getLearningRecommendations() async {
    await _simulateDelay();

    return RecommendationsResponse(
      weakAreas: [
        'Verb conjugation (Präsens)',
        'Articles (der, die, das)',
        'Word order in subordinate clauses',
      ],
      suggestedTopics: [
        'Reflexive verbs',
        'Modal verbs',
        'Comparative and superlative',
      ],
      practiceExercises: [
        'Conjugate 10 verbs in all persons',
        'Practice with 20 article cards',
        'Complete 5 listening exercises',
      ],
      dailyGoalSuggestion:
          'Study 20 cards daily to reach B1 level in 3 months',
      content: '''
## Deine Lernempfehlungen

### Bereiche zum Üben:
- Verbkonjugation im Präsens
- Artikelbestimmung
- Nebensatz-Wortstellung

### Empfohlene Themen:
- Reflexive Verben
- Modalverben
- Komparativ und Superlativ

### Übungen für heute:
- 10 Verben konjugieren
- 20 Artikel-Karten üben
- 5 Hörübungen absolvieren

### Tipp für den Erfolg:
Wiederhole jeden Tag die Karten von gestern. Regelmäßiges Üben ist der Schlüssel zum Erfolg!
''',
    );
  }

  /// Simulates network delay of 500-1500ms
  Future<void> _simulateDelay() async {
    await Future.delayed(
      Duration(milliseconds: 500 + _random.nextInt(1001)),
    );
  }
}
