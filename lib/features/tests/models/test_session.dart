import 'package:freezed_annotation/freezed_annotation.dart';
import 'test_model.dart';
import 'question_model.dart';

part 'test_session.freezed.dart';
part 'test_session.g.dart';

@freezed
class TestSession with _$TestSession {
  const factory TestSession({
    required TestModel test,
    required List<int> userAnswers,
    required int currentQuestionIndex,
    DateTime? startTime,
    int? timeLeft,
    int? timeElapsed,
    @Default(false) bool isComplete,
  }) = _TestSession;

  factory TestSession.fromJson(Map<String, dynamic> json) =>
      _$TestSessionFromJson(json);

  const TestSession._();

  QuestionModel? get currentQuestion =>
      currentQuestionIndex < test.questions.length
          ? test.questions[currentQuestionIndex]
          : null;

  int get totalQuestions => test.questions.length;

  int get correctAnswers => userAnswers
      .asMap()
      .entries
      .where((entry) =>
          entry.value == test.questions[entry.key].correctAnswerIndex)
      .length;

  int get score => totalQuestions > 0
      ? ((correctAnswers / totalQuestions) * 100).round()
      : 0;

  bool get isPassed => score >= (test.minPassingScore ?? 70);

  List<AnswerReview> get incorrectAnswers {
    final List<AnswerReview> reviews = [];
    for (int i = 0; i < test.questions.length; i++) {
      if (userAnswers[i] != test.questions[i].correctAnswerIndex) {
        reviews.add(AnswerReview(
          question: test.questions[i],
          correctAnswer: test.questions[i]
              .options[test.questions[i].correctAnswerIndex],
          selectedAnswer: userAnswers[i] >= 0
              ? test.questions[i].options[userAnswers[i]]
              : '',
        ));
      }
    }
    return reviews;
  }
}

@freezed
class AnswerReview with _$AnswerReview {
  const factory AnswerReview({
    required QuestionModel question,
    required String correctAnswer,
    required String selectedAnswer,
  }) = _AnswerReview;

  factory AnswerReview.fromJson(Map<String, dynamic> json) =>
      _$AnswerReviewFromJson(json);
}
