import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:my_final_project/entities/section.dart';

class SettingState extends Equatable {
  final List<Section> listSection;
  final bool isAdd;
  final ThemeData theme;
  final TextTheme textTheme;

  SettingState({
    this.isAdd = false,
    required this.listSection,
    required this.theme,
    required this.textTheme,
  });

  SettingState copyWith({
    List<Section>? listSection,
    bool? isAdd,
    ThemeData? theme,
    TextTheme? textTheme,
  }) {
    return SettingState(
      isAdd: isAdd ?? this.isAdd,
      listSection: listSection ?? this.listSection,
      theme: theme ?? this.theme,
      textTheme: textTheme ?? this.textTheme,
    );
  }

  @override
  List<Object?> get props => [
        listSection,
        isAdd,
        theme,
        textTheme,
      ];
}
