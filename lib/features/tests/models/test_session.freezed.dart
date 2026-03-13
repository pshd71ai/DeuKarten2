// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestSession _$TestSessionFromJson(Map<String, dynamic> json) {
  return _TestSession.fromJson(json);
}

/// @nodoc
mixin _$TestSession {
  TestModel get test => throw _privateConstructorUsedError;
  List<int> get userAnswers => throw _privateConstructorUsedError;
  int get currentQuestionIndex => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  int? get timeLeft => throw _privateConstructorUsedError;
  int? get timeElapsed => throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TestSessionCopyWith<TestSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestSessionCopyWith<$Res> {
  factory $TestSessionCopyWith(
          TestSession value, $Res Function(TestSession) then) =
      _$TestSessionCopyWithImpl<$Res, TestSession>;
  @useResult
  $Res call(
      {TestModel test,
      List<int> userAnswers,
      int currentQuestionIndex,
      DateTime? startTime,
      int? timeLeft,
      int? timeElapsed,
      bool isComplete});
}

/// @nodoc
class _$TestSessionCopyWithImpl<$Res, $Val extends TestSession>
    implements $TestSessionCopyWith<$Res> {
  _$TestSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? test = null,
    Object? userAnswers = null,
    Object? currentQuestionIndex = null,
    Object? startTime = freezed,
    Object? timeLeft = freezed,
    Object? timeElapsed = freezed,
    Object? isComplete = null,
  }) {
    return _then(_value.copyWith(
      test: null == test
          ? _value.test
          : test // ignore: cast_nullable_to_non_nullable
              as TestModel,
      userAnswers: null == userAnswers
          ? _value.userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      currentQuestionIndex: null == currentQuestionIndex
          ? _value.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timeLeft: freezed == timeLeft
          ? _value.timeLeft
          : timeLeft // ignore: cast_nullable_to_non_nullable
              as int?,
      timeElapsed: freezed == timeElapsed
          ? _value.timeElapsed
          : timeElapsed // ignore: cast_nullable_to_non_nullable
              as int?,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestSessionImplCopyWith<$Res>
    implements $TestSessionCopyWith<$Res> {
  factory _$$TestSessionImplCopyWith(
          _$TestSessionImpl value, $Res Function(_$TestSessionImpl) then) =
      __$$TestSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TestModel test,
      List<int> userAnswers,
      int currentQuestionIndex,
      DateTime? startTime,
      int? timeLeft,
      int? timeElapsed,
      bool isComplete});
}

/// @nodoc
class __$$TestSessionImplCopyWithImpl<$Res>
    extends _$TestSessionCopyWithImpl<$Res, _$TestSessionImpl>
    implements _$$TestSessionImplCopyWith<$Res> {
  __$$TestSessionImplCopyWithImpl(
      _$TestSessionImpl _value, $Res Function(_$TestSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? test = null,
    Object? userAnswers = null,
    Object? currentQuestionIndex = null,
    Object? startTime = freezed,
    Object? timeLeft = freezed,
    Object? timeElapsed = freezed,
    Object? isComplete = null,
  }) {
    return _then(_$TestSessionImpl(
      test: null == test
          ? _value.test
          : test // ignore: cast_nullable_to_non_nullable
              as TestModel,
      userAnswers: null == userAnswers
          ? _value._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      currentQuestionIndex: null == currentQuestionIndex
          ? _value.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timeLeft: freezed == timeLeft
          ? _value.timeLeft
          : timeLeft // ignore: cast_nullable_to_non_nullable
              as int?,
      timeElapsed: freezed == timeElapsed
          ? _value.timeElapsed
          : timeElapsed // ignore: cast_nullable_to_non_nullable
              as int?,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestSessionImpl extends _TestSession {
  const _$TestSessionImpl(
      {required this.test,
      required final List<int> userAnswers,
      required this.currentQuestionIndex,
      this.startTime,
      this.timeLeft,
      this.timeElapsed,
      this.isComplete = false})
      : _userAnswers = userAnswers,
        super._();

  factory _$TestSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestSessionImplFromJson(json);

  @override
  final TestModel test;
  final List<int> _userAnswers;
  @override
  List<int> get userAnswers {
    if (_userAnswers is EqualUnmodifiableListView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userAnswers);
  }

  @override
  final int currentQuestionIndex;
  @override
  final DateTime? startTime;
  @override
  final int? timeLeft;
  @override
  final int? timeElapsed;
  @override
  @JsonKey()
  final bool isComplete;

  @override
  String toString() {
    return 'TestSession(test: $test, userAnswers: $userAnswers, currentQuestionIndex: $currentQuestionIndex, startTime: $startTime, timeLeft: $timeLeft, timeElapsed: $timeElapsed, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestSessionImpl &&
            (identical(other.test, test) || other.test == test) &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.timeLeft, timeLeft) ||
                other.timeLeft == timeLeft) &&
            (identical(other.timeElapsed, timeElapsed) ||
                other.timeElapsed == timeElapsed) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      test,
      const DeepCollectionEquality().hash(_userAnswers),
      currentQuestionIndex,
      startTime,
      timeLeft,
      timeElapsed,
      isComplete);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestSessionImplCopyWith<_$TestSessionImpl> get copyWith =>
      __$$TestSessionImplCopyWithImpl<_$TestSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestSessionImplToJson(
      this,
    );
  }
}

abstract class _TestSession extends TestSession {
  const factory _TestSession(
      {required final TestModel test,
      required final List<int> userAnswers,
      required final int currentQuestionIndex,
      final DateTime? startTime,
      final int? timeLeft,
      final int? timeElapsed,
      final bool isComplete}) = _$TestSessionImpl;
  const _TestSession._() : super._();

  factory _TestSession.fromJson(Map<String, dynamic> json) =
      _$TestSessionImpl.fromJson;

  @override
  TestModel get test;
  @override
  List<int> get userAnswers;
  @override
  int get currentQuestionIndex;
  @override
  DateTime? get startTime;
  @override
  int? get timeLeft;
  @override
  int? get timeElapsed;
  @override
  bool get isComplete;
  @override
  @JsonKey(ignore: true)
  _$$TestSessionImplCopyWith<_$TestSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnswerReview _$AnswerReviewFromJson(Map<String, dynamic> json) {
  return _AnswerReview.fromJson(json);
}

/// @nodoc
mixin _$AnswerReview {
  QuestionModel get question => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  String get selectedAnswer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnswerReviewCopyWith<AnswerReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerReviewCopyWith<$Res> {
  factory $AnswerReviewCopyWith(
          AnswerReview value, $Res Function(AnswerReview) then) =
      _$AnswerReviewCopyWithImpl<$Res, AnswerReview>;
  @useResult
  $Res call(
      {QuestionModel question, String correctAnswer, String selectedAnswer});
}

/// @nodoc
class _$AnswerReviewCopyWithImpl<$Res, $Val extends AnswerReview>
    implements $AnswerReviewCopyWith<$Res> {
  _$AnswerReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? correctAnswer = null,
    Object? selectedAnswer = null,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as QuestionModel,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      selectedAnswer: null == selectedAnswer
          ? _value.selectedAnswer
          : selectedAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnswerReviewImplCopyWith<$Res>
    implements $AnswerReviewCopyWith<$Res> {
  factory _$$AnswerReviewImplCopyWith(
          _$AnswerReviewImpl value, $Res Function(_$AnswerReviewImpl) then) =
      __$$AnswerReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {QuestionModel question, String correctAnswer, String selectedAnswer});
}

/// @nodoc
class __$$AnswerReviewImplCopyWithImpl<$Res>
    extends _$AnswerReviewCopyWithImpl<$Res, _$AnswerReviewImpl>
    implements _$$AnswerReviewImplCopyWith<$Res> {
  __$$AnswerReviewImplCopyWithImpl(
      _$AnswerReviewImpl _value, $Res Function(_$AnswerReviewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? correctAnswer = null,
    Object? selectedAnswer = null,
  }) {
    return _then(_$AnswerReviewImpl(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as QuestionModel,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      selectedAnswer: null == selectedAnswer
          ? _value.selectedAnswer
          : selectedAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerReviewImpl implements _AnswerReview {
  const _$AnswerReviewImpl(
      {required this.question,
      required this.correctAnswer,
      required this.selectedAnswer});

  factory _$AnswerReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerReviewImplFromJson(json);

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
            other is _$AnswerReviewImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.selectedAnswer, selectedAnswer) ||
                other.selectedAnswer == selectedAnswer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, question, correctAnswer, selectedAnswer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerReviewImplCopyWith<_$AnswerReviewImpl> get copyWith =>
      __$$AnswerReviewImplCopyWithImpl<_$AnswerReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerReviewImplToJson(
      this,
    );
  }
}

abstract class _AnswerReview implements AnswerReview {
  const factory _AnswerReview(
      {required final QuestionModel question,
      required final String correctAnswer,
      required final String selectedAnswer}) = _$AnswerReviewImpl;

  factory _AnswerReview.fromJson(Map<String, dynamic> json) =
      _$AnswerReviewImpl.fromJson;

  @override
  QuestionModel get question;
  @override
  String get correctAnswer;
  @override
  String get selectedAnswer;
  @override
  @JsonKey(ignore: true)
  _$$AnswerReviewImplCopyWith<_$AnswerReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
