// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StreakData _$StreakDataFromJson(Map<String, dynamic> json) {
  return _StreakData.fromJson(json);
}

/// @nodoc
mixin _$StreakData {
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  DateTime get lastStudyDate => throw _privateConstructorUsedError;
  bool get studiedToday => throw _privateConstructorUsedError;
  List<DateTime> get studyDates => throw _privateConstructorUsedError;
  StreakMilestone? get lastMilestone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StreakDataCopyWith<StreakData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreakDataCopyWith<$Res> {
  factory $StreakDataCopyWith(
          StreakData value, $Res Function(StreakData) then) =
      _$StreakDataCopyWithImpl<$Res, StreakData>;
  @useResult
  $Res call(
      {int currentStreak,
      int longestStreak,
      DateTime lastStudyDate,
      bool studiedToday,
      List<DateTime> studyDates,
      StreakMilestone? lastMilestone});
}

/// @nodoc
class _$StreakDataCopyWithImpl<$Res, $Val extends StreakData>
    implements $StreakDataCopyWith<$Res> {
  _$StreakDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastStudyDate = null,
    Object? studiedToday = null,
    Object? studyDates = null,
    Object? lastMilestone = freezed,
  }) {
    return _then(_value.copyWith(
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastStudyDate: null == lastStudyDate
          ? _value.lastStudyDate
          : lastStudyDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      studiedToday: null == studiedToday
          ? _value.studiedToday
          : studiedToday // ignore: cast_nullable_to_non_nullable
              as bool,
      studyDates: null == studyDates
          ? _value.studyDates
          : studyDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      lastMilestone: freezed == lastMilestone
          ? _value.lastMilestone
          : lastMilestone // ignore: cast_nullable_to_non_nullable
              as StreakMilestone?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreakDataImplCopyWith<$Res>
    implements $StreakDataCopyWith<$Res> {
  factory _$$StreakDataImplCopyWith(
          _$StreakDataImpl value, $Res Function(_$StreakDataImpl) then) =
      __$$StreakDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentStreak,
      int longestStreak,
      DateTime lastStudyDate,
      bool studiedToday,
      List<DateTime> studyDates,
      StreakMilestone? lastMilestone});
}

/// @nodoc
class __$$StreakDataImplCopyWithImpl<$Res>
    extends _$StreakDataCopyWithImpl<$Res, _$StreakDataImpl>
    implements _$$StreakDataImplCopyWith<$Res> {
  __$$StreakDataImplCopyWithImpl(
      _$StreakDataImpl _value, $Res Function(_$StreakDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastStudyDate = null,
    Object? studiedToday = null,
    Object? studyDates = null,
    Object? lastMilestone = freezed,
  }) {
    return _then(_$StreakDataImpl(
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastStudyDate: null == lastStudyDate
          ? _value.lastStudyDate
          : lastStudyDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      studiedToday: null == studiedToday
          ? _value.studiedToday
          : studiedToday // ignore: cast_nullable_to_non_nullable
              as bool,
      studyDates: null == studyDates
          ? _value._studyDates
          : studyDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      lastMilestone: freezed == lastMilestone
          ? _value.lastMilestone
          : lastMilestone // ignore: cast_nullable_to_non_nullable
              as StreakMilestone?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StreakDataImpl with DiagnosticableTreeMixin implements _StreakData {
  const _$StreakDataImpl(
      {required this.currentStreak,
      required this.longestStreak,
      required this.lastStudyDate,
      required this.studiedToday,
      required final List<DateTime> studyDates,
      this.lastMilestone})
      : _studyDates = studyDates;

  factory _$StreakDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreakDataImplFromJson(json);

  @override
  final int currentStreak;
  @override
  final int longestStreak;
  @override
  final DateTime lastStudyDate;
  @override
  final bool studiedToday;
  final List<DateTime> _studyDates;
  @override
  List<DateTime> get studyDates {
    if (_studyDates is EqualUnmodifiableListView) return _studyDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_studyDates);
  }

  @override
  final StreakMilestone? lastMilestone;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StreakData(currentStreak: $currentStreak, longestStreak: $longestStreak, lastStudyDate: $lastStudyDate, studiedToday: $studiedToday, studyDates: $studyDates, lastMilestone: $lastMilestone)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StreakData'))
      ..add(DiagnosticsProperty('currentStreak', currentStreak))
      ..add(DiagnosticsProperty('longestStreak', longestStreak))
      ..add(DiagnosticsProperty('lastStudyDate', lastStudyDate))
      ..add(DiagnosticsProperty('studiedToday', studiedToday))
      ..add(DiagnosticsProperty('studyDates', studyDates))
      ..add(DiagnosticsProperty('lastMilestone', lastMilestone));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreakDataImpl &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.lastStudyDate, lastStudyDate) ||
                other.lastStudyDate == lastStudyDate) &&
            (identical(other.studiedToday, studiedToday) ||
                other.studiedToday == studiedToday) &&
            const DeepCollectionEquality()
                .equals(other._studyDates, _studyDates) &&
            (identical(other.lastMilestone, lastMilestone) ||
                other.lastMilestone == lastMilestone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentStreak,
      longestStreak,
      lastStudyDate,
      studiedToday,
      const DeepCollectionEquality().hash(_studyDates),
      lastMilestone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StreakDataImplCopyWith<_$StreakDataImpl> get copyWith =>
      __$$StreakDataImplCopyWithImpl<_$StreakDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreakDataImplToJson(
      this,
    );
  }
}

abstract class _StreakData implements StreakData {
  const factory _StreakData(
      {required final int currentStreak,
      required final int longestStreak,
      required final DateTime lastStudyDate,
      required final bool studiedToday,
      required final List<DateTime> studyDates,
      final StreakMilestone? lastMilestone}) = _$StreakDataImpl;

  factory _StreakData.fromJson(Map<String, dynamic> json) =
      _$StreakDataImpl.fromJson;

  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  DateTime get lastStudyDate;
  @override
  bool get studiedToday;
  @override
  List<DateTime> get studyDates;
  @override
  StreakMilestone? get lastMilestone;
  @override
  @JsonKey(ignore: true)
  _$$StreakDataImplCopyWith<_$StreakDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
