import 'package:json_annotation/json_annotation.dart';

import '../json_kit.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  final String id;
  final int count;

  const Tag({
    required this.id,
    required this.count,
  });

  factory Tag.fromJson(JsonMap json) => _$TagFromJson(json);

  JsonMap toJson() => _$TagToJson(this);

  Tag copyWith({
    String? id,
    int? count,
  }) =>
      Tag(
        id: id ?? this.id,
        count: count ?? this.count,
      );
}
