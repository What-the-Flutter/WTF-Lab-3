import '../../domain/entities/chat.dart';
import '../../domain/entities/event.dart';
import '../models/db_chat.dart';
import '../models/db_event.dart';

class Transformer {
  static Chat dbChatToEntity(DBChat dbChat) {
    return Chat(
      id: dbChat.id,
      iconIndex: dbChat.iconIndex,
      name: dbChat.name,
      creationDate: DateTime.parse(dbChat.creationDate),
      lastDate: DateTime.parse(dbChat.lastDate),
      lastMessage: dbChat.lastMessage,
    );
  }

  static Event dbEventToEntity(DBEvent dbEvent) {
    return Event(
      id: dbEvent.id,
      parentId: dbEvent.parentId,
      text: dbEvent.text,
      dateTime: DateTime.parse(dbEvent.dateTime),
      iconIndex: dbEvent.iconIndex,
      imagePath: dbEvent.imagePath,
      isFavorite: dbEvent.isFavorite,
      isSelected: false,
    );
  }

  static DBEvent eventToModel(Event event) {
    return DBEvent(
      id: event.id.toString(),
      parentId: event.parentId.toString(),
      text: event.text,
      dateTime: event.dateTime.toString(),
      imagePath: event.imagePath,
      iconIndex: event.iconIndex,
      isFavorite: event.isFavorite,
    );
  }

  static DBChat chatToModel(Chat chat) {
    return DBChat(
      id: chat.id.toString(),
      name: chat.name,
      iconIndex: chat.iconIndex,
      creationDate: chat.creationDate.toString(),
      lastDate: chat.lastDate.toString(),
      lastMessage: chat.lastMessage,
    );
  }
}
