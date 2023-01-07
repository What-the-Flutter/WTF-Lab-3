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
  Message get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Message message) defaultMode,
    required TResult Function(Message message) editMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Message message)? defaultMode,
    TResult? Function(Message message)? editMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Message message)? defaultMode,
    TResult Function(Message message)? editMode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_EditMode value) editMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_EditMode value)? editMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_EditMode value)? editMode,
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
  $Res call({Message message});

  $MessageCopyWith<$Res> get message;
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
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res> get message {
    return $MessageCopyWith<$Res>(_value.message, (value) {
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
  $Res call({Message message});

  @override
  $MessageCopyWith<$Res> get message;
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
  }) {
    return _then(_$_DefaultMode(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message,
    ));
  }
}

/// @nodoc

class _$_DefaultMode extends _DefaultMode {
  const _$_DefaultMode({required this.message}) : super._();

  @override
  final Message message;

  @override
  String toString() {
    return 'MessageInputState.defaultMode(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DefaultMode &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      __$$_DefaultModeCopyWithImpl<_$_DefaultMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Message message) defaultMode,
    required TResult Function(Message message) editMode,
  }) {
    return defaultMode(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Message message)? defaultMode,
    TResult? Function(Message message)? editMode,
  }) {
    return defaultMode?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Message message)? defaultMode,
    TResult Function(Message message)? editMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_EditMode value) editMode,
  }) {
    return defaultMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_EditMode value)? editMode,
  }) {
    return defaultMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_EditMode value)? editMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(this);
    }
    return orElse();
  }
}

abstract class _DefaultMode extends MessageInputState {
  const factory _DefaultMode({required final Message message}) = _$_DefaultMode;
  const _DefaultMode._() : super._();

  @override
  Message get message;
  @override
  @JsonKey(ignore: true)
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_EditModeCopyWith<$Res>
    implements $MessageInputStateCopyWith<$Res> {
  factory _$$_EditModeCopyWith(
          _$_EditMode value, $Res Function(_$_EditMode) then) =
      __$$_EditModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Message message});

  @override
  $MessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$_EditModeCopyWithImpl<$Res>
    extends _$MessageInputStateCopyWithImpl<$Res, _$_EditMode>
    implements _$$_EditModeCopyWith<$Res> {
  __$$_EditModeCopyWithImpl(
      _$_EditMode _value, $Res Function(_$_EditMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_EditMode(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message,
    ));
  }
}

/// @nodoc

class _$_EditMode extends _EditMode {
  const _$_EditMode({required this.message}) : super._();

  @override
  final Message message;

  @override
  String toString() {
    return 'MessageInputState.editMode(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditMode &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditModeCopyWith<_$_EditMode> get copyWith =>
      __$$_EditModeCopyWithImpl<_$_EditMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Message message) defaultMode,
    required TResult Function(Message message) editMode,
  }) {
    return editMode(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Message message)? defaultMode,
    TResult? Function(Message message)? editMode,
  }) {
    return editMode?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Message message)? defaultMode,
    TResult Function(Message message)? editMode,
    required TResult orElse(),
  }) {
    if (editMode != null) {
      return editMode(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_EditMode value) editMode,
  }) {
    return editMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_EditMode value)? editMode,
  }) {
    return editMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_EditMode value)? editMode,
    required TResult orElse(),
  }) {
    if (editMode != null) {
      return editMode(this);
    }
    return orElse();
  }
}

abstract class _EditMode extends MessageInputState {
  const factory _EditMode({required final Message message}) = _$_EditMode;
  const _EditMode._() : super._();

  @override
  Message get message;
  @override
  @JsonKey(ignore: true)
  _$$_EditModeCopyWith<_$_EditMode> get copyWith =>
      throw _privateConstructorUsedError;
}
