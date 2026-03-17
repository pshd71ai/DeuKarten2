import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' show Value;

import 'package:deu_karten/core/database/drift_database.dart';

class CloudDeckInfo {
  final String cloudId;
  final String name;
  final String level;
  final int totalCards;
  final String? authorId;

  CloudDeckInfo({
    required this.cloudId,
    required this.name,
    required this.level,
    required this.totalCards,
    this.authorId,
  });
}

class CloudSyncService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static const Uuid _uuid = Uuid();

  static CollectionReference<Map<String, dynamic>> get _deckCollection =>
      _firestore.collection('cards');

  // ─────────────────────────────────────────────
  // EXPORT локального deck -> Firestore
  // Формат сумісний зі старим Kotlin-додатком
  // ─────────────────────────────────────────────
  static Future<String> exportDeck(
      String localDeckId, {
        void Function(int processed, int total)? onProgress,
      }) async {
    final db = AppDatabase.instance;
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Nicht angemeldet. Bitte melde dich zuerst an.');
    }

    final deck = await db.getDeckById(localDeckId);
    if (deck == null) {
      throw Exception('Deck nicht gefunden.');
    }

    final cards = await db.getWordCardsByDeck(localDeckId);

    // У старому додатку документ деку = deck.name
    final deckDocRef = _deckCollection.doc(deck.name);

    await deckDocRef.set({
      'name': deck.name,
      'level': deck.level,
      'cardCount': cards.length,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
      'authorId': user.uid,
      'description': deck.description,
      'category': deck.category,
      'thumbnailEmoji': deck.thumbnailEmoji,
    }, SetOptions(merge: true));

    const batchSize = 30;

    for (int start = 0; start < cards.length; start += batchSize) {
      final end =
      (start + batchSize < cards.length) ? start + batchSize : cards.length;
      final chunk = cards.sublist(start, end);

      final batch = _firestore.batch();

      for (final card in chunk) {
        final cardRef = deckDocRef.collection('cards').doc();

        batch.set(cardRef, {
          'front_text': card.germanWord,
          'back_text': card.translation,
          'front_example_sentence': card.exampleSentence,
          'back_example_sentence': card.exampleTranslation,
          'transcription_ipa': '',
          'transcription_ua': '',
          'notes': '',
          'tags': card.tags,
          'article': card.article,
          'type': card.type,
          'pluralForm': card.pluralForm,
          'imageUrl': card.imageUrl,
          'level': card.level,
        });
      }

      await batch.commit();

      onProgress?.call(end, cards.length);
    }

    return deck.name;
  }

  // ─────────────────────────────────────────────
  // Отримати список deck-ів з хмари
  // ─────────────────────────────────────────────
  static Future<List<CloudDeckInfo>> getCloudDecks() async {
    print('CLOUD: getCloudDecks start');

    final snapshot = await _deckCollection.get();

    print('CLOUD: docs count = ${snapshot.docs.length}');

    return snapshot.docs.map((doc) {
      final data = doc.data();

      final rawCount = data['cardCount'];
      final cardCount = rawCount is int
          ? rawCount
          : int.tryParse(rawCount?.toString() ?? '0') ?? 0;

      return CloudDeckInfo(
        cloudId: doc.id,
        name: (data['name'] ?? doc.id).toString(),
        level: (data['level'] ?? '').toString(),
        totalCards: cardCount,
        authorId: data['authorId']?.toString(),
      );
    }).toList();
  }

  static String _normalizeLevel(String value) {
    final v = value.trim().toLowerCase();

    switch (v) {
      case 'a1':
        return 'a1';
      case 'a2':
        return 'a2';
      case 'b1':
        return 'b1';
      case 'b2':
        return 'b2';
      case 'c1':
        return 'c1';
      case 'c2':
        return 'c2';
      default:
        return 'a1';
    }
  }
  // ─────────────────────────────────────────────
  // IMPORT deck з Firestore -> локальна Drift БД
  // Читає саме старий Kotlin-формат
  // ─────────────────────────────────────────────
  static Future<String> importDeck(
      String cloudDeckId, {
        void Function(int processed, int total)? onProgress,
      }) async {
    final db = AppDatabase.instance;

    final deckDoc = await _deckCollection.doc(cloudDeckId).get();

    if (!deckDoc.exists) {
      throw Exception('Cloud-Deck nicht gefunden.');
    }

    final deckData = deckDoc.data()!;
    final cardsSnapshot =
    await _deckCollection.doc(cloudDeckId).collection('cards').get();

    final existingDecks = await db.getAllDecks();

    final baseName = (deckData['name'] ?? cloudDeckId).toString();
    String uniqueName = baseName;
    int counter = 1;

    while (existingDecks.any((d) => d.name == uniqueName)) {
      uniqueName = '$baseName ($counter)';
      counter++;
    }

    final newDeckId = _uuid.v4();

    await db.into(db.decks).insert(
      DecksCompanion.insert(
        id: newDeckId,
        name: uniqueName,
        description: (deckData['description'] ?? '').toString(),
        category: (deckData['category'] ?? '').toString(),
        level: _normalizeLevel((deckData['level'] ?? '').toString()),
        cardIds: '[]',
        totalCards: cardsSnapshot.docs.length,
        thumbnailEmoji: (deckData['thumbnailEmoji'] ?? '📚').toString(),
        createdAt: DateTime.now(),
      ),
    );

    for (int i = 0; i < cardsSnapshot.docs.length; i++) {
      final data = cardsSnapshot.docs[i].data();

      final germanWord = (data['front_text'] ?? '').toString();
      final translation = (data['back_text'] ?? '').toString();
      final exampleSentence = _nullableString(data['front_example_sentence']);
      final exampleTranslation = _nullableString(data['back_example_sentence']);
      final article = (data['article'] ?? '').toString();
      final type = (data['type'] ?? '').toString();
      final tags = (data['tags'] ?? '[]').toString();

      // Деякі старі картки можуть мати pluralForm, деякі ні
      final pluralForm = (data['pluralForm'] ?? '').toString();

      // imageUrl теж може бути відсутнє
      final imageUrl = _nullableString(data['imageUrl']);

      // level у картки може бути відсутній → беремо level деку
      final level = _normalizeLevel((data['level'] ?? deckData['level'] ?? '').toString());

      await db.into(db.wordCards).insert(
        WordCardsCompanion.insert(
          id: _uuid.v4(),
          germanWord: germanWord,
          translation: translation,
          article: article,
          pluralForm: pluralForm,
          exampleSentence: Value(exampleSentence),
          exampleTranslation: Value(exampleTranslation),
          imageUrl: Value(imageUrl),
          level: level,
          type: type,
          tags: tags,
          deckId: newDeckId,
        ),
      );

      onProgress?.call(i + 1, cardsSnapshot.docs.length);
    }

    return uniqueName;
  }

  static String? _nullableString(dynamic value) {
    if (value == null) return null;
    final s = value.toString().trim();
    if (s.isEmpty) return null;
    return s;
  }
}