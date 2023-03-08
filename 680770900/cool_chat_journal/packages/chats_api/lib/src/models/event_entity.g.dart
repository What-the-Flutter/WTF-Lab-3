// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventEntity _$EventEntityFromJson(Map<String, dynamic> json) => $checkedCreate(
      'EventEntity',
      json,
      ($checkedConvert) {
        final val = EventEntity(
          id: $checkedConvert('id', (v) => v as String),
          chatId: $checkedConvert('chat_id', (v) => v as String),
          content: $checkedConvert('content', (v) => v as String),
          isImage: $checkedConvert('is_image', (v) => v as bool),
          isFavorite: $checkedConvert('is_favorite', (v) => v as bool),
          changeTime: $checkedConvert(
              'change_time', (v) => DateTime.parse(v as String)),
          category: $checkedConvert('category', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'chatId': 'chat_id',
        'isImage': 'is_image',
        'isFavorite': 'is_favorite',
        'changeTime': 'change_time'
      },
    );

Map<String, dynamic> _$EventEntityToJson(EventEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chatId,
      'content': instance.content,
      'is_image': instance.isImage,
      'is_favorite': instance.isFavorite,
      'change_time': instance.changeTime.toIso8601String(),
      'category': instance.category,
    };
