// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images_converter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageImages _$MessageImagesFromJson(Map<String, dynamic> json) =>
    MessageImages(
      IList<String>.fromJson(json['paths'], (value) => value as String),
    );

Map<String, dynamic> _$MessageImagesToJson(MessageImages instance) =>
    <String, dynamic>{
      'paths': instance.paths.toJson(
        (value) => value,
      ),
    };
