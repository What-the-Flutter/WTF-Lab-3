import 'package:flutter/material.dart';

class ThemeState {
  final ThemeData theme;

  const ThemeState({
    required this.theme,
  });

  ThemeState copyWith({ThemeData? theme}) {
    return ThemeState(theme: theme ?? this.theme);
  }
}
