// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element
part of 'streak_model.dart';

// **************************************************************************
// Freezed Generator
// **************************************************************************

mixin _$StreakData {
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  DateTime get lastStudyDate => throw _privateConstructorUsedError;
  bool get studiedToday => throw _privateConstructorUsedError;
  List<DateTime> get studyDates => throw _privateConstructorUsedError;
  StreakMilestone? get lastMilestone => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StreakDataCopyWith<StreakData> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $StreakDataCopyWith<$Res> {
  factory $StreakDataCopyWith(StreakData value, $Res Function(StreakData) then) =
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

class _$StreakDataCopyWithImpl<$Res, $Val extends StreakData>
    implements $StreakDataCopyWith<$Res> {
  _$StreakDataCopyWithImpl(this._value, this._then);

  final $Val _value;
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
          : currentStreak as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak as int,
      lastStudyDate: null == lastStudyDate
          ? _value.lastStudyDate
          : lastStudyDate as DateTime,
      studiedToday: null == studiedToday
          ? _value.studiedToday
          : studiedToday as bool,
      studyDates: null == studyDates
          ? _value.studyDates
          : studyDates as List<DateTime>,
      lastMilestone: freezed == lastMilestone
          ? _value.lastMilestone
          : lastMilestone as StreakMilestone?,
    ) as $Val);
  }
}

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
          : currentStreak as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak as int,
      lastStudyDate: null == lastStudyDate
          ? _value.lastStudyDate
          : lastStudyDate as DateTime,
      studiedToday: null == studiedToday
          ? _value.studiedToday
          : studiedToday as bool,
      studyDates: null == studyDates
          ? _value._studyDates
          : studyDates as List<DateTime>,
      lastMilestone: freezed == lastMilestone
          ? _value.lastMilestone
          : lastMilestone as StreakMilestone?,
    ));
  }
}

@JsonSerializable()
class _$StreakDataImpl implements _StreakData {
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
    return _studyDates;
  }

  @override
  final StreakMilestone? lastMilestone;

  @override
  String toString() {
    return 'StreakData(currentStreak: $currentStreak, longestStreak: $longestStreak, lastStudyDate: $lastStudyDate, studiedToday: $studiedToday, studyDates: $studyDates, lastMilestone: $lastMilestone)';
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
            const DeepCollectionEquality().equals(other._studyDates, _studyDates) &&
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
