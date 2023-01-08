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
    required TResult Function(int? selectedIcon, String name) closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? selectedIcon, String name)? adding,
    TResult? Function(int? selectedIcon, String name, Chat chat)? editing,
    TResult? Function(int? selectedIcon, String name)? closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? selectedIcon, String name)? adding,
    TResult Function(int? selectedIcon, String name, Chat chat)? editing,
    TResult Function(int? selectedIcon, String name)? closed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ManageChatAdding value) adding,
    required TResult Function(ManageChatEditing value) editing,
    required TResult Function(ManageChatClosed value) closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ManageChatAdding value)? adding,
    TResult? Function(ManageChatEditing value)? editing,
    TResult? Function(ManageChatClosed value)? closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ManageChatAdding value)? adding,
    TResult Function(ManageChatEditing value)? editing,
    TResult Function(ManageChatClosed value)? closed,
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
abstract class _$$ManageChatAddingCopyWith<$Res>
    implements $ManageChatStateCopyWith<$Res> {
  factory _$$ManageChatAddingCopyWith(
          _$ManageChatAdding value, $Res Function(_$ManageChatAdding) then) =
      __$$ManageChatAddingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? selectedIcon, String name});
}

/// @nodoc
class __$$ManageChatAddingCopyWithImpl<$Res>
    extends _$ManageChatStateCopyWithImpl<$Res, _$ManageChatAdding>
    implements _$$ManageChatAddingCopyWith<$Res> {
  __$$ManageChatAddingCopyWithImpl(
      _$ManageChatAdding _value, $Res Function(_$ManageChatAdding) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIcon = freezed,
    Object? name = null,
  }) {
    return _then(_$ManageChatAdding(
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

class _$ManageChatAdding extends ManageChatAdding {
  const _$ManageChatAdding({this.selectedIcon, this.name = ''}) : super._();

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
            other is _$ManageChatAdding &&
            (identical(other.selectedIcon, selectedIcon) ||
                other.selectedIcon == selectedIcon) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedIcon, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ManageChatAddingCopyWith<_$ManageChatAdding> get copyWith =>
      __$$ManageChatAddingCopyWithImpl<_$ManageChatAdding>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? selectedIcon, String name) adding,
    required TResult Function(int? selectedIcon, String name, Chat chat)
        editing,
    required TResult Function(int? selectedIcon, String name) closed,
  }) {
    return adding(selectedIcon, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? selectedIcon, String name)? adding,
    TResult? Function(int? selectedIcon, String name, Chat chat)? editing,
    TResult? Function(int? selectedIcon, String name)? closed,
  }) {
    return adding?.call(selectedIcon, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? selectedIcon, String name)? adding,
    TResult Function(int? selectedIcon, String name, Chat chat)? editing,
    TResult Function(int? selectedIcon, String name)? closed,
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
    required TResult Function(ManageChatAdding value) adding,
    required TResult Function(ManageChatEditing value) editing,
    required TResult Function(ManageChatClosed value) closed,
  }) {
    return adding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ManageChatAdding value)? adding,
    TResult? Function(ManageChatEditing value)? editing,
    TResult? Function(ManageChatClosed value)? closed,
  }) {
    return adding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ManageChatAdding value)? adding,
    TResult Function(ManageChatEditing value)? editing,
    TResult Function(ManageChatClosed value)? closed,
    required TResult orElse(),
  }) {
    if (adding != null) {
      return adding(this);
    }
    return orElse();
  }
}

abstract class ManageChatAdding extends ManageChatState {
  const factory ManageChatAdding({final int? selectedIcon, final String name}) =
      _$ManageChatAdding;
  const ManageChatAdding._() : super._();

  @override
  int? get selectedIcon;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ManageChatAddingCopyWith<_$ManageChatAdding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ManageChatEditingCopyWith<$Res>
    implements $ManageChatStateCopyWith<$Res> {
  factory _$$ManageChatEditingCopyWith(
          _$ManageChatEditing value, $Res Function(_$ManageChatEditing) then) =
      __$$ManageChatEditingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? selectedIcon, String name, Chat chat});

  $ChatCopyWith<$Res> get chat;
}

/// @nodoc
class __$$ManageChatEditingCopyWithImpl<$Res>
    extends _$ManageChatStateCopyWithImpl<$Res, _$ManageChatEditing>
    implements _$$ManageChatEditingCopyWith<$Res> {
  __$$ManageChatEditingCopyWithImpl(
      _$ManageChatEditing _value, $Res Function(_$ManageChatEditing) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIcon = freezed,
    Object? name = null,
    Object? chat = null,
  }) {
    return _then(_$ManageChatEditing(
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

class _$ManageChatEditing extends ManageChatEditing {
  const _$ManageChatEditing(
      {this.selectedIcon, this.name = '', required this.chat})
      : super._();

  @override
  final int? selectedIcon;
  @override
  @JsonKey()
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
            other is _$ManageChatEditing &&
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
  _$$ManageChatEditingCopyWith<_$ManageChatEditing> get copyWith =>
      __$$ManageChatEditingCopyWithImpl<_$ManageChatEditing>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? selectedIcon, String name) adding,
    required TResult Function(int? selectedIcon, String name, Chat chat)
        editing,
    required TResult Function(int? selectedIcon, String name) closed,
  }) {
    return editing(selectedIcon, name, chat);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? selectedIcon, String name)? adding,
    TResult? Function(int? selectedIcon, String name, Chat chat)? editing,
    TResult? Function(int? selectedIcon, String name)? closed,
  }) {
    return editing?.call(selectedIcon, name, chat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? selectedIcon, String name)? adding,
    TResult Function(int? selectedIcon, String name, Chat chat)? editing,
    TResult Function(int? selectedIcon, String name)? closed,
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
    required TResult Function(ManageChatAdding value) adding,
    required TResult Function(ManageChatEditing value) editing,
    required TResult Function(ManageChatClosed value) closed,
  }) {
    return editing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ManageChatAdding value)? adding,
    TResult? Function(ManageChatEditing value)? editing,
    TResult? Function(ManageChatClosed value)? closed,
  }) {
    return editing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ManageChatAdding value)? adding,
    TResult Function(ManageChatEditing value)? editing,
    TResult Function(ManageChatClosed value)? closed,
    required TResult orElse(),
  }) {
    if (editing != null) {
      return editing(this);
    }
    return orElse();
  }
}

abstract class ManageChatEditing extends ManageChatState {
  const factory ManageChatEditing(
      {final int? selectedIcon,
      final String name,
      required final Chat chat}) = _$ManageChatEditing;
  const ManageChatEditing._() : super._();

  @override
  int? get selectedIcon;
  @override
  String get name;
  Chat get chat;
  @override
  @JsonKey(ignore: true)
  _$$ManageChatEditingCopyWith<_$ManageChatEditing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ManageChatClosedCopyWith<$Res>
    implements $ManageChatStateCopyWith<$Res> {
  factory _$$ManageChatClosedCopyWith(
          _$ManageChatClosed value, $Res Function(_$ManageChatClosed) then) =
      __$$ManageChatClosedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? selectedIcon, String name});
}

/// @nodoc
class __$$ManageChatClosedCopyWithImpl<$Res>
    extends _$ManageChatStateCopyWithImpl<$Res, _$ManageChatClosed>
    implements _$$ManageChatClosedCopyWith<$Res> {
  __$$ManageChatClosedCopyWithImpl(
      _$ManageChatClosed _value, $Res Function(_$ManageChatClosed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIcon = freezed,
    Object? name = null,
  }) {
    return _then(_$ManageChatClosed(
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

class _$ManageChatClosed extends ManageChatClosed {
  const _$ManageChatClosed({this.selectedIcon, this.name = ''}) : super._();

  @override
  final int? selectedIcon;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'ManageChatState.closed(selectedIcon: $selectedIcon, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManageChatClosed &&
            (identical(other.selectedIcon, selectedIcon) ||
                other.selectedIcon == selectedIcon) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedIcon, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ManageChatClosedCopyWith<_$ManageChatClosed> get copyWith =>
      __$$ManageChatClosedCopyWithImpl<_$ManageChatClosed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? selectedIcon, String name) adding,
    required TResult Function(int? selectedIcon, String name, Chat chat)
        editing,
    required TResult Function(int? selectedIcon, String name) closed,
  }) {
    return closed(selectedIcon, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? selectedIcon, String name)? adding,
    TResult? Function(int? selectedIcon, String name, Chat chat)? editing,
    TResult? Function(int? selectedIcon, String name)? closed,
  }) {
    return closed?.call(selectedIcon, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? selectedIcon, String name)? adding,
    TResult Function(int? selectedIcon, String name, Chat chat)? editing,
    TResult Function(int? selectedIcon, String name)? closed,
    required TResult orElse(),
  }) {
    if (closed != null) {
      return closed(selectedIcon, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ManageChatAdding value) adding,
    required TResult Function(ManageChatEditing value) editing,
    required TResult Function(ManageChatClosed value) closed,
  }) {
    return closed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ManageChatAdding value)? adding,
    TResult? Function(ManageChatEditing value)? editing,
    TResult? Function(ManageChatClosed value)? closed,
  }) {
    return closed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ManageChatAdding value)? adding,
    TResult Function(ManageChatEditing value)? editing,
    TResult Function(ManageChatClosed value)? closed,
    required TResult orElse(),
  }) {
    if (closed != null) {
      return closed(this);
    }
    return orElse();
  }
}

abstract class ManageChatClosed extends ManageChatState {
  const factory ManageChatClosed({final int? selectedIcon, final String name}) =
      _$ManageChatClosed;
  const ManageChatClosed._() : super._();

  @override
  int? get selectedIcon;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ManageChatClosedCopyWith<_$ManageChatClosed> get copyWith =>
      throw _privateConstructorUsedError;
}
