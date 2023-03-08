// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatEntity _$ChatEntityFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ChatEntity',
      json,
      ($checkedConvert) {
        final val = ChatEntity(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          icon: $checkedConvert('icon', (v) => v as int),
          createdTime: $checkedConvert(
              'created_time', (v) => DateTime.parse(v as String)),
          isPinned: $checkedConvert('is_pinned', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdTime': 'created_time',
        'isPinned': 'is_pinned'
      },
    );

Map<String, dynamic> _$ChatEntityToJson(ChatEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name': instance.name,
      'created_time': instance.createdTime.toIso8601String(),
      'is_pinned': instance.isPinned,
    };
