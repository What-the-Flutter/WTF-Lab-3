import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:my_final_project/entities/event.dart';

class EventState extends Equatable {
  final List<Event> listEvent;
  final bool isFavorite;
  final bool isSelected;
  final bool isEdit;
  final bool isRepet;
  final String editText;
  final bool isPicter;
  final bool isSearch;
  final int countSelected;
  final bool isSection;
  final bool switchSectionTag;
  final IconData sectionIcon;
  final String sectionTitle;
  final String searchText;
  final bool isWrite;
  final bool isTag;
  final String tagTitle;

  EventState({
    required this.listEvent,
    this.switchSectionTag = false,
    this.isFavorite = false,
    this.isSelected = false,
    this.isEdit = false,
    this.isPicter = false,
    this.isRepet = false,
    this.editText = '',
    this.isSearch = false,
    this.countSelected = 0,
    this.isSection = false,
    this.isWrite = false,
    this.sectionIcon = Icons.bubble_chart,
    this.sectionTitle = 'Cancel',
    this.tagTitle = 'Cancel',
    this.searchText = '',
    this.isTag = false,
  });

  EventState copyWith({
    String? searchText,
    bool? isSelected,
    bool? isFavorite,
    List<Event>? listEvent,
    bool? isEdit,
    String? editText,
    bool? isPicter,
    bool? isSearch,
    int? countSelected,
    bool? isSection,
    IconData? sectionIcon,
    String? sectionTitle,
    bool? isRepet,
    bool? isWrite,
    bool? switchSectionTag,
    bool? isTag,
    String? tagTitle,
  }) {
    return EventState(
      isSelected: isSelected ?? this.isSelected,
      listEvent: listEvent ?? this.listEvent,
      isFavorite: isFavorite ?? this.isFavorite,
      isEdit: isEdit ?? this.isEdit,
      editText: editText ?? this.editText,
      isPicter: isPicter ?? this.isPicter,
      isSearch: isSearch ?? this.isSearch,
      countSelected: countSelected ?? this.countSelected,
      isSection: isSection ?? this.isSection,
      sectionIcon: sectionIcon ?? this.sectionIcon,
      sectionTitle: sectionTitle ?? this.sectionTitle,
      searchText: searchText ?? this.searchText,
      isRepet: isRepet ?? this.isRepet,
      isWrite: isWrite ?? this.isWrite,
      switchSectionTag: switchSectionTag ?? this.switchSectionTag,
      isTag: isTag ?? this.isTag,
      tagTitle: tagTitle ?? this.tagTitle,
    );
  }

  @override
  List<Object?> get props => [
        listEvent,
        isFavorite,
        isSelected,
        isEdit,
        isRepet,
        editText,
        isPicter,
        isSearch,
        countSelected,
        isSection,
        sectionIcon,
        sectionTitle,
        searchText,
        isWrite,
        switchSectionTag,
        isTag,
        tagTitle,
      ];
}
