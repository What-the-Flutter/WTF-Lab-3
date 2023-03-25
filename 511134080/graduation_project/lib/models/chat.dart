import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class Chat {
  final String id;
  final int iconId;
  final String title;
  final DateTime? date;
  final bool isPinned;
  final bool isShowingFavourites;
  final String lastEventTitle;
  final DateTime? lastEventTime;

  const Chat({
    required this.iconId,
    required this.title,
    required this.id,
    required this.date,
    this.isPinned = false,
    this.isShowingFavourites = false,
    this.lastEventTitle = 'No events. Click here to create one.',
    this.lastEventTime,
  });

  Chat copyWith({
    dynamic newId,
    int? newIconId,
    String? newTitle,
    DateTime? newDate,
    bool? pinned,
    bool? showingFavourites,
    String? newLastEventTitle,
    DateTime? newLastEventTime,
  }) {
    return Chat(
      id: newId ?? id,
      iconId: newIconId ?? iconId,
      title: newTitle ?? title,
      date: newDate ?? date,
      isPinned: pinned ?? isPinned,
      isShowingFavourites: showingFavourites ?? isShowingFavourites,
      lastEventTitle: newLastEventTitle ?? lastEventTitle,
      lastEventTime: newLastEventTime ?? lastEventTime,
    );
  }

  factory Chat.fromDatabaseMap(Map<String, dynamic> data) => Chat(
        iconId: data['icon_id'],
        title: data['title'],
        id: data['id'],
        date: DateTime.parse(data['date']),
        isPinned: data['is_pinned'] == 1 ? true : false,
        isShowingFavourites: data['is_showing_favourites'] == 1 ? true : false,
        lastEventTitle: data['last_event_title'],
        lastEventTime: data['last_event_time'] != null
            ? DateTime.parse(data['last_event_time'])
            : null,
      );

  Map<String, dynamic> toDatabaseMap() => {
        'icon_id': iconId,
        'title': title,
        'id': id,
        'date': date.toString(),
        'is_pinned': isPinned ? 1 : 0,
        'is_showing_favourites': isShowingFavourites ? 1 : 0,
        'last_event_title': lastEventTitle,
        'last_event_time': lastEventTime?.toString(),
      };
}
