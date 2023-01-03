import 'package:flutter/material.dart';

class Event {
  final bool isFavorit;
  final bool isSelected;
  final String messageContent;
  final String messageType;
  final DateTime messageTime;
  final Image? messageImage;
  final IconData? sectionIcon;
  final String? sectionTitle;

  Event({
    required this.messageContent,
    required this.messageType,
    required this.messageTime,
    required this.isFavorit,
    required this.isSelected,
    this.messageImage,
    this.sectionIcon,
    this.sectionTitle,
  });

  Event copyWith({
    bool? isFavorit,
    bool? isSelected,
    String? messageContent,
    String? messageType,
    DateTime? messageTime,
    Image? messageImage,
    IconData? sectionIcon,
    String? sectionTitle,
  }) {
    return Event(
      isFavorit: isFavorit ?? this.isFavorit,
      isSelected: isSelected ?? this.isSelected,
      messageContent: messageContent ?? this.messageContent,
      messageType: messageType ?? this.messageType,
      messageTime: messageTime ?? this.messageTime,
      messageImage: messageImage ?? this.messageImage,
      sectionIcon: sectionIcon ?? this.sectionIcon,
      sectionTitle: sectionTitle ?? this.sectionTitle,
    );
  }
}
