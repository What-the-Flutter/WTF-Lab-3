import 'package:equatable/equatable.dart';
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
  static final String isSelected = 'isSelected';
}

class Event extends Equatable {
  final int id;
  final bool isFavorit;
  final bool isSelected;
  final String messageContent;
  final String messageType;
  final DateTime messageTime;
  final String? messageImage;
  final IconData? sectionIcon;
  final String? sectionTitle;
  final int chatId;

  Event({
    required this.id,
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
    String? messageImage,
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

  Map<String, dynamic> toMap() {
    return {
      '${EventField.id}': id,
      '${EventField.messageContent}': messageContent,
      '${EventField.messageType}': messageType,
      '${EventField.messageTime}': messageTime.toIso8601String(),
      '${EventField.favorite}': isFavorit.toString(),
      '${EventField.sectionTitle}': sectionTitle,
      '${EventField.sectionIcon}': sectionIcon != null ? sectionIcon!.codePoint : null,
      '${EventField.chatId}': chatId,
      '${EventField.messageImage}': messageImage != null ? messageImage! : null,
      '${EventField.isSelected}': isSelected == false ? 1 : 0,
    };
  }

  static Event fromJson(Map<dynamic, dynamic> map) {
    return Event(
      id: map['${EventField.id}'],
      messageContent: map['${EventField.messageContent}'],
      messageType: map['${EventField.messageType}'],
      messageTime: DateTime.parse(map['${EventField.messageTime}']),
      isFavorit: map['${EventField.favorite}'] == 'true',
      chatId: map['${EventField.chatId}'],
      messageImage: map['${EventField.messageImage}'],
      sectionIcon: map['${EventField.sectionIcon}'] != null
          ? IconData(map['${EventField.sectionIcon}'], fontFamily: 'MaterialIcons')
          : null,
      sectionTitle: map['${EventField.sectionTitle}'],
      isSelected: map[EventField.isSelected] == 1 ? false : true,
    );
  }

  @override
  List<Object?> get props => [
        id,
        isFavorit,
        isSelected,
        messageContent,
        messageType,
        messageTime,
        messageImage,
        sectionIcon,
        sectionTitle,
        chatId,
      ];
}
