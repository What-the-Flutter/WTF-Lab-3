// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_converter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageTags _$MessageTagsFromJson(Map<String, dynamic> json) => MessageTags(
      IList<int>.fromJson(json['tagsIds'], (value) => value as int),
      IList<String>.fromJson(json['tagsTitles'], (value) => value as String),
      IList<int>.fromJson(json['tagsIcons'], (value) => value as int),
    );

Map<String, dynamic> _$MessageTagsToJson(MessageTags instance) =>
    <String, dynamic>{
      'tagsIds': instance.tagsIds.toJson(
        (value) => value,
      ),
      'tagsTitles': instance.tagsTitles.toJson(
        (value) => value,
      ),
      'tagsIcons': instance.tagsIcons.toJson(
        (value) => value,
      ),
    };
