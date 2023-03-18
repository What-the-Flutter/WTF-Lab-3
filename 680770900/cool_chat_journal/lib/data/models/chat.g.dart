// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Chat',
      json,
      ($checkedConvert) {
        final val = Chat(
          id: $checkedConvert('id', (v) => v as String),
          iconCode: $checkedConvert('icon_code', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          createdTime: $checkedConvert(
              'created_time', (v) => DateTime.parse(v as String)),
          isPinned: $checkedConvert(
              'is_pinned', (v) => const BooleanConverter().fromJson(v as int)),
        );
        return val;
      },
      fieldKeyMap: const {
        'iconCode': 'icon_code',
        'createdTime': 'created_time',
        'isPinned': 'is_pinned'
      },
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'icon_code': instance.iconCode,
      'name': instance.name,
      'created_time': instance.createdTime.toIso8601String(),
      'is_pinned': const BooleanConverter().toJson(instance.isPinned),
    };
