import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String format(String pattern) => DateFormat(pattern).format(this);

  String get formatMonthDay => format('MMM d');

  String get formatTime => DateFormat.jm().format(this);

  String get formatFullDateTime =>
      DateFormat.yMMMd('en_US').add_jm().format(this);

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension IterableExtensions on Iterable {
  bool containsAll(Iterable other) {
    if (runtimeType == other.runtimeType) {
      for (var item in other) {
        if (!contains(item)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}

extension ColorExtensions on Color {
  Color withBrightness(double value) {
    return Color.fromARGB(
      alpha,
      min(255, (red * value).toInt()),
      min(255, (green * value).toInt()),
      min(255, (blue * value).toInt()),
    );
  }
}

extension StringExtensions on String {
  bool containsIgnoreCase(String part) {
    return toLowerCase().contains(part.toLowerCase());
  }
}
