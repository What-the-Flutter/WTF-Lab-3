import 'package:flutter/material.dart';

import 'event.dart';

class Chat {
  final String title;
  final List<Event> events;
  final IconData iconData;
  final DateTime creationTime;

  Chat({
    required this.title,
    required this.events,
    required this.iconData,
    required this.creationTime,
  });

  Chat copyWith({String? title, IconData? iconData}) {
    return Chat(
      title: title ?? this.title,
      events: events,
      iconData: iconData ?? this.iconData,
      creationTime: creationTime,
    );
  }
}
