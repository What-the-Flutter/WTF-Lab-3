// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Category',
      json,
      ($checkedConvert) {
        final val = Category(
          id: $checkedConvert('id', (v) => v as String?),
          title: $checkedConvert('title', (v) => v as String),
          icon: $checkedConvert('icon', (v) => v as int),
          isCustom: $checkedConvert(
              'is_custom', (v) => const BooleanConverter().fromJson(v as int)),
        );
        return val;
      },
      fieldKeyMap: const {'isCustom': 'is_custom'},
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'is_custom': const BooleanConverter().toJson(instance.isCustom),
    };
