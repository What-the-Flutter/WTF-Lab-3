// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_input_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MessageInputState {
  MessageModel get message => throw _privateConstructorUsedError;
  int get sendIcon => throw _privateConstructorUsedError;
  bool get isTagOpened => throw _privateConstructorUsedError;
  IMap<int, bool> get tagSelected => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MessageModel message, int sendIcon,
            bool isTagOpened, IMap<int, bool> tagSelected)
        defaultMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MessageModel message, int sendIcon, bool isTagOpened,
            IMap<int, bool> tagSelected)?
        defaultMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MessageModel message, int sendIcon, bool isTagOpened,
            IMap<int, bool> tagSelected)?
        defaultMode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageInputStateCopyWith<MessageInputState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageInputStateCopyWith<$Res> {
  factory $MessageInputStateCopyWith(
          MessageInputState value, $Res Function(MessageInputState) then) =
      _$MessageInputStateCopyWithImpl<$Res, MessageInputState>;
  @useResult
  $Res call(
      {MessageModel message,
      int sendIcon,
      bool isTagOpened,
      IMap<int, bool> tagSelected});

  $MessageModelCopyWith<$Res> get message;
}

/// @nodoc
class _$MessageInputStateCopyWithImpl<$Res, $Val extends MessageInputState>
    implements $MessageInputStateCopyWith<$Res> {
  _$MessageInputStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? sendIcon = null,
    Object? isTagOpened = null,
    Object? tagSelected = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageModel,
      sendIcon: null == sendIcon
          ? _value.sendIcon
          : sendIcon // ignore: cast_nullable_to_non_nullable
              as int,
      isTagOpened: null == isTagOpened
          ? _value.isTagOpened
          : isTagOpened // ignore: cast_nullable_to_non_nullable
              as bool,
      tagSelected: null == tagSelected
          ? _value.tagSelected
          : tagSelected // ignore: cast_nullable_to_non_nullable
              as IMap<int, bool>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageModelCopyWith<$Res> get message {
    return $MessageModelCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DefaultModeCopyWith<$Res>
    implements $MessageInputStateCopyWith<$Res> {
  factory _$$_DefaultModeCopyWith(
          _$_DefaultMode value, $Res Function(_$_DefaultMode) then) =
      __$$_DefaultModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MessageModel message,
      int sendIcon,
      bool isTagOpened,
      IMap<int, bool> tagSelected});

  @override
  $MessageModelCopyWith<$Res> get message;
}

/// @nodoc
class __$$_DefaultModeCopyWithImpl<$Res>
    extends _$MessageInputStateCopyWithImpl<$Res, _$_DefaultMode>
    implements _$$_DefaultModeCopyWith<$Res> {
  __$$_DefaultModeCopyWithImpl(
      _$_DefaultMode _value, $Res Function(_$_DefaultMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? sendIcon = null,
    Object? isTagOpened = null,
    Object? tagSelected = null,
  }) {
    return _then(_$_DefaultMode(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageModel,
      sendIcon: null == sendIcon
          ? _value.sendIcon
          : sendIcon // ignore: cast_nullable_to_non_nullable
              as int,
      isTagOpened: null == isTagOpened
          ? _value.isTagOpened
          : isTagOpened // ignore: cast_nullable_to_non_nullable
              as bool,
      tagSelected: null == tagSelected
          ? _value.tagSelected
          : tagSelected // ignore: cast_nullable_to_non_nullable
              as IMap<int, bool>,
    ));
  }
}

/// @nodoc

class _$_DefaultMode extends _DefaultMode {
  const _$_DefaultMode(
      {required this.message,
      required this.sendIcon,
      required this.isTagOpened,
      required this.tagSelected})
      : super._();

  @override
  final MessageModel message;
  @override
  final int sendIcon;
  @override
  final bool isTagOpened;
  @override
  final IMap<int, bool> tagSelected;

  @override
  String toString() {
    return 'MessageInputState.defaultMode(message: $message, sendIcon: $sendIcon, isTagOpened: $isTagOpened, tagSelected: $tagSelected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DefaultMode &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.sendIcon, sendIcon) ||
                other.sendIcon == sendIcon) &&
            (identical(other.isTagOpened, isTagOpened) ||
                other.isTagOpened == isTagOpened) &&
            (identical(other.tagSelected, tagSelected) ||
                other.tagSelected == tagSelected));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, sendIcon, isTagOpened, tagSelected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      __$$_DefaultModeCopyWithImpl<_$_DefaultMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MessageModel message, int sendIcon,
            bool isTagOpened, IMap<int, bool> tagSelected)
        defaultMode,
  }) {
    return defaultMode(message, sendIcon, isTagOpened, tagSelected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MessageModel message, int sendIcon, bool isTagOpened,
            IMap<int, bool> tagSelected)?
        defaultMode,
  }) {
    return defaultMode?.call(message, sendIcon, isTagOpened, tagSelected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MessageModel message, int sendIcon, bool isTagOpened,
            IMap<int, bool> tagSelected)?
        defaultMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(message, sendIcon, isTagOpened, tagSelected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
  }) {
    return defaultMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
  }) {
    return defaultMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(this);
    }
    return orElse();
  }
}

abstract class _DefaultMode extends MessageInputState {
  const factory _DefaultMode(
      {required final MessageModel message,
      required final int sendIcon,
      required final bool isTagOpened,
      required final IMap<int, bool> tagSelected}) = _$_DefaultMode;
  const _DefaultMode._() : super._();

  @override
  MessageModel get message;
  @override
  int get sendIcon;
  @override
  bool get isTagOpened;
  @override
  IMap<int, bool> get tagSelected;
  @override
  @JsonKey(ignore: true)
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      throw _privateConstructorUsedError;
}
