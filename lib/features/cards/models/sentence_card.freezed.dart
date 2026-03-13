// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sentence_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SentenceCard _$SentenceCardFromJson(Map<String, dynamic> json) {
  return _SentenceCard.fromJson(json);
}

/// @nodoc
mixin _$SentenceCard {
  String get id => throw _privateConstructorUsedError;
  String get incompleteSentence => throw _privateConstructorUsedError;
  List<String> get wordOptions => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  String get completeSentence => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;
  DifficultyLevel get level => throw _privateConstructorUsedError;
  String? get grammarTopic => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SentenceCardCopyWith<SentenceCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentenceCardCopyWith<$Res> {
  factory $SentenceCardCopyWith(
          SentenceCard value, $Res Function(SentenceCard) then) =
      _$SentenceCardCopyWithImpl<$Res, SentenceCard>;
  @useResult
  $Res call(
      {String id,
      String incompleteSentence,
      List<String> wordOptions,
      String correctAnswer,
      String completeSentence,
      String translation,
      DifficultyLevel level,
      String? grammarTopic});
}

/// @nodoc
class _$SentenceCardCopyWithImpl<$Res, $Val extends SentenceCard>
    implements $SentenceCardCopyWith<$Res> {
  _$SentenceCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? incompleteSentence = null,
    Object? wordOptions = null,
    Object? correctAnswer = null,
    Object? completeSentence = null,
    Object? translation = null,
    Object? level = null,
    Object? grammarTopic = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      incompleteSentence: null == incompleteSentence
          ? _value.incompleteSentence
          : incompleteSentence // ignore: cast_nullable_to_non_nullable
              as String,
      wordOptions: null == wordOptions
          ? _value.wordOptions
          : wordOptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      completeSentence: null == completeSentence
          ? _value.completeSentence
          : completeSentence // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      grammarTopic: freezed == grammarTopic
          ? _value.grammarTopic
          : grammarTopic // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentenceCardImplCopyWith<$Res>
    implements $SentenceCardCopyWith<$Res> {
  factory _$$SentenceCardImplCopyWith(
          _$SentenceCardImpl value, $Res Function(_$SentenceCardImpl) then) =
      __$$SentenceCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String incompleteSentence,
      List<String> wordOptions,
      String correctAnswer,
      String completeSentence,
      String translation,
      DifficultyLevel level,
      String? grammarTopic});
}

/// @nodoc
class __$$SentenceCardImplCopyWithImpl<$Res>
    extends _$SentenceCardCopyWithImpl<$Res, _$SentenceCardImpl>
    implements _$$SentenceCardImplCopyWith<$Res> {
  __$$SentenceCardImplCopyWithImpl(
      _$SentenceCardImpl _value, $Res Function(_$SentenceCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? incompleteSentence = null,
    Object? wordOptions = null,
    Object? correctAnswer = null,
    Object? completeSentence = null,
    Object? translation = null,
    Object? level = null,
    Object? grammarTopic = freezed,
  }) {
    return _then(_$SentenceCardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      incompleteSentence: null == incompleteSentence
          ? _value.incompleteSentence
          : incompleteSentence // ignore: cast_nullable_to_non_nullable
              as String,
      wordOptions: null == wordOptions
          ? _value._wordOptions
          : wordOptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      completeSentence: null == completeSentence
          ? _value.completeSentence
          : completeSentence // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      grammarTopic: freezed == grammarTopic
          ? _value.grammarTopic
          : grammarTopic // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SentenceCardImpl implements _SentenceCard {
  const _$SentenceCardImpl(
      {required this.id,
      required this.incompleteSentence,
      required final List<String> wordOptions,
      required this.correctAnswer,
      required this.completeSentence,
      required this.translation,
      required this.level,
      this.grammarTopic})
      : _wordOptions = wordOptions;

  factory _$SentenceCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$SentenceCardImplFromJson(json);

  @override
  final String id;
  @override
  final String incompleteSentence;
  final List<String> _wordOptions;
  @override
  List<String> get wordOptions {
    if (_wordOptions is EqualUnmodifiableListView) return _wordOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wordOptions);
  }

  @override
  final String correctAnswer;
  @override
  final String completeSentence;
  @override
  final String translation;
  @override
  final DifficultyLevel level;
  @override
  final String? grammarTopic;

  @override
  String toString() {
    return 'SentenceCard(id: $id, incompleteSentence: $incompleteSentence, wordOptions: $wordOptions, correctAnswer: $correctAnswer, completeSentence: $completeSentence, translation: $translation, level: $level, grammarTopic: $grammarTopic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.incompleteSentence, incompleteSentence) ||
                other.incompleteSentence == incompleteSentence) &&
            const DeepCollectionEquality()
                .equals(other._wordOptions, _wordOptions) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.completeSentence, completeSentence) ||
                other.completeSentence == completeSentence) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.grammarTopic, grammarTopic) ||
                other.grammarTopic == grammarTopic));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      incompleteSentence,
      const DeepCollectionEquality().hash(_wordOptions),
      correctAnswer,
      completeSentence,
      translation,
      level,
      grammarTopic);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SentenceCardImplCopyWith<_$SentenceCardImpl> get copyWith =>
      __$$SentenceCardImplCopyWithImpl<_$SentenceCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SentenceCardImplToJson(
      this,
    );
  }
}

abstract class _SentenceCard implements SentenceCard {
  const factory _SentenceCard(
      {required final String id,
      required final String incompleteSentence,
      required final List<String> wordOptions,
      required final String correctAnswer,
      required final String completeSentence,
      required final String translation,
      required final DifficultyLevel level,
      final String? grammarTopic}) = _$SentenceCardImpl;

  factory _SentenceCard.fromJson(Map<String, dynamic> json) =
      _$SentenceCardImpl.fromJson;

  @override
  String get id;
  @override
  String get incompleteSentence;
  @override
  List<String> get wordOptions;
  @override
  String get correctAnswer;
  @override
  String get completeSentence;
  @override
  String get translation;
  @override
  DifficultyLevel get level;
  @override
  String? get grammarTopic;
  @override
  @JsonKey(ignore: true)
  _$$SentenceCardImplCopyWith<_$SentenceCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
