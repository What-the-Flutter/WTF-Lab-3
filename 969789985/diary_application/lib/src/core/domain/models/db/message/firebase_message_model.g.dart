// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirebaseMessageModel _$$_FirebaseMessageModelFromJson(
        Map<String, dynamic> json) =>
    _$_FirebaseMessageModel(
      id: json['id'] as String? ?? '_id',
      chatId: json['chatId'] as String,
      messageText: json['messageText'] as String? ?? '_message_text',
      sendDate: DateTime.parse(json['sendDate'] as String),
      tagsIds: json['tagsIds'] == null
          ? const IListConst([])
          : IList<String>.fromJson(json['tagsIds'], (value) => value as String),
      imagePaths: json['imagePaths'] == null
          ? const IListConst([])
          : IList<String>.fromJson(
              json['imagePaths'], (value) => value as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$_FirebaseMessageModelToJson(
        _$_FirebaseMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'messageText': instance.messageText,
      'sendDate': instance.sendDate.toIso8601String(),
      'tagsIds': instance.tagsIds.toJson(
        (value) => value,
      ),
      'imagePaths': instance.imagePaths.toJson(
        (value) => value,
      ),
      'isFavorite': instance.isFavorite,
    };
