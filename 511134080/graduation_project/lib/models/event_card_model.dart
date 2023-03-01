import 'package:flutter/material.dart';

class EventCardModel {
  String title;
  DateTime time;
  bool isFavourite;
  bool isSelected;
  bool isSelectionMode;

  Key id;

  EventCardModel({
    required this.title,
    required this.time,
    required this.id,
    this.isFavourite = false,
    this.isSelected = false,
    this.isSelectionMode = false,
  });
}
