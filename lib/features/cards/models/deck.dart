import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'deck.freezed.dart';
part 'deck.g.dart';

@freezed
class Deck with _$Deck {
  const factory Deck({
    required String id,
    required String name,
    required String description,
    required String category,
    required DifficultyLevel level,
    required List<String> cardIds,
    required int totalCards,
    int? cardsLearned,
    double? progress,
    String? thumbnailEmoji,
    required DateTime createdAt,
    DateTime? lastStudied,
  }) = _Deck;

  factory Deck.fromJson(Map<String, dynamic> json) =>
      _$DeckFromJson(json);
}
