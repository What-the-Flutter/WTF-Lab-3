import 'package:diary_app/data/all_icons.dart';
import 'package:diary_app/data/models/chat_model.dart';
import 'package:diary_app/data/models/event_model.dart';
import 'package:diary_app/domain/entities/chat.dart';
import 'package:diary_app/domain/entities/event.dart';
import 'package:sqflite/sqflite.dart';

class LocalRepository {
  final Database database;
  LocalRepository(this.database);

  Future<List<Event>> loadChatEvents(int chatId) async {
    final rawData = await database.query(
      'events',
      where: 'chatId = ?',
      whereArgs: [chatId],
    );

    final rawList = List<EventModel>.generate(
      rawData.length,
      (index) => EventModel.fromMap(rawData[index]),
    );

    final eventsList = List<Event>.generate(
      rawList.length,
      (index) => rawList[index].toEvent()..id = rawData[index]['id'] as int,
    );

    return eventsList;
  }

  Future<void> removeSelectedItems(List<int> ids) async {
    for (var id in ids) {
      await removeItemById(id);
    }
  }

  Future<void> removeItemById(int eventId) async {
    await database.delete(
      'events',
      where: 'id = ?',
      whereArgs: [eventId],
    );
  }

  Future<void> changeFavoriteness(List<int> ids, bool isFavorite) async {
    for (var id in ids) {
      final eventMap = await database.query(
        'events',
        where: 'id = ?',
        whereArgs: [id],
      );

      final e = eventMap.first;

      final model = EventModel.fromMap(e);
      model.isFavorite = isFavorite;

      await database.update(
        'events',
        model.toMap(),
        where: 'id = ?',
        whereArgs: [e['id']],
      );
    }
  }

  Future<void> editEvent(Event event) async {
    await database.update(
      'events',
      EventModel.fromEvent(event).toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> addEvent(Event event) async {
    return await database.insert(
      'events',
      EventModel.fromEvent(event).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> moveSelectedItems(List<int> ids, int chatId, int targetChatId) async {
    final List<Map<String, dynamic>> eventMaps = await database.query(
      'events',
      where: 'chatId = ?',
      whereArgs: [chatId],
    );

    for (var e in eventMaps) {
      if (!ids.contains(e['id'])) continue;
      final model = EventModel.fromMap(e);
      model.chatId = targetChatId;
      model.dateTime = DateTime.now().millisecondsSinceEpoch;

      await database.delete(
        'events',
        where: 'id = ?',
        whereArgs: [e['id']],
      );

      await database.insert(
        'events',
        model.toMap(),
      );
    }
  }

  Future<void> pinUnpinChat(int id) async {
    final chat = await database.query(
      'chats',
      where: 'id = ?',
      whereArgs: [id],
    );

    final model = ChatModel.fromMap(chat.first);
    model.isPinned = !model.isPinned;

    await database.update(
      'chats',
      model.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> editChat(int id, Chat result) async {
    final chat = await database.query(
      'chats',
      where: 'id = ?',
      whereArgs: [id],
    );

    final model = ChatModel.fromMap(chat.first);
    model.isPinned = !model.isPinned;
    model.icon = allIcons.indexOf(result.icon);
    model.title = result.title;

    await database.update(
      'chats',
      model.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> removeChat(int id) async {
    await database.delete(
      'chats',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearChatData(int id) async {
    await database.delete(
      'events',
      where: 'chatId = ?',
      whereArgs: [id],
    );
  }

  Future<int> addChat(Chat result) async {
    return await database.insert(
      'chats',
      ChatModel.fromChat(result).toMap(),
    );
  }

  Future<List<Chat>> loadChats() async {
    final rawData = await database.query(
      'chats',
    );

    final rawList = List<ChatModel>.generate(
      rawData.length,
      (index) => ChatModel.fromMap(rawData[index]),
    );

    final chatsList = List<Chat>.generate(
      rawList.length,
      (index) => rawList[index].toChat()..id = rawData[index]['id'] as int,
    );

    return chatsList;
  }
}
