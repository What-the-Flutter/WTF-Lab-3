// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Event',
      json,
      ($checkedConvert) {
        final val = Event(
          id: $checkedConvert('id', (v) => v as String?),
          content: $checkedConvert('content', (v) => v as String?),
          isFavorite: $checkedConvert('is_favorite',
              (v) => const BooleanConverter().fromJson(v as int)),
          changeTime: $checkedConvert(
              'change_time', (v) => DateTime.parse(v as String)),
          chatId: $checkedConvert('chat_id', (v) => v as String),
          categoryId: $checkedConvert('category_id', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'isFavorite': 'is_favorite',
        'changeTime': 'change_time',
        'chatId': 'chat_id',
        'categoryId': 'category_id'
      },
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'change_time': instance.changeTime.toIso8601String(),
      'chat_id': instance.chatId,
      'category_id': instance.categoryId,
      'is_favorite': const BooleanConverter().toJson(instance.isFavorite),
    };
