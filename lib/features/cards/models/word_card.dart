import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'word_card.freezed.dart';
part 'word_card.g.dart';

@freezed
class WordCard with _$WordCard {
  const factory WordCard({
    required String id,
    required String germanWord,
    required String translation,
    required String article,
    required String pluralForm,
    String? exampleSentence,
    String? exampleTranslation,
    String? imageUrl,
    required DifficultyLevel level,
    required CardType type,
    required List<String> tags,
    DateTime? lastReviewed,
    DateTime? nextReview,
    int? intervalDays,
    @Default(0) int repetitionCount,
    @Default(2.5) double easeFactor,
  }) = _WordCard;

  factory WordCard.fromJson(Map<String, dynamic> json) =>
      _$WordCardFromJson(json);
}
