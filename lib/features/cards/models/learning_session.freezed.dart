// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element

part of 'learning_session.dart';

// **************************************************************************
// Freezed Generator
// **************************************************************************

mixin _$LearningSession {
  String get id => throw _privateConstructorUsedError;
  String get deckId => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  List<SessionCard> get cards => throw _privateConstructorUsedError;
  int? get cardsStudied => throw _privateConstructorUsedError;
  int? get correctAnswers => throw _privateConstructorUsedError;
  int? get xpEarned => throw _privateConstructorUsedError;
  SessionStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LearningSessionCopyWith<LearningSession> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $LearningSessionCopyWith<$Res> {
  factory $LearningSessionCopyWith(
          LearningSession value, $Res Function(LearningSession) then) =
      _$LearningSessionCopyWithImpl<$Res, LearningSession>;
  @useResult
  $Res call(
      {String id,
      String deckId,
      DateTime startedAt,
      DateTime? completedAt,
      List<SessionCard> cards,
      int? cardsStudied,
      int? correctAnswers,
      int? xpEarned,
      SessionStatus status});
}

class _$LearningSessionCopyWithImpl<$Res, $Val extends LearningSession>
    implements $LearningSessionCopyWith<$Res> {
  _$LearningSessionCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deckId = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? cards = null,
    Object? cardsStudied = freezed,
    Object? correctAnswers = freezed,
    Object? xpEarned = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id as String,
      deckId: null == deckId
          ? _value.deckId
          : deckId as String,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt as DateTime?,
      cards: null == cards
          ? _value.cards
          : cards as List<SessionCard>,
      cardsStudied: freezed == cardsStudied
          ? _value.cardsStudied
          : cardsStudied as int?,
      correctAnswers: freezed == correctAnswers
          ? _value.correctAnswers
          : correctAnswers as int?,
      xpEarned: freezed == xpEarned
          ? _value.xpEarned
          : xpEarned as int?,
      status: null == status
          ? _value.status
          : status as SessionStatus,
    ) as $Val);
  }
}

abstract class _$$LearningSessionImplCopyWith<$Res>
    implements $LearningSessionCopyWith<$Res> {
  factory _$$LearningSessionImplCopyWith(_$LearningSessionImpl value,
          $Res Function(_$LearningSessionImpl) then) =
      __$$LearningSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String deckId,
      DateTime startedAt,
      DateTime? completedAt,
      List<SessionCard> cards,
      int? cardsStudied,
      int? correctAnswers,
      int? xpEarned,
      SessionStatus status});
}

class __$$LearningSessionImplCopyWithImpl<$Res>
    extends _$LearningSessionCopyWithImpl<$Res, _$LearningSessionImpl>
    implements _$$LearningSessionImplCopyWith<$Res> {
  __$$LearningSessionImplCopyWithImpl(
      _$LearningSessionImpl _value, $Res Function(_$LearningSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deckId = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? cards = null,
    Object? cardsStudied = freezed,
    Object? correctAnswers = freezed,
    Object? xpEarned = freezed,
    Object? status = null,
  }) {
    return _then(_$LearningSessionImpl(
      id: null == id
          ? _value.id
          : id as String,
      deckId: null == deckId
          ? _value.deckId
          : deckId as String,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt as DateTime?,
      cards: null == cards
          ? _value._cards
          : cards as List<SessionCard>,
      cardsStudied: freezed == cardsStudied
          ? _value.cardsStudied
          : cardsStudied as int?,
      correctAnswers: freezed == correctAnswers
          ? _value.correctAnswers
          : correctAnswers as int?,
      xpEarned: freezed == xpEarned
          ? _value.xpEarned
          : xpEarned as int?,
      status: null == status
          ? _value.status
          : status as SessionStatus,
    ));
  }
}

@JsonSerializable()
class _$LearningSessionImpl implements _LearningSession {
  const _$LearningSessionImpl(
      {required this.id,
      required this.deckId,
      required this.startedAt,
      this.completedAt,
      required final List<SessionCard> cards,
      this.cardsStudied,
      this.correctAnswers,
      this.xpEarned,
      this.status = SessionStatus.inProgress})
      : _cards = cards;

  factory _$LearningSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$LearningSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String deckId;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  final List<SessionCard> _cards;
  @override
  List<SessionCard> get cards {
    return _cards;
  }

  @override
  final int? cardsStudied;
  @override
  final int? correctAnswers;
  @override
  final int? xpEarned;
  @override
  @JsonKey()
  final SessionStatus status;

  @override
  String toString() {
    return 'LearningSession(id: $id, deckId: $deckId, startedAt: $startedAt, completedAt: $completedAt, cards: $cards, cardsStudied: $cardsStudied, correctAnswers: $correctAnswers, xpEarned: $xpEarned, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LearningSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deckId, deckId) || other.deckId == deckId) &&
            (identical(other.startedAt, startedAt) || other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) || other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.cardsStudied, cardsStudied) || other.cardsStudied == cardsStudied) &&
            (identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers) &&
            (identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      deckId,
      startedAt,
      completedAt,
      const DeepCollectionEquality().hash(_cards),
      cardsStudied,
      correctAnswers,
      xpEarned,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LearningSessionImplCopyWith<_$LearningSessionImpl> get copyWith =>
      __$$LearningSessionImplCopyWithImpl<_$LearningSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LearningSessionImplToJson(this);
  }
}

abstract class _LearningSession implements LearningSession {
  const factory _LearningSession(
      {required final String id,
      required final String deckId,
      required final DateTime startedAt,
      final DateTime? completedAt,
      required final List<SessionCard> cards,
      final int? cardsStudied,
      final int? correctAnswers,
      final int? xpEarned,
      final SessionStatus status}) = _$LearningSessionImpl;

  factory _LearningSession.fromJson(Map<String, dynamic> json) =
      _$LearningSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get deckId;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  List<SessionCard> get cards;
  @override
  int? get cardsStudied;
  @override
  int? get correctAnswers;
  @override
  int? get xpEarned;
  @override
  SessionStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$LearningSessionImplCopyWith<_$LearningSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

mixin _$SessionCard {
  String get cardId => throw _privateConstructorUsedError;
  CardType get type => throw _privateConstructorUsedError;
  CardStatus get status => throw _privateConstructorUsedError;
  int? get attempts => throw _privateConstructorUsedError;
  bool? get wasCorrect => throw _privateConstructorUsedError;
  DateTime? get shownAt => throw _privateConstructorUsedError;
  DateTime? get answeredAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SessionCardCopyWith<SessionCard> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $SessionCardCopyWith<$Res> {
  factory $SessionCardCopyWith(
          SessionCard value, $Res Function(SessionCard) then) =
      _$SessionCardCopyWithImpl<$Res, SessionCard>;
  @useResult
  $Res call(
      {String cardId,
      CardType type,
      CardStatus status,
      int? attempts,
      bool? wasCorrect,
      DateTime? shownAt,
      DateTime? answeredAt});
}

class _$SessionCardCopyWithImpl<$Res, $Val extends SessionCard>
    implements $SessionCardCopyWith<$Res> {
  _$SessionCardCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? type = null,
    Object? status = null,
    Object? attempts = freezed,
    Object? wasCorrect = freezed,
    Object? shownAt = freezed,
    Object? answeredAt = freezed,
  }) {
    return _then(_value.copyWith(
      cardId: null == cardId
          ? _value.cardId
          : cardId as String,
      type: null == type
          ? _value.type
          : type as CardType,
      status: null == status
          ? _value.status
          : status as CardStatus,
      attempts: freezed == attempts
          ? _value.attempts
          : attempts as int?,
      wasCorrect: freezed == wasCorrect
          ? _value.wasCorrect
          : wasCorrect as bool?,
      shownAt: freezed == shownAt
          ? _value.shownAt
          : shownAt as DateTime?,
      answeredAt: freezed == answeredAt
          ? _value.answeredAt
          : answeredAt as DateTime?,
    ) as $Val);
  }
}

abstract class _$$SessionCardImplCopyWith<$Res>
    implements $SessionCardCopyWith<$Res> {
  factory _$$SessionCardImplCopyWith(
          _$SessionCardImpl value, $Res Function(_$SessionCardImpl) then) =
      __$$SessionCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String cardId,
      CardType type,
      CardStatus status,
      int? attempts,
      bool? wasCorrect,
      DateTime? shownAt,
      DateTime? answeredAt});
}

class __$$SessionCardImplCopyWithImpl<$Res>
    extends _$SessionCardCopyWithImpl<$Res, _$SessionCardImpl>
    implements _$$SessionCardImplCopyWith<$Res> {
  __$$SessionCardImplCopyWithImpl(
      _$SessionCardImpl _value, $Res Function(_$SessionCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? type = null,
    Object? status = null,
    Object? attempts = freezed,
    Object? wasCorrect = freezed,
    Object? shownAt = freezed,
    Object? answeredAt = freezed,
  }) {
    return _then(_$SessionCardImpl(
      cardId: null == cardId
          ? _value.cardId
          : cardId as String,
      type: null == type
          ? _value.type
          : type as CardType,
      status: null == status
          ? _value.status
          : status as CardStatus,
      attempts: freezed == attempts
          ? _value.attempts
          : attempts as int?,
      wasCorrect: freezed == wasCorrect
          ? _value.wasCorrect
          : wasCorrect as bool?,
      shownAt: freezed == shownAt
          ? _value.shownAt
          : shownAt as DateTime?,
      answeredAt: freezed == answeredAt
          ? _value.answeredAt
          : answeredAt as DateTime?,
    ));
  }
}

@JsonSerializable()
class _$SessionCardImpl implements _SessionCard {
  const _$SessionCardImpl(
      {required this.cardId,
      required this.type,
      this.status = CardStatus.new_card,
      this.attempts,
      this.wasCorrect,
      this.shownAt,
      this.answeredAt});

  factory _$SessionCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionCardImplFromJson(json);

  @override
  final String cardId;
  @override
  final CardType type;
  @override
  @JsonKey()
  final CardStatus status;
  @override
  final int? attempts;
  @override
  final bool? wasCorrect;
  @override
  final DateTime? shownAt;
  @override
  final DateTime? answeredAt;

  @override
  String toString() {
    return 'SessionCard(cardId: $cardId, type: $type, status: $status, attempts: $attempts, wasCorrect: $wasCorrect, shownAt: $shownAt, answeredAt: $answeredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionCardImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.attempts, attempts) || other.attempts == attempts) &&
            (identical(other.wasCorrect, wasCorrect) || other.wasCorrect == wasCorrect) &&
            (identical(other.shownAt, shownAt) || other.shownAt == shownAt) &&
            (identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cardId,
      type,
      status,
      attempts,
      wasCorrect,
      shownAt,
      answeredAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionCardImplCopyWith<_$SessionCardImpl> get copyWith =>
      __$$SessionCardImplCopyWithImpl<_$SessionCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionCardImplToJson(this);
  }
}

abstract class _SessionCard implements SessionCard {
  const factory _SessionCard(
      {required final String cardId,
      required final CardType type,
      final CardStatus status,
      final int? attempts,
      final bool? wasCorrect,
      final DateTime? shownAt,
      final DateTime? answeredAt}) = _$SessionCardImpl;

  factory _SessionCard.fromJson(Map<String, dynamic> json) =
      _$SessionCardImpl.fromJson;

  @override
  String get cardId;
  @override
  CardType get type;
  @override
  CardStatus get status;
  @override
  int? get attempts;
  @override
  bool? get wasCorrect;
  @override
  DateTime? get shownAt;
  @override
  DateTime? get answeredAt;
  @override
  @JsonKey(ignore: true)
  _$$SessionCardImplCopyWith<_$SessionCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

T _$identity<T>(T value) => value;
final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.',
);

class DeepCollectionEquality {
  const DeepCollectionEquality();
  bool equals(Object? e1, Object? e2) {
    if (e1 is List && e2 is List) {
      if (e1.length != e2.length) return false;
      for (var i = 0; i < e1.length; i++) {
        if (!equals(e1[i], e2[i])) return false;
      }
      return true;
    }
    return e1 == e2;
  }
  int hash(Object? o) {
    if (o is List) {
      return Object.hashAll(o);
    }
    return o.hashCode;
  }
}
