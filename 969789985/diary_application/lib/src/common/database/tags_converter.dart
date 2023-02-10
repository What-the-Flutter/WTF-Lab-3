import 'dart:convert';
import 'dart:developer' as dev;
import 'package:drift/drift.dart';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'tags_converter.g.dart';

@j.JsonSerializable()
class MessageTags {
  final IList<int> tagsIds;
  final IList<String> tagsTitles;
  final IList<int> tagsIcons;

  const MessageTags(
    this.tagsIds,
    this.tagsTitles,
    this.tagsIcons,
  );

  factory MessageTags.fromJson(Map<String, dynamic> json) =>
      _$MessageTagsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageTagsToJson(this);
}

class TagsConverter extends TypeConverter<MessageTags, String> {
  const TagsConverter();

  @override
  MessageTags fromSql(String fromDb) {
    dev.log('In json: $fromDb', name: 'Converting_maps');
    return MessageTags.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(MessageTags value) {
    return json.encode(value.toJson());
  }
}
