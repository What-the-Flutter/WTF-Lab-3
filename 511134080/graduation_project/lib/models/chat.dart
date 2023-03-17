import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'event.dart';

@immutable
class Chat {
  final String id;
  final int iconId;
  final String title;
  final DateTime? date;
  final bool isPinned;
  final bool isShowingFavourites;
  final List<Event> events;

  const Chat({
    required this.iconId,
    required this.title,
    required this.id,
    required this.date,
    this.isPinned = false,
    this.isShowingFavourites = false,
    this.events = const [],
  });

  Chat copyWith({
    dynamic newId,
    int? newIconId,
    String? newTitle,
    DateTime? newDate,
    bool? pinned,
    bool? showingFavourites,
    List<Event>? newEvents,
  }) {
    return Chat(
      id: newId ?? id,
      iconId: newIconId ?? iconId,
      title: newTitle ?? title,
      date: newDate ?? date,
      isPinned: pinned ?? isPinned,
      isShowingFavourites: showingFavourites ?? isShowingFavourites,
      events: newEvents ?? events,
    );
  }

  factory Chat.fromDatabaseMap(Map<String, dynamic> data) => Chat(
        iconId: data['icon_id'],
        title: data['title'],
        id: data['id'],
        date: DateTime.parse(data['date']),
        isPinned: data['is_pinned'] == 1 ? true : false,
        isShowingFavourites: data['is_showing_favourites'] == 1 ? true : false,
      );

  Map<String, dynamic> toDatabaseMap() => {
        'icon_id': iconId,
        'title': title,
        'id': id,
        'date': date.toString(),
        'is_pinned': isPinned ? 1 : 0,
        'is_showing_favourites': isShowingFavourites ? 1 : 0,
      };
}
