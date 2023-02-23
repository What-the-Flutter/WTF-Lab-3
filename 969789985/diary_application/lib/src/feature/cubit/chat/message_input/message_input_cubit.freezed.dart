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
  IList<TagModel> get tags => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            MessageModel message, IList<TagModel> tags, bool canSend)
        defaultMode,
    required TResult Function(MessageModel message, IList<TagModel> tags,
            IMap<String, bool> selectedTags, bool removingMode)
        tagMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MessageModel message, IList<TagModel> tags, bool canSend)?
        defaultMode,
    TResult? Function(MessageModel message, IList<TagModel> tags,
            IMap<String, bool> selectedTags, bool removingMode)?
        tagMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MessageModel message, IList<TagModel> tags, bool canSend)?
        defaultMode,
    TResult Function(MessageModel message, IList<TagModel> tags,
            IMap<String, bool> selectedTags, bool removingMode)?
        tagMode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_TagMode value) tagMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_TagMode value)? tagMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_TagMode value)? tagMode,
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
  $Res call({MessageModel message, IList<TagModel> tags});

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
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageModel,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as IList<TagModel>,
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
  $Res call({MessageModel message, IList<TagModel> tags, bool canSend});

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
    Object? tags = null,
    Object? canSend = null,
  }) {
    return _then(_$_DefaultMode(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageModel,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as IList<TagModel>,
      canSend: null == canSend
          ? _value.canSend
          : canSend // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DefaultMode extends _DefaultMode {
  const _$_DefaultMode(
      {required this.message, required this.tags, required this.canSend})
      : super._();

  @override
  final MessageModel message;
  @override
  final IList<TagModel> tags;
  @override
  final bool canSend;

  @override
  String toString() {
    return 'MessageInputState.defaultMode(message: $message, tags: $tags, canSend: $canSend)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DefaultMode &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.canSend, canSend) || other.canSend == canSend));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(tags), canSend);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      __$$_DefaultModeCopyWithImpl<_$_DefaultMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            MessageModel message, IList<TagModel> tags, bool canSend)
        defaultMode,
    required TResult Function(MessageModel message, IList<TagModel> tags,
            IMap<String, bool> selectedTags, bool removingMode)
        tagMode,
  }) {
    return defaultMode(message, tags, canSend);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MessageModel message, IList<TagModel> tags, bool canSend)?
        defaultMode,
    TResult? Function(MessageModel message, IList<TagModel> tags,
            IMap<String, bool> selectedTags, bool removingMode)?
        tagMode,
  }) {
    return defaultMode?.call(message, tags, canSend);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MessageModel message, IList<TagModel> tags, bool canSend)?
        defaultMode,
    TResult Function(MessageModel message, IList<TagModel> tags,
            IMap<String, bool> selectedTags, bool removingMode)?
        tagMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(message, tags, canSend);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_TagMode value) tagMode,
  }) {
    return defaultMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_TagMode value)? tagMode,
  }) {
    return defaultMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_TagMode value)? tagMode,
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
      required final IList<TagModel> tags,
      required final bool canSend}) = _$_DefaultMode;
  const _DefaultMode._() : super._();

  @override
  MessageModel get message;
  @override
  IList<TagModel> get tags;
  bool get canSend;
  @override
  @JsonKey(ignore: true)
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TagModeCopyWith<$Res>
    implements $MessageInputStateCopyWith<$Res> {
  factory _$$_TagModeCopyWith(
          _$_TagMode value, $Res Function(_$_TagMode) then) =
      __$$_TagModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MessageModel message,
      IList<TagModel> tags,
      IMap<String, bool> selectedTags,
      bool removingMode});

  @override
  $MessageModelCopyWith<$Res> get message;
}

/// @nodoc
class __$$_TagModeCopyWithImpl<$Res>
    extends _$MessageInputStateCopyWithImpl<$Res, _$_TagMode>
    implements _$$_TagModeCopyWith<$Res> {
  __$$_TagModeCopyWithImpl(_$_TagMode _value, $Res Function(_$_TagMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? tags = null,
    Object? selectedTags = null,
    Object? removingMode = null,
  }) {
    return _then(_$_TagMode(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageModel,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as IList<TagModel>,
      selectedTags: null == selectedTags
          ? _value.selectedTags
          : selectedTags // ignore: cast_nullable_to_non_nullable
              as IMap<String, bool>,
      removingMode: null == removingMode
          ? _value.removingMode
          : removingMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TagMode extends _TagMode {
  const _$_TagMode(
      {required this.message,
      required this.tags,
      required this.selectedTags,
      required this.removingMode})
      : super._();

  @override
  final MessageModel message;
  @override
  final IList<TagModel> tags;
  @override
  final IMap<String, bool> selectedTags;
  @override
  final bool removingMode;

  @override
  String toString() {
    return 'MessageInputState.tagMode(message: $message, tags: $tags, selectedTags: $selectedTags, removingMode: $removingMode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TagMode &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.selectedTags, selectedTags) ||
                other.selectedTags == selectedTags) &&
            (identical(other.removingMode, removingMode) ||
                other.removingMode == removingMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message,
      const DeepCollectionEquality().hash(tags), selectedTags, removingMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TagModeCopyWith<_$_TagMode> get copyWith =>
      __$$_TagModeCopyWithImpl<_$_TagMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            MessageModel message, IList<TagModel> tags, bool canSend)
        defaultMode,
    required TResult Function(MessageModel message, IList<TagModel> tags,
            IMap<String, bool> selectedTags, bool removingMode)
        tagMode,
  }) {
    return tagMode(message, tags, selectedTags, removingMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MessageModel message, IList<TagModel> tags, bool canSend)?
        defaultMode,
    TResult? Function(MessageModel message, IList<TagModel> tags,
            IMap<String, bool> selectedTags, bool removingMode)?
        tagMode,
  }) {
    return tagMode?.call(message, tags, selectedTags, removingMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MessageModel message, IList<TagModel> tags, bool canSend)?
        defaultMode,
    TResult Function(MessageModel message, IList<TagModel> tags,
            IMap<String, bool> selectedTags, bool removingMode)?
        tagMode,
    required TResult orElse(),
  }) {
    if (tagMode != null) {
      return tagMode(message, tags, selectedTags, removingMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_TagMode value) tagMode,
  }) {
    return tagMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_TagMode value)? tagMode,
  }) {
    return tagMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_TagMode value)? tagMode,
    required TResult orElse(),
  }) {
    if (tagMode != null) {
      return tagMode(this);
    }
    return orElse();
  }
}

abstract class _TagMode extends MessageInputState {
  const factory _TagMode(
      {required final MessageModel message,
      required final IList<TagModel> tags,
      required final IMap<String, bool> selectedTags,
      required final bool removingMode}) = _$_TagMode;
  const _TagMode._() : super._();

  @override
  MessageModel get message;
  @override
  IList<TagModel> get tags;
  IMap<String, bool> get selectedTags;
  bool get removingMode;
  @override
  @JsonKey(ignore: true)
  _$$_TagModeCopyWith<_$_TagMode> get copyWith =>
      throw _privateConstructorUsedError;
}
