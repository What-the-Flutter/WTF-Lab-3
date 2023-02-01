// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_resend_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MessageResendState {
  IList<ChatModel> get chats => throw _privateConstructorUsedError;
  IMap<int, bool> get selectedChats => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageResendStateCopyWith<MessageResendState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageResendStateCopyWith<$Res> {
  factory $MessageResendStateCopyWith(
          MessageResendState value, $Res Function(MessageResendState) then) =
      _$MessageResendStateCopyWithImpl<$Res, MessageResendState>;
  @useResult
  $Res call({IList<ChatModel> chats, IMap<int, bool> selectedChats});
}

/// @nodoc
class _$MessageResendStateCopyWithImpl<$Res, $Val extends MessageResendState>
    implements $MessageResendStateCopyWith<$Res> {
  _$MessageResendStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
    Object? selectedChats = null,
  }) {
    return _then(_value.copyWith(
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<ChatModel>,
      selectedChats: null == selectedChats
          ? _value.selectedChats
          : selectedChats // ignore: cast_nullable_to_non_nullable
              as IMap<int, bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessageResendStateCopyWith<$Res>
    implements $MessageResendStateCopyWith<$Res> {
  factory _$$_MessageResendStateCopyWith(_$_MessageResendState value,
          $Res Function(_$_MessageResendState) then) =
      __$$_MessageResendStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<ChatModel> chats, IMap<int, bool> selectedChats});
}

/// @nodoc
class __$$_MessageResendStateCopyWithImpl<$Res>
    extends _$MessageResendStateCopyWithImpl<$Res, _$_MessageResendState>
    implements _$$_MessageResendStateCopyWith<$Res> {
  __$$_MessageResendStateCopyWithImpl(
      _$_MessageResendState _value, $Res Function(_$_MessageResendState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
    Object? selectedChats = null,
  }) {
    return _then(_$_MessageResendState(
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<ChatModel>,
      selectedChats: null == selectedChats
          ? _value.selectedChats
          : selectedChats // ignore: cast_nullable_to_non_nullable
              as IMap<int, bool>,
    ));
  }
}

/// @nodoc

class _$_MessageResendState implements _MessageResendState {
  const _$_MessageResendState(
      {required this.chats, required this.selectedChats});

  @override
  final IList<ChatModel> chats;
  @override
  final IMap<int, bool> selectedChats;

  @override
  String toString() {
    return 'MessageResendState(chats: $chats, selectedChats: $selectedChats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageResendState &&
            const DeepCollectionEquality().equals(other.chats, chats) &&
            (identical(other.selectedChats, selectedChats) ||
                other.selectedChats == selectedChats));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(chats), selectedChats);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageResendStateCopyWith<_$_MessageResendState> get copyWith =>
      __$$_MessageResendStateCopyWithImpl<_$_MessageResendState>(
          this, _$identity);
}

abstract class _MessageResendState implements MessageResendState {
  const factory _MessageResendState(
      {required final IList<ChatModel> chats,
      required final IMap<int, bool> selectedChats}) = _$_MessageResendState;

  @override
  IList<ChatModel> get chats;
  @override
  IMap<int, bool> get selectedChats;
  @override
  @JsonKey(ignore: true)
  _$$_MessageResendStateCopyWith<_$_MessageResendState> get copyWith =>
      throw _privateConstructorUsedError;
}
