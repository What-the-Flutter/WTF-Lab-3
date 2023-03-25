import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'json_kit.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  final String id;
  final String value;
  final int count;

  Tag({
    String? id,
    required this.value,
    required this.count,
  }) : id = id ?? const Uuid().v4();

  factory Tag.fromJson(JsonMap json) => _$TagFromJson(json);

  JsonMap toJson() => _$TagToJson(this);

  Tag copyWith({
    String? id,
    String? value,
    int? count,
  }) => 
      Tag(
        id: id ?? this.id,
        value: value ?? this.value,
        count: count ?? this.count,
      );
}