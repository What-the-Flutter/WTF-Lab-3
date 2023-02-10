import 'dart:io';

import 'package:intl/intl.dart';

class PackedMessage {
  final DateTime _createTime = DateTime.now();
  final DateFormat formatter = DateFormat('Hm');
  final String? _textData;
  final File? _imageData;
  final bool isDone = false;
  final bool isFavorite = false;

  PackedMessage({textData, imageData, createTime, isDone, isFavorite})
      : _textData = textData,
        _imageData = imageData;

  String? get textData => _textData;

  File? get imageData => _imageData;

  String get createTime => formatter.format(_createTime);

  PackedMessage copyWith(
      {String? textMessage, bool? isDone, bool? isFavorite}) {
    return PackedMessage(
      textData: textMessage ?? _textData,
      imageData: _imageData,
      createTime: _createTime,
      isDone: isDone ?? this.isDone,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  PackedMessage updateDoneState(PackedMessage oldState, bool isDone){
    return oldState.copyWith(isDone: isDone);
  }

  PackedMessage updateFavoriteState(PackedMessage oldState, bool isFavorite){
    return oldState.copyWith(isFavorite: isFavorite);
  }

  PackedMessage updateTextData(PackedMessage oldState, String text){
    return oldState.copyWith(textMessage: text);
  }
}
