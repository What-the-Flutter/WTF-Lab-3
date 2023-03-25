// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ActivityModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  dynamic get spentTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActivityModelCopyWith<ActivityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityModelCopyWith<$Res> {
  factory $ActivityModelCopyWith(
          ActivityModel value, $Res Function(ActivityModel) then) =
      _$ActivityModelCopyWithImpl<$Res, ActivityModel>;
  @useResult
  $Res call({String id, DateTime date, dynamic spentTime});
}

/// @nodoc
class _$ActivityModelCopyWithImpl<$Res, $Val extends ActivityModel>
    implements $ActivityModelCopyWith<$Res> {
  _$ActivityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? spentTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      spentTime: freezed == spentTime
          ? _value.spentTime
          : spentTime // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ActivityModelCopyWith<$Res>
    implements $ActivityModelCopyWith<$Res> {
  factory _$$_ActivityModelCopyWith(
          _$_ActivityModel value, $Res Function(_$_ActivityModel) then) =
      __$$_ActivityModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, DateTime date, dynamic spentTime});
}

/// @nodoc
class __$$_ActivityModelCopyWithImpl<$Res>
    extends _$ActivityModelCopyWithImpl<$Res, _$_ActivityModel>
    implements _$$_ActivityModelCopyWith<$Res> {
  __$$_ActivityModelCopyWithImpl(
      _$_ActivityModel _value, $Res Function(_$_ActivityModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? spentTime = freezed,
  }) {
    return _then(_$_ActivityModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      spentTime: freezed == spentTime ? _value.spentTime! : spentTime,
    ));
  }
}

/// @nodoc

class _$_ActivityModel implements _ActivityModel {
  _$_ActivityModel({this.id = '_id', required this.date, this.spentTime = '0'});

  @override
  @JsonKey()
  final String id;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final dynamic spentTime;

  @override
  String toString() {
    return 'ActivityModel(id: $id, date: $date, spentTime: $spentTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivityModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other.spentTime, spentTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, date, const DeepCollectionEquality().hash(spentTime));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActivityModelCopyWith<_$_ActivityModel> get copyWith =>
      __$$_ActivityModelCopyWithImpl<_$_ActivityModel>(this, _$identity);
}

abstract class _ActivityModel implements ActivityModel {
  factory _ActivityModel(
      {final String id,
      required final DateTime date,
      final dynamic spentTime}) = _$_ActivityModel;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  dynamic get spentTime;
  @override
  @JsonKey(ignore: true)
  _$$_ActivityModelCopyWith<_$_ActivityModel> get copyWith =>
      throw _privateConstructorUsedError;
}
