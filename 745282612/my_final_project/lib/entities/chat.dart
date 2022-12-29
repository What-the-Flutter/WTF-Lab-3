import 'package:flutter/material.dart';

import 'package:my_final_project/entities/event.dart';

class Chat {
  final Icon icon;
  final String title;
  final bool isPin;
  final List<Event> listEvent;
  final DateTime dateCreate;
  Chat({
    required this.icon,
    required this.title,
    required this.isPin,
    required this.listEvent,
    required this.dateCreate,
  });

  Chat copyWith({
    Icon? icon,
    String? title,
    bool? isPin,
    List<Event>? listEvent,
    DateTime? dateCreate,
  }) {
    return Chat(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      isPin: isPin ?? this.isPin,
      listEvent: listEvent ?? this.listEvent,
      dateCreate: dateCreate ?? this.dateCreate,
    );
  }
}
