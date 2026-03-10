import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'sentence_card.freezed.dart';
part 'sentence_card.g.dart';

@freezed
class SentenceCard with _$SentenceCard {
  const factory SentenceCard({
    required String id,
    required String incompleteSentence,
    required List<String> wordOptions,
    required String correctAnswer,
    required String completeSentence,
    required String translation,
    required DifficultyLevel level,
    String? grammarTopic,
  }) = _SentenceCard;

  factory SentenceCard.fromJson(Map<String, dynamic> json) =>
      _$SentenceCardFromJson(json);
}
