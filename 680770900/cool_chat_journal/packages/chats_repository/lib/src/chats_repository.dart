import 'package:chats_api/chats_api.dart';

import 'models/models.dart';

class ChatsRepository {
  final ChatsApi chatsApi;

  const ChatsRepository({
    required this.chatsApi,
  });

  Future<List<Chat>> loadChats() async {
    final chatsEntity = await chatsApi.loadChats();
    final eventsEntity = await chatsApi.loadEvents();
    final events = eventsEntity.map(Event.fromEventEntity);
    return chatsEntity
      .map(
        (chat) => Chat
          .fromChatEntity(chat)
          .copyWith(
            events: events
              .where((event) => event.chatId == chat.id)
              .toList(),
          ),
      )
      .toList();
  }

  Future<List<Event>> loadEvents(String chatId) async {
    final eventsEntity = await chatsApi.loadEvents();
    return eventsEntity
      .where((event) => event.chatId == chatId)
      .map(Event.fromEventEntity)
      .toList();
  } 

  Future<void> addChat(Chat chat) async {
    final chatEntity = chat.toChatEntity();
    final eventsEntity = chat.events
      .map((event) => event.toEventEntity());

    final chats = await chatsApi.loadChats();
    final events = await chatsApi.loadEvents();

    chats.add(chatEntity);
    events.addAll(eventsEntity);

    await chatsApi.saveChats(chats);
    await chatsApi.saveEvents(events);
  }

  Future<void> deleteChat(String chatId) async {
    final chats = await chatsApi.loadChats();
    final events = await chatsApi.loadEvents();

    await chatsApi.saveChats(chats.where((chat) => chat.id != chatId));
    await chatsApi.saveEvents(events.where((event) => event.chatId != chatId));
  }

  Future<void> updateChat(Chat chat) async {
    final chatsEntity = await chatsApi.loadChats();
    final eventsEntity = await chatsApi.loadEvents();

    final chats = chatsEntity
      .where((e) => e.id != chat.id)
      .toList();
    chats.add(chat.toChatEntity());

    final events = eventsEntity
      .where((event) => event.chatId != chat.id)
      .toList();
    events.addAll(chat.events.map((event) => event.toEventEntity()));

    await chatsApi.saveChats(chats);
    await chatsApi.saveEvents(events);
  }

}