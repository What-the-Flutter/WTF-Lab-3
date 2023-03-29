import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../json_kit.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final String id;
  final int iconCode;
  final String name;
  final DateTime createdTime;

  @BooleanConverter()
  final bool isPinned;

  Chat({
    String? id,
    required this.iconCode,
    required this.name,
    required this.createdTime,
    required this.isPinned,
  }) : id = id ?? const Uuid().v4();

  factory Chat.fromJson(JsonMap json) => _$ChatFromJson(json);

  JsonMap toJson() => _$ChatToJson(this);

  Chat copyWith({
    String? id,
    int? iconCode,
    String? name,
    DateTime? createdTime,
    bool? isPinned,
  }) =>
      Chat(
        id: id ?? this.id,
        iconCode: iconCode ?? this.iconCode,
        name: name ?? this.name,
        createdTime: createdTime ?? this.createdTime,
        isPinned: isPinned ?? this.isPinned,
      );
}
