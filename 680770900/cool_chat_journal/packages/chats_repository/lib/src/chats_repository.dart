import 'package:cool_chat_journal_source/cool_chat_journal_source.dart'
  show ChatSourceClient;

import 'models/models.dart';

class ChatsRepository {
  final ChatSourceClient _chatSourceClient;

  ChatsRepository({ChatSourceClient? chatSourceClient}) 
    : _chatSourceClient = chatSourceClient ?? ChatSourceClient();

  Future<List<Chat>> readChats() async {
    final chats = await _chatSourceClient.readChats();
    final events = await _chatSourceClient.readEvents();

    return chats.map(
      (chat) =>
        Chat.fromSourceChat(chat)
          ..copyWith(
            events: events
              .where(
                (event) => event.chatId == chat.id,
              )
              .map(Event.fromSourceEvent)
              .toList(),
          )
    ).toList();
  }

  Future<void> insertChat(Chat chat) async {
    final events = chat.events;

    await _chatSourceClient.insertChat(chat.toSourceChat());
    
    for (final event in events) {
      await _chatSourceClient.insertEvent(
        event.toSourceEvent(chatId: chat.id),
      );
    }
  }

  Future<void> deleteChat(int chatId) async {
    await _chatSourceClient.deleteChat(chatId);

    final events = await _chatSourceClient.readEvents();
    final chatEvents = events.where((event) => event.chatId == chatId);

    for (final event in chatEvents) {
      _chatSourceClient.deleteEvent(event.id);
    }
  }

  Future<void> updateChat(Chat chat) async {
    await _chatSourceClient.updateChat(chat.toSourceChat());

    final events = await _chatSourceClient.readEvents();
    final chatEventsIds =
      events.where((event) => event.chatId == chat.id)
        .map((event) => event.id);

    for (final event in chat.events) {
      final sourceEvent = event.toSourceEvent(chatId: chat.id);
      if (chatEventsIds.contains(event.id)) {
        await _chatSourceClient.updateEvent(sourceEvent);
      } else {
        await _chatSourceClient.insertEvent(sourceEvent);
      }
    }
  }
}