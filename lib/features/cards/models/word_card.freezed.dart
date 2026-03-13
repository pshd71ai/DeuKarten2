// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WordCard _$WordCardFromJson(Map<String, dynamic> json) {
  return _WordCard.fromJson(json);
}

/// @nodoc
mixin _$WordCard {
  String get id => throw _privateConstructorUsedError;
  String get germanWord => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;
  String get article => throw _privateConstructorUsedError;
  String get pluralForm => throw _privateConstructorUsedError;
  String? get exampleSentence => throw _privateConstructorUsedError;
  String? get exampleTranslation => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DifficultyLevel get level => throw _privateConstructorUsedError;
  CardType get type => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get lastReviewed => throw _privateConstructorUsedError;
  DateTime? get nextReview => throw _privateConstructorUsedError;
  int? get intervalDays => throw _privateConstructorUsedError;
  int get repetitionCount => throw _privateConstructorUsedError;
  double get easeFactor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WordCardCopyWith<WordCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordCardCopyWith<$Res> {
  factory $WordCardCopyWith(WordCard value, $Res Function(WordCard) then) =
      _$WordCardCopyWithImpl<$Res, WordCard>;
  @useResult
  $Res call(
      {String id,
      String germanWord,
      String translation,
      String article,
      String pluralForm,
      String? exampleSentence,
      String? exampleTranslation,
      String? imageUrl,
      DifficultyLevel level,
      CardType type,
      List<String> tags,
      DateTime? lastReviewed,
      DateTime? nextReview,
      int? intervalDays,
      int repetitionCount,
      double easeFactor});
}

/// @nodoc
class _$WordCardCopyWithImpl<$Res, $Val extends WordCard>
    implements $WordCardCopyWith<$Res> {
  _$WordCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? germanWord = null,
    Object? translation = null,
    Object? article = null,
    Object? pluralForm = null,
    Object? exampleSentence = freezed,
    Object? exampleTranslation = freezed,
    Object? imageUrl = freezed,
    Object? level = null,
    Object? type = null,
    Object? tags = null,
    Object? lastReviewed = freezed,
    Object? nextReview = freezed,
    Object? intervalDays = freezed,
    Object? repetitionCount = null,
    Object? easeFactor = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      germanWord: null == germanWord
          ? _value.germanWord
          : germanWord // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      article: null == article
          ? _value.article
          : article // ignore: cast_nullable_to_non_nullable
              as String,
      pluralForm: null == pluralForm
          ? _value.pluralForm
          : pluralForm // ignore: cast_nullable_to_non_nullable
              as String,
      exampleSentence: freezed == exampleSentence
          ? _value.exampleSentence
          : exampleSentence // ignore: cast_nullable_to_non_nullable
              as String?,
      exampleTranslation: freezed == exampleTranslation
          ? _value.exampleTranslation
          : exampleTranslation // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CardType,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastReviewed: freezed == lastReviewed
          ? _value.lastReviewed
          : lastReviewed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextReview: freezed == nextReview
          ? _value.nextReview
          : nextReview // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      intervalDays: freezed == intervalDays
          ? _value.intervalDays
          : intervalDays // ignore: cast_nullable_to_non_nullable
              as int?,
      repetitionCount: null == repetitionCount
          ? _value.repetitionCount
          : repetitionCount // ignore: cast_nullable_to_non_nullable
              as int,
      easeFactor: null == easeFactor
          ? _value.easeFactor
          : easeFactor // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WordCardImplCopyWith<$Res>
    implements $WordCardCopyWith<$Res> {
  factory _$$WordCardImplCopyWith(
          _$WordCardImpl value, $Res Function(_$WordCardImpl) then) =
      __$$WordCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String germanWord,
      String translation,
      String article,
      String pluralForm,
      String? exampleSentence,
      String? exampleTranslation,
      String? imageUrl,
      DifficultyLevel level,
      CardType type,
      List<String> tags,
      DateTime? lastReviewed,
      DateTime? nextReview,
      int? intervalDays,
      int repetitionCount,
      double easeFactor});
}

/// @nodoc
class __$$WordCardImplCopyWithImpl<$Res>
    extends _$WordCardCopyWithImpl<$Res, _$WordCardImpl>
    implements _$$WordCardImplCopyWith<$Res> {
  __$$WordCardImplCopyWithImpl(
      _$WordCardImpl _value, $Res Function(_$WordCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? germanWord = null,
    Object? translation = null,
    Object? article = null,
    Object? pluralForm = null,
    Object? exampleSentence = freezed,
    Object? exampleTranslation = freezed,
    Object? imageUrl = freezed,
    Object? level = null,
    Object? type = null,
    Object? tags = null,
    Object? lastReviewed = freezed,
    Object? nextReview = freezed,
    Object? intervalDays = freezed,
    Object? repetitionCount = null,
    Object? easeFactor = null,
  }) {
    return _then(_$WordCardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      germanWord: null == germanWord
          ? _value.germanWord
          : germanWord // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      article: null == article
          ? _value.article
          : article // ignore: cast_nullable_to_non_nullable
              as String,
      pluralForm: null == pluralForm
          ? _value.pluralForm
          : pluralForm // ignore: cast_nullable_to_non_nullable
              as String,
      exampleSentence: freezed == exampleSentence
          ? _value.exampleSentence
          : exampleSentence // ignore: cast_nullable_to_non_nullable
              as String?,
      exampleTranslation: freezed == exampleTranslation
          ? _value.exampleTranslation
          : exampleTranslation // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CardType,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastReviewed: freezed == lastReviewed
          ? _value.lastReviewed
          : lastReviewed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextReview: freezed == nextReview
          ? _value.nextReview
          : nextReview // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      intervalDays: freezed == intervalDays
          ? _value.intervalDays
          : intervalDays // ignore: cast_nullable_to_non_nullable
              as int?,
      repetitionCount: null == repetitionCount
          ? _value.repetitionCount
          : repetitionCount // ignore: cast_nullable_to_non_nullable
              as int,
      easeFactor: null == easeFactor
          ? _value.easeFactor
          : easeFactor // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WordCardImpl implements _WordCard {
  const _$WordCardImpl(
      {required this.id,
      required this.germanWord,
      required this.translation,
      required this.article,
      required this.pluralForm,
      this.exampleSentence,
      this.exampleTranslation,
      this.imageUrl,
      required this.level,
      required this.type,
      required final List<String> tags,
      this.lastReviewed,
      this.nextReview,
      this.intervalDays,
      this.repetitionCount = 0,
      this.easeFactor = 2.5})
      : _tags = tags;

  factory _$WordCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordCardImplFromJson(json);

  @override
  final String id;
  @override
  final String germanWord;
  @override
  final String translation;
  @override
  final String article;
  @override
  final String pluralForm;
  @override
  final String? exampleSentence;
  @override
  final String? exampleTranslation;
  @override
  final String? imageUrl;
  @override
  final DifficultyLevel level;
  @override
  final CardType type;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? lastReviewed;
  @override
  final DateTime? nextReview;
  @override
  final int? intervalDays;
  @override
  @JsonKey()
  final int repetitionCount;
  @override
  @JsonKey()
  final double easeFactor;

  @override
  String toString() {
    return 'WordCard(id: $id, germanWord: $germanWord, translation: $translation, article: $article, pluralForm: $pluralForm, exampleSentence: $exampleSentence, exampleTranslation: $exampleTranslation, imageUrl: $imageUrl, level: $level, type: $type, tags: $tags, lastReviewed: $lastReviewed, nextReview: $nextReview, intervalDays: $intervalDays, repetitionCount: $repetitionCount, easeFactor: $easeFactor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.germanWord, germanWord) ||
                other.germanWord == germanWord) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.article, article) || other.article == article) &&
            (identical(other.pluralForm, pluralForm) ||
                other.pluralForm == pluralForm) &&
            (identical(other.exampleSentence, exampleSentence) ||
                other.exampleSentence == exampleSentence) &&
            (identical(other.exampleTranslation, exampleTranslation) ||
                other.exampleTranslation == exampleTranslation) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.lastReviewed, lastReviewed) ||
                other.lastReviewed == lastReviewed) &&
            (identical(other.nextReview, nextReview) ||
                other.nextReview == nextReview) &&
            (identical(other.intervalDays, intervalDays) ||
                other.intervalDays == intervalDays) &&
            (identical(other.repetitionCount, repetitionCount) ||
                other.repetitionCount == repetitionCount) &&
            (identical(other.easeFactor, easeFactor) ||
                other.easeFactor == easeFactor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      germanWord,
      translation,
      article,
      pluralForm,
      exampleSentence,
      exampleTranslation,
      imageUrl,
      level,
      type,
      const DeepCollectionEquality().hash(_tags),
      lastReviewed,
      nextReview,
      intervalDays,
      repetitionCount,
      easeFactor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WordCardImplCopyWith<_$WordCardImpl> get copyWith =>
      __$$WordCardImplCopyWithImpl<_$WordCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordCardImplToJson(
      this,
    );
  }
}

abstract class _WordCard implements WordCard {
  const factory _WordCard(
      {required final String id,
      required final String germanWord,
      required final String translation,
      required final String article,
      required final String pluralForm,
      final String? exampleSentence,
      final String? exampleTranslation,
      final String? imageUrl,
      required final DifficultyLevel level,
      required final CardType type,
      required final List<String> tags,
      final DateTime? lastReviewed,
      final DateTime? nextReview,
      final int? intervalDays,
      final int repetitionCount,
      final double easeFactor}) = _$WordCardImpl;

  factory _WordCard.fromJson(Map<String, dynamic> json) =
      _$WordCardImpl.fromJson;

  @override
  String get id;
  @override
  String get germanWord;
  @override
  String get translation;
  @override
  String get article;
  @override
  String get pluralForm;
  @override
  String? get exampleSentence;
  @override
  String? get exampleTranslation;
  @override
  String? get imageUrl;
  @override
  DifficultyLevel get level;
  @override
  CardType get type;
  @override
  List<String> get tags;
  @override
  DateTime? get lastReviewed;
  @override
  DateTime? get nextReview;
  @override
  int? get intervalDays;
  @override
  int get repetitionCount;
  @override
  double get easeFactor;
  @override
  @JsonKey(ignore: true)
  _$$WordCardImplCopyWith<_$WordCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
