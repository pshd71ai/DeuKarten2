// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_cards_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TodayCardsState {
  List<String> get newCards => throw _privateConstructorUsedError;
  List<String> get reviewCards => throw _privateConstructorUsedError;
  List<String> get learningCards => throw _privateConstructorUsedError;
  int get totalDue => throw _privateConstructorUsedError;
  Map<DateTime, int> get forecast => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodayCardsStateCopyWith<TodayCardsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayCardsStateCopyWith<$Res> {
  factory $TodayCardsStateCopyWith(
          TodayCardsState value, $Res Function(TodayCardsState) then) =
      _$TodayCardsStateCopyWithImpl<$Res, TodayCardsState>;
  @useResult
  $Res call(
      {List<String> newCards,
      List<String> reviewCards,
      List<String> learningCards,
      int totalDue,
      Map<DateTime, int> forecast});
}

/// @nodoc
class _$TodayCardsStateCopyWithImpl<$Res, $Val extends TodayCardsState>
    implements $TodayCardsStateCopyWith<$Res> {
  _$TodayCardsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newCards = null,
    Object? reviewCards = null,
    Object? learningCards = null,
    Object? totalDue = null,
    Object? forecast = null,
  }) {
    return _then(_value.copyWith(
      newCards: null == newCards
          ? _value.newCards
          : newCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reviewCards: null == reviewCards
          ? _value.reviewCards
          : reviewCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      learningCards: null == learningCards
          ? _value.learningCards
          : learningCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalDue: null == totalDue
          ? _value.totalDue
          : totalDue // ignore: cast_nullable_to_non_nullable
              as int,
      forecast: null == forecast
          ? _value.forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodayCardsStateImplCopyWith<$Res>
    implements $TodayCardsStateCopyWith<$Res> {
  factory _$$TodayCardsStateImplCopyWith(_$TodayCardsStateImpl value,
          $Res Function(_$TodayCardsStateImpl) then) =
      __$$TodayCardsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> newCards,
      List<String> reviewCards,
      List<String> learningCards,
      int totalDue,
      Map<DateTime, int> forecast});
}

/// @nodoc
class __$$TodayCardsStateImplCopyWithImpl<$Res>
    extends _$TodayCardsStateCopyWithImpl<$Res, _$TodayCardsStateImpl>
    implements _$$TodayCardsStateImplCopyWith<$Res> {
  __$$TodayCardsStateImplCopyWithImpl(
      _$TodayCardsStateImpl _value, $Res Function(_$TodayCardsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newCards = null,
    Object? reviewCards = null,
    Object? learningCards = null,
    Object? totalDue = null,
    Object? forecast = null,
  }) {
    return _then(_$TodayCardsStateImpl(
      newCards: null == newCards
          ? _value._newCards
          : newCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reviewCards: null == reviewCards
          ? _value._reviewCards
          : reviewCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      learningCards: null == learningCards
          ? _value._learningCards
          : learningCards // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalDue: null == totalDue
          ? _value.totalDue
          : totalDue // ignore: cast_nullable_to_non_nullable
              as int,
      forecast: null == forecast
          ? _value._forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, int>,
    ));
  }
}

/// @nodoc

class _$TodayCardsStateImpl implements _TodayCardsState {
  const _$TodayCardsStateImpl(
      {required final List<String> newCards,
      required final List<String> reviewCards,
      required final List<String> learningCards,
      required this.totalDue,
      required final Map<DateTime, int> forecast})
      : _newCards = newCards,
        _reviewCards = reviewCards,
        _learningCards = learningCards,
        _forecast = forecast;

  final List<String> _newCards;
  @override
  List<String> get newCards {
    if (_newCards is EqualUnmodifiableListView) return _newCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newCards);
  }

  final List<String> _reviewCards;
  @override
  List<String> get reviewCards {
    if (_reviewCards is EqualUnmodifiableListView) return _reviewCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviewCards);
  }

  final List<String> _learningCards;
  @override
  List<String> get learningCards {
    if (_learningCards is EqualUnmodifiableListView) return _learningCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_learningCards);
  }

  @override
  final int totalDue;
  final Map<DateTime, int> _forecast;
  @override
  Map<DateTime, int> get forecast {
    if (_forecast is EqualUnmodifiableMapView) return _forecast;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_forecast);
  }

  @override
  String toString() {
    return 'TodayCardsState(newCards: $newCards, reviewCards: $reviewCards, learningCards: $learningCards, totalDue: $totalDue, forecast: $forecast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodayCardsStateImpl &&
            const DeepCollectionEquality().equals(other._newCards, _newCards) &&
            const DeepCollectionEquality()
                .equals(other._reviewCards, _reviewCards) &&
            const DeepCollectionEquality()
                .equals(other._learningCards, _learningCards) &&
            (identical(other.totalDue, totalDue) ||
                other.totalDue == totalDue) &&
            const DeepCollectionEquality().equals(other._forecast, _forecast));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_newCards),
      const DeepCollectionEquality().hash(_reviewCards),
      const DeepCollectionEquality().hash(_learningCards),
      totalDue,
      const DeepCollectionEquality().hash(_forecast));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodayCardsStateImplCopyWith<_$TodayCardsStateImpl> get copyWith =>
      __$$TodayCardsStateImplCopyWithImpl<_$TodayCardsStateImpl>(
          this, _$identity);
}

abstract class _TodayCardsState implements TodayCardsState {
  const factory _TodayCardsState(
      {required final List<String> newCards,
      required final List<String> reviewCards,
      required final List<String> learningCards,
      required final int totalDue,
      required final Map<DateTime, int> forecast}) = _$TodayCardsStateImpl;

  @override
  List<String> get newCards;
  @override
  List<String> get reviewCards;
  @override
  List<String> get learningCards;
  @override
  int get totalDue;
  @override
  Map<DateTime, int> get forecast;
  @override
  @JsonKey(ignore: true)
  _$$TodayCardsStateImplCopyWith<_$TodayCardsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
