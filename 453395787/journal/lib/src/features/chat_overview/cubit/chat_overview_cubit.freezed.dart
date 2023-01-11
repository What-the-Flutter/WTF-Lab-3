// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_overview_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatOverviewState {
  IList<Chat> get chats => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatOverviewStateCopyWith<ChatOverviewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatOverviewStateCopyWith<$Res> {
  factory $ChatOverviewStateCopyWith(
          ChatOverviewState value, $Res Function(ChatOverviewState) then) =
      _$ChatOverviewStateCopyWithImpl<$Res, ChatOverviewState>;
  @useResult
  $Res call({IList<Chat> chats});
}

/// @nodoc
class _$ChatOverviewStateCopyWithImpl<$Res, $Val extends ChatOverviewState>
    implements $ChatOverviewStateCopyWith<$Res> {
  _$ChatOverviewStateCopyWithImpl(this._value, this._then);

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
              as IList<Chat>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatOverviewStateCopyWith<$Res>
    implements $ChatOverviewStateCopyWith<$Res> {
  factory _$$_ChatOverviewStateCopyWith(_$_ChatOverviewState value,
          $Res Function(_$_ChatOverviewState) then) =
      __$$_ChatOverviewStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<Chat> chats});
}

/// @nodoc
class __$$_ChatOverviewStateCopyWithImpl<$Res>
    extends _$ChatOverviewStateCopyWithImpl<$Res, _$_ChatOverviewState>
    implements _$$_ChatOverviewStateCopyWith<$Res> {
  __$$_ChatOverviewStateCopyWithImpl(
      _$_ChatOverviewState _value, $Res Function(_$_ChatOverviewState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
  }) {
    return _then(_$_ChatOverviewState(
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<Chat>,
    ));
  }
}

/// @nodoc

class _$_ChatOverviewState implements _ChatOverviewState {
  const _$_ChatOverviewState({required this.chats});

  @override
  final IList<Chat> chats;

  @override
  String toString() {
    return 'ChatOverviewState(chats: $chats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatOverviewState &&
            const DeepCollectionEquality().equals(other.chats, chats));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(chats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatOverviewStateCopyWith<_$_ChatOverviewState> get copyWith =>
      __$$_ChatOverviewStateCopyWithImpl<_$_ChatOverviewState>(
          this, _$identity);
}

abstract class _ChatOverviewState implements ChatOverviewState {
  const factory _ChatOverviewState({required final IList<Chat> chats}) =
      _$_ChatOverviewState;

  @override
  IList<Chat> get chats;
  @override
  @JsonKey(ignore: true)
  _$$_ChatOverviewStateCopyWith<_$_ChatOverviewState> get copyWith =>
      throw _privateConstructorUsedError;
}
