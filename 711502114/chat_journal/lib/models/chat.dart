import 'package:flutter/material.dart';

import 'event.dart';

class Chat {
  final String title;
  final List<Event> events;
  final IconData iconData;
  final DateTime creationTime;
  final bool isPin;

  Chat({
    required this.title,
    required this.events,
    required this.iconData,
    required this.creationTime,
    this.isPin = false,
  });

  Chat copyWith({String? title, IconData? iconData, bool? isPin}) {
    return Chat(
      title: title ?? this.title,
      events: events,
      iconData: iconData ?? this.iconData,
      creationTime: creationTime,
      isPin: isPin ?? this.isPin,
    );
  }
}
