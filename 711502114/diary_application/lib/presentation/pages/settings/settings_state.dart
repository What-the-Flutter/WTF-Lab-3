import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final ThemeData theme;
  final bool isLocked;

  const SettingsState({
    required this.theme,
    required this.isLocked,
  });

  SettingsState copyWith({
    ThemeData? theme,
    bool? isLocked,
  }) {
    return SettingsState(
      theme: theme ?? this.theme,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  @override
  List<Object?> get props => [theme, isLocked];
}
