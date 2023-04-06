import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../data/models/theme_enums.dart';

class CustomTheme extends InheritedWidget {
  final ThemeData themeData;
  final ThemeType themeType;
  final BubbleAlignmentType bubbleAlignmentType;
  final FontSizeType fontSizeType;
  final Uint8List? backgroundImage;

  const CustomTheme({
    super.key,
    required super.child,
    required this.themeData,
    required this.themeType,
    required this.bubbleAlignmentType,
    required this.fontSizeType,
    required this.backgroundImage,
  });

  static CustomTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomTheme>();
  }

  static CustomTheme of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No CustomTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CustomTheme oldWidget) {
    return themeData != oldWidget.themeData ||
        themeType != oldWidget.themeType ||
        bubbleAlignmentType != oldWidget.bubbleAlignmentType ||
        fontSizeType != oldWidget.fontSizeType;
  }
}
