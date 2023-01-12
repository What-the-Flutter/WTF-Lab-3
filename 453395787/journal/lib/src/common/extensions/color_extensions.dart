import 'dart:math';

import 'package:flutter/material.dart';

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
