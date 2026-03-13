// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deck.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Deck _$DeckFromJson(Map<String, dynamic> json) {
  return _Deck.fromJson(json);
}

/// @nodoc
mixin _$Deck {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  DifficultyLevel get level => throw _privateConstructorUsedError;
  List<String> get cardIds => throw _privateConstructorUsedError;
  int get totalCards => throw _privateConstructorUsedError;
  int? get cardsLearned => throw _privateConstructorUsedError;
  double? get progress => throw _privateConstructorUsedError;
  String? get thumbnailEmoji => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastStudied => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeckCopyWith<Deck> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckCopyWith<$Res> {
  factory $DeckCopyWith(Deck value, $Res Function(Deck) then) =
      _$DeckCopyWithImpl<$Res, Deck>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String category,
      DifficultyLevel level,
      List<String> cardIds,
      int totalCards,
      int? cardsLearned,
      double? progress,
      String? thumbnailEmoji,
      DateTime createdAt,
      DateTime? lastStudied});
}

/// @nodoc
class _$DeckCopyWithImpl<$Res, $Val extends Deck>
    implements $DeckCopyWith<$Res> {
  _$DeckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? level = null,
    Object? cardIds = null,
    Object? totalCards = null,
    Object? cardsLearned = freezed,
    Object? progress = freezed,
    Object? thumbnailEmoji = freezed,
    Object? createdAt = null,
    Object? lastStudied = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      cardIds: null == cardIds
          ? _value.cardIds
          : cardIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalCards: null == totalCards
          ? _value.totalCards
          : totalCards // ignore: cast_nullable_to_non_nullable
              as int,
      cardsLearned: freezed == cardsLearned
          ? _value.cardsLearned
          : cardsLearned // ignore: cast_nullable_to_non_nullable
              as int?,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double?,
      thumbnailEmoji: freezed == thumbnailEmoji
          ? _value.thumbnailEmoji
          : thumbnailEmoji // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastStudied: freezed == lastStudied
          ? _value.lastStudied
          : lastStudied // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeckImplCopyWith<$Res> implements $DeckCopyWith<$Res> {
  factory _$$DeckImplCopyWith(
          _$DeckImpl value, $Res Function(_$DeckImpl) then) =
      __$$DeckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String category,
      DifficultyLevel level,
      List<String> cardIds,
      int totalCards,
      int? cardsLearned,
      double? progress,
      String? thumbnailEmoji,
      DateTime createdAt,
      DateTime? lastStudied});
}

/// @nodoc
class __$$DeckImplCopyWithImpl<$Res>
    extends _$DeckCopyWithImpl<$Res, _$DeckImpl>
    implements _$$DeckImplCopyWith<$Res> {
  __$$DeckImplCopyWithImpl(_$DeckImpl _value, $Res Function(_$DeckImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? level = null,
    Object? cardIds = null,
    Object? totalCards = null,
    Object? cardsLearned = freezed,
    Object? progress = freezed,
    Object? thumbnailEmoji = freezed,
    Object? createdAt = null,
    Object? lastStudied = freezed,
  }) {
    return _then(_$DeckImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      cardIds: null == cardIds
          ? _value._cardIds
          : cardIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalCards: null == totalCards
          ? _value.totalCards
          : totalCards // ignore: cast_nullable_to_non_nullable
              as int,
      cardsLearned: freezed == cardsLearned
          ? _value.cardsLearned
          : cardsLearned // ignore: cast_nullable_to_non_nullable
              as int?,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double?,
      thumbnailEmoji: freezed == thumbnailEmoji
          ? _value.thumbnailEmoji
          : thumbnailEmoji // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastStudied: freezed == lastStudied
          ? _value.lastStudied
          : lastStudied // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeckImpl implements _Deck {
  const _$DeckImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.level,
      required final List<String> cardIds,
      required this.totalCards,
      this.cardsLearned,
      this.progress,
      this.thumbnailEmoji,
      required this.createdAt,
      this.lastStudied})
      : _cardIds = cardIds;

  factory _$DeckImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeckImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String category;
  @override
  final DifficultyLevel level;
  final List<String> _cardIds;
  @override
  List<String> get cardIds {
    if (_cardIds is EqualUnmodifiableListView) return _cardIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cardIds);
  }

  @override
  final int totalCards;
  @override
  final int? cardsLearned;
  @override
  final double? progress;
  @override
  final String? thumbnailEmoji;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastStudied;

  @override
  String toString() {
    return 'Deck(id: $id, name: $name, description: $description, category: $category, level: $level, cardIds: $cardIds, totalCards: $totalCards, cardsLearned: $cardsLearned, progress: $progress, thumbnailEmoji: $thumbnailEmoji, createdAt: $createdAt, lastStudied: $lastStudied)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(other._cardIds, _cardIds) &&
            (identical(other.totalCards, totalCards) ||
                other.totalCards == totalCards) &&
            (identical(other.cardsLearned, cardsLearned) ||
                other.cardsLearned == cardsLearned) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.thumbnailEmoji, thumbnailEmoji) ||
                other.thumbnailEmoji == thumbnailEmoji) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastStudied, lastStudied) ||
                other.lastStudied == lastStudied));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      category,
      level,
      const DeepCollectionEquality().hash(_cardIds),
      totalCards,
      cardsLearned,
      progress,
      thumbnailEmoji,
      createdAt,
      lastStudied);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckImplCopyWith<_$DeckImpl> get copyWith =>
      __$$DeckImplCopyWithImpl<_$DeckImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeckImplToJson(
      this,
    );
  }
}

abstract class _Deck implements Deck {
  const factory _Deck(
      {required final String id,
      required final String name,
      required final String description,
      required final String category,
      required final DifficultyLevel level,
      required final List<String> cardIds,
      required final int totalCards,
      final int? cardsLearned,
      final double? progress,
      final String? thumbnailEmoji,
      required final DateTime createdAt,
      final DateTime? lastStudied}) = _$DeckImpl;

  factory _Deck.fromJson(Map<String, dynamic> json) = _$DeckImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get category;
  @override
  DifficultyLevel get level;
  @override
  List<String> get cardIds;
  @override
  int get totalCards;
  @override
  int? get cardsLearned;
  @override
  double? get progress;
  @override
  String? get thumbnailEmoji;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastStudied;
  @override
  @JsonKey(ignore: true)
  _$$DeckImplCopyWith<_$DeckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
