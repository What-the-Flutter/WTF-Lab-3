// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirebaseChatModel _$FirebaseChatModelFromJson(Map<String, dynamic> json) {
  return _FirebaseChatModel.fromJson(json);
}

/// @nodoc
mixin _$FirebaseChatModel {
  String get id => throw _privateConstructorUsedError;
  String get chatTitle => throw _privateConstructorUsedError;
  int get chatIcon => throw _privateConstructorUsedError;
  DateTime get creationDate => throw _privateConstructorUsedError;
  String get messages => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  bool get isArchive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebaseChatModelCopyWith<FirebaseChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseChatModelCopyWith<$Res> {
  factory $FirebaseChatModelCopyWith(
          FirebaseChatModel value, $Res Function(FirebaseChatModel) then) =
      _$FirebaseChatModelCopyWithImpl<$Res, FirebaseChatModel>;
  @useResult
  $Res call(
      {String id,
      String chatTitle,
      int chatIcon,
      DateTime creationDate,
      String messages,
      bool isPinned,
      bool isArchive});
}

/// @nodoc
class _$FirebaseChatModelCopyWithImpl<$Res, $Val extends FirebaseChatModel>
    implements $FirebaseChatModelCopyWith<$Res> {
  _$FirebaseChatModelCopyWithImpl(this._value, this._then);

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
    Object? isPinned = null,
    Object? isArchive = null,
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
              as String,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      isArchive: null == isArchive
          ? _value.isArchive
          : isArchive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FirebaseChatModelCopyWith<$Res>
    implements $FirebaseChatModelCopyWith<$Res> {
  factory _$$_FirebaseChatModelCopyWith(_$_FirebaseChatModel value,
          $Res Function(_$_FirebaseChatModel) then) =
      __$$_FirebaseChatModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String chatTitle,
      int chatIcon,
      DateTime creationDate,
      String messages,
      bool isPinned,
      bool isArchive});
}

/// @nodoc
class __$$_FirebaseChatModelCopyWithImpl<$Res>
    extends _$FirebaseChatModelCopyWithImpl<$Res, _$_FirebaseChatModel>
    implements _$$_FirebaseChatModelCopyWith<$Res> {
  __$$_FirebaseChatModelCopyWithImpl(
      _$_FirebaseChatModel _value, $Res Function(_$_FirebaseChatModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatTitle = null,
    Object? chatIcon = null,
    Object? creationDate = null,
    Object? messages = null,
    Object? isPinned = null,
    Object? isArchive = null,
  }) {
    return _then(_$_FirebaseChatModel(
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
              as String,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      isArchive: null == isArchive
          ? _value.isArchive
          : isArchive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirebaseChatModel implements _FirebaseChatModel {
  const _$_FirebaseChatModel(
      {this.id = '_id',
      this.chatTitle = '_chat_title',
      required this.chatIcon,
      required this.creationDate,
      this.messages = '',
      this.isPinned = false,
      this.isArchive = false});

  factory _$_FirebaseChatModel.fromJson(Map<String, dynamic> json) =>
      _$$_FirebaseChatModelFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String chatTitle;
  @override
  final int chatIcon;
  @override
  final DateTime creationDate;
  @override
  @JsonKey()
  final String messages;
  @override
  @JsonKey()
  final bool isPinned;
  @override
  @JsonKey()
  final bool isArchive;

  @override
  String toString() {
    return 'FirebaseChatModel(id: $id, chatTitle: $chatTitle, chatIcon: $chatIcon, creationDate: $creationDate, messages: $messages, isPinned: $isPinned, isArchive: $isArchive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirebaseChatModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatTitle, chatTitle) ||
                other.chatTitle == chatTitle) &&
            (identical(other.chatIcon, chatIcon) ||
                other.chatIcon == chatIcon) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.messages, messages) ||
                other.messages == messages) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isArchive, isArchive) ||
                other.isArchive == isArchive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, chatTitle, chatIcon,
      creationDate, messages, isPinned, isArchive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirebaseChatModelCopyWith<_$_FirebaseChatModel> get copyWith =>
      __$$_FirebaseChatModelCopyWithImpl<_$_FirebaseChatModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirebaseChatModelToJson(
      this,
    );
  }
}

abstract class _FirebaseChatModel implements FirebaseChatModel {
  const factory _FirebaseChatModel(
      {final String id,
      final String chatTitle,
      required final int chatIcon,
      required final DateTime creationDate,
      final String messages,
      final bool isPinned,
      final bool isArchive}) = _$_FirebaseChatModel;

  factory _FirebaseChatModel.fromJson(Map<String, dynamic> json) =
      _$_FirebaseChatModel.fromJson;

  @override
  String get id;
  @override
  String get chatTitle;
  @override
  int get chatIcon;
  @override
  DateTime get creationDate;
  @override
  String get messages;
  @override
  bool get isPinned;
  @override
  bool get isArchive;
  @override
  @JsonKey(ignore: true)
  _$$_FirebaseChatModelCopyWith<_$_FirebaseChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}
