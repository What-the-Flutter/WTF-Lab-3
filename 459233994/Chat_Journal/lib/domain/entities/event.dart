import 'package:flutter/material.dart';

class Event {
  final String? id;
  final String chatId;
  final DateTime createTime;
  final String? textData;
  final String? imageData;
  final IconData? category;
  final bool isDone;
  final bool isFavorite;

  Event({
    required this.chatId,
    this.textData,
    this.imageData,
    this.category,
    this.id,
    createTime,
    isDone,
    isFavorite,
  })  : isDone = isDone ?? false,
        isFavorite = isFavorite ?? false,createTime = (createTime != null) ? createTime : DateTime.now();


  Event copyWith({String? id,String? textMessage, bool? isDone, bool? isFavorite}) {
    return Event(
      id: id ?? this.id,
      chatId: chatId,
      textData: textMessage ?? textData,
      imageData: imageData,
      category: category,
      createTime: createTime,
      isDone: isDone ?? this.isDone,
      isFavorite: isFavorite ?? this.isFavorite,
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
