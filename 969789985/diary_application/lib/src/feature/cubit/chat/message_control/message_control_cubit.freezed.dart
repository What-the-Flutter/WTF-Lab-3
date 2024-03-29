// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_control_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MessageControlState {
  IList<MessageModel> get messages => throw _privateConstructorUsedError;
  IMap<String, bool> get selected => throw _privateConstructorUsedError;
  MessageModel get message => throw _privateConstructorUsedError;
  int get selectedCount => throw _privateConstructorUsedError;
  bool get isSelectMode => throw _privateConstructorUsedError;
  bool get isEditMode => throw _privateConstructorUsedError;
  bool get isFavoriteMode => throw _privateConstructorUsedError;
  bool get selectionVisible => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)
        defaultMode,
    required TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)
        manageMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        defaultMode,
    TResult? Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        manageMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        defaultMode,
    TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        manageMode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_ManageMode value) manageMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_ManageMode value)? manageMode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_ManageMode value)? manageMode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageControlStateCopyWith<MessageControlState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageControlStateCopyWith<$Res> {
  factory $MessageControlStateCopyWith(
          MessageControlState value, $Res Function(MessageControlState) then) =
      _$MessageControlStateCopyWithImpl<$Res, MessageControlState>;
  @useResult
  $Res call(
      {IList<MessageModel> messages,
      IMap<String, bool> selected,
      MessageModel message,
      int selectedCount,
      bool isSelectMode,
      bool isEditMode,
      bool isFavoriteMode,
      bool selectionVisible});

  $MessageModelCopyWith<$Res> get message;
}

/// @nodoc
class _$MessageControlStateCopyWithImpl<$Res, $Val extends MessageControlState>
    implements $MessageControlStateCopyWith<$Res> {
  _$MessageControlStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? selected = null,
    Object? message = null,
    Object? selectedCount = null,
    Object? isSelectMode = null,
    Object? isEditMode = null,
    Object? isFavoriteMode = null,
    Object? selectionVisible = null,
  }) {
    return _then(_value.copyWith(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as IMap<String, bool>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageModel,
      selectedCount: null == selectedCount
          ? _value.selectedCount
          : selectedCount // ignore: cast_nullable_to_non_nullable
              as int,
      isSelectMode: null == isSelectMode
          ? _value.isSelectMode
          : isSelectMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: null == isEditMode
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavoriteMode: null == isFavoriteMode
          ? _value.isFavoriteMode
          : isFavoriteMode // ignore: cast_nullable_to_non_nullable
              as bool,
      selectionVisible: null == selectionVisible
          ? _value.selectionVisible
          : selectionVisible // ignore: cast_nullable_to_non_nullable
              as bool,
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
    implements $MessageControlStateCopyWith<$Res> {
  factory _$$_DefaultModeCopyWith(
          _$_DefaultMode value, $Res Function(_$_DefaultMode) then) =
      __$$_DefaultModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IList<MessageModel> messages,
      IMap<String, bool> selected,
      MessageModel message,
      int selectedCount,
      bool isSelectMode,
      bool isEditMode,
      bool isFavoriteMode,
      bool selectionVisible});

  @override
  $MessageModelCopyWith<$Res> get message;
}

/// @nodoc
class __$$_DefaultModeCopyWithImpl<$Res>
    extends _$MessageControlStateCopyWithImpl<$Res, _$_DefaultMode>
    implements _$$_DefaultModeCopyWith<$Res> {
  __$$_DefaultModeCopyWithImpl(
      _$_DefaultMode _value, $Res Function(_$_DefaultMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? selected = null,
    Object? message = null,
    Object? selectedCount = null,
    Object? isSelectMode = null,
    Object? isEditMode = null,
    Object? isFavoriteMode = null,
    Object? selectionVisible = null,
  }) {
    return _then(_$_DefaultMode(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as IMap<String, bool>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageModel,
      selectedCount: null == selectedCount
          ? _value.selectedCount
          : selectedCount // ignore: cast_nullable_to_non_nullable
              as int,
      isSelectMode: null == isSelectMode
          ? _value.isSelectMode
          : isSelectMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: null == isEditMode
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavoriteMode: null == isFavoriteMode
          ? _value.isFavoriteMode
          : isFavoriteMode // ignore: cast_nullable_to_non_nullable
              as bool,
      selectionVisible: null == selectionVisible
          ? _value.selectionVisible
          : selectionVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DefaultMode extends _DefaultMode {
  const _$_DefaultMode(
      {required this.messages,
      required this.selected,
      required this.message,
      required this.selectedCount,
      required this.isSelectMode,
      required this.isEditMode,
      required this.isFavoriteMode,
      required this.selectionVisible})
      : super._();

  @override
  final IList<MessageModel> messages;
  @override
  final IMap<String, bool> selected;
  @override
  final MessageModel message;
  @override
  final int selectedCount;
  @override
  final bool isSelectMode;
  @override
  final bool isEditMode;
  @override
  final bool isFavoriteMode;
  @override
  final bool selectionVisible;

  @override
  String toString() {
    return 'MessageControlState.defaultMode(messages: $messages, selected: $selected, message: $message, selectedCount: $selectedCount, isSelectMode: $isSelectMode, isEditMode: $isEditMode, isFavoriteMode: $isFavoriteMode, selectionVisible: $selectionVisible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DefaultMode &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.selectedCount, selectedCount) ||
                other.selectedCount == selectedCount) &&
            (identical(other.isSelectMode, isSelectMode) ||
                other.isSelectMode == isSelectMode) &&
            (identical(other.isEditMode, isEditMode) ||
                other.isEditMode == isEditMode) &&
            (identical(other.isFavoriteMode, isFavoriteMode) ||
                other.isFavoriteMode == isFavoriteMode) &&
            (identical(other.selectionVisible, selectionVisible) ||
                other.selectionVisible == selectionVisible));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(messages),
      selected,
      message,
      selectedCount,
      isSelectMode,
      isEditMode,
      isFavoriteMode,
      selectionVisible);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      __$$_DefaultModeCopyWithImpl<_$_DefaultMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)
        defaultMode,
    required TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)
        manageMode,
  }) {
    return defaultMode(messages, selected, message, selectedCount, isSelectMode,
        isEditMode, isFavoriteMode, selectionVisible);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        defaultMode,
    TResult? Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        manageMode,
  }) {
    return defaultMode?.call(messages, selected, message, selectedCount,
        isSelectMode, isEditMode, isFavoriteMode, selectionVisible);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        defaultMode,
    TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        manageMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(messages, selected, message, selectedCount,
          isSelectMode, isEditMode, isFavoriteMode, selectionVisible);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_ManageMode value) manageMode,
  }) {
    return defaultMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_ManageMode value)? manageMode,
  }) {
    return defaultMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_ManageMode value)? manageMode,
    required TResult orElse(),
  }) {
    if (defaultMode != null) {
      return defaultMode(this);
    }
    return orElse();
  }
}

abstract class _DefaultMode extends MessageControlState {
  const factory _DefaultMode(
      {required final IList<MessageModel> messages,
      required final IMap<String, bool> selected,
      required final MessageModel message,
      required final int selectedCount,
      required final bool isSelectMode,
      required final bool isEditMode,
      required final bool isFavoriteMode,
      required final bool selectionVisible}) = _$_DefaultMode;
  const _DefaultMode._() : super._();

  @override
  IList<MessageModel> get messages;
  @override
  IMap<String, bool> get selected;
  @override
  MessageModel get message;
  @override
  int get selectedCount;
  @override
  bool get isSelectMode;
  @override
  bool get isEditMode;
  @override
  bool get isFavoriteMode;
  @override
  bool get selectionVisible;
  @override
  @JsonKey(ignore: true)
  _$$_DefaultModeCopyWith<_$_DefaultMode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ManageModeCopyWith<$Res>
    implements $MessageControlStateCopyWith<$Res> {
  factory _$$_ManageModeCopyWith(
          _$_ManageMode value, $Res Function(_$_ManageMode) then) =
      __$$_ManageModeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IList<MessageModel> messages,
      IMap<String, bool> selected,
      MessageModel message,
      int selectedCount,
      bool isSelectMode,
      bool isEditMode,
      bool isFavoriteMode,
      bool selectionVisible});

  @override
  $MessageModelCopyWith<$Res> get message;
}

/// @nodoc
class __$$_ManageModeCopyWithImpl<$Res>
    extends _$MessageControlStateCopyWithImpl<$Res, _$_ManageMode>
    implements _$$_ManageModeCopyWith<$Res> {
  __$$_ManageModeCopyWithImpl(
      _$_ManageMode _value, $Res Function(_$_ManageMode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? selected = null,
    Object? message = null,
    Object? selectedCount = null,
    Object? isSelectMode = null,
    Object? isEditMode = null,
    Object? isFavoriteMode = null,
    Object? selectionVisible = null,
  }) {
    return _then(_$_ManageMode(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as IMap<String, bool>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageModel,
      selectedCount: null == selectedCount
          ? _value.selectedCount
          : selectedCount // ignore: cast_nullable_to_non_nullable
              as int,
      isSelectMode: null == isSelectMode
          ? _value.isSelectMode
          : isSelectMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: null == isEditMode
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavoriteMode: null == isFavoriteMode
          ? _value.isFavoriteMode
          : isFavoriteMode // ignore: cast_nullable_to_non_nullable
              as bool,
      selectionVisible: null == selectionVisible
          ? _value.selectionVisible
          : selectionVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ManageMode extends _ManageMode {
  const _$_ManageMode(
      {required this.messages,
      required this.selected,
      required this.message,
      required this.selectedCount,
      required this.isSelectMode,
      required this.isEditMode,
      required this.isFavoriteMode,
      required this.selectionVisible})
      : super._();

  @override
  final IList<MessageModel> messages;
  @override
  final IMap<String, bool> selected;
  @override
  final MessageModel message;
  @override
  final int selectedCount;
  @override
  final bool isSelectMode;
  @override
  final bool isEditMode;
  @override
  final bool isFavoriteMode;
  @override
  final bool selectionVisible;

  @override
  String toString() {
    return 'MessageControlState.manageMode(messages: $messages, selected: $selected, message: $message, selectedCount: $selectedCount, isSelectMode: $isSelectMode, isEditMode: $isEditMode, isFavoriteMode: $isFavoriteMode, selectionVisible: $selectionVisible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ManageMode &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.selectedCount, selectedCount) ||
                other.selectedCount == selectedCount) &&
            (identical(other.isSelectMode, isSelectMode) ||
                other.isSelectMode == isSelectMode) &&
            (identical(other.isEditMode, isEditMode) ||
                other.isEditMode == isEditMode) &&
            (identical(other.isFavoriteMode, isFavoriteMode) ||
                other.isFavoriteMode == isFavoriteMode) &&
            (identical(other.selectionVisible, selectionVisible) ||
                other.selectionVisible == selectionVisible));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(messages),
      selected,
      message,
      selectedCount,
      isSelectMode,
      isEditMode,
      isFavoriteMode,
      selectionVisible);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ManageModeCopyWith<_$_ManageMode> get copyWith =>
      __$$_ManageModeCopyWithImpl<_$_ManageMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)
        defaultMode,
    required TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)
        manageMode,
  }) {
    return manageMode(messages, selected, message, selectedCount, isSelectMode,
        isEditMode, isFavoriteMode, selectionVisible);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        defaultMode,
    TResult? Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        manageMode,
  }) {
    return manageMode?.call(messages, selected, message, selectedCount,
        isSelectMode, isEditMode, isFavoriteMode, selectionVisible);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        defaultMode,
    TResult Function(
            IList<MessageModel> messages,
            IMap<String, bool> selected,
            MessageModel message,
            int selectedCount,
            bool isSelectMode,
            bool isEditMode,
            bool isFavoriteMode,
            bool selectionVisible)?
        manageMode,
    required TResult orElse(),
  }) {
    if (manageMode != null) {
      return manageMode(messages, selected, message, selectedCount,
          isSelectMode, isEditMode, isFavoriteMode, selectionVisible);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DefaultMode value) defaultMode,
    required TResult Function(_ManageMode value) manageMode,
  }) {
    return manageMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DefaultMode value)? defaultMode,
    TResult? Function(_ManageMode value)? manageMode,
  }) {
    return manageMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DefaultMode value)? defaultMode,
    TResult Function(_ManageMode value)? manageMode,
    required TResult orElse(),
  }) {
    if (manageMode != null) {
      return manageMode(this);
    }
    return orElse();
  }
}

abstract class _ManageMode extends MessageControlState {
  const factory _ManageMode(
      {required final IList<MessageModel> messages,
      required final IMap<String, bool> selected,
      required final MessageModel message,
      required final int selectedCount,
      required final bool isSelectMode,
      required final bool isEditMode,
      required final bool isFavoriteMode,
      required final bool selectionVisible}) = _$_ManageMode;
  const _ManageMode._() : super._();

  @override
  IList<MessageModel> get messages;
  @override
  IMap<String, bool> get selected;
  @override
  MessageModel get message;
  @override
  int get selectedCount;
  @override
  bool get isSelectMode;
  @override
  bool get isEditMode;
  @override
  bool get isFavoriteMode;
  @override
  bool get selectionVisible;
  @override
  @JsonKey(ignore: true)
  _$$_ManageModeCopyWith<_$_ManageMode> get copyWith =>
      throw _privateConstructorUsedError;
}
