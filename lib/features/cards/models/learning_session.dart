import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'learning_session.freezed.dart';
part 'learning_session.g.dart';

@freezed
class LearningSession with _$LearningSession {
  const factory LearningSession({
    required String id,
    required String deckId,
    required DateTime startedAt,
    DateTime? completedAt,
    required List<SessionCard> cards,
    int? cardsStudied,
    int? correctAnswers,
    int? xpEarned,
    @Default(SessionStatus.inProgress) SessionStatus status,
  }) = _LearningSession;

  factory LearningSession.fromJson(Map<String, dynamic> json) =>
      _$LearningSessionFromJson(json);
}

@freezed
class SessionCard with _$SessionCard {
  const factory SessionCard({
    required String cardId,
    required CardType type,
    @Default(CardStatus.new_card) CardStatus status,
    int? attempts,
    bool? wasCorrect,
    DateTime? shownAt,
    DateTime? answeredAt,
  }) = _SessionCard;

  factory SessionCard.fromJson(Map<String, dynamic> json) =>
      _$SessionCardFromJson(json);
}
