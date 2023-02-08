import 'dart:convert';
import 'dart:developer' as dev;
import 'package:drift/drift.dart';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'images_converter.g.dart';

@j.JsonSerializable()
class MessageImages {
  IList<String> paths;

  MessageImages(this.paths);

  factory MessageImages.fromJson(Map<String, dynamic> json) =>
      _$MessageImagesFromJson(json);

  Map<String, dynamic> toJson() => _$MessageImagesToJson(this);
}

class ImagesConverter extends TypeConverter<MessageImages, String> {
  const ImagesConverter();

  @override
  MessageImages fromSql(String fromDb) {
    dev.log('In json: $fromDb', name: 'Converting_maps');
    return MessageImages.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(MessageImages value) {
    return json.encode(value.toJson());
  }
}