import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final ThemeData theme;
  final bool isLocked;
  final String fontSize;
  final bool alignment;
  final bool isCenter;
  final String backgroundImage;

  const SettingsState({
    required this.theme,
    required this.isLocked,
    required this.fontSize,
    required this.alignment,
    required this.isCenter,
    required this.backgroundImage,
  });

  SettingsState copyWith({
    ThemeData? theme,
    bool? isLocked,
    String? fontSize,
    bool? alignment,
    bool? isCenter,
    String? backgroundImage,
  }) {
    return SettingsState(
      theme: theme ?? this.theme,
      isLocked: isLocked ?? this.isLocked,
      fontSize: fontSize ?? this.fontSize,
      alignment: alignment ?? this.alignment,
      isCenter: isCenter ?? this.isCenter,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }

  @override
  List<Object?> get props => [
        theme,
        isLocked,
        fontSize,
        alignment,
        isCenter,
        backgroundImage,
      ];
}
