import 'dart:async';

import 'package:diary_application/data/converter/converter_db.dart';
import 'package:diary_application/data/entities/event_db.dart';
import 'package:diary_application/data/provider/api_firebase_provider.dart';
import 'package:diary_application/domain/models/event.dart';
import 'package:diary_application/domain/repository/event_repository_api.dart';

class EventRepository extends EventRepositoryApi {
  final ApiDataProvider _provider;

  EventRepository({required ApiDataProvider provider}) : _provider = provider;

  @override
  Future<void> addEvent(Event event) async {
    final eventDB = ConverterDB.event2Entity(event);
    await _provider.addEvent(eventDB);
  }

  @override
  Future<void> changeEvent(Event event) async {
    final eventDB = ConverterDB.event2Entity(event);
    await _provider.updateEvent(eventDB);
  }

  @override
  Future<void> deleteEvent(Event event) async {
    final eventDB = ConverterDB.event2Entity(event);
    await _provider.deleteEvent(eventDB);
  }

  @override
  Future<List<Event>> getEvents(String chatId) async {
    final eventsDB = await _provider.events;
    final chatEventsDB = eventsDB.where((e) => e.chatId == chatId).toList();
    chatEventsDB.sort((a, b) => a.creationTime.compareTo(b.creationTime));
    return List<Event>.generate(chatEventsDB.length, (index) {
      return ConverterDB.entity2Event(chatEventsDB[index]);
    });
  }

  @override
  Stream<List<Event>> get eventStream => _provider.eventsStream
      .map<List<Event>>(_transformToListEvent)
      .asBroadcastStream();

  List<Event> _transformToListEvent(List<EventDB> dbEvents) {
    final result = <Event>[];
    for (final dbEvent in dbEvents) {
      result.add(ConverterDB.entity2Event(dbEvent));
    }
    return result;
  }

  @override
  Future<List<Event>> getAllEvents() async {
    final dbEvents = await _provider.events;
    final events = List<Event>.generate(
      dbEvents.length,
      (i) => ConverterDB.entity2Event(dbEvents[i]),
    );
    return events;
  }
}
