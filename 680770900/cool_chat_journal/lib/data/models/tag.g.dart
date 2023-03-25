// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Tag',
      json,
      ($checkedConvert) {
        final val = Tag(
          id: $checkedConvert('id', (v) => v as String?),
          value: $checkedConvert('value', (v) => v as String),
          count: $checkedConvert('count', (v) => v as int),
        );
        return val;
      },
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'count': instance.count,
    };
