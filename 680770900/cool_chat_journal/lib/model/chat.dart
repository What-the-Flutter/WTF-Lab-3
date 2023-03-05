import 'package:flutter/material.dart';

import 'event.dart';

/// Contains all events from group
class Chat {
  final int id;
  final IconData icon;
  final String name;
  final List<Event> events;
  final DateTime createdTime;
  final bool isPinned;

  const Chat({
    this.id = 0,
    required this.icon,
    required this.name,
    required this.createdTime,
    this.events = const <Event>[],
    this.isPinned = false,
  });

  Chat copyWith({
    IconData? icon,
    String? name,
    List<Event>? events,
    DateTime? createdTime,
    bool? isPinned,
  }) {
    return Chat(
      icon: icon ?? this.icon,
      name: name ?? this.name,
      events: events ?? this.events,
      createdTime: createdTime ?? this.createdTime,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
