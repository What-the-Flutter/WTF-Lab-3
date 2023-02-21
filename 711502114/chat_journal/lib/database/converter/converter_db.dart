import '../../models/category.dart';
import '../../models/chat.dart';
import '../../models/event.dart';
import '../entities/chat_db.dart';
import '../entities/event_db.dart';

class ConverterDB {
  static Chat entity2Chat(ChatDB chatDB) {
    return Chat(
      id: chatDB.id,
      title: chatDB.title,
      iconNumber: chatDB.iconNumber,
      events: [],
      creationTime: chatDB.creationTime,
      isPin: chatDB.isPin == 1,
      isArchive: chatDB.isArchive == 1,
    );
  }

  static ChatDB chat2Entity(Chat chat) {
    return ChatDB(
      id: chat.id,
      title: chat.title,
      iconNumber: chat.iconNumber,
      creationTime: chat.creationTime,
      isPin: chat.isPin ? 1 : 0,
      isArchive: chat.isArchive ? 1 : 0,
    );
  }

  static Event entity2Event(EventDB eventDB) {
    return Event(
      id: eventDB.id,
      chatId: eventDB.chatId,
      message: eventDB.message,
      creationTime: eventDB.creationTime,
      isFavorite: eventDB.isFavorite == 1,
      photoPath: eventDB.photoPath,
      category: Category.model(eventDB.categoryName),
    );
  }

  static EventDB event2Entity(Event event) {
    return EventDB(
      id: event.id,
      chatId: event.chatId,
      message: event.message,
      creationTime: event.creationTime,
      isFavorite: event.isFavorite ? 1 : 0,
      photoPath: event.photoPath ?? '',
      categoryName: event.category?.title ?? '',
    );
  }
}
