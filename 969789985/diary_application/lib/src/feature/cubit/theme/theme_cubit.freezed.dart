// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ThemeState {
  bool get isDarkMode => throw _privateConstructorUsedError;
  double get messageFontSize => throw _privateConstructorUsedError;
  int get primaryColor => throw _privateConstructorUsedError;
  int get primaryItemColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeStateCopyWith<ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeStateCopyWith<$Res> {
  factory $ThemeStateCopyWith(
          ThemeState value, $Res Function(ThemeState) then) =
      _$ThemeStateCopyWithImpl<$Res, ThemeState>;
  @useResult
  $Res call(
      {bool isDarkMode,
      double messageFontSize,
      int primaryColor,
      int primaryItemColor});
}

/// @nodoc
class _$ThemeStateCopyWithImpl<$Res, $Val extends ThemeState>
    implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDarkMode = null,
    Object? messageFontSize = null,
    Object? primaryColor = null,
    Object? primaryItemColor = null,
  }) {
    return _then(_value.copyWith(
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      messageFontSize: null == messageFontSize
          ? _value.messageFontSize
          : messageFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as int,
      primaryItemColor: null == primaryItemColor
          ? _value.primaryItemColor
          : primaryItemColor // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ThemeStateCopyWith<$Res>
    implements $ThemeStateCopyWith<$Res> {
  factory _$$_ThemeStateCopyWith(
          _$_ThemeState value, $Res Function(_$_ThemeState) then) =
      __$$_ThemeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isDarkMode,
      double messageFontSize,
      int primaryColor,
      int primaryItemColor});
}

/// @nodoc
class __$$_ThemeStateCopyWithImpl<$Res>
    extends _$ThemeStateCopyWithImpl<$Res, _$_ThemeState>
    implements _$$_ThemeStateCopyWith<$Res> {
  __$$_ThemeStateCopyWithImpl(
      _$_ThemeState _value, $Res Function(_$_ThemeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDarkMode = null,
    Object? messageFontSize = null,
    Object? primaryColor = null,
    Object? primaryItemColor = null,
  }) {
    return _then(_$_ThemeState(
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      messageFontSize: null == messageFontSize
          ? _value.messageFontSize
          : messageFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as int,
      primaryItemColor: null == primaryItemColor
          ? _value.primaryItemColor
          : primaryItemColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ThemeState implements _ThemeState {
  const _$_ThemeState(
      {required this.isDarkMode,
      required this.messageFontSize,
      required this.primaryColor,
      required this.primaryItemColor});

  @override
  final bool isDarkMode;
  @override
  final double messageFontSize;
  @override
  final int primaryColor;
  @override
  final int primaryItemColor;

  @override
  String toString() {
    return 'ThemeState(isDarkMode: $isDarkMode, messageFontSize: $messageFontSize, primaryColor: $primaryColor, primaryItemColor: $primaryItemColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThemeState &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.messageFontSize, messageFontSize) ||
                other.messageFontSize == messageFontSize) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.primaryItemColor, primaryItemColor) ||
                other.primaryItemColor == primaryItemColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isDarkMode, messageFontSize, primaryColor, primaryItemColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ThemeStateCopyWith<_$_ThemeState> get copyWith =>
      __$$_ThemeStateCopyWithImpl<_$_ThemeState>(this, _$identity);
}

abstract class _ThemeState implements ThemeState {
  const factory _ThemeState(
      {required final bool isDarkMode,
      required final double messageFontSize,
      required final int primaryColor,
      required final int primaryItemColor}) = _$_ThemeState;

  @override
  bool get isDarkMode;
  @override
  double get messageFontSize;
  @override
  int get primaryColor;
  @override
  int get primaryItemColor;
  @override
  @JsonKey(ignore: true)
  _$$_ThemeStateCopyWith<_$_ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}
