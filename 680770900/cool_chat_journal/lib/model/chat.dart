import 'package:flutter/material.dart';

import 'event.dart';

/// Contains all events from group
class Chat {
  final IconData icon;
  final String name;
  final List<Event> events;
  final DateTime createdTime;

  Chat({
    required this.icon,
    required this.name,
    required this.events,
    required this.createdTime,
  });

  Chat.withoutEvents({
    required this.icon,
    required this.name,
    required this.createdTime,
  }) : events = <Event>[];

  Chat copyWith({
    IconData? icon,
    String? name,
    List<Event>? events,
    DateTime? createdTime,
    DateTime? latestEventTime,
    bool? isPinned,
  }) {
    return Chat(
      icon: icon ?? this.icon,
      name: name ?? this.name,
      events: events ?? this.events,
      createdTime: createdTime ?? this.createdTime,
    );
  }
}
