import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entities/event.dart';

class EventDTO {
  final int? id;
  final int chatId;
  final DateTime createTime;
  final String? textData;
  final File? imageData;
  final IconData? category;
  final bool isDone;
  final bool isFavorite;

  EventDTO({
    this.id,
    required this.chatId,
    required this.createTime,
    required this.isDone,
    required this.isFavorite,
    this.textData,
    this.imageData,
    this.category,
  });

  factory EventDTO.fromJSON(Map<String, dynamic> json) {
    return EventDTO(
      id: json['event_id'],
      chatId: json['chat_id'],
      createTime: DateTime.parse(json['create_time']),
      isDone: json['is_done'] == 0 ? false : true,
      isFavorite: json['is_favorite'] == 0 ? false : true,
      textData: json['text_data'],
      imageData: json['image_data'] == null ? null : File(json['image_data']),
      category: json['category'] == null ? null : IconData(
        int.parse(json['category']),
        fontFamily: 'MaterialIcons',
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'create_time': createTime.toString(),
        'chat_id': chatId,
        'is_done': isDone ? 1 : 0,
        'is_favorite': isFavorite ? 1 : 0,
        'text_data': textData,
        'image_data': imageData?.path,
        'category': category?.codePoint,
      };

  Event toModel() {
    return Event(
      id: id,
      chatId: chatId,
      createTime: createTime,
      textData: textData,
      imageData: imageData,
      category: category,
      isDone: isDone,
      isFavorite: isFavorite,
    );
  }
}
