import 'package:cool_chat_journal_source/cool_chat_journal_source.dart'
  as data_source show Chat;

import 'event.dart';

class Chat {
  final int id;
  final int icon;
  final String name;
  final DateTime createdTime;
  final bool isPinned;
  final List<Event> events;

  const Chat({
    required this.id,
    required this.icon,
    required this.name,
    required this.createdTime,
    required this.isPinned,
    this.events = const [],
  });

  factory Chat.fromSourceChat(data_source.Chat chat) => 
    Chat(
      id: chat.id,
      icon: chat.icon,
      name: chat.name,
      createdTime: chat.createdTime,
      isPinned: chat.isPinned,
    );

  data_source.Chat toSourceChat() =>
    data_source.Chat(
      id: id,
      icon: icon,
      name: name,
      createdTime: createdTime,
      isPinned: isPinned
    );

  Chat copyWith({
    int? id,
    int? icon,
    String? name,
    DateTime? createdTime,
    bool? isPinned,
    List<Event>? events,
  }) => Chat(
    id: id ?? this.id,
    icon: icon ?? this.icon,
    name: name ?? this.name,
    createdTime: createdTime ?? this.createdTime,
    isPinned: isPinned ?? this.isPinned,
    events: events ?? this.events,
  );
}
