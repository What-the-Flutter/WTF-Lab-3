import 'package:flutter/material.dart';

import 'event.dart';

/// Contains all events from group
class Chat {
  final IconData icon;
  final String name;
  final List<Event> events;
  final DateTime createdTime;

  const Chat({
    required this.icon,
    required this.name,
    required this.createdTime,
    this.events = const <Event>[],
  });

  Chat copyWith({
    IconData? icon,
    String? name,
    List<Event>? events,
    DateTime? createdTime,
  }) {
    return Chat(
      icon: icon ?? this.icon,
      name: name ?? this.name,
      events: events ?? this.events,
      createdTime: createdTime ?? this.createdTime,
    );
  }
}
