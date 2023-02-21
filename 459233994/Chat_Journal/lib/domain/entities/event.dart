import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  final DateTime _createTime = DateTime.now();
  final DateFormat formatter = DateFormat('Hm');
  final String? textData;
  final File? imageData;
  final IconData? category;
  final bool isDone;
  final bool isFavorite;

  Event({
    this.textData,
    this.imageData,
    this.category,
    createTime,
    isDone,
    isFavorite,
  })  : isDone = isDone ?? false,
        isFavorite = isFavorite ?? false;

  String get createTime => formatter.format(_createTime);

  Event copyWith({String? textMessage, bool? isDone, bool? isFavorite}) {
    return Event(
      textData: textMessage ?? textData,
      imageData: imageData,
      category: category,
      createTime: _createTime,
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
