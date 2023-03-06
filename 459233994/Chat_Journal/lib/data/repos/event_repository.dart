import '../../domain/entities/event.dart';
import '../../domain/repos/event_repository.dart';
import '../entities/event_dto.dart';
import '../services/database_helper.dart';

class EventRepositoryImpl extends EventRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Future<List<Event>> getEvents(int chatId) async {
    var raw = await databaseHelper.queryAllEventsForChat(chatId);
    return raw.map((f) => EventDTO.fromJSON(f).toModel()).toList();
  }

  @override
  Future<void> insertEvent(Event event) async {
    var eventDTO = EventDTO(
      chatId: event.chatId,
      createTime: event.createTime,
      isDone: event.isDone,
      isFavorite: event.isFavorite,
      textData: event.textData,
      imageData: event.imageData,
      category: event.category,
    );
    databaseHelper.insertEvent(eventDTO.toJson());
  }

  @override
  Future<void> changeEvent(Event event) async {
    var eventDTO = EventDTO(
      id: event.id,
      chatId: event.chatId,
      createTime: event.createTime,
      isDone: event.isDone,
      isFavorite: event.isFavorite,
      textData: event.textData,
      imageData: event.imageData,
      category: event.category,
    );
    databaseHelper.updateEvent(
      event.id!,
      eventDTO.toJson(),
    );
  }

  @override
  Future<void> deleteEvent(Event event) async {
    databaseHelper.deleteEvent(event.id!);
  }
}
