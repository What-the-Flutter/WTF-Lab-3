// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CategoryEntity',
      json,
      ($checkedConvert) {
        final val = CategoryEntity(
          id: $checkedConvert('id', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          icon: $checkedConvert('icon', (v) => v as int),
          isCustom: $checkedConvert('is_custom', (v) => (v as int) != 0),
        );
        return val;
      },
      fieldKeyMap: const {'isCustom': 'is_custom'},
    );

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'is_custom': instance.isCustom ? 1 : 0,
    };
