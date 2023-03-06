import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final ThemeData theme;
  final bool isLocked;
  final bool bubbleAlignment;
  final String backgroundImage;
  final bool centerDate;
  final TextTheme fontSize;

  const SettingsState({
    required this.theme,
    required this.isLocked,
    required this.backgroundImage,
    required this.bubbleAlignment,
    required this.centerDate,
    required this.fontSize,
  });

  SettingsState copyWith({
    ThemeData? theme,
    bool? isLocked,
    bool? bubbleAlignment,
    String? backgroundImage,
    bool? centerDate,
    TextTheme? fontSize,
  }) {
    return SettingsState(
      theme: theme ?? this.theme,
      isLocked: isLocked ?? this.isLocked,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      bubbleAlignment: bubbleAlignment ?? this.bubbleAlignment,
      centerDate: centerDate ?? this.centerDate,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  List<Object?> get props => [
        theme,
        isLocked,
        backgroundImage,
        bubbleAlignment,
        centerDate,
        fontSize,
      ];
}
