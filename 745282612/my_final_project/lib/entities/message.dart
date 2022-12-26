import 'package:flutter/material.dart';

class Message {
  bool isFavorit = false;
  bool isSelected = false;
  bool isDay = false;
  String messageContent;
  String messageType;
  DateTime messageTime;
  Image? messageImage;
  Message({
    required this.messageContent,
    required this.messageType,
    required this.messageTime,
    this.messageImage,
  });
}
