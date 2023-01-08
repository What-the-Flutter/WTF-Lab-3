import 'package:flutter/material.dart';

class ChatField {
  static final String id = 'id';
  static final String title = 'title';
  static final String icon = 'icon';
  static final String dateCreate = 'dateCreate';
  static final String pin = 'pin';
}

class Chat {
  final int? id;
  final Icon icon;
  final String title;
  final bool isPin;
  // final List<Event>? listEvent;
  final DateTime dateCreate;

  Chat({
    this.id,
    required this.icon,
    required this.title,
    required this.isPin,
    // this.listEvent,
    required this.dateCreate,
  });

  Chat copyWith({
    int? id,
    Icon? icon,
    String? title,
    bool? isPin,
    // List<Event>? listEvent,
    DateTime? dateCreate,
  }) {
    return Chat(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      isPin: isPin ?? this.isPin,
      // listEvent: listEvent ?? this.listEvent,
      dateCreate: dateCreate ?? this.dateCreate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '${ChatField.id}': id,
      '${ChatField.title}': title,
      '${ChatField.icon}': icon.icon!.codePoint,
      '${ChatField.pin}': isPin.toString(),
      '${ChatField.dateCreate}': dateCreate.toString(),
    };
  }
}
