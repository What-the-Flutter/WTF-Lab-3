// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirebaseChatModel _$$_FirebaseChatModelFromJson(Map<String, dynamic> json) =>
    _$_FirebaseChatModel(
      id: json['id'] as String? ?? '_id',
      chatTitle: json['chatTitle'] as String? ?? '_chat_title',
      chatIcon: json['chatIcon'] as int,
      creationDate: DateTime.parse(json['creationDate'] as String),
      messages: json['messages'] as String? ?? '',
      isPinned: json['isPinned'] as bool? ?? false,
      isArchive: json['isArchive'] as bool? ?? false,
    );

Map<String, dynamic> _$$_FirebaseChatModelToJson(
        _$_FirebaseChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatTitle': instance.chatTitle,
      'chatIcon': instance.chatIcon,
      'creationDate': instance.creationDate.toIso8601String(),
      'messages': instance.messages,
      'isPinned': instance.isPinned,
      'isArchive': instance.isArchive,
    };
