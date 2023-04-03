import 'dart:io';

import '../../domain/entities/event.dart';
import '../../domain/repos/event_repository.dart';
import '../entities/event_dto.dart';
import '../services/database_service.dart';

class EventRepositoryImpl extends EventRepository {
  final DataBaseService dataBaseService;

  EventRepositoryImpl({required this.dataBaseService});

  @override
  Future<List<Event>> getEvents(String chatId) async {
    final keys = <String>[];
    final raw = await dataBaseService.queryAllEventsForChat(chatId, keys);
    final events =
        raw.map((event) => EventDTO.fromJSON(event).toModel()).toList();
    for (var i = 0; i < events.length; i++) {
      events[i] = events[i].copyWith(id: keys[i]);
    }
    return events;
  }

  @override
  Future<void> insertEvent(Event event) async {
    String? fileUrl;
    if (event.imageData != null) {
      fileUrl = await dataBaseService.loadImage(File(event.imageData!));
    }
    final eventDTO = EventDTO(
      chatId: event.chatId,
      createTime: event.createTime,
      isDone: event.isDone,
      isFavorite: event.isFavorite,
      textData: event.textData,
      imageData: fileUrl ?? event.imageData,
      category: event.category,
      tags: event.tags,
    );
    dataBaseService.insertEvent(eventDTO.toJson());
  }

  @override
  Future<void> changeEvent(Event event) async {
    final eventDTO = EventDTO(
      id: event.id,
      chatId: event.chatId,
      createTime: event.createTime,
      isDone: event.isDone,
      isFavorite: event.isFavorite,
      textData: event.textData,
      imageData: event.imageData,
      category: event.category,
      tags: event.tags,
    );
    dataBaseService.updateEvent(
      event.id!,
      eventDTO.toJson(),
    );
  }

  @override
  Future<void> deleteEvent(Event event) async {
    dataBaseService.deleteEvent(event.id!);
  }

  @override
  void initListener(Function updateChat) {
    dataBaseService.databaseRef
        .child(dataBaseService.fireBaseAuth.currentUser!.uid)
        .child('events')
        .onValue
        .listen((event) {
      updateChat();
    });
  }
}
