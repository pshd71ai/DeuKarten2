// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$TestSession implements _TestSession {
  const _$TestSession({
    required this.test,
    required this.userAnswers,
    required this.currentQuestionIndex,
    required this.startTime,
    this.timeLeft,
    this.timeElapsed,
    this.isComplete = false,
  });

  @override
  final TestModel test;

  @override
  final List<int> userAnswers;

  @override
  final int currentQuestionIndex;

  @override
  final DateTime? startTime;

  @override
  final int? timeLeft;

  @override
  final int? timeElapsed;

  @override
  final bool isComplete;

  @override
  String toString() {
    return 'TestSession(test: $test, userAnswers: $userAnswers, currentQuestionIndex: $currentQuestionIndex, startTime: $startTime, timeLeft: $timeLeft, timeElapsed: $timeElapsed, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestSession &&
            (identical(other.test, test) || other.test == test) &&
            const ListEquality().equals(other.userAnswers, userAnswers) &&
            other.currentQuestionIndex == currentQuestionIndex &&
            other.startTime == startTime &&
            other.timeLeft == timeLeft &&
            other.timeElapsed == timeElapsed &&
            other.isComplete == isComplete);
  }

  @override
  int get hashCode => Object.hash(runtimeType, test, userAnswers, currentQuestionIndex, startTime, timeLeft, timeElapsed, isComplete);

  @override
  @optionalTypeArgs
  TResult? map<TResult>({
    TResult Function(_$TestSession value)? _$,
  }) {
    return _$?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult>({
    TResult Function(_$TestSession value)? _$,
  }) {
    return _$?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult>({
    TResult Function(_$TestSession value)? _$,
    required TResult orElse(),
  }) {
    return _$?.call(this) ?? orElse();
  }
}

class _$$_TestSession with _$TestSession {
  const _$$_TestSession({
    required super.test,
    required super.userAnswers,
    required super.currentQuestionIndex,
    required super.startTime,
    super.timeLeft,
    super.timeElapsed,
    super.isComplete = false,
  }) : super._();

  @override
  TestSession copyWith({
    TestModel? test,
    List<int>? userAnswers,
    int? currentQuestionIndex,
    DateTime? startTime,
    int? timeLeft,
    int? timeElapsed,
    bool? isComplete,
  }) {
    return TestSession(
      test: test ?? this.test,
      userAnswers: userAnswers ?? this.userAnswers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      startTime: startTime ?? this.startTime,
      timeLeft: timeLeft ?? this.timeLeft,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

class _$AnswerReview implements _AnswerReview {
  const _$AnswerReview({
    required this.question,
    required this.correctAnswer,
    required this.selectedAnswer,
  });

  @override
  final QuestionModel question;

  @override
  final String correctAnswer;

  @override
  final String selectedAnswer;

  @override
  String toString() {
    return 'AnswerReview(question: $question, correctAnswer: $correctAnswer, selectedAnswer: $selectedAnswer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerReview &&
            (identical(other.question, question) || other.question == question) &&
            other.correctAnswer == correctAnswer &&
            other.selectedAnswer == selectedAnswer);
  }

  @override
  int get hashCode => Object.hash(runtimeType, question, correctAnswer, selectedAnswer);

  @override
  @optionalTypeArgs
  TResult? map<TResult>({
    TResult Function(_$AnswerReview value)? _$,
  }) {
    return _$?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult>({
    TResult Function(_$AnswerReview value)? _$,
  }) {
    return _$?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult>({
    TResult Function(_$AnswerReview value)? _$,
    required TResult orElse(),
  }) {
    return _$?.call(this) ?? orElse();
  }
}

class $$_AnswerReview with _$AnswerReview {
  const $$_AnswerReview({
    required super.question,
    required super.correctAnswer,
    required super.selectedAnswer,
  }) : super._();

  @override
  AnswerReview copyWith({
    QuestionModel? question,
    String? correctAnswer,
    String? selectedAnswer,
  }) {
    return AnswerReview(
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }
}
