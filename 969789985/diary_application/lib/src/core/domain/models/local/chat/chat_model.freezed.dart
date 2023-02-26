// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatModel {
  String get id => throw _privateConstructorUsedError;
  String get chatTitle => throw _privateConstructorUsedError;
  int get chatIcon => throw _privateConstructorUsedError;
  DateTime get creationDate => throw _privateConstructorUsedError;
  IList<MessageModel> get messages => throw _privateConstructorUsedError;
  bool get isArchive => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call(
      {String id,
      String chatTitle,
      int chatIcon,
      DateTime creationDate,
      IList<MessageModel> messages,
      bool isArchive,
      bool isPinned});
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatTitle = null,
    Object? chatIcon = null,
    Object? creationDate = null,
    Object? messages = null,
    Object? isArchive = null,
    Object? isPinned = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatTitle: null == chatTitle
          ? _value.chatTitle
          : chatTitle // ignore: cast_nullable_to_non_nullable
              as String,
      chatIcon: null == chatIcon
          ? _value.chatIcon
          : chatIcon // ignore: cast_nullable_to_non_nullable
              as int,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      isArchive: null == isArchive
          ? _value.isArchive
          : isArchive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$$_ChatModelCopyWith(
          _$_ChatModel value, $Res Function(_$_ChatModel) then) =
      __$$_ChatModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String chatTitle,
      int chatIcon,
      DateTime creationDate,
      IList<MessageModel> messages,
      bool isArchive,
      bool isPinned});
}

/// @nodoc
class __$$_ChatModelCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$_ChatModel>
    implements _$$_ChatModelCopyWith<$Res> {
  __$$_ChatModelCopyWithImpl(
      _$_ChatModel _value, $Res Function(_$_ChatModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatTitle = null,
    Object? chatIcon = null,
    Object? creationDate = null,
    Object? messages = null,
    Object? isArchive = null,
    Object? isPinned = null,
  }) {
    return _then(_$_ChatModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatTitle: null == chatTitle
          ? _value.chatTitle
          : chatTitle // ignore: cast_nullable_to_non_nullable
              as String,
      chatIcon: null == chatIcon
          ? _value.chatIcon
          : chatIcon // ignore: cast_nullable_to_non_nullable
              as int,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as IList<MessageModel>,
      isArchive: null == isArchive
          ? _value.isArchive
          : isArchive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ChatModel extends _ChatModel {
  _$_ChatModel(
      {required this.id,
      required this.chatTitle,
      required this.chatIcon,
      required this.creationDate,
      required this.messages,
      required this.isArchive,
      required this.isPinned})
      : super._();

  @override
  final String id;
  @override
  final String chatTitle;
  @override
  final int chatIcon;
  @override
  final DateTime creationDate;
  @override
  final IList<MessageModel> messages;
  @override
  final bool isArchive;
  @override
  final bool isPinned;

  @override
  String toString() {
    return 'ChatModel._internal(id: $id, chatTitle: $chatTitle, chatIcon: $chatIcon, creationDate: $creationDate, messages: $messages, isArchive: $isArchive, isPinned: $isPinned)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatTitle, chatTitle) ||
                other.chatTitle == chatTitle) &&
            (identical(other.chatIcon, chatIcon) ||
                other.chatIcon == chatIcon) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            (identical(other.isArchive, isArchive) ||
                other.isArchive == isArchive) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      chatTitle,
      chatIcon,
      creationDate,
      const DeepCollectionEquality().hash(messages),
      isArchive,
      isPinned);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatModelCopyWith<_$_ChatModel> get copyWith =>
      __$$_ChatModelCopyWithImpl<_$_ChatModel>(this, _$identity);
}

abstract class _ChatModel extends ChatModel {
  factory _ChatModel(
      {required final String id,
      required final String chatTitle,
      required final int chatIcon,
      required final DateTime creationDate,
      required final IList<MessageModel> messages,
      required final bool isArchive,
      required final bool isPinned}) = _$_ChatModel;
  _ChatModel._() : super._();

  @override
  String get id;
  @override
  String get chatTitle;
  @override
  int get chatIcon;
  @override
  DateTime get creationDate;
  @override
  IList<MessageModel> get messages;
  @override
  bool get isArchive;
  @override
  bool get isPinned;
  @override
  @JsonKey(ignore: true)
  _$$_ChatModelCopyWith<_$_ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}
