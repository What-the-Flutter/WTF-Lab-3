// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_screen_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StartScreenState {
  int get pageIndex => throw _privateConstructorUsedError;
  bool get fabVisible => throw _privateConstructorUsedError;
  bool get gNavVisible => throw _privateConstructorUsedError;
  String get hashtag => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StartScreenStateCopyWith<StartScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StartScreenStateCopyWith<$Res> {
  factory $StartScreenStateCopyWith(
          StartScreenState value, $Res Function(StartScreenState) then) =
      _$StartScreenStateCopyWithImpl<$Res, StartScreenState>;
  @useResult
  $Res call({int pageIndex, bool fabVisible, bool gNavVisible, String hashtag});
}

/// @nodoc
class _$StartScreenStateCopyWithImpl<$Res, $Val extends StartScreenState>
    implements $StartScreenStateCopyWith<$Res> {
  _$StartScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageIndex = null,
    Object? fabVisible = null,
    Object? gNavVisible = null,
    Object? hashtag = null,
  }) {
    return _then(_value.copyWith(
      pageIndex: null == pageIndex
          ? _value.pageIndex
          : pageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      fabVisible: null == fabVisible
          ? _value.fabVisible
          : fabVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      gNavVisible: null == gNavVisible
          ? _value.gNavVisible
          : gNavVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      hashtag: null == hashtag
          ? _value.hashtag
          : hashtag // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StartScreenStateCopyWith<$Res>
    implements $StartScreenStateCopyWith<$Res> {
  factory _$$_StartScreenStateCopyWith(
          _$_StartScreenState value, $Res Function(_$_StartScreenState) then) =
      __$$_StartScreenStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int pageIndex, bool fabVisible, bool gNavVisible, String hashtag});
}

/// @nodoc
class __$$_StartScreenStateCopyWithImpl<$Res>
    extends _$StartScreenStateCopyWithImpl<$Res, _$_StartScreenState>
    implements _$$_StartScreenStateCopyWith<$Res> {
  __$$_StartScreenStateCopyWithImpl(
      _$_StartScreenState _value, $Res Function(_$_StartScreenState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageIndex = null,
    Object? fabVisible = null,
    Object? gNavVisible = null,
    Object? hashtag = null,
  }) {
    return _then(_$_StartScreenState(
      pageIndex: null == pageIndex
          ? _value.pageIndex
          : pageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      fabVisible: null == fabVisible
          ? _value.fabVisible
          : fabVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      gNavVisible: null == gNavVisible
          ? _value.gNavVisible
          : gNavVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      hashtag: null == hashtag
          ? _value.hashtag
          : hashtag // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_StartScreenState implements _StartScreenState {
  const _$_StartScreenState(
      {required this.pageIndex,
      required this.fabVisible,
      required this.gNavVisible,
      required this.hashtag});

  @override
  final int pageIndex;
  @override
  final bool fabVisible;
  @override
  final bool gNavVisible;
  @override
  final String hashtag;

  @override
  String toString() {
    return 'StartScreenState(pageIndex: $pageIndex, fabVisible: $fabVisible, gNavVisible: $gNavVisible, hashtag: $hashtag)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StartScreenState &&
            (identical(other.pageIndex, pageIndex) ||
                other.pageIndex == pageIndex) &&
            (identical(other.fabVisible, fabVisible) ||
                other.fabVisible == fabVisible) &&
            (identical(other.gNavVisible, gNavVisible) ||
                other.gNavVisible == gNavVisible) &&
            (identical(other.hashtag, hashtag) || other.hashtag == hashtag));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, pageIndex, fabVisible, gNavVisible, hashtag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StartScreenStateCopyWith<_$_StartScreenState> get copyWith =>
      __$$_StartScreenStateCopyWithImpl<_$_StartScreenState>(this, _$identity);
}

abstract class _StartScreenState implements StartScreenState {
  const factory _StartScreenState(
      {required final int pageIndex,
      required final bool fabVisible,
      required final bool gNavVisible,
      required final String hashtag}) = _$_StartScreenState;

  @override
  int get pageIndex;
  @override
  bool get fabVisible;
  @override
  bool get gNavVisible;
  @override
  String get hashtag;
  @override
  @JsonKey(ignore: true)
  _$$_StartScreenStateCopyWith<_$_StartScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}
