// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'move_messages_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MoveMessagesState {
  IList<Chat> get chats => throw _privateConstructorUsedError;
  int get amountOfMessages => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<Chat> chats, int amountOfMessages) initial,
    required TResult Function(
            IList<Chat> chats, int amountOfMessages, int selectedChatId)
        withSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<Chat> chats, int amountOfMessages)? initial,
    TResult? Function(
            IList<Chat> chats, int amountOfMessages, int selectedChatId)?
        withSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<Chat> chats, int amountOfMessages)? initial,
    TResult Function(
            IList<Chat> chats, int amountOfMessages, int selectedChatId)?
        withSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_WithSelectedState value) withSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialState value)? initial,
    TResult? Function(_WithSelectedState value)? withSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_WithSelectedState value)? withSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MoveMessagesStateCopyWith<MoveMessagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoveMessagesStateCopyWith<$Res> {
  factory $MoveMessagesStateCopyWith(
          MoveMessagesState value, $Res Function(MoveMessagesState) then) =
      _$MoveMessagesStateCopyWithImpl<$Res, MoveMessagesState>;
  @useResult
  $Res call({IList<Chat> chats, int amountOfMessages});
}

/// @nodoc
class _$MoveMessagesStateCopyWithImpl<$Res, $Val extends MoveMessagesState>
    implements $MoveMessagesStateCopyWith<$Res> {
  _$MoveMessagesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
    Object? amountOfMessages = null,
  }) {
    return _then(_value.copyWith(
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<Chat>,
      amountOfMessages: null == amountOfMessages
          ? _value.amountOfMessages
          : amountOfMessages // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialStateCopyWith<$Res>
    implements $MoveMessagesStateCopyWith<$Res> {
  factory _$$_InitialStateCopyWith(
          _$_InitialState value, $Res Function(_$_InitialState) then) =
      __$$_InitialStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<Chat> chats, int amountOfMessages});
}

/// @nodoc
class __$$_InitialStateCopyWithImpl<$Res>
    extends _$MoveMessagesStateCopyWithImpl<$Res, _$_InitialState>
    implements _$$_InitialStateCopyWith<$Res> {
  __$$_InitialStateCopyWithImpl(
      _$_InitialState _value, $Res Function(_$_InitialState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
    Object? amountOfMessages = null,
  }) {
    return _then(_$_InitialState(
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<Chat>,
      amountOfMessages: null == amountOfMessages
          ? _value.amountOfMessages
          : amountOfMessages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_InitialState implements _InitialState {
  const _$_InitialState({required this.chats, required this.amountOfMessages});

  @override
  final IList<Chat> chats;
  @override
  final int amountOfMessages;

  @override
  String toString() {
    return 'MoveMessagesState.initial(chats: $chats, amountOfMessages: $amountOfMessages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InitialState &&
            const DeepCollectionEquality().equals(other.chats, chats) &&
            (identical(other.amountOfMessages, amountOfMessages) ||
                other.amountOfMessages == amountOfMessages));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(chats), amountOfMessages);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialStateCopyWith<_$_InitialState> get copyWith =>
      __$$_InitialStateCopyWithImpl<_$_InitialState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<Chat> chats, int amountOfMessages) initial,
    required TResult Function(
            IList<Chat> chats, int amountOfMessages, int selectedChatId)
        withSelected,
  }) {
    return initial(chats, amountOfMessages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<Chat> chats, int amountOfMessages)? initial,
    TResult? Function(
            IList<Chat> chats, int amountOfMessages, int selectedChatId)?
        withSelected,
  }) {
    return initial?.call(chats, amountOfMessages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<Chat> chats, int amountOfMessages)? initial,
    TResult Function(
            IList<Chat> chats, int amountOfMessages, int selectedChatId)?
        withSelected,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(chats, amountOfMessages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_WithSelectedState value) withSelected,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialState value)? initial,
    TResult? Function(_WithSelectedState value)? withSelected,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_WithSelectedState value)? withSelected,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialState implements MoveMessagesState {
  const factory _InitialState(
      {required final IList<Chat> chats,
      required final int amountOfMessages}) = _$_InitialState;

  @override
  IList<Chat> get chats;
  @override
  int get amountOfMessages;
  @override
  @JsonKey(ignore: true)
  _$$_InitialStateCopyWith<_$_InitialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_WithSelectedStateCopyWith<$Res>
    implements $MoveMessagesStateCopyWith<$Res> {
  factory _$$_WithSelectedStateCopyWith(_$_WithSelectedState value,
          $Res Function(_$_WithSelectedState) then) =
      __$$_WithSelectedStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<Chat> chats, int amountOfMessages, int selectedChatId});
}

/// @nodoc
class __$$_WithSelectedStateCopyWithImpl<$Res>
    extends _$MoveMessagesStateCopyWithImpl<$Res, _$_WithSelectedState>
    implements _$$_WithSelectedStateCopyWith<$Res> {
  __$$_WithSelectedStateCopyWithImpl(
      _$_WithSelectedState _value, $Res Function(_$_WithSelectedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
    Object? amountOfMessages = null,
    Object? selectedChatId = null,
  }) {
    return _then(_$_WithSelectedState(
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as IList<Chat>,
      amountOfMessages: null == amountOfMessages
          ? _value.amountOfMessages
          : amountOfMessages // ignore: cast_nullable_to_non_nullable
              as int,
      selectedChatId: null == selectedChatId
          ? _value.selectedChatId
          : selectedChatId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_WithSelectedState implements _WithSelectedState {
  const _$_WithSelectedState(
      {required this.chats,
      required this.amountOfMessages,
      required this.selectedChatId});

  @override
  final IList<Chat> chats;
  @override
  final int amountOfMessages;
  @override
  final int selectedChatId;

  @override
  String toString() {
    return 'MoveMessagesState.withSelected(chats: $chats, amountOfMessages: $amountOfMessages, selectedChatId: $selectedChatId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WithSelectedState &&
            const DeepCollectionEquality().equals(other.chats, chats) &&
            (identical(other.amountOfMessages, amountOfMessages) ||
                other.amountOfMessages == amountOfMessages) &&
            (identical(other.selectedChatId, selectedChatId) ||
                other.selectedChatId == selectedChatId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(chats),
      amountOfMessages,
      selectedChatId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WithSelectedStateCopyWith<_$_WithSelectedState> get copyWith =>
      __$$_WithSelectedStateCopyWithImpl<_$_WithSelectedState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IList<Chat> chats, int amountOfMessages) initial,
    required TResult Function(
            IList<Chat> chats, int amountOfMessages, int selectedChatId)
        withSelected,
  }) {
    return withSelected(chats, amountOfMessages, selectedChatId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IList<Chat> chats, int amountOfMessages)? initial,
    TResult? Function(
            IList<Chat> chats, int amountOfMessages, int selectedChatId)?
        withSelected,
  }) {
    return withSelected?.call(chats, amountOfMessages, selectedChatId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IList<Chat> chats, int amountOfMessages)? initial,
    TResult Function(
            IList<Chat> chats, int amountOfMessages, int selectedChatId)?
        withSelected,
    required TResult orElse(),
  }) {
    if (withSelected != null) {
      return withSelected(chats, amountOfMessages, selectedChatId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_WithSelectedState value) withSelected,
  }) {
    return withSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialState value)? initial,
    TResult? Function(_WithSelectedState value)? withSelected,
  }) {
    return withSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_WithSelectedState value)? withSelected,
    required TResult orElse(),
  }) {
    if (withSelected != null) {
      return withSelected(this);
    }
    return orElse();
  }
}

abstract class _WithSelectedState implements MoveMessagesState {
  const factory _WithSelectedState(
      {required final IList<Chat> chats,
      required final int amountOfMessages,
      required final int selectedChatId}) = _$_WithSelectedState;

  @override
  IList<Chat> get chats;
  @override
  int get amountOfMessages;
  int get selectedChatId;
  @override
  @JsonKey(ignore: true)
  _$$_WithSelectedStateCopyWith<_$_WithSelectedState> get copyWith =>
      throw _privateConstructorUsedError;
}
