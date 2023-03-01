import 'package:flutter/material.dart';

class EventCardModel {
  String title;
  DateTime time;
  bool isFavourite;
  bool isLongPress;
  bool isSelectionMode;

  Key id;

  EventCardModel({
    required this.title,
    required this.time,
    required this.id,
    this.isFavourite = false,
    this.isLongPress = false,
    this.isSelectionMode = false,
  });
}
