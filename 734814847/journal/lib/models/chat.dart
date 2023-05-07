import 'package:flutter/material.dart';
import 'event.dart';

class Chat {
  String name;
  final IconData icon;
  List<Event>? events;

  Chat({required this.name, required this.icon, this.events});
}
