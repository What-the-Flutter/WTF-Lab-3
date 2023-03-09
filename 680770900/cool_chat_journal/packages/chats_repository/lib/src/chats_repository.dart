import 'package:chats_api/chats_api.dart';
import 'package:collection/collection.dart';

import 'models/models.dart';

class ChatsRepository {
  final ChatsApi chatsApi;

  const ChatsRepository({
    required this.chatsApi,
  });

  Future<List<Chat>> loadChats() async {
    final chatsEntity = await chatsApi.loadChats();
    final events = await loadEvents();
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

  Future<List<Event>> loadEvents() async {
    final eventsEntity = await chatsApi.loadEvents();
    final categoriesEntity = await chatsApi.loadCategories();

    return eventsEntity
      .map((event) {
        final categoryEntity = categoriesEntity
          .firstWhereOrNull((category) => category.id == event.category);

        final NullWrapper<Category?>? category;
        if (categoryEntity != null) {
          category = NullWrapper<Category?>(
            Category.fromCategoryEntity(categoryEntity)
          );
        } else {
          category = null;
        }

        return Event.fromEventEntity(event).copyWith(category: category);
      }
      )
      .toList();
  } 

  Future<List<Category>> loadCategories() async {
    final categoriesEntity = await chatsApi.loadCategories();

    if (categoriesEntity.isEmpty) {
      await saveBasicCategories();
      return Category.basic;
    } else {
      return categoriesEntity.map(Category.fromCategoryEntity).toList();
    }
  }

  Future<void> saveBasicCategories() async {
    await chatsApi.saveCategories(
      Category.basic.map((category) => category.toCategoryEntity()),
    );
  }

  Future<void> addCategory(Category category) async {
    final categoryEntity = category.toCategoryEntity();
    final categories = await chatsApi.loadCategories();
    categories.add(categoryEntity);
    await chatsApi.saveCategories(categories);
  }

  Future<void> deleteCategory(String categoryId) async {
    final categories = await chatsApi.loadCategories();
    await chatsApi.saveCategories(
      categories.where((category) => category.id != categoryId),
    ); 
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