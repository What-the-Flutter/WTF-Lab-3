import 'package:flutter/material.dart';

import 'event.dart';

/// Contains all events from group 
class Chat {
  final Icon icon;
  final String name;
  final List<Event> events;
  final DateTime createdTime;
  final DateTime? latestEventTime;

  Chat({
    required this.icon,
    required this.name,
    required this.events,
    required this.createdTime,
    this.latestEventTime,
  });

  Chat.withoutEvents({
    required this.icon,
    required this.name,
    required this.createdTime,
    this.latestEventTime,
  }) : events = <Event>[];

  Chat copyWith({
    Icon? icon,
    String? name,
    List<Event>? events,
    DateTime? createdTime,
    DateTime? latestEventTime,
  }) {
    return Chat(
      icon: icon ?? this.icon,
      name: name ?? this.name,
      events: events ?? this.events,
      createdTime: createdTime ?? this.createdTime,
      latestEventTime: latestEventTime ?? this.latestEventTime,
    );
  }
}