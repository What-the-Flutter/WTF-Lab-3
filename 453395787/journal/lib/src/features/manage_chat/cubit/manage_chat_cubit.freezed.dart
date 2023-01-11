// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_chat_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ManageChatState {
  int? get selectedIcon => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? selectedIcon, String name) adding,
    required TResult Function(int? selectedIcon, String name, Chat chat)
        editing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? selectedIcon, String name)? adding,
    TResult? Function(int? selectedIcon, String name, Chat chat)? editing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? selectedIcon, String name)? adding,
    TResult Function(int? selectedIcon, String name, Chat chat)? editing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddModeState value) adding,
    required TResult Function(_EditModeState value) editing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddModeState value)? adding,
    TResult? Function(_EditModeState value)? editing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddModeState value)? adding,
    TResult Function(_EditModeState value)? editing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ManageChatStateCopyWith<ManageChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManageChatStateCopyWith<$Res> {
  factory $ManageChatStateCopyWith(
          ManageChatState value, $Res Function(ManageChatState) then) =
      _$ManageChatStateCopyWithImpl<$Res, ManageChatState>;
  @useResult
  $Res call({int? selectedIcon, String name});
}

/// @nodoc
class _$ManageChatStateCopyWithImpl<$Res, $Val extends ManageChatState>
    implements $ManageChatStateCopyWith<$Res> {
  _$ManageChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIcon = freezed,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      selectedIcon: freezed == selectedIcon
          ? _value.selectedIcon
          : selectedIcon // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddModeStateCopyWith<$Res>
    implements $ManageChatStateCopyWith<$Res> {
  factory _$$_AddModeStateCopyWith(
          _$_AddModeState value, $Res Function(_$_AddModeState) then) =
      __$$_AddModeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? selectedIcon, String name});
}

/// @nodoc
class __$$_AddModeStateCopyWithImpl<$Res>
    extends _$ManageChatStateCopyWithImpl<$Res, _$_AddModeState>
    implements _$$_AddModeStateCopyWith<$Res> {
  __$$_AddModeStateCopyWithImpl(
      _$_AddModeState _value, $Res Function(_$_AddModeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIcon = freezed,
    Object? name = null,
  }) {
    return _then(_$_AddModeState(
      selectedIcon: freezed == selectedIcon
          ? _value.selectedIcon
          : selectedIcon // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AddModeState extends _AddModeState {
  const _$_AddModeState({this.selectedIcon, this.name = ''}) : super._();

  @override
  final int? selectedIcon;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'ManageChatState.adding(selectedIcon: $selectedIcon, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddModeState &&
            (identical(other.selectedIcon, selectedIcon) ||
                other.selectedIcon == selectedIcon) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedIcon, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddModeStateCopyWith<_$_AddModeState> get copyWith =>
      __$$_AddModeStateCopyWithImpl<_$_AddModeState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? selectedIcon, String name) adding,
    required TResult Function(int? selectedIcon, String name, Chat chat)
        editing,
  }) {
    return adding(selectedIcon, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? selectedIcon, String name)? adding,
    TResult? Function(int? selectedIcon, String name, Chat chat)? editing,
  }) {
    return adding?.call(selectedIcon, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? selectedIcon, String name)? adding,
    TResult Function(int? selectedIcon, String name, Chat chat)? editing,
    required TResult orElse(),
  }) {
    if (adding != null) {
      return adding(selectedIcon, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddModeState value) adding,
    required TResult Function(_EditModeState value) editing,
  }) {
    return adding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddModeState value)? adding,
    TResult? Function(_EditModeState value)? editing,
  }) {
    return adding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddModeState value)? adding,
    TResult Function(_EditModeState value)? editing,
    required TResult orElse(),
  }) {
    if (adding != null) {
      return adding(this);
    }
    return orElse();
  }
}

abstract class _AddModeState extends ManageChatState {
  const factory _AddModeState({final int? selectedIcon, final String name}) =
      _$_AddModeState;
  const _AddModeState._() : super._();

  @override
  int? get selectedIcon;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_AddModeStateCopyWith<_$_AddModeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_EditModeStateCopyWith<$Res>
    implements $ManageChatStateCopyWith<$Res> {
  factory _$$_EditModeStateCopyWith(
          _$_EditModeState value, $Res Function(_$_EditModeState) then) =
      __$$_EditModeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? selectedIcon, String name, Chat chat});

  $ChatCopyWith<$Res> get chat;
}

/// @nodoc
class __$$_EditModeStateCopyWithImpl<$Res>
    extends _$ManageChatStateCopyWithImpl<$Res, _$_EditModeState>
    implements _$$_EditModeStateCopyWith<$Res> {
  __$$_EditModeStateCopyWithImpl(
      _$_EditModeState _value, $Res Function(_$_EditModeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIcon = freezed,
    Object? name = null,
    Object? chat = null,
  }) {
    return _then(_$_EditModeState(
      selectedIcon: freezed == selectedIcon
          ? _value.selectedIcon
          : selectedIcon // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      chat: null == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as Chat,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatCopyWith<$Res> get chat {
    return $ChatCopyWith<$Res>(_value.chat, (value) {
      return _then(_value.copyWith(chat: value));
    });
  }
}

/// @nodoc

class _$_EditModeState extends _EditModeState {
  const _$_EditModeState(
      {this.selectedIcon, required this.name, required this.chat})
      : super._();

  @override
  final int? selectedIcon;
  @override
  final String name;
  @override
  final Chat chat;

  @override
  String toString() {
    return 'ManageChatState.editing(selectedIcon: $selectedIcon, name: $name, chat: $chat)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditModeState &&
            (identical(other.selectedIcon, selectedIcon) ||
                other.selectedIcon == selectedIcon) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.chat, chat) || other.chat == chat));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedIcon, name, chat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditModeStateCopyWith<_$_EditModeState> get copyWith =>
      __$$_EditModeStateCopyWithImpl<_$_EditModeState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? selectedIcon, String name) adding,
    required TResult Function(int? selectedIcon, String name, Chat chat)
        editing,
  }) {
    return editing(selectedIcon, name, chat);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? selectedIcon, String name)? adding,
    TResult? Function(int? selectedIcon, String name, Chat chat)? editing,
  }) {
    return editing?.call(selectedIcon, name, chat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? selectedIcon, String name)? adding,
    TResult Function(int? selectedIcon, String name, Chat chat)? editing,
    required TResult orElse(),
  }) {
    if (editing != null) {
      return editing(selectedIcon, name, chat);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddModeState value) adding,
    required TResult Function(_EditModeState value) editing,
  }) {
    return editing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddModeState value)? adding,
    TResult? Function(_EditModeState value)? editing,
  }) {
    return editing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddModeState value)? adding,
    TResult Function(_EditModeState value)? editing,
    required TResult orElse(),
  }) {
    if (editing != null) {
      return editing(this);
    }
    return orElse();
  }
}

abstract class _EditModeState extends ManageChatState {
  const factory _EditModeState(
      {final int? selectedIcon,
      required final String name,
      required final Chat chat}) = _$_EditModeState;
  const _EditModeState._() : super._();

  @override
  int? get selectedIcon;
  @override
  String get name;
  Chat get chat;
  @override
  @JsonKey(ignore: true)
  _$$_EditModeStateCopyWith<_$_EditModeState> get copyWith =>
      throw _privateConstructorUsedError;
}
