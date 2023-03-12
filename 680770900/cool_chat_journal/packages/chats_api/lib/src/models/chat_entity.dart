import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'chat_entity.g.dart';

@JsonSerializable()
class ChatEntity extends Equatable {
  final String id;
  final int icon;
  final String name;
  final DateTime createdTime;
  final bool isPinned;

  ChatEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdTime,
    required this.isPinned,
  });

  factory ChatEntity.fromJson(JsonMap json) => _$ChatEntityFromJson(json);

  JsonMap toJson() => _$ChatEntityToJson(this);

  ChatEntity copyWith({
    String? id,
    int? icon,
    String? name,
    DateTime? createdTime,
    bool? isPinned,
  }) =>
      ChatEntity(
        id: id ?? this.id,
        icon: icon ?? this.icon,
        name: name ?? this.name,
        createdTime: createdTime ?? this.createdTime,
        isPinned: isPinned ?? this.isPinned,
      );

  @override
  List<Object?> get props => [
        id,
        icon,
        name,
        createdTime,
        isPinned,
      ];
}
