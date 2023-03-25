// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeInfo _$ThemeInfoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ThemeInfo',
      json,
      ($checkedConvert) {
        final val = ThemeInfo(
          themeType: $checkedConvert('theme_type', (v) => v as String),
          fontSize: $checkedConvert('font_size', (v) => v as String),
          bubbleAlignment:
              $checkedConvert('bubble_alignment', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'themeType': 'theme_type',
        'fontSize': 'font_size',
        'bubbleAlignment': 'bubble_alignment'
      },
    );

Map<String, dynamic> _$ThemeInfoToJson(ThemeInfo instance) => <String, dynamic>{
      'theme_type': instance.themeType,
      'font_size': instance.fontSize,
      'bubble_alignment': instance.bubbleAlignment,
    };
