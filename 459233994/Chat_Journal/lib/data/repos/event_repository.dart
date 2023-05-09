import 'dart:async';
import 'dart:io';

import '../../domain/entities/event.dart';
import '../../domain/repos/event_repository.dart';
import '../entities/event_dto.dart';
import '../services/database_service.dart';

class EventRepositoryImpl extends EventRepository {
  final DataBaseService _dataBaseService;

  EventRepositoryImpl({required dataBaseService})
      : _dataBaseService = dataBaseService;

  @override
  Future<List<Event>> getEvents(String chatId) async {
    final keys = <String>[];
    final raw = await _dataBaseService.queryAllEventsForChat(chatId, keys);
    final events =
        raw.map((event) => EventDTO.fromJSON(event).toModel()).toList();
    for (var i = 0; i < events.length; i++) {
      events[i] = events[i].copyWith(id: keys[i]);
    }
    return events;
  }

  @override
  Future<List<Event>> getEventsForTimeLine() async {
    final keys = <String>[];
    final raw = await _dataBaseService.queryAllEventsForTimeLine(keys);
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
      fileUrl = await _dataBaseService.loadImage(File(event.imageData!));
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
    _dataBaseService.insertEvent(eventDTO.toJson());
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
    _dataBaseService.updateEvent(
      event.id!,
      eventDTO.toJson(),
    );
  }

  @override
  Future<void> deleteEvent(Event event) async {
    _dataBaseService.deleteEvent(event.id!);
  }

  @override
  Future<StreamSubscription> initListener(String chatId) async {
    return await _dataBaseService.initListenerEvents(chatId);
  }

}
