// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatter_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatterState {
  IList<ChatModel> get chats => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatterStateCopyWith<ChatterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatterStateCopyWith<$Res> {
  factory $ChatterStateCopyWith(
          ChatterState value, $Res Function(ChatterState) then) =
      _$ChatterStateCopyWithImpl<$Res, ChatterState>;
  @useResult
  $Res call({IList<ChatModel> chats});
}

/// @nodoc
class _$ChatterStateCopyWithImpl<$Res, $Val extends ChatterState>
    implements $ChatterStateCopyWith<$Res> {
  _$ChatterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
  }) {
    return _then(_value.copyWith(
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<ChatModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatterStateCopyWith<$Res>
    implements $ChatterStateCopyWith<$Res> {
  factory _$$_ChatterStateCopyWith(
          _$_ChatterState value, $Res Function(_$_ChatterState) then) =
      __$$_ChatterStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<ChatModel> chats});
}

/// @nodoc
class __$$_ChatterStateCopyWithImpl<$Res>
    extends _$ChatterStateCopyWithImpl<$Res, _$_ChatterState>
    implements _$$_ChatterStateCopyWith<$Res> {
  __$$_ChatterStateCopyWithImpl(
      _$_ChatterState _value, $Res Function(_$_ChatterState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
  }) {
    return _then(_$_ChatterState(
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<ChatModel>,
    ));
  }
}

/// @nodoc

class _$_ChatterState implements _ChatterState {
  const _$_ChatterState({required this.chats});

  @override
  final IList<ChatModel> chats;

  @override
  String toString() {
    return 'ChatterState(chats: $chats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatterState &&
            const DeepCollectionEquality().equals(other.chats, chats));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(chats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatterStateCopyWith<_$_ChatterState> get copyWith =>
      __$$_ChatterStateCopyWithImpl<_$_ChatterState>(this, _$identity);
}

abstract class _ChatterState implements ChatterState {
  const factory _ChatterState({required final IList<ChatModel> chats}) =
      _$_ChatterState;

  @override
  IList<ChatModel> get chats;
  @override
  @JsonKey(ignore: true)
  _$$_ChatterStateCopyWith<_$_ChatterState> get copyWith =>
      throw _privateConstructorUsedError;
}
