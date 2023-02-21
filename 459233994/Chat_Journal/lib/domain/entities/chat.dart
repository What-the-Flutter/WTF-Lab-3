import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'event.dart';

class Chat {
  final String name;
  final DateTime _createTime = DateTime.now();
  final DateFormat formatter = DateFormat('yMd');
  final IconData pageIcon;
  final bool isPinned;
  final List<Event> events = <Event>[];

  Chat({
    required this.name,
    required this.pageIcon,
    pinnedState,
    events,
  }) : isPinned = pinnedState ?? false;

  String get createTime => formatter.format(_createTime);

  Chat copyWith({String? name, IconData? pageIcon, bool? isPinned}) {
    return Chat(
      name: name ?? this.name,
      pageIcon: pageIcon ?? this.pageIcon,
      pinnedState: isPinned ?? this.isPinned,
      events: events,
    );
  }
}
