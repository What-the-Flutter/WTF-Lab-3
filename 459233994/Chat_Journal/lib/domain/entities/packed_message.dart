import 'package:intl/intl.dart';

import 'image_message.dart';
import 'text_message.dart';


class PackedMessage{
  final DateTime _createTime = DateTime.now();
  final DateFormat formatter = DateFormat('Hm');
  final TextMessage? _textMessage;
  final ImageMessage? _imageMessage;
  bool isDone = false;
  bool isFavorite = false;

  PackedMessage({textMessage, imageMessage}) : _textMessage = textMessage, _imageMessage = imageMessage;

  TextMessage? get textMessage => _textMessage;
  ImageMessage? get imageMessage => _imageMessage;
  String get createTime => formatter.format(_createTime);
}