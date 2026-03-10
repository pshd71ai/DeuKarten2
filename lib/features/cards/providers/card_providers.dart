import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/card_model.dart';

// Sample data provider - replace with actual data source
final cardsProvider = StateNotifierProvider<CardsNotifier, List<CardModel>>((ref) {
  return CardsNotifier();
});

class CardsNotifier extends StateNotifier<List<CardModel>> {
  CardsNotifier() : super(_sampleCards);

  void addCard(CardModel card) {
    state = [...state, card];
  }

  void updateCard(CardModel updatedCard) {
    state = state.map((card) {
      return card.id == updatedCard.id ? updatedCard : card;
    }).toList();
  }

  void deleteCard(String cardId) {
    state = state.where((card) => card.id != cardId).toList();
  }

  List<CardModel> getCardsByCategory(String category) {
    return state.where((card) => card.category == category).toList();
  }

  List<CardModel> getCardsByLevel(int level) {
    return state.where((card) => card.level == level).toList();
  }
}

final _sampleCards = <CardModel>[
  CardModel(
    id: '1',
    german: 'Hallo',
    english: 'Hello',
    exampleGerman: 'Hallo, wie geht es dir?',
    exampleEnglish: 'Hello, how are you?',
    category: 'Greetings',
  ),
  CardModel(
    id: '2',
    german: 'Danke',
    english: 'Thank you',
    exampleGerman: 'Vielen Danke!',
    exampleEnglish: 'Thank you very much!',
    category: 'Greetings',
  ),
  CardModel(
    id: '3',
    german: 'Bitte',
    english: 'Please/You\'re welcome',
    exampleGerman: 'Bitte schön',
    exampleEnglish: 'You\'re welcome',
    category: 'Greetings',
  ),
  CardModel(
    id: '4',
    german: 'Guten Morgen',
    english: 'Good morning',
    exampleGerman: 'Guten Morgen, meine Freunde!',
    exampleEnglish: 'Good morning, my friends!',
    category: 'Greetings',
  ),
  CardModel(
    id: '5',
    german: 'Auf Wiedersehen',
    english: 'Goodbye',
    exampleGerman: 'Auf Wiedersehen und bis bald!',
    exampleEnglish: 'Goodbye and see you soon!',
    category: 'Greetings',
  ),
];
