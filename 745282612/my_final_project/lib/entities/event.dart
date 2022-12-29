import 'package:flutter/material.dart';

class Event {
  final bool isFavorit;
  final bool isSelected;
  final String messageContent;
  final String messageType;
  final DateTime messageTime;
  final Image? messageImage;

  Event({
    required this.messageContent,
    required this.messageType,
    required this.messageTime,
    required this.isFavorit,
    required this.isSelected,
    this.messageImage,
  });

  Event copyWith({
    bool? isFavorit,
    bool? isSelected,
    String? messageContent,
    String? messageType,
    DateTime? messageTime,
    Image? messageImage,
  }) {
    return Event(
      isFavorit: isFavorit ?? this.isFavorit,
      isSelected: isSelected ?? this.isSelected,
      messageContent: messageContent ?? this.messageContent,
      messageType: messageType ?? this.messageType,
      messageTime: messageTime ?? this.messageTime,
      messageImage: messageImage ?? this.messageImage,
    );
  }
}
