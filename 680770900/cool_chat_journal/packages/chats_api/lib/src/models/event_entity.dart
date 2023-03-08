import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'event_entity.g.dart';

@immutable
@JsonSerializable()
class EventEntity extends Equatable {
  final String id;
  final String chatId;
  final String content;
  final bool isImage;
  final bool isFavorite;
  final DateTime changeTime;
  final String? category;

  EventEntity({
    required this.id,
    required this.chatId,
    required this.content,
    required this.isImage,
    required this.isFavorite,
    required this.changeTime,
    required this.category,
  });

  factory EventEntity.fromJson(JsonMap json) => _$EventEntityFromJson(json);  

  JsonMap toJson() => _$EventEntityToJson(this);

  EventEntity copyWith({
    String? id,
    String? chatId,
    String? content,
    bool? isImage,
    bool? isFavorite,
    DateTime? changeTime,
    String? category,
  }) => EventEntity(
    id: id ?? this.id,
    chatId: chatId ?? this.chatId,
    content: content ?? this.content,
    isImage: isImage ?? this.isImage,
    isFavorite: isFavorite ?? this.isFavorite,
    changeTime: changeTime ?? this.changeTime,
    category: category ?? this.category,
  );
  
  @override
  List<Object?> get props => [
    id,
    chatId,
    content,
    isImage,
    isFavorite,
    changeTime,
    category,
  ];
}
