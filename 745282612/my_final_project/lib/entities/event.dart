import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventField {
  static final String id = 'id';
  static final String messageContent = 'content';
  static final String messageType = 'type';
  static final String messageTime = 'timeCreate';
  static final String favorite = 'favorite';
  static final String sectionTitle = 'sectionTitle';
  static final String sectionIcon = 'sectionIcon';
  static final String messageImage = 'image';
  static final String chatId = 'chatId';
}

class Event {
  final int? id;
  final bool isFavorit;
  final bool isSelected;
  final String messageContent;
  final String messageType;
  final DateTime messageTime;
  final File? messageImage;
  final IconData? sectionIcon;
  final String? sectionTitle;
  final int chatId;

  Event({
    this.id,
    required this.messageContent,
    required this.messageType,
    required this.messageTime,
    this.isFavorit = false,
    this.isSelected = false,
    required this.chatId,
    this.messageImage,
    this.sectionIcon,
    this.sectionTitle,
  });

  Event copyWith({
    int? id,
    bool? isFavorit,
    bool? isSelected,
    String? messageContent,
    String? messageType,
    DateTime? messageTime,
    File? messageImage,
    IconData? sectionIcon,
    String? sectionTitle,
    int? chatId,
  }) {
    return Event(
      id: id ?? this.id,
      isFavorit: isFavorit ?? this.isFavorit,
      isSelected: isSelected ?? this.isSelected,
      messageContent: messageContent ?? this.messageContent,
      messageType: messageType ?? this.messageType,
      messageTime: messageTime ?? this.messageTime,
      messageImage: messageImage ?? this.messageImage,
      sectionIcon: sectionIcon ?? this.sectionIcon,
      sectionTitle: sectionTitle ?? this.sectionTitle,
      chatId: chatId ?? this.chatId,
    );
  }

  String _base64String(Uint8List data) {
    return base64Encode(data);
  }

  Map<String, dynamic> toMap() {
    return {
      '${EventField.id}': id,
      '${EventField.messageContent}': messageContent,
      '${EventField.messageType}': messageType,
      '${EventField.messageTime}': messageTime.toString(),
      '${EventField.favorite}': isFavorit.toString(),
      '${EventField.sectionTitle}': sectionTitle,
      '${EventField.sectionIcon}': sectionIcon != null ? sectionIcon!.codePoint : null,
      '${EventField.chatId}': chatId,
      '${EventField.messageImage}': messageImage != null ? messageImage!.path : null,
    };
  }
}
