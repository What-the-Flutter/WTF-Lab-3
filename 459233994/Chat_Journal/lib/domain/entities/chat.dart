import 'package:flutter/material.dart';

import 'event.dart';

class Chat {
  final String? id;
  final String name;
  final DateTime createTime;
  final IconData pageIcon;
  final bool isPinned;
  final List<Event> events = <Event>[];

  Chat({
    required this.name,
    required this.pageIcon,
    pinnedState,
    events,
    createTime,
    this.id,
  })  : isPinned = pinnedState ?? false,
        createTime = (createTime != null) ? createTime : DateTime.now();

  Chat copyWith({String? id,String? name, IconData? pageIcon, bool? isPinned}) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      pageIcon: pageIcon ?? this.pageIcon,
      pinnedState: isPinned ?? this.isPinned,
      events: events,
      createTime: createTime,
    );
  }
}
