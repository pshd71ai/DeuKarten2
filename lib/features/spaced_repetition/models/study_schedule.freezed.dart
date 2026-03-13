// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StudySchedule _$StudyScheduleFromJson(Map<String, dynamic> json) {
  return _StudySchedule.fromJson(json);
}

/// @nodoc
mixin _$StudySchedule {
  DateTime get date => throw _privateConstructorUsedError;
  List<String> get newCards => throw _privateConstructorUsedError;
  List<String> get reviewCards => throw _privateConstructorUsedError;
  List<String> get learningCards => throw _privateConstructorUsedError;
  int get completedCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudyScheduleCopyWith<StudySchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyScheduleCopyWith<$Res> {
  factory $StudyScheduleCopyWith(
          StudySchedule value, $Res Function(StudySchedule) then) =
      _$StudyScheduleCopyWithImpl<$Res, StudySchedule>;
  @useResult
  $Res call(
      {DateTime date,
      List<String> newCards,
      List<String> reviewCards,
      List<String> learningCards,
      int completedCount});
}

/// @nodoc
class _$StudyScheduleCopyWithImpl<$Res, $Val extends StudySchedule>
    implements $StudyScheduleCopyWith<$Res> {
  _$StudyScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? newCards = null,
    Object? reviewCards = null,
    Object? learningCards = null,
    Object? completedCount = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      newCards: null == newCards
          ? _value.newCards
          : newCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reviewCards: null == reviewCards
          ? _value.reviewCards
          : reviewCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      learningCards: null == learningCards
          ? _value.learningCards
          : learningCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      completedCount: null == completedCount
          ? _value.completedCount
          : completedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudyScheduleImplCopyWith<$Res>
    implements $StudyScheduleCopyWith<$Res> {
  factory _$$StudyScheduleImplCopyWith(
          _$StudyScheduleImpl value, $Res Function(_$StudyScheduleImpl) then) =
      __$$StudyScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      List<String> newCards,
      List<String> reviewCards,
      List<String> learningCards,
      int completedCount});
}

/// @nodoc
class __$$StudyScheduleImplCopyWithImpl<$Res>
    extends _$StudyScheduleCopyWithImpl<$Res, _$StudyScheduleImpl>
    implements _$$StudyScheduleImplCopyWith<$Res> {
  __$$StudyScheduleImplCopyWithImpl(
      _$StudyScheduleImpl _value, $Res Function(_$StudyScheduleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? newCards = null,
    Object? reviewCards = null,
    Object? learningCards = null,
    Object? completedCount = null,
  }) {
    return _then(_$StudyScheduleImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      newCards: null == newCards
          ? _value._newCards
          : newCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reviewCards: null == reviewCards
          ? _value._reviewCards
          : reviewCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      learningCards: null == learningCards
          ? _value._learningCards
          : learningCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      completedCount: null == completedCount
          ? _value.completedCount
          : completedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyScheduleImpl implements _StudySchedule {
  const _$StudyScheduleImpl(
      {required this.date,
      required final List<String> newCards,
      required final List<String> reviewCards,
      required final List<String> learningCards,
      this.completedCount = 0})
      : _newCards = newCards,
        _reviewCards = reviewCards,
        _learningCards = learningCards;

  factory _$StudyScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyScheduleImplFromJson(json);

  @override
  final DateTime date;
  final List<String> _newCards;
  @override
  List<String> get newCards {
    if (_newCards is EqualUnmodifiableListView) return _newCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newCards);
  }

  final List<String> _reviewCards;
  @override
  List<String> get reviewCards {
    if (_reviewCards is EqualUnmodifiableListView) return _reviewCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviewCards);
  }

  final List<String> _learningCards;
  @override
  List<String> get learningCards {
    if (_learningCards is EqualUnmodifiableListView) return _learningCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_learningCards);
  }

  @override
  @JsonKey()
  final int completedCount;

  @override
  String toString() {
    return 'StudySchedule(date: $date, newCards: $newCards, reviewCards: $reviewCards, learningCards: $learningCards, completedCount: $completedCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyScheduleImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._newCards, _newCards) &&
            const DeepCollectionEquality()
                .equals(other._reviewCards, _reviewCards) &&
            const DeepCollectionEquality()
                .equals(other._learningCards, _learningCards) &&
            (identical(other.completedCount, completedCount) ||
                other.completedCount == completedCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      const DeepCollectionEquality().hash(_newCards),
      const DeepCollectionEquality().hash(_reviewCards),
      const DeepCollectionEquality().hash(_learningCards),
      completedCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyScheduleImplCopyWith<_$StudyScheduleImpl> get copyWith =>
      __$$StudyScheduleImplCopyWithImpl<_$StudyScheduleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyScheduleImplToJson(
      this,
    );
  }
}

abstract class _StudySchedule implements StudySchedule {
  const factory _StudySchedule(
      {required final DateTime date,
      required final List<String> newCards,
      required final List<String> reviewCards,
      required final List<String> learningCards,
      final int completedCount}) = _$StudyScheduleImpl;

  factory _StudySchedule.fromJson(Map<String, dynamic> json) =
      _$StudyScheduleImpl.fromJson;

  @override
  DateTime get date;
  @override
  List<String> get newCards;
  @override
  List<String> get reviewCards;
  @override
  List<String> get learningCards;
  @override
  int get completedCount;
  @override
  @JsonKey(ignore: true)
  _$$StudyScheduleImplCopyWith<_$StudyScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyStats _$DailyStatsFromJson(Map<String, dynamic> json) {
  return _DailyStats.fromJson(json);
}

/// @nodoc
mixin _$DailyStats {
  DateTime get date => throw _privateConstructorUsedError;
  int get newCardsStudied => throw _privateConstructorUsedError;
  int get reviewsCompleted => throw _privateConstructorUsedError;
  int get cardsLearned => throw _privateConstructorUsedError;
  int get xpEarned => throw _privateConstructorUsedError;
  double get averageQuality => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyStatsCopyWith<DailyStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyStatsCopyWith<$Res> {
  factory $DailyStatsCopyWith(
          DailyStats value, $Res Function(DailyStats) then) =
      _$DailyStatsCopyWithImpl<$Res, DailyStats>;
  @useResult
  $Res call(
      {DateTime date,
      int newCardsStudied,
      int reviewsCompleted,
      int cardsLearned,
      int xpEarned,
      double averageQuality});
}

/// @nodoc
class _$DailyStatsCopyWithImpl<$Res, $Val extends DailyStats>
    implements $DailyStatsCopyWith<$Res> {
  _$DailyStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? newCardsStudied = null,
    Object? reviewsCompleted = null,
    Object? cardsLearned = null,
    Object? xpEarned = null,
    Object? averageQuality = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      newCardsStudied: null == newCardsStudied
          ? _value.newCardsStudied
          : newCardsStudied // ignore: cast_nullable_to_non_nullable
              as int,
      reviewsCompleted: null == reviewsCompleted
          ? _value.reviewsCompleted
          : reviewsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      cardsLearned: null == cardsLearned
          ? _value.cardsLearned
          : cardsLearned // ignore: cast_nullable_to_non_nullable
              as int,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      averageQuality: null == averageQuality
          ? _value.averageQuality
          : averageQuality // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyStatsImplCopyWith<$Res>
    implements $DailyStatsCopyWith<$Res> {
  factory _$$DailyStatsImplCopyWith(
          _$DailyStatsImpl value, $Res Function(_$DailyStatsImpl) then) =
      __$$DailyStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      int newCardsStudied,
      int reviewsCompleted,
      int cardsLearned,
      int xpEarned,
      double averageQuality});
}

/// @nodoc
class __$$DailyStatsImplCopyWithImpl<$Res>
    extends _$DailyStatsCopyWithImpl<$Res, _$DailyStatsImpl>
    implements _$$DailyStatsImplCopyWith<$Res> {
  __$$DailyStatsImplCopyWithImpl(
      _$DailyStatsImpl _value, $Res Function(_$DailyStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? newCardsStudied = null,
    Object? reviewsCompleted = null,
    Object? cardsLearned = null,
    Object? xpEarned = null,
    Object? averageQuality = null,
  }) {
    return _then(_$DailyStatsImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      newCardsStudied: null == newCardsStudied
          ? _value.newCardsStudied
          : newCardsStudied // ignore: cast_nullable_to_non_nullable
              as int,
      reviewsCompleted: null == reviewsCompleted
          ? _value.reviewsCompleted
          : reviewsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      cardsLearned: null == cardsLearned
          ? _value.cardsLearned
          : cardsLearned // ignore: cast_nullable_to_non_nullable
              as int,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      averageQuality: null == averageQuality
          ? _value.averageQuality
          : averageQuality // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyStatsImpl implements _DailyStats {
  const _$DailyStatsImpl(
      {required this.date,
      required this.newCardsStudied,
      required this.reviewsCompleted,
      required this.cardsLearned,
      required this.xpEarned,
      required this.averageQuality});

  factory _$DailyStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyStatsImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int newCardsStudied;
  @override
  final int reviewsCompleted;
  @override
  final int cardsLearned;
  @override
  final int xpEarned;
  @override
  final double averageQuality;

  @override
  String toString() {
    return 'DailyStats(date: $date, newCardsStudied: $newCardsStudied, reviewsCompleted: $reviewsCompleted, cardsLearned: $cardsLearned, xpEarned: $xpEarned, averageQuality: $averageQuality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyStatsImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.newCardsStudied, newCardsStudied) ||
                other.newCardsStudied == newCardsStudied) &&
            (identical(other.reviewsCompleted, reviewsCompleted) ||
                other.reviewsCompleted == reviewsCompleted) &&
            (identical(other.cardsLearned, cardsLearned) ||
                other.cardsLearned == cardsLearned) &&
            (identical(other.xpEarned, xpEarned) ||
                other.xpEarned == xpEarned) &&
            (identical(other.averageQuality, averageQuality) ||
                other.averageQuality == averageQuality));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, newCardsStudied,
      reviewsCompleted, cardsLearned, xpEarned, averageQuality);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyStatsImplCopyWith<_$DailyStatsImpl> get copyWith =>
      __$$DailyStatsImplCopyWithImpl<_$DailyStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyStatsImplToJson(
      this,
    );
  }
}

abstract class _DailyStats implements DailyStats {
  const factory _DailyStats(
      {required final DateTime date,
      required final int newCardsStudied,
      required final int reviewsCompleted,
      required final int cardsLearned,
      required final int xpEarned,
      required final double averageQuality}) = _$DailyStatsImpl;

  factory _DailyStats.fromJson(Map<String, dynamic> json) =
      _$DailyStatsImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get newCardsStudied;
  @override
  int get reviewsCompleted;
  @override
  int get cardsLearned;
  @override
  int get xpEarned;
  @override
  double get averageQuality;
  @override
  @JsonKey(ignore: true)
  _$$DailyStatsImplCopyWith<_$DailyStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
