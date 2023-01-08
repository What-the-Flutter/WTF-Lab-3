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
  dynamic get chats => throw _privateConstructorUsedError;
  int get amountOfMessages => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic chats, int amountOfMessages) initial,
    required TResult Function(
            dynamic chats, int amountOfMessages, int selectedChatId)
        selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic chats, int amountOfMessages)? initial,
    TResult? Function(dynamic chats, int amountOfMessages, int selectedChatId)?
        selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic chats, int amountOfMessages)? initial,
    TResult Function(dynamic chats, int amountOfMessages, int selectedChatId)?
        selected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Selected value) selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Selected value)? selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Selected value)? selected,
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
  $Res call({dynamic chats, int amountOfMessages});
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
    Object? chats = freezed,
    Object? amountOfMessages = null,
  }) {
    return _then(_value.copyWith(
      chats: freezed == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as dynamic,
      amountOfMessages: null == amountOfMessages
          ? _value.amountOfMessages
          : amountOfMessages // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $MoveMessagesStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic chats, int amountOfMessages});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$MoveMessagesStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = freezed,
    Object? amountOfMessages = null,
  }) {
    return _then(_$_Initial(
      chats: freezed == chats ? _value.chats! : chats,
      amountOfMessages: null == amountOfMessages
          ? _value.amountOfMessages
          : amountOfMessages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({required this.chats, required this.amountOfMessages});

  @override
  final dynamic chats;
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
            other is _$_Initial &&
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
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic chats, int amountOfMessages) initial,
    required TResult Function(
            dynamic chats, int amountOfMessages, int selectedChatId)
        selected,
  }) {
    return initial(chats, amountOfMessages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic chats, int amountOfMessages)? initial,
    TResult? Function(dynamic chats, int amountOfMessages, int selectedChatId)?
        selected,
  }) {
    return initial?.call(chats, amountOfMessages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic chats, int amountOfMessages)? initial,
    TResult Function(dynamic chats, int amountOfMessages, int selectedChatId)?
        selected,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Selected value) selected,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Selected value)? selected,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements MoveMessagesState {
  const factory _Initial(
      {required final dynamic chats,
      required final int amountOfMessages}) = _$_Initial;

  @override
  dynamic get chats;
  @override
  int get amountOfMessages;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SelectedCopyWith<$Res>
    implements $MoveMessagesStateCopyWith<$Res> {
  factory _$$_SelectedCopyWith(
          _$_Selected value, $Res Function(_$_Selected) then) =
      __$$_SelectedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic chats, int amountOfMessages, int selectedChatId});
}

/// @nodoc
class __$$_SelectedCopyWithImpl<$Res>
    extends _$MoveMessagesStateCopyWithImpl<$Res, _$_Selected>
    implements _$$_SelectedCopyWith<$Res> {
  __$$_SelectedCopyWithImpl(
      _$_Selected _value, $Res Function(_$_Selected) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = freezed,
    Object? amountOfMessages = null,
    Object? selectedChatId = null,
  }) {
    return _then(_$_Selected(
      chats: freezed == chats ? _value.chats! : chats,
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

class _$_Selected implements _Selected {
  const _$_Selected(
      {required this.chats,
      required this.amountOfMessages,
      required this.selectedChatId});

  @override
  final dynamic chats;
  @override
  final int amountOfMessages;
  @override
  final int selectedChatId;

  @override
  String toString() {
    return 'MoveMessagesState.selected(chats: $chats, amountOfMessages: $amountOfMessages, selectedChatId: $selectedChatId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Selected &&
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
  _$$_SelectedCopyWith<_$_Selected> get copyWith =>
      __$$_SelectedCopyWithImpl<_$_Selected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic chats, int amountOfMessages) initial,
    required TResult Function(
            dynamic chats, int amountOfMessages, int selectedChatId)
        selected,
  }) {
    return selected(chats, amountOfMessages, selectedChatId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic chats, int amountOfMessages)? initial,
    TResult? Function(dynamic chats, int amountOfMessages, int selectedChatId)?
        selected,
  }) {
    return selected?.call(chats, amountOfMessages, selectedChatId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic chats, int amountOfMessages)? initial,
    TResult Function(dynamic chats, int amountOfMessages, int selectedChatId)?
        selected,
    required TResult orElse(),
  }) {
    if (selected != null) {
      return selected(chats, amountOfMessages, selectedChatId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Selected value) selected,
  }) {
    return selected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Selected value)? selected,
  }) {
    return selected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) {
    if (selected != null) {
      return selected(this);
    }
    return orElse();
  }
}

abstract class _Selected implements MoveMessagesState {
  const factory _Selected(
      {required final dynamic chats,
      required final int amountOfMessages,
      required final int selectedChatId}) = _$_Selected;

  @override
  dynamic get chats;
  @override
  int get amountOfMessages;
  int get selectedChatId;
  @override
  @JsonKey(ignore: true)
  _$$_SelectedCopyWith<_$_Selected> get copyWith =>
      throw _privateConstructorUsedError;
}
