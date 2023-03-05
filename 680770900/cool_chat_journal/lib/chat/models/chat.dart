import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'event.dart';

class Chat extends Equatable {
  static final empty = Chat(
    icon: Icons.note_outlined,
    name: '--',
    createdTime: DateTime(0),
  );

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
    int? id,
    IconData? icon,
    String? name,
    List<Event>? events,
    DateTime? createdTime,
    bool? isPinned,
  }) {
    return Chat(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      events: events ?? this.events,
      createdTime: createdTime ?? this.createdTime,
      isPinned: isPinned ?? this.isPinned,
    );
  }
  
  @override
  List<Object?> get props =>
    [id, icon, name, events, createdTime, isPinned];
}
