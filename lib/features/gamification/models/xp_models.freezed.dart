// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'xp_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

XpData _$XpDataFromJson(Map<String, dynamic> json) {
  return _XpData.fromJson(json);
}

/// @nodoc
mixin _$XpData {
  int get currentXp => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get xpForNextLevel => throw _privateConstructorUsedError;
  int get xpInCurrentLevel => throw _privateConstructorUsedError;
  int get totalXpEarned => throw _privateConstructorUsedError;
  List<XpHistoryEntry> get history => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $XpDataCopyWith<XpData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
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

/// @nodoc
class _$XpDataCopyWithImpl<$Res, $Val extends XpData>
    implements $XpDataCopyWith<$Res> {
  _$XpDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
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
          : currentXp // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      xpForNextLevel: null == xpForNextLevel
          ? _value.xpForNextLevel
          : xpForNextLevel // ignore: cast_nullable_to_non_nullable
              as int,
      xpInCurrentLevel: null == xpInCurrentLevel
          ? _value.xpInCurrentLevel
          : xpInCurrentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      totalXpEarned: null == totalXpEarned
          ? _value.totalXpEarned
          : totalXpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<XpHistoryEntry>,
    ) as $Val);
  }
}

/// @nodoc
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

/// @nodoc
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
          : currentXp // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      xpForNextLevel: null == xpForNextLevel
          ? _value.xpForNextLevel
          : xpForNextLevel // ignore: cast_nullable_to_non_nullable
              as int,
      xpInCurrentLevel: null == xpInCurrentLevel
          ? _value.xpInCurrentLevel
          : xpInCurrentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      totalXpEarned: null == totalXpEarned
          ? _value.totalXpEarned
          : totalXpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<XpHistoryEntry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$XpDataImpl with DiagnosticableTreeMixin implements _XpData {
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
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'XpData(currentXp: $currentXp, level: $level, xpForNextLevel: $xpForNextLevel, xpInCurrentLevel: $xpInCurrentLevel, totalXpEarned: $totalXpEarned, history: $history)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'XpData'))
      ..add(DiagnosticsProperty('currentXp', currentXp))
      ..add(DiagnosticsProperty('level', level))
      ..add(DiagnosticsProperty('xpForNextLevel', xpForNextLevel))
      ..add(DiagnosticsProperty('xpInCurrentLevel', xpInCurrentLevel))
      ..add(DiagnosticsProperty('totalXpEarned', totalXpEarned))
      ..add(DiagnosticsProperty('history', history));
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

XpHistoryEntry _$XpHistoryEntryFromJson(Map<String, dynamic> json) {
  return _XpHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$XpHistoryEntry {
  int get amount => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $XpHistoryEntryCopyWith<XpHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $XpHistoryEntryCopyWith<$Res> {
  factory $XpHistoryEntryCopyWith(
          XpHistoryEntry value, $Res Function(XpHistoryEntry) then) =
      _$XpHistoryEntryCopyWithImpl<$Res, XpHistoryEntry>;
  @useResult
  $Res call(
      {int amount, String source, DateTime timestamp, String? description});
}

/// @nodoc
class _$XpHistoryEntryCopyWithImpl<$Res, $Val extends XpHistoryEntry>
    implements $XpHistoryEntryCopyWith<$Res> {
  _$XpHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
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
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$XpHistoryEntryImplCopyWith<$Res>
    implements $XpHistoryEntryCopyWith<$Res> {
  factory _$$XpHistoryEntryImplCopyWith(_$XpHistoryEntryImpl value,
          $Res Function(_$XpHistoryEntryImpl) then) =
      __$$XpHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int amount, String source, DateTime timestamp, String? description});
}

/// @nodoc
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
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$XpHistoryEntryImpl
    with DiagnosticableTreeMixin
    implements _XpHistoryEntry {
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'XpHistoryEntry(amount: $amount, source: $source, timestamp: $timestamp, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'XpHistoryEntry'))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('description', description));
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
      __$$XpHistoryEntryImplCopyWithImpl<_$XpHistoryEntryImpl>(
          this, _$identity);

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

/// @nodoc
mixin _$XpReward {
  int get amount => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  XpRewardType get type => throw _privateConstructorUsedError;
  bool get isBonus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $XpRewardCopyWith<XpReward> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $XpRewardCopyWith<$Res> {
  factory $XpRewardCopyWith(XpReward value, $Res Function(XpReward) then) =
      _$XpRewardCopyWithImpl<$Res, XpReward>;
  @useResult
  $Res call({int amount, String reason, XpRewardType type, bool isBonus});
}

/// @nodoc
class _$XpRewardCopyWithImpl<$Res, $Val extends XpReward>
    implements $XpRewardCopyWith<$Res> {
  _$XpRewardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? reason = null,
    Object? type = null,
    Object? isBonus = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as XpRewardType,
      isBonus: null == isBonus
          ? _value.isBonus
          : isBonus // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$XpRewardImplCopyWith<$Res>
    implements $XpRewardCopyWith<$Res> {
  factory _$$XpRewardImplCopyWith(
          _$XpRewardImpl value, $Res Function(_$XpRewardImpl) then) =
      __$$XpRewardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int amount, String reason, XpRewardType type, bool isBonus});
}

/// @nodoc
class __$$XpRewardImplCopyWithImpl<$Res>
    extends _$XpRewardCopyWithImpl<$Res, _$XpRewardImpl>
    implements _$$XpRewardImplCopyWith<$Res> {
  __$$XpRewardImplCopyWithImpl(
      _$XpRewardImpl _value, $Res Function(_$XpRewardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? reason = null,
    Object? type = null,
    Object? isBonus = null,
  }) {
    return _then(_$XpRewardImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as XpRewardType,
      isBonus: null == isBonus
          ? _value.isBonus
          : isBonus // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$XpRewardImpl with DiagnosticableTreeMixin implements _XpReward {
  const _$XpRewardImpl(
      {required this.amount,
      required this.reason,
      required this.type,
      this.isBonus = false});

  @override
  final int amount;
  @override
  final String reason;
  @override
  final XpRewardType type;
  @override
  @JsonKey()
  final bool isBonus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'XpReward(amount: $amount, reason: $reason, type: $type, isBonus: $isBonus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'XpReward'))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('reason', reason))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('isBonus', isBonus));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$XpRewardImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isBonus, isBonus) || other.isBonus == isBonus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, reason, type, isBonus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$XpRewardImplCopyWith<_$XpRewardImpl> get copyWith =>
      __$$XpRewardImplCopyWithImpl<_$XpRewardImpl>(this, _$identity);
}

abstract class _XpReward implements XpReward {
  const factory _XpReward(
      {required final int amount,
      required final String reason,
      required final XpRewardType type,
      final bool isBonus}) = _$XpRewardImpl;

  @override
  int get amount;
  @override
  String get reason;
  @override
  XpRewardType get type;
  @override
  bool get isBonus;
  @override
  @JsonKey(ignore: true)
  _$$XpRewardImplCopyWith<_$XpRewardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
