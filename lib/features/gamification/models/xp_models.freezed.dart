// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element
part of 'xp_models.dart';

// **************************************************************************
// Freezed Generator
// **************************************************************************

mixin _$XpData {
  int get currentXp => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get xpForNextLevel => throw _privateConstructorUsedError;
  int get xpInCurrentLevel => throw _privateConstructorUsedError;
  int get totalXpEarned => throw _privateConstructorUsedError;
  List<XpHistoryEntry> get history => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $XpDataCopyWith<XpData> get copyWith => throw _privateConstructorUsedError;
}

abstract class $XpDataCopyWith<$Res> {
  factory $XpDataCopyWith(XpData value, $Res Function(XpData) then) =
      _$XpDataCopyWithImpl<$Res, XpData>;
  @useResult
  $Res call(
      {int currentXp,
      int level,
      int xpForNextLevel,
      int xpInCurrentLevel,
      int totalXpEarned,
      List<XpHistoryEntry> history});
}

class _$XpDataCopyWithImpl<$Res, $Val extends XpData>
    implements $XpDataCopyWith<$Res> {
  _$XpDataCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentXp = null,
    Object? level = null,
    Object? xpForNextLevel = null,
    Object? xpInCurrentLevel = null,
    Object? totalXpEarned = null,
    Object? history = null,
  }) {
    return _then(_value.copyWith(
      currentXp: null == currentXp
          ? _value.currentXp
          : currentXp as int,
      level: null == level
          ? _value.level
          : level as int,
      xpForNextLevel: null == xpForNextLevel
          ? _value.xpForNextLevel
          : xpForNextLevel as int,
      xpInCurrentLevel: null == xpInCurrentLevel
          ? _value.xpInCurrentLevel
          : xpInCurrentLevel as int,
      totalXpEarned: null == totalXpEarned
          ? _value.totalXpEarned
          : totalXpEarned as int,
      history: null == history
          ? _value.history
          : history as List<XpHistoryEntry>,
    ) as $Val);
  }
}

abstract class _$$XpDataImplCopyWith<$Res> implements $XpDataCopyWith<$Res> {
  factory _$$XpDataImplCopyWith(
          _$XpDataImpl value, $Res Function(_$XpDataImpl) then) =
      __$$XpDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentXp,
      int level,
      int xpForNextLevel,
      int xpInCurrentLevel,
      int totalXpEarned,
      List<XpHistoryEntry> history});
}

class __$$XpDataImplCopyWithImpl<$Res>
    extends _$XpDataCopyWithImpl<$Res, _$XpDataImpl>
    implements _$$XpDataImplCopyWith<$Res> {
  __$$XpDataImplCopyWithImpl(
      _$XpDataImpl _value, $Res Function(_$XpDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentXp = null,
    Object? level = null,
    Object? xpForNextLevel = null,
    Object? xpInCurrentLevel = null,
    Object? totalXpEarned = null,
    Object? history = null,
  }) {
    return _then(_$XpDataImpl(
      currentXp: null == currentXp
          ? _value.currentXp
          : currentXp as int,
      level: null == level
          ? _value.level
          : level as int,
      xpForNextLevel: null == xpForNextLevel
          ? _value.xpForNextLevel
          : xpForNextLevel as int,
      xpInCurrentLevel: null == xpInCurrentLevel
          ? _value.xpInCurrentLevel
          : xpInCurrentLevel as int,
      totalXpEarned: null == totalXpEarned
          ? _value.totalXpEarned
          : totalXpEarned as int,
      history: null == history
          ? _value._history
          : history as List<XpHistoryEntry>,
    ));
  }
}

@JsonSerializable()
class _$XpDataImpl implements _XpData {
  const _$XpDataImpl(
      {required this.currentXp,
      required this.level,
      required this.xpForNextLevel,
      required this.xpInCurrentLevel,
      required this.totalXpEarned,
      required final List<XpHistoryEntry> history})
      : _history = history;

  factory _$XpDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$XpDataImplFromJson(json);

  @override
  final int currentXp;
  @override
  final int level;
  @override
  final int xpForNextLevel;
  @override
  final int xpInCurrentLevel;
  @override
  final int totalXpEarned;
  final List<XpHistoryEntry> _history;
  @override
  List<XpHistoryEntry> get history {
    return _history;
  }

  @override
  String toString() {
    return 'XpData(currentXp: $currentXp, level: $level, xpForNextLevel: $xpForNextLevel, xpInCurrentLevel: $xpInCurrentLevel, totalXpEarned: $totalXpEarned, history: $history)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$XpDataImpl &&
            (identical(other.currentXp, currentXp) ||
                other.currentXp == currentXp) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.xpForNextLevel, xpForNextLevel) ||
                other.xpForNextLevel == xpForNextLevel) &&
            (identical(other.xpInCurrentLevel, xpInCurrentLevel) ||
                other.xpInCurrentLevel == xpInCurrentLevel) &&
            (identical(other.totalXpEarned, totalXpEarned) ||
                other.totalXpEarned == totalXpEarned) &&
            const DeepCollectionEquality().equals(other._history, _history));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentXp,
      level,
      xpForNextLevel,
      xpInCurrentLevel,
      totalXpEarned,
      const DeepCollectionEquality().hash(_history));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$XpDataImplCopyWith<_$XpDataImpl> get copyWith =>
      __$$XpDataImplCopyWithImpl<_$XpDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$XpDataImplToJson(
      this,
    );
  }
}

abstract class _XpData implements XpData {
  const factory _XpData(
      {required final int currentXp,
      required final int level,
      required final int xpForNextLevel,
      required final int xpInCurrentLevel,
      required final int totalXpEarned,
      required final List<XpHistoryEntry> history}) = _$XpDataImpl;

  factory _XpData.fromJson(Map<String, dynamic> json) = _$XpDataImpl.fromJson;

  @override
  int get currentXp;
  @override
  int get level;
  @override
  int get xpForNextLevel;
  @override
  int get xpInCurrentLevel;
  @override
  int get totalXpEarned;
  @override
  List<XpHistoryEntry> get history;
  @override
  @JsonKey(ignore: true)
  _$$XpDataImplCopyWith<_$XpDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

mixin _$XpHistoryEntry {
  int get amount => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $XpHistoryEntryCopyWith<XpHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $XpHistoryEntryCopyWith<$Res> {
  factory $XpHistoryEntryCopyWith(
          XpHistoryEntry value, $Res Function(XpHistoryEntry) then) =
      _$XpHistoryEntryCopyWithImpl<$Res, XpHistoryEntry>;
  @useResult
  $Res call({int amount, String source, DateTime timestamp, String? description});
}

class _$XpHistoryEntryCopyWithImpl<$Res, $Val extends XpHistoryEntry>
    implements $XpHistoryEntryCopyWith<$Res> {
  _$XpHistoryEntryCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? source = null,
    Object? timestamp = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount as int,
      source: null == source
          ? _value.source
          : source as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp as DateTime,
      description: freezed == description
          ? _value.description
          : description as String?,
    ) as $Val);
  }
}

abstract class _$$XpHistoryEntryImplCopyWith<$Res>
    implements $XpHistoryEntryCopyWith<$Res> {
  factory _$$XpHistoryEntryImplCopyWith(
          _$XpHistoryEntryImpl value, $Res Function(_$XpHistoryEntryImpl) then) =
      __$$XpHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int amount, String source, DateTime timestamp, String? description});
}

class __$$XpHistoryEntryImplCopyWithImpl<$Res>
    extends _$XpHistoryEntryCopyWithImpl<$Res, _$XpHistoryEntryImpl>
    implements _$$XpHistoryEntryImplCopyWith<$Res> {
  __$$XpHistoryEntryImplCopyWithImpl(
      _$XpHistoryEntryImpl _value, $Res Function(_$XpHistoryEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? source = null,
    Object? timestamp = null,
    Object? description = freezed,
  }) {
    return _then(_$XpHistoryEntryImpl(
      amount: null == amount
          ? _value.amount
          : amount as int,
      source: null == source
          ? _value.source
          : source as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp as DateTime,
      description: freezed == description
          ? _value.description
          : description as String?,
    ));
  }
}

@JsonSerializable()
class _$XpHistoryEntryImpl implements _XpHistoryEntry {
  const _$XpHistoryEntryImpl(
      {required this.amount,
      required this.source,
      required this.timestamp,
      this.description});

  factory _$XpHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$XpHistoryEntryImplFromJson(json);

  @override
  final int amount;
  @override
  final String source;
  @override
  final DateTime timestamp;
  @override
  final String? description;

  @override
  String toString() {
    return 'XpHistoryEntry(amount: $amount, source: $source, timestamp: $timestamp, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$XpHistoryEntryImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, source, timestamp, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$XpHistoryEntryImplCopyWith<_$XpHistoryEntryImpl> get copyWith =>
      __$$XpHistoryEntryImplCopyWithImpl<_$XpHistoryEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$XpHistoryEntryImplToJson(
      this,
    );
  }
}

abstract class _XpHistoryEntry implements XpHistoryEntry {
  const factory _XpHistoryEntry(
      {required final int amount,
      required final String source,
      required final DateTime timestamp,
      final String? description}) = _$XpHistoryEntryImpl;

  factory _XpHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$XpHistoryEntryImpl.fromJson;

  @override
  int get amount;
  @override
  String get source;
  @override
  DateTime get timestamp;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$XpHistoryEntryImplCopyWith<_$XpHistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
