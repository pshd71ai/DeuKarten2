// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CardProgress _$CardProgressFromJson(Map<String, dynamic> json) {
  return _CardProgress.fromJson(json);
}

/// @nodoc
mixin _$CardProgress {
  String get cardId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastReviewed => throw _privateConstructorUsedError;
  DateTime? get nextReview => throw _privateConstructorUsedError;

  /// SM-2 Algorithm fields
  int get repetitions => throw _privateConstructorUsedError;

  /// EF - Easiness factor (starts at 2.5)
  double get easeFactor => throw _privateConstructorUsedError;

  /// Current interval in days (I)
  int get intervalDays => throw _privateConstructorUsedError;

  /// Quality of response (0-5)
  /// 5 - perfect response
  /// 4 - correct response after hesitation
  /// 3 - correct response recalled with serious difficulty
  /// 2 - incorrect response; correct one remembered
  /// 1 - incorrect response; correct one seemed easy to recall
  /// 0 - complete blackout
  int? get lastQuality => throw _privateConstructorUsedError;

  /// Statistics
  int get totalReviews => throw _privateConstructorUsedError;
  int get correctReviews => throw _privateConstructorUsedError;
  int get consecutiveCorrect => throw _privateConstructorUsedError;

  /// Status
  SRSStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CardProgressCopyWith<CardProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardProgressCopyWith<$Res> {
  factory $CardProgressCopyWith(
          CardProgress value, $Res Function(CardProgress) then) =
      _$CardProgressCopyWithImpl<$Res, CardProgress>;
  @useResult
  $Res call(
      {String cardId,
      DateTime createdAt,
      DateTime? lastReviewed,
      DateTime? nextReview,
      int repetitions,
      double easeFactor,
      int intervalDays,
      int? lastQuality,
      int totalReviews,
      int correctReviews,
      int consecutiveCorrect,
      SRSStatus status});
}

/// @nodoc
class _$CardProgressCopyWithImpl<$Res, $Val extends CardProgress>
    implements $CardProgressCopyWith<$Res> {
  _$CardProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? createdAt = null,
    Object? lastReviewed = freezed,
    Object? nextReview = freezed,
    Object? repetitions = null,
    Object? easeFactor = null,
    Object? intervalDays = null,
    Object? lastQuality = freezed,
    Object? totalReviews = null,
    Object? correctReviews = null,
    Object? consecutiveCorrect = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastReviewed: freezed == lastReviewed
          ? _value.lastReviewed
          : lastReviewed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextReview: freezed == nextReview
          ? _value.nextReview
          : nextReview // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      repetitions: null == repetitions
          ? _value.repetitions
          : repetitions // ignore: cast_nullable_to_non_nullable
              as int,
      easeFactor: null == easeFactor
          ? _value.easeFactor
          : easeFactor // ignore: cast_nullable_to_non_nullable
              as double,
      intervalDays: null == intervalDays
          ? _value.intervalDays
          : intervalDays // ignore: cast_nullable_to_non_nullable
              as int,
      lastQuality: freezed == lastQuality
          ? _value.lastQuality
          : lastQuality // ignore: cast_nullable_to_non_nullable
              as int?,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      correctReviews: null == correctReviews
          ? _value.correctReviews
          : correctReviews // ignore: cast_nullable_to_non_nullable
              as int,
      consecutiveCorrect: null == consecutiveCorrect
          ? _value.consecutiveCorrect
          : consecutiveCorrect // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SRSStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardProgressImplCopyWith<$Res>
    implements $CardProgressCopyWith<$Res> {
  factory _$$CardProgressImplCopyWith(
          _$CardProgressImpl value, $Res Function(_$CardProgressImpl) then) =
      __$$CardProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String cardId,
      DateTime createdAt,
      DateTime? lastReviewed,
      DateTime? nextReview,
      int repetitions,
      double easeFactor,
      int intervalDays,
      int? lastQuality,
      int totalReviews,
      int correctReviews,
      int consecutiveCorrect,
      SRSStatus status});
}

/// @nodoc
class __$$CardProgressImplCopyWithImpl<$Res>
    extends _$CardProgressCopyWithImpl<$Res, _$CardProgressImpl>
    implements _$$CardProgressImplCopyWith<$Res> {
  __$$CardProgressImplCopyWithImpl(
      _$CardProgressImpl _value, $Res Function(_$CardProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? createdAt = null,
    Object? lastReviewed = freezed,
    Object? nextReview = freezed,
    Object? repetitions = null,
    Object? easeFactor = null,
    Object? intervalDays = null,
    Object? lastQuality = freezed,
    Object? totalReviews = null,
    Object? correctReviews = null,
    Object? consecutiveCorrect = null,
    Object? status = null,
  }) {
    return _then(_$CardProgressImpl(
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastReviewed: freezed == lastReviewed
          ? _value.lastReviewed
          : lastReviewed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextReview: freezed == nextReview
          ? _value.nextReview
          : nextReview // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      repetitions: null == repetitions
          ? _value.repetitions
          : repetitions // ignore: cast_nullable_to_non_nullable
              as int,
      easeFactor: null == easeFactor
          ? _value.easeFactor
          : easeFactor // ignore: cast_nullable_to_non_nullable
              as double,
      intervalDays: null == intervalDays
          ? _value.intervalDays
          : intervalDays // ignore: cast_nullable_to_non_nullable
              as int,
      lastQuality: freezed == lastQuality
          ? _value.lastQuality
          : lastQuality // ignore: cast_nullable_to_non_nullable
              as int?,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      correctReviews: null == correctReviews
          ? _value.correctReviews
          : correctReviews // ignore: cast_nullable_to_non_nullable
              as int,
      consecutiveCorrect: null == consecutiveCorrect
          ? _value.consecutiveCorrect
          : consecutiveCorrect // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SRSStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CardProgressImpl implements _CardProgress {
  const _$CardProgressImpl(
      {required this.cardId,
      required this.createdAt,
      this.lastReviewed,
      this.nextReview,
      this.repetitions = 0,
      this.easeFactor = 2.5,
      this.intervalDays = 0,
      this.lastQuality,
      this.totalReviews = 0,
      this.correctReviews = 0,
      this.consecutiveCorrect = 0,
      this.status = SRSStatus.newCard});

  factory _$CardProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardProgressImplFromJson(json);

  @override
  final String cardId;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastReviewed;
  @override
  final DateTime? nextReview;

  /// SM-2 Algorithm fields
  @override
  @JsonKey()
  final int repetitions;

  /// EF - Easiness factor (starts at 2.5)
  @override
  @JsonKey()
  final double easeFactor;

  /// Current interval in days (I)
  @override
  @JsonKey()
  final int intervalDays;

  /// Quality of response (0-5)
  /// 5 - perfect response
  /// 4 - correct response after hesitation
  /// 3 - correct response recalled with serious difficulty
  /// 2 - incorrect response; correct one remembered
  /// 1 - incorrect response; correct one seemed easy to recall
  /// 0 - complete blackout
  @override
  final int? lastQuality;

  /// Statistics
  @override
  @JsonKey()
  final int totalReviews;
  @override
  @JsonKey()
  final int correctReviews;
  @override
  @JsonKey()
  final int consecutiveCorrect;

  /// Status
  @override
  @JsonKey()
  final SRSStatus status;

  @override
  String toString() {
    return 'CardProgress(cardId: $cardId, createdAt: $createdAt, lastReviewed: $lastReviewed, nextReview: $nextReview, repetitions: $repetitions, easeFactor: $easeFactor, intervalDays: $intervalDays, lastQuality: $lastQuality, totalReviews: $totalReviews, correctReviews: $correctReviews, consecutiveCorrect: $consecutiveCorrect, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardProgressImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastReviewed, lastReviewed) ||
                other.lastReviewed == lastReviewed) &&
            (identical(other.nextReview, nextReview) ||
                other.nextReview == nextReview) &&
            (identical(other.repetitions, repetitions) ||
                other.repetitions == repetitions) &&
            (identical(other.easeFactor, easeFactor) ||
                other.easeFactor == easeFactor) &&
            (identical(other.intervalDays, intervalDays) ||
                other.intervalDays == intervalDays) &&
            (identical(other.lastQuality, lastQuality) ||
                other.lastQuality == lastQuality) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            (identical(other.correctReviews, correctReviews) ||
                other.correctReviews == correctReviews) &&
            (identical(other.consecutiveCorrect, consecutiveCorrect) ||
                other.consecutiveCorrect == consecutiveCorrect) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cardId,
      createdAt,
      lastReviewed,
      nextReview,
      repetitions,
      easeFactor,
      intervalDays,
      lastQuality,
      totalReviews,
      correctReviews,
      consecutiveCorrect,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CardProgressImplCopyWith<_$CardProgressImpl> get copyWith =>
      __$$CardProgressImplCopyWithImpl<_$CardProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardProgressImplToJson(
      this,
    );
  }
}

abstract class _CardProgress implements CardProgress {
  const factory _CardProgress(
      {required final String cardId,
      required final DateTime createdAt,
      final DateTime? lastReviewed,
      final DateTime? nextReview,
      final int repetitions,
      final double easeFactor,
      final int intervalDays,
      final int? lastQuality,
      final int totalReviews,
      final int correctReviews,
      final int consecutiveCorrect,
      final SRSStatus status}) = _$CardProgressImpl;

  factory _CardProgress.fromJson(Map<String, dynamic> json) =
      _$CardProgressImpl.fromJson;

  @override
  String get cardId;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastReviewed;
  @override
  DateTime? get nextReview;

  /// SM-2 Algorithm fields
  @override
  int get repetitions;

  /// EF - Easiness factor (starts at 2.5)
  @override
  double get easeFactor;

  /// Current interval in days (I)
  @override
  int get intervalDays;

  /// Quality of response (0-5)
  /// 5 - perfect response
  /// 4 - correct response after hesitation
  /// 3 - correct response recalled with serious difficulty
  /// 2 - incorrect response; correct one remembered
  /// 1 - incorrect response; correct one seemed easy to recall
  /// 0 - complete blackout
  @override
  int? get lastQuality;

  /// Statistics
  @override
  int get totalReviews;
  @override
  int get correctReviews;
  @override
  int get consecutiveCorrect;

  /// Status
  @override
  SRSStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$CardProgressImplCopyWith<_$CardProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
