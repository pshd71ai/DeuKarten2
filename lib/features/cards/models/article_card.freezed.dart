// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element

part of 'article_card.dart';

mixin _$ArticleCard {
  String get id => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String get correctArticle => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;
  String? get exampleSentence => throw _privateConstructorUsedError;
  DifficultyLevel get level => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArticleCardCopyWith<ArticleCard> get copyWith =>
      throw _privateConstructorUsedError;
}

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

class _$ArticleCardCopyWithImpl<$Res, $Val extends ArticleCard>
    implements $ArticleCardCopyWith<$Res> {
  _$ArticleCardCopyWithImpl(this._value, this._then);

  final $Val _value;
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
      id: null == id ? _value.id : id as String,
      word: null == word ? _value.word : word as String,
      correctArticle: null == correctArticle ? _value.correctArticle : correctArticle as String,
      options: null == options ? _value.options : options as List<String>,
      translation: null == translation ? _value.translation : translation as String,
      exampleSentence: freezed == exampleSentence
          ? _value.exampleSentence
          : exampleSentence as String?,
      level: null == level ? _value.level : level as DifficultyLevel,
    ) as $Val);
  }
}

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
      id: null == id ? _value.id : id as String,
      word: null == word ? _value.word : word as String,
      correctArticle: null == correctArticle ? _value.correctArticle : correctArticle as String,
      options: null == options ? _value._options : options as List<String>,
      translation: null == translation ? _value.translation : translation as String,
      exampleSentence: freezed == exampleSentence
          ? _value.exampleSentence
          : exampleSentence as String?,
      level: null == level ? _value.level : level as DifficultyLevel,
    ));
  }
}

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
    return _options;
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
            (identical(other.correctArticle, correctArticle) || other.correctArticle == correctArticle) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.translation, translation) || other.translation == translation) &&
            (identical(other.exampleSentence, exampleSentence) || other.exampleSentence == exampleSentence) &&
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
    return _$$ArticleCardImplToJson(this);
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
