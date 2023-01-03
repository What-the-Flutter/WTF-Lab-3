import 'package:flutter/material.dart';

import 'package:my_final_project/entities/event.dart';

class EventState {
  final List<Event> listEvent;
  final List<Event> listSearch;
  final bool isFavorite;
  final bool isSelected;
  final bool isEdit;
  final String editText;
  final bool isPicter;
  final bool isSearch;
  final int countSelected;
  final bool isSection;
  final IconData sectionIcon;
  final String sectionTitle;

  EventState({
    required this.listEvent,
    this.isFavorite = false,
    this.isSelected = false,
    this.isEdit = false,
    this.isPicter = false,
    this.editText = '',
    this.isSearch = false,
    this.countSelected = 0,
    this.isSection = false,
    required this.listSearch,
    this.sectionIcon = Icons.bubble_chart,
    this.sectionTitle = 'Cancel',
  });

  EventState copyWith({
    bool? isSelected,
    bool? isFavorite,
    List<Event>? listEvent,
    List<Event>? listSearch,
    bool? isEdit,
    String? editText,
    bool? isPicter,
    bool? isSearch,
    int? countSelected,
    bool? isSection,
    IconData? sectionIcon,
    String? sectionTitle,
  }) {
    return EventState(
      isSelected: isSelected ?? this.isSelected,
      listEvent: listEvent ?? this.listEvent,
      listSearch: listSearch ?? this.listSearch,
      isFavorite: isFavorite ?? this.isFavorite,
      isEdit: isEdit ?? this.isEdit,
      editText: editText ?? this.editText,
      isPicter: isPicter ?? this.isPicter,
      isSearch: isSearch ?? this.isSearch,
      countSelected: countSelected ?? this.countSelected,
      isSection: isSection ?? this.isSection,
      sectionIcon: sectionIcon ?? this.sectionIcon,
      sectionTitle: sectionTitle ?? this.sectionTitle,
    );
  }
}
