// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element

part of 'sentence_card.dart';

mixin _$SentenceCard {
  String get id => throw _privateConstructorUsedError;
  String get incompleteSentence => throw _privateConstructorUsedError;
  List<String> get wordOptions => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  String get completeSentence => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;
  DifficultyLevel get level => throw _privateConstructorUsedError;
  String? get grammarTopic => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SentenceCardCopyWith<SentenceCard> get copyWith =>
      throw _privateConstructorUsedError;
}

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

class _$SentenceCardCopyWithImpl<$Res, $Val extends SentenceCard>
    implements $SentenceCardCopyWith<$Res> {
  _$SentenceCardCopyWithImpl(this._value, this._then);

  final $Val _value;
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
      id: null == id ? _value.id : id as String,
      incompleteSentence: null == incompleteSentence ? _value.incompleteSentence : incompleteSentence as String,
      wordOptions: null == wordOptions ? _value.wordOptions : wordOptions as List<String>,
      correctAnswer: null == correctAnswer ? _value.correctAnswer : correctAnswer as String,
      completeSentence: null == completeSentence ? _value.completeSentence : completeSentence as String,
      translation: null == translation ? _value.translation : translation as String,
      level: null == level ? _value.level : level as DifficultyLevel,
      grammarTopic: freezed == grammarTopic ? _value.grammarTopic : grammarTopic as String?,
    ) as $Val);
  }
}

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
      id: null == id ? _value.id : id as String,
      incompleteSentence: null == incompleteSentence ? _value.incompleteSentence : incompleteSentence as String,
      wordOptions: null == wordOptions ? _value._wordOptions : wordOptions as List<String>,
      correctAnswer: null == correctAnswer ? _value.correctAnswer : correctAnswer as String,
      completeSentence: null == completeSentence ? _value.completeSentence : completeSentence as String,
      translation: null == translation ? _value.translation : translation as String,
      level: null == level ? _value.level : level as DifficultyLevel,
      grammarTopic: freezed == grammarTopic ? _value.grammarTopic : grammarTopic as String?,
    ));
  }
}

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
    return _wordOptions;
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
            (identical(other.incompleteSentence, incompleteSentence) || other.incompleteSentence == incompleteSentence) &&
            const DeepCollectionEquality().equals(other._wordOptions, _wordOptions) &&
            (identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer) &&
            (identical(other.completeSentence, completeSentence) || other.completeSentence == completeSentence) &&
            (identical(other.translation, translation) || other.translation == translation) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.grammarTopic, grammarTopic) || other.grammarTopic == grammarTopic));
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
    return _$$SentenceCardImplToJson(this);
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
