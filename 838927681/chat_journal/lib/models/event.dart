import 'package:flutter/material.dart';

class Event {
  String text;
  final Image? image;
  final IconData? icon;
  final DateTime dateTime;
  bool isFavorite = false;

  Event({required this.text, required this.dateTime, this.image, this.icon});
}
