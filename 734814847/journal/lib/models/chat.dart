import 'package:flutter/material.dart';

import '../widgets/event_widget.dart';

class Chat {
  String name;
  final IconData icon;
  List<Widget> events;

  Chat({required this.name, required this.icon, required this.events});
}
