// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestSession _$TestSessionFromJson(Map<String, dynamic> json) =>
    TestSession(
      test: json['test'] == null
          ? throw ArgumentError.notNull('test')
          : TestModel.fromJson(json['test'] as Map<String, dynamic>),
      userAnswers: (json['userAnswers'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      currentQuestionIndex: json['currentQuestionIndex'] as int,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      timeLeft: json['timeLeft'] as int?,
      timeElapsed: json['timeElapsed'] as int?,
      isComplete: json['isComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$TestSessionToJson(TestSession instance) =>
    <String, dynamic>{
      'test': instance.test,
      'userAnswers': instance.userAnswers,
      'currentQuestionIndex': instance.currentQuestionIndex,
      'startTime': instance.startTime?.toIso8601String(),
      'timeLeft': instance.timeLeft,
      'timeElapsed': instance.timeElapsed,
      'isComplete': instance.isComplete,
    };

AnswerReview _$AnswerReviewFromJson(Map<String, dynamic> json) =>
    AnswerReview(
      question: json['question'] == null
          ? throw ArgumentError.notNull('question')
          : QuestionModel.fromJson(json['question'] as Map<String, dynamic>),
      correctAnswer: json['correctAnswer'] as String,
      selectedAnswer: json['selectedAnswer'] as String,
    );

Map<String, dynamic> _$AnswerReviewToJson(AnswerReview instance) =>
    <String, dynamic>{
      'question': instance.question,
      'correctAnswer': instance.correctAnswer,
      'selectedAnswer': instance.selectedAnswer,
    };
