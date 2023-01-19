import 'package:flutter/cupertino.dart';

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
}
