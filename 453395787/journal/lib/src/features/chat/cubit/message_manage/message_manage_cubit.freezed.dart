// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_manage_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MessageManageState {
  String get name => throw _privateConstructorUsedError;
  IList<Message> get messages => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, IList<Message> messages) defaultMode,
    required TResult Function(
            String name, IList<Message> messages, ISet<int> selected)
        selectionMode,
    required TResult Function(
            String name, IList<Message> messages, Message message)
        editMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, IList<Message> messages)? defaultMode,
    TResult? Function(String name, IList<Message> messages, ISet<int> selected)?
        selectionMode,
    TResult? Function(String name, IList<Message> messages, Message message)?
        editMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, IList<Message> messages)? defaultMode,
    TResult Function(String name, IList<Message> messages, ISet<int> selected)?
        selectionMode,
    TResult Function(String name, IList<Message> messages, Message message)?
        editMode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageManageDefaultMode value) defaultMode,
    required TResult Function(MessageManageSelectionMode value) selectionMode,
    required TResult Function(MessageManageEditMode value) editMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessageManageDefaultMode value)? defaultMode,
    TResult? Function(MessageManageSelectionMode value)? selectionMode,
    TResult? Function(MessageManageEditMode value)? editMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageManageDefaultMode value)? defaultMode,
    TResult Function(MessageManageSelectionMode value)? selectionMode,
    TResult Function(MessageManageEditMode value)? editMode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageManageStateCopyWith<MessageManageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageManageStateCopyWith<$Res> {
  factory $MessageManageStateCopyWith(
          MessageManageState value, $Res Function(MessageManageState) then) =
      _$MessageManageStateCopyWithImpl<$Res, MessageManageState>;
  @useResult
  $Res call({String name, IList<Message> messages});
}

/// @nodoc
class _$MessageManageStateCopyWithImpl<$Res, $Val extends MessageManageState>
    implements $MessageManageStateCopyWith<$Res> {
  _$MessageManageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<Message>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageManageDefaultModeCopyWith<$Res>
    implements $MessageManageStateCopyWith<$Res> {
  factory _$$MessageManageDefaultModeCopyWith(_$MessageManageDefaultMode value,
          $Res Function(_$MessageManageDefaultMode) then) =
      __$$MessageManageDefaultModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, IList<Message> messages});
}

/// @nodoc
class __$$MessageManageDefaultModeCopyWithImpl<$Res>
    extends _$MessageManageStateCopyWithImpl<$Res, _$MessageManageDefaultMode>
    implements _$$MessageManageDefaultModeCopyWith<$Res> {
  __$$MessageManageDefaultModeCopyWithImpl(_$MessageManageDefaultMode _value,
      $Res Function(_$MessageManageDefaultMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? messages = null,
  }) {
    return _then(_$MessageManageDefaultMode(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<Message>,
    ));
  }
}

/// @nodoc

class _$MessageManageDefaultMode extends MessageManageDefaultMode {
  const _$MessageManageDefaultMode({required this.name, required this.messages})
      : super._();

  @override
  final String name;
  @override
  final IList<Message> messages;

  @override
  String toString() {
    return 'MessageManageState.defaultMode(name: $name, messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageManageDefaultMode &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.messages, messages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageManageDefaultModeCopyWith<_$MessageManageDefaultMode>
      get copyWith =>
          __$$MessageManageDefaultModeCopyWithImpl<_$MessageManageDefaultMode>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, IList<Message> messages) defaultMode,
    required TResult Function(
            String name, IList<Message> messages, ISet<int> selected)
        selectionMode,
    required TResult Function(
            String name, IList<Message> messages, Message message)
        editMode,
  }) {
    return defaultMode(name, messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, IList<Message> messages)? defaultMode,
    TResult? Function(String name, IList<Message> messages, ISet<int> selected)?
        selectionMode,
    TResult? Function(String name, IList<Message> messages, Message message)?
        editMode,
  }) {
    return defaultMode?.call(name, messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, IList<Message> messages)? defaultMode,
    TResult Function(String name, IList<Message> messages, ISet<int> selected)?
        selectionMode,
    TResult Function(String name, IList<Message> messages, Message message)?
        editMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(name, messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageManageDefaultMode value) defaultMode,
    required TResult Function(MessageManageSelectionMode value) selectionMode,
    required TResult Function(MessageManageEditMode value) editMode,
  }) {
    return defaultMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessageManageDefaultMode value)? defaultMode,
    TResult? Function(MessageManageSelectionMode value)? selectionMode,
    TResult? Function(MessageManageEditMode value)? editMode,
  }) {
    return defaultMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageManageDefaultMode value)? defaultMode,
    TResult Function(MessageManageSelectionMode value)? selectionMode,
    TResult Function(MessageManageEditMode value)? editMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(this);
    }
    return orElse();
  }
}

abstract class MessageManageDefaultMode extends MessageManageState {
  const factory MessageManageDefaultMode(
      {required final String name,
      required final IList<Message> messages}) = _$MessageManageDefaultMode;
  const MessageManageDefaultMode._() : super._();

  @override
  String get name;
  @override
  IList<Message> get messages;
  @override
  @JsonKey(ignore: true)
  _$$MessageManageDefaultModeCopyWith<_$MessageManageDefaultMode>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessageManageSelectionModeCopyWith<$Res>
    implements $MessageManageStateCopyWith<$Res> {
  factory _$$MessageManageSelectionModeCopyWith(
          _$MessageManageSelectionMode value,
          $Res Function(_$MessageManageSelectionMode) then) =
      __$$MessageManageSelectionModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, IList<Message> messages, ISet<int> selected});
}

/// @nodoc
class __$$MessageManageSelectionModeCopyWithImpl<$Res>
    extends _$MessageManageStateCopyWithImpl<$Res, _$MessageManageSelectionMode>
    implements _$$MessageManageSelectionModeCopyWith<$Res> {
  __$$MessageManageSelectionModeCopyWithImpl(
      _$MessageManageSelectionMode _value,
      $Res Function(_$MessageManageSelectionMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? messages = null,
    Object? selected = null,
  }) {
    return _then(_$MessageManageSelectionMode(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<Message>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as ISet<int>,
    ));
  }
}

/// @nodoc

class _$MessageManageSelectionMode extends MessageManageSelectionMode {
  const _$MessageManageSelectionMode(
      {required this.name, required this.messages, required this.selected})
      : super._();

  @override
  final String name;
  @override
  final IList<Message> messages;
  @override
  final ISet<int> selected;

  @override
  String toString() {
    return 'MessageManageState.selectionMode(name: $name, messages: $messages, selected: $selected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageManageSelectionMode &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            const DeepCollectionEquality().equals(other.selected, selected));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(messages),
      const DeepCollectionEquality().hash(selected));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageManageSelectionModeCopyWith<_$MessageManageSelectionMode>
      get copyWith => __$$MessageManageSelectionModeCopyWithImpl<
          _$MessageManageSelectionMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, IList<Message> messages) defaultMode,
    required TResult Function(
            String name, IList<Message> messages, ISet<int> selected)
        selectionMode,
    required TResult Function(
            String name, IList<Message> messages, Message message)
        editMode,
  }) {
    return selectionMode(name, messages, selected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, IList<Message> messages)? defaultMode,
    TResult? Function(String name, IList<Message> messages, ISet<int> selected)?
        selectionMode,
    TResult? Function(String name, IList<Message> messages, Message message)?
        editMode,
  }) {
    return selectionMode?.call(name, messages, selected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, IList<Message> messages)? defaultMode,
    TResult Function(String name, IList<Message> messages, ISet<int> selected)?
        selectionMode,
    TResult Function(String name, IList<Message> messages, Message message)?
        editMode,
    required TResult orElse(),
  }) {
    if (selectionMode != null) {
      return selectionMode(name, messages, selected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageManageDefaultMode value) defaultMode,
    required TResult Function(MessageManageSelectionMode value) selectionMode,
    required TResult Function(MessageManageEditMode value) editMode,
  }) {
    return selectionMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessageManageDefaultMode value)? defaultMode,
    TResult? Function(MessageManageSelectionMode value)? selectionMode,
    TResult? Function(MessageManageEditMode value)? editMode,
  }) {
    return selectionMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageManageDefaultMode value)? defaultMode,
    TResult Function(MessageManageSelectionMode value)? selectionMode,
    TResult Function(MessageManageEditMode value)? editMode,
    required TResult orElse(),
  }) {
    if (selectionMode != null) {
      return selectionMode(this);
    }
    return orElse();
  }
}

abstract class MessageManageSelectionMode extends MessageManageState {
  const factory MessageManageSelectionMode(
      {required final String name,
      required final IList<Message> messages,
      required final ISet<int> selected}) = _$MessageManageSelectionMode;
  const MessageManageSelectionMode._() : super._();

  @override
  String get name;
  @override
  IList<Message> get messages;
  ISet<int> get selected;
  @override
  @JsonKey(ignore: true)
  _$$MessageManageSelectionModeCopyWith<_$MessageManageSelectionMode>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessageManageEditModeCopyWith<$Res>
    implements $MessageManageStateCopyWith<$Res> {
  factory _$$MessageManageEditModeCopyWith(_$MessageManageEditMode value,
          $Res Function(_$MessageManageEditMode) then) =
      __$$MessageManageEditModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, IList<Message> messages, Message message});

  $MessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$MessageManageEditModeCopyWithImpl<$Res>
    extends _$MessageManageStateCopyWithImpl<$Res, _$MessageManageEditMode>
    implements _$$MessageManageEditModeCopyWith<$Res> {
  __$$MessageManageEditModeCopyWithImpl(_$MessageManageEditMode _value,
      $Res Function(_$MessageManageEditMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? messages = null,
    Object? message = null,
  }) {
    return _then(_$MessageManageEditMode(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<Message>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res> get message {
    return $MessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc

class _$MessageManageEditMode extends MessageManageEditMode {
  const _$MessageManageEditMode(
      {required this.name, required this.messages, required this.message})
      : super._();

  @override
  final String name;
  @override
  final IList<Message> messages;
  @override
  final Message message;

  @override
  String toString() {
    return 'MessageManageState.editMode(name: $name, messages: $messages, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageManageEditMode &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name,
      const DeepCollectionEquality().hash(messages), message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageManageEditModeCopyWith<_$MessageManageEditMode> get copyWith =>
      __$$MessageManageEditModeCopyWithImpl<_$MessageManageEditMode>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, IList<Message> messages) defaultMode,
    required TResult Function(
            String name, IList<Message> messages, ISet<int> selected)
        selectionMode,
    required TResult Function(
            String name, IList<Message> messages, Message message)
        editMode,
  }) {
    return editMode(name, messages, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, IList<Message> messages)? defaultMode,
    TResult? Function(String name, IList<Message> messages, ISet<int> selected)?
        selectionMode,
    TResult? Function(String name, IList<Message> messages, Message message)?
        editMode,
  }) {
    return editMode?.call(name, messages, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, IList<Message> messages)? defaultMode,
    TResult Function(String name, IList<Message> messages, ISet<int> selected)?
        selectionMode,
    TResult Function(String name, IList<Message> messages, Message message)?
        editMode,
    required TResult orElse(),
  }) {
    if (editMode != null) {
      return editMode(name, messages, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageManageDefaultMode value) defaultMode,
    required TResult Function(MessageManageSelectionMode value) selectionMode,
    required TResult Function(MessageManageEditMode value) editMode,
  }) {
    return editMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessageManageDefaultMode value)? defaultMode,
    TResult? Function(MessageManageSelectionMode value)? selectionMode,
    TResult? Function(MessageManageEditMode value)? editMode,
  }) {
    return editMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageManageDefaultMode value)? defaultMode,
    TResult Function(MessageManageSelectionMode value)? selectionMode,
    TResult Function(MessageManageEditMode value)? editMode,
    required TResult orElse(),
  }) {
    if (editMode != null) {
      return editMode(this);
    }
    return orElse();
  }
}

abstract class MessageManageEditMode extends MessageManageState {
  const factory MessageManageEditMode(
      {required final String name,
      required final IList<Message> messages,
      required final Message message}) = _$MessageManageEditMode;
  const MessageManageEditMode._() : super._();

  @override
  String get name;
  @override
  IList<Message> get messages;
  Message get message;
  @override
  @JsonKey(ignore: true)
  _$$MessageManageEditModeCopyWith<_$MessageManageEditMode> get copyWith =>
      throw _privateConstructorUsedError;
}
