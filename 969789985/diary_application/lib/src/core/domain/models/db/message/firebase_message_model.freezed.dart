// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirebaseMessageModel _$FirebaseMessageModelFromJson(Map<String, dynamic> json) {
  return _FirebaseMessageModel.fromJson(json);
}

/// @nodoc
mixin _$FirebaseMessageModel {
  String get id => throw _privateConstructorUsedError;
  String get chatId => throw _privateConstructorUsedError;
  String get messageText => throw _privateConstructorUsedError;
  DateTime get sendDate => throw _privateConstructorUsedError;
  IList<String> get tagsIds => throw _privateConstructorUsedError;
  IList<String> get imagePaths => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebaseMessageModelCopyWith<FirebaseMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseMessageModelCopyWith<$Res> {
  factory $FirebaseMessageModelCopyWith(FirebaseMessageModel value,
          $Res Function(FirebaseMessageModel) then) =
      _$FirebaseMessageModelCopyWithImpl<$Res, FirebaseMessageModel>;
  @useResult
  $Res call(
      {String id,
      String chatId,
      String messageText,
      DateTime sendDate,
      IList<String> tagsIds,
      IList<String> imagePaths,
      bool isFavorite});
}

/// @nodoc
class _$FirebaseMessageModelCopyWithImpl<$Res,
        $Val extends FirebaseMessageModel>
    implements $FirebaseMessageModelCopyWith<$Res> {
  _$FirebaseMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? messageText = null,
    Object? sendDate = null,
    Object? tagsIds = null,
    Object? imagePaths = null,
    Object? isFavorite = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      messageText: null == messageText
          ? _value.messageText
          : messageText // ignore: cast_nullable_to_non_nullable
              as String,
      sendDate: null == sendDate
          ? _value.sendDate
          : sendDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tagsIds: null == tagsIds
          ? _value.tagsIds
          : tagsIds // ignore: cast_nullable_to_non_nullable
              as IList<String>,
      imagePaths: null == imagePaths
          ? _value.imagePaths
          : imagePaths // ignore: cast_nullable_to_non_nullable
              as IList<String>,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FirebaseMessageModelCopyWith<$Res>
    implements $FirebaseMessageModelCopyWith<$Res> {
  factory _$$_FirebaseMessageModelCopyWith(_$_FirebaseMessageModel value,
          $Res Function(_$_FirebaseMessageModel) then) =
      __$$_FirebaseMessageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String chatId,
      String messageText,
      DateTime sendDate,
      IList<String> tagsIds,
      IList<String> imagePaths,
      bool isFavorite});
}

/// @nodoc
class __$$_FirebaseMessageModelCopyWithImpl<$Res>
    extends _$FirebaseMessageModelCopyWithImpl<$Res, _$_FirebaseMessageModel>
    implements _$$_FirebaseMessageModelCopyWith<$Res> {
  __$$_FirebaseMessageModelCopyWithImpl(_$_FirebaseMessageModel _value,
      $Res Function(_$_FirebaseMessageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? messageText = null,
    Object? sendDate = null,
    Object? tagsIds = null,
    Object? imagePaths = null,
    Object? isFavorite = null,
  }) {
    return _then(_$_FirebaseMessageModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      messageText: null == messageText
          ? _value.messageText
          : messageText // ignore: cast_nullable_to_non_nullable
              as String,
      sendDate: null == sendDate
          ? _value.sendDate
          : sendDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tagsIds: null == tagsIds
          ? _value.tagsIds
          : tagsIds // ignore: cast_nullable_to_non_nullable
              as IList<String>,
      imagePaths: null == imagePaths
          ? _value.imagePaths
          : imagePaths // ignore: cast_nullable_to_non_nullable
              as IList<String>,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirebaseMessageModel implements _FirebaseMessageModel {
  const _$_FirebaseMessageModel(
      {this.id = '_id',
      required this.chatId,
      this.messageText = '_message_text',
      required this.sendDate,
      this.tagsIds = const IListConst([]),
      this.imagePaths = const IListConst([]),
      this.isFavorite = false});

  factory _$_FirebaseMessageModel.fromJson(Map<String, dynamic> json) =>
      _$$_FirebaseMessageModelFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  final String chatId;
  @override
  @JsonKey()
  final String messageText;
  @override
  final DateTime sendDate;
  @override
  @JsonKey()
  final IList<String> tagsIds;
  @override
  @JsonKey()
  final IList<String> imagePaths;
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'FirebaseMessageModel(id: $id, chatId: $chatId, messageText: $messageText, sendDate: $sendDate, tagsIds: $tagsIds, imagePaths: $imagePaths, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirebaseMessageModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.messageText, messageText) ||
                other.messageText == messageText) &&
            (identical(other.sendDate, sendDate) ||
                other.sendDate == sendDate) &&
            const DeepCollectionEquality().equals(other.tagsIds, tagsIds) &&
            const DeepCollectionEquality()
                .equals(other.imagePaths, imagePaths) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      chatId,
      messageText,
      sendDate,
      const DeepCollectionEquality().hash(tagsIds),
      const DeepCollectionEquality().hash(imagePaths),
      isFavorite);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirebaseMessageModelCopyWith<_$_FirebaseMessageModel> get copyWith =>
      __$$_FirebaseMessageModelCopyWithImpl<_$_FirebaseMessageModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirebaseMessageModelToJson(
      this,
    );
  }
}

abstract class _FirebaseMessageModel implements FirebaseMessageModel {
  const factory _FirebaseMessageModel(
      {final String id,
      required final String chatId,
      final String messageText,
      required final DateTime sendDate,
      final IList<String> tagsIds,
      final IList<String> imagePaths,
      final bool isFavorite}) = _$_FirebaseMessageModel;

  factory _FirebaseMessageModel.fromJson(Map<String, dynamic> json) =
      _$_FirebaseMessageModel.fromJson;

  @override
  String get id;
  @override
  String get chatId;
  @override
  String get messageText;
  @override
  DateTime get sendDate;
  @override
  IList<String> get tagsIds;
  @override
  IList<String> get imagePaths;
  @override
  bool get isFavorite;
  @override
  @JsonKey(ignore: true)
  _$$_FirebaseMessageModelCopyWith<_$_FirebaseMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
