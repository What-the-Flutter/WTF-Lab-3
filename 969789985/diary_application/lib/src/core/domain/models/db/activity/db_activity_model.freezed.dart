// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'db_activity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DBActivityModel _$DBActivityModelFromJson(Map<String, dynamic> json) {
  return _DBActivityModel.fromJson(json);
}

/// @nodoc
mixin _$DBActivityModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  dynamic get spentTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DBActivityModelCopyWith<DBActivityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DBActivityModelCopyWith<$Res> {
  factory $DBActivityModelCopyWith(
          DBActivityModel value, $Res Function(DBActivityModel) then) =
      _$DBActivityModelCopyWithImpl<$Res, DBActivityModel>;
  @useResult
  $Res call({String id, DateTime date, dynamic spentTime});
}

/// @nodoc
class _$DBActivityModelCopyWithImpl<$Res, $Val extends DBActivityModel>
    implements $DBActivityModelCopyWith<$Res> {
  _$DBActivityModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_DBActivityModelCopyWith<$Res>
    implements $DBActivityModelCopyWith<$Res> {
  factory _$$_DBActivityModelCopyWith(
          _$_DBActivityModel value, $Res Function(_$_DBActivityModel) then) =
      __$$_DBActivityModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, DateTime date, dynamic spentTime});
}

/// @nodoc
class __$$_DBActivityModelCopyWithImpl<$Res>
    extends _$DBActivityModelCopyWithImpl<$Res, _$_DBActivityModel>
    implements _$$_DBActivityModelCopyWith<$Res> {
  __$$_DBActivityModelCopyWithImpl(
      _$_DBActivityModel _value, $Res Function(_$_DBActivityModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? spentTime = freezed,
  }) {
    return _then(_$_DBActivityModel(
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
@JsonSerializable()
class _$_DBActivityModel implements _DBActivityModel {
  _$_DBActivityModel(
      {this.id = '_id', required this.date, this.spentTime = '0'});

  factory _$_DBActivityModel.fromJson(Map<String, dynamic> json) =>
      _$$_DBActivityModelFromJson(json);

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
    return 'DBActivityModel(id: $id, date: $date, spentTime: $spentTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DBActivityModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other.spentTime, spentTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, date, const DeepCollectionEquality().hash(spentTime));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DBActivityModelCopyWith<_$_DBActivityModel> get copyWith =>
      __$$_DBActivityModelCopyWithImpl<_$_DBActivityModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DBActivityModelToJson(
      this,
    );
  }
}

abstract class _DBActivityModel implements DBActivityModel {
  factory _DBActivityModel(
      {final String id,
      required final DateTime date,
      final dynamic spentTime}) = _$_DBActivityModel;

  factory _DBActivityModel.fromJson(Map<String, dynamic> json) =
      _$_DBActivityModel.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  dynamic get spentTime;
  @override
  @JsonKey(ignore: true)
  _$$_DBActivityModelCopyWith<_$_DBActivityModel> get copyWith =>
      throw _privateConstructorUsedError;
}
