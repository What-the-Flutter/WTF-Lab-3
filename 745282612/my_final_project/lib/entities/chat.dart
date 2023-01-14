import 'package:flutter/material.dart';

class ChatField {
  static final String id = 'id';
  static final String title = 'title';
  static final String icon = 'icon';
  static final String dateCreate = 'dateCreate';
  static final String pin = 'pin';
}

class Chat {
  final int id;
  final Icon icon;
  final String title;
  final bool isPin;
  final DateTime dateCreate;

  Chat({
    required this.id,
    required this.icon,
    required this.title,
    required this.isPin,
    required this.dateCreate,
  });

  Chat copyWith({
    int? id,
    Icon? icon,
    String? title,
    bool? isPin,
    DateTime? dateCreate,
  }) {
    return Chat(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      isPin: isPin ?? this.isPin,
      dateCreate: dateCreate ?? this.dateCreate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '${ChatField.id}': id,
      '${ChatField.title}': title,
      '${ChatField.icon}': icon.icon!.codePoint,
      '${ChatField.pin}': isPin,
      '${ChatField.dateCreate}': dateCreate.toString(),
    };
  }

  static Chat fromJson(Map<dynamic, dynamic> map) {
    return Chat(
      id: map['${ChatField.id}'],
      title: map['${ChatField.title}'],
      icon: Icon(IconData(map['${ChatField.icon}'], fontFamily: 'MaterialIcons')),
      dateCreate: DateTime.parse(map['${ChatField.dateCreate}']),
      isPin: map['${ChatField.pin}'] == true,
    );
  }
}
