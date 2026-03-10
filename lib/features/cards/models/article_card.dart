import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'article_card.freezed.dart';
part 'article_card.g.dart';

@freezed
class ArticleCard with _$ArticleCard {
  const factory ArticleCard({
    required String id,
    required String word,
    required String correctArticle,
    required List<String> options,
    required String translation,
    String? exampleSentence,
    required DifficultyLevel level,
  }) = _ArticleCard;

  factory ArticleCard.fromJson(Map<String, dynamic> json) =>
      _$ArticleCardFromJson(json);
}
