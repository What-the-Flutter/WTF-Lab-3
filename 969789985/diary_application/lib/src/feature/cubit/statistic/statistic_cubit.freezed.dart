// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistic_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StatisticState {
  IList<ActivityModel> get activities => throw _privateConstructorUsedError;
  IList<MessageModel> get messages => throw _privateConstructorUsedError;
  IList<DateTime> get datesRange => throw _privateConstructorUsedError;
  DateTime get entryTime => throw _privateConstructorUsedError;
  int get yMax => throw _privateConstructorUsedError;
  MessageDateChartSelections get dateSelection =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StatisticStateCopyWith<StatisticState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticStateCopyWith<$Res> {
  factory $StatisticStateCopyWith(
          StatisticState value, $Res Function(StatisticState) then) =
      _$StatisticStateCopyWithImpl<$Res, StatisticState>;
  @useResult
  $Res call(
      {IList<ActivityModel> activities,
      IList<MessageModel> messages,
      IList<DateTime> datesRange,
      DateTime entryTime,
      int yMax,
      MessageDateChartSelections dateSelection});
}

/// @nodoc
class _$StatisticStateCopyWithImpl<$Res, $Val extends StatisticState>
    implements $StatisticStateCopyWith<$Res> {
  _$StatisticStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activities = null,
    Object? messages = null,
    Object? datesRange = null,
    Object? entryTime = null,
    Object? yMax = null,
    Object? dateSelection = null,
  }) {
    return _then(_value.copyWith(
      activities: null == activities
          ? _value.activities
          : activities // ignore: cast_nullable_to_non_nullable
              as IList<ActivityModel>,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      datesRange: null == datesRange
          ? _value.datesRange
          : datesRange // ignore: cast_nullable_to_non_nullable
              as IList<DateTime>,
      entryTime: null == entryTime
          ? _value.entryTime
          : entryTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      yMax: null == yMax
          ? _value.yMax
          : yMax // ignore: cast_nullable_to_non_nullable
              as int,
      dateSelection: null == dateSelection
          ? _value.dateSelection
          : dateSelection // ignore: cast_nullable_to_non_nullable
              as MessageDateChartSelections,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StatisticStateCopyWith<$Res>
    implements $StatisticStateCopyWith<$Res> {
  factory _$$_StatisticStateCopyWith(
          _$_StatisticState value, $Res Function(_$_StatisticState) then) =
      __$$_StatisticStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IList<ActivityModel> activities,
      IList<MessageModel> messages,
      IList<DateTime> datesRange,
      DateTime entryTime,
      int yMax,
      MessageDateChartSelections dateSelection});
}

/// @nodoc
class __$$_StatisticStateCopyWithImpl<$Res>
    extends _$StatisticStateCopyWithImpl<$Res, _$_StatisticState>
    implements _$$_StatisticStateCopyWith<$Res> {
  __$$_StatisticStateCopyWithImpl(
      _$_StatisticState _value, $Res Function(_$_StatisticState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activities = null,
    Object? messages = null,
    Object? datesRange = null,
    Object? entryTime = null,
    Object? yMax = null,
    Object? dateSelection = null,
  }) {
    return _then(_$_StatisticState(
      activities: null == activities
          ? _value.activities
          : activities // ignore: cast_nullable_to_non_nullable
              as IList<ActivityModel>,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      datesRange: null == datesRange
          ? _value.datesRange
          : datesRange // ignore: cast_nullable_to_non_nullable
              as IList<DateTime>,
      entryTime: null == entryTime
          ? _value.entryTime
          : entryTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      yMax: null == yMax
          ? _value.yMax
          : yMax // ignore: cast_nullable_to_non_nullable
              as int,
      dateSelection: null == dateSelection
          ? _value.dateSelection
          : dateSelection // ignore: cast_nullable_to_non_nullable
              as MessageDateChartSelections,
    ));
  }
}

/// @nodoc

class _$_StatisticState implements _StatisticState {
  const _$_StatisticState(
      {required this.activities,
      required this.messages,
      required this.datesRange,
      required this.entryTime,
      required this.yMax,
      required this.dateSelection});

  @override
  final IList<ActivityModel> activities;
  @override
  final IList<MessageModel> messages;
  @override
  final IList<DateTime> datesRange;
  @override
  final DateTime entryTime;
  @override
  final int yMax;
  @override
  final MessageDateChartSelections dateSelection;

  @override
  String toString() {
    return 'StatisticState(activities: $activities, messages: $messages, datesRange: $datesRange, entryTime: $entryTime, yMax: $yMax, dateSelection: $dateSelection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StatisticState &&
            const DeepCollectionEquality()
                .equals(other.activities, activities) &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            const DeepCollectionEquality()
                .equals(other.datesRange, datesRange) &&
            (identical(other.entryTime, entryTime) ||
                other.entryTime == entryTime) &&
            (identical(other.yMax, yMax) || other.yMax == yMax) &&
            (identical(other.dateSelection, dateSelection) ||
                other.dateSelection == dateSelection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(activities),
      const DeepCollectionEquality().hash(messages),
      const DeepCollectionEquality().hash(datesRange),
      entryTime,
      yMax,
      dateSelection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StatisticStateCopyWith<_$_StatisticState> get copyWith =>
      __$$_StatisticStateCopyWithImpl<_$_StatisticState>(this, _$identity);
}

abstract class _StatisticState implements StatisticState {
  const factory _StatisticState(
          {required final IList<ActivityModel> activities,
          required final IList<MessageModel> messages,
          required final IList<DateTime> datesRange,
          required final DateTime entryTime,
          required final int yMax,
          required final MessageDateChartSelections dateSelection}) =
      _$_StatisticState;

  @override
  IList<ActivityModel> get activities;
  @override
  IList<MessageModel> get messages;
  @override
  IList<DateTime> get datesRange;
  @override
  DateTime get entryTime;
  @override
  int get yMax;
  @override
  MessageDateChartSelections get dateSelection;
  @override
  @JsonKey(ignore: true)
  _$$_StatisticStateCopyWith<_$_StatisticState> get copyWith =>
      throw _privateConstructorUsedError;
}
