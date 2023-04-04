import 'package:flutter/material.dart';

class Event {
  final String? id;
  final String chatId;
  final DateTime createTime;
  final String? textData;
  final String? imageData;
  final IconData? category;
  final List<String>? tags;
  final bool isDone;
  final bool isFavorite;

  Event({
    required this.chatId,
    this.textData,
    this.imageData,
    this.category,
    this.id,
    tags,
    createTime,
    isDone,
    isFavorite,
  })  : isDone = isDone ?? false,
        isFavorite = isFavorite ?? false,
        tags = tags ?? <String>[],
        createTime = (createTime != null) ? createTime : DateTime.now();

  Event copyWith({
    String? id,
    String? textMessage,
    bool? isDone,
    bool? isFavorite,
    IconData? category,
    List<String>? tags,
  }) {
    return Event(
      id: id ?? this.id,
      chatId: chatId,
      textData: textMessage ?? textData,
      imageData: imageData,
      category: category ?? this.category,
      createTime: createTime,
      isDone: isDone ?? this.isDone,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
    );
  }

  Event updateDoneState(Event oldState, bool isDone) {
    return oldState.copyWith(isDone: isDone);
  }

  Event updateFavoriteState(Event oldState, bool isFavorite) {
    return oldState.copyWith(isFavorite: isFavorite);
  }

  Event updateTextData(Event oldState, String text) {
    return oldState.copyWith(textMessage: text);
  }
}
