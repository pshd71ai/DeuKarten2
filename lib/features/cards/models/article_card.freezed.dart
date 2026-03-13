// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ArticleCard _$ArticleCardFromJson(Map<String, dynamic> json) {
  return _ArticleCard.fromJson(json);
}

/// @nodoc
mixin _$ArticleCard {
  String get id => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String get correctArticle => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;
  String? get exampleSentence => throw _privateConstructorUsedError;
  DifficultyLevel get level => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleCardCopyWith<ArticleCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCardCopyWith<$Res> {
  factory $ArticleCardCopyWith(
          ArticleCard value, $Res Function(ArticleCard) then) =
      _$ArticleCardCopyWithImpl<$Res, ArticleCard>;
  @useResult
  $Res call(
      {String id,
      String word,
      String correctArticle,
      List<String> options,
      String translation,
      String? exampleSentence,
      DifficultyLevel level});
}

/// @nodoc
class _$ArticleCardCopyWithImpl<$Res, $Val extends ArticleCard>
    implements $ArticleCardCopyWith<$Res> {
  _$ArticleCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? correctArticle = null,
    Object? options = null,
    Object? translation = null,
    Object? exampleSentence = freezed,
    Object? level = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      correctArticle: null == correctArticle
          ? _value.correctArticle
          : correctArticle // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      exampleSentence: freezed == exampleSentence
          ? _value.exampleSentence
          : exampleSentence // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArticleCardImplCopyWith<$Res>
    implements $ArticleCardCopyWith<$Res> {
  factory _$$ArticleCardImplCopyWith(
          _$ArticleCardImpl value, $Res Function(_$ArticleCardImpl) then) =
      __$$ArticleCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String word,
      String correctArticle,
      List<String> options,
      String translation,
      String? exampleSentence,
      DifficultyLevel level});
}

/// @nodoc
class __$$ArticleCardImplCopyWithImpl<$Res>
    extends _$ArticleCardCopyWithImpl<$Res, _$ArticleCardImpl>
    implements _$$ArticleCardImplCopyWith<$Res> {
  __$$ArticleCardImplCopyWithImpl(
      _$ArticleCardImpl _value, $Res Function(_$ArticleCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? correctArticle = null,
    Object? options = null,
    Object? translation = null,
    Object? exampleSentence = freezed,
    Object? level = null,
  }) {
    return _then(_$ArticleCardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      correctArticle: null == correctArticle
          ? _value.correctArticle
          : correctArticle // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      exampleSentence: freezed == exampleSentence
          ? _value.exampleSentence
          : exampleSentence // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArticleCardImpl implements _ArticleCard {
  const _$ArticleCardImpl(
      {required this.id,
      required this.word,
      required this.correctArticle,
      required final List<String> options,
      required this.translation,
      this.exampleSentence,
      required this.level})
      : _options = options;

  factory _$ArticleCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArticleCardImplFromJson(json);

  @override
  final String id;
  @override
  final String word;
  @override
  final String correctArticle;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final String translation;
  @override
  final String? exampleSentence;
  @override
  final DifficultyLevel level;

  @override
  String toString() {
    return 'ArticleCard(id: $id, word: $word, correctArticle: $correctArticle, options: $options, translation: $translation, exampleSentence: $exampleSentence, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.correctArticle, correctArticle) ||
                other.correctArticle == correctArticle) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.exampleSentence, exampleSentence) ||
                other.exampleSentence == exampleSentence) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      word,
      correctArticle,
      const DeepCollectionEquality().hash(_options),
      translation,
      exampleSentence,
      level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleCardImplCopyWith<_$ArticleCardImpl> get copyWith =>
      __$$ArticleCardImplCopyWithImpl<_$ArticleCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArticleCardImplToJson(
      this,
    );
  }
}

abstract class _ArticleCard implements ArticleCard {
  const factory _ArticleCard(
      {required final String id,
      required final String word,
      required final String correctArticle,
      required final List<String> options,
      required final String translation,
      final String? exampleSentence,
      required final DifficultyLevel level}) = _$ArticleCardImpl;

  factory _ArticleCard.fromJson(Map<String, dynamic> json) =
      _$ArticleCardImpl.fromJson;

  @override
  String get id;
  @override
  String get word;
  @override
  String get correctArticle;
  @override
  List<String> get options;
  @override
  String get translation;
  @override
  String? get exampleSentence;
  @override
  DifficultyLevel get level;
  @override
  @JsonKey(ignore: true)
  _$$ArticleCardImplCopyWith<_$ArticleCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
