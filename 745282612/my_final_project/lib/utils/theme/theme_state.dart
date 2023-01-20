import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeData theme;
  final TextTheme textTheme;

  ThemeState({
    required this.theme,
    required this.textTheme,
  });

  ThemeState copyWith({
    ThemeData? theme,
    TextTheme? textTheme,
  }) {
    return ThemeState(
      theme: theme ?? this.theme,
      textTheme: textTheme ?? this.textTheme,
    );
  }

  @override
  List<Object?> get props => [
        theme,
        textTheme,
      ];
}
