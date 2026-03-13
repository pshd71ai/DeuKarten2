// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestSessionImpl _$$TestSessionImplFromJson(Map<String, dynamic> json) =>
    _$TestSessionImpl(
      test: TestModel.fromJson(json['test'] as Map<String, dynamic>),
      userAnswers: (json['userAnswers'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      currentQuestionIndex: (json['currentQuestionIndex'] as num).toInt(),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      timeLeft: (json['timeLeft'] as num?)?.toInt(),
      timeElapsed: (json['timeElapsed'] as num?)?.toInt(),
      isComplete: json['isComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$$TestSessionImplToJson(_$TestSessionImpl instance) =>
    <String, dynamic>{
      'test': instance.test,
      'userAnswers': instance.userAnswers,
      'currentQuestionIndex': instance.currentQuestionIndex,
      'startTime': instance.startTime?.toIso8601String(),
      'timeLeft': instance.timeLeft,
      'timeElapsed': instance.timeElapsed,
      'isComplete': instance.isComplete,
    };

_$AnswerReviewImpl _$$AnswerReviewImplFromJson(Map<String, dynamic> json) =>
    _$AnswerReviewImpl(
      question:
          QuestionModel.fromJson(json['question'] as Map<String, dynamic>),
      correctAnswer: json['correctAnswer'] as String,
      selectedAnswer: json['selectedAnswer'] as String,
    );

Map<String, dynamic> _$$AnswerReviewImplToJson(_$AnswerReviewImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'correctAnswer': instance.correctAnswer,
      'selectedAnswer': instance.selectedAnswer,
    };
