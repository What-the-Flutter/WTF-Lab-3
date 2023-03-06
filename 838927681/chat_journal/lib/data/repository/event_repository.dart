import 'dart:async';

import '../../domain/entities/event.dart';
import '../../domain/repositories/api_event_repository.dart';
import '../models/db_event.dart';
import '../transformer/transformer.dart';
import 'api_provider/api_data_provider.dart';

class EventRepository extends ApiEventRepository {
  final ApiDataProvider _provider;

  EventRepository({required ApiDataProvider provider}) : _provider = provider;

  @override
  Stream<List<Event>> get eventStream =>
      _provider.eventsStream.map<List<Event>>(_transformToListEvent);

  List<Event> _transformToListEvent(List<DBEvent> dbEvents) {
    final result = <Event>[];
    for (final dbEvent in dbEvents) {
      result.add(Transformer.dbEventToEntity(dbEvent));
    }
    return result;
  }

  @override
  Future<List<Event>> getEvents(String parentId) async {
    var dbEvents = await _provider.events;
    dbEvents =
        dbEvents.where((element) => element.parentId == parentId).toList();
    dbEvents.sort((a, b) {
      return a.dateTime.compareTo(b.dateTime);
    });
    final events = List<Event>.generate(
      dbEvents.length,
      (index) {
        return Transformer.dbEventToEntity(dbEvents[index]);
      },
    );
    return events;
  }

  @override
  Future<List<Event>> getAllEvents() async {
    var dbEvents = await _provider.events;
    final events = List<Event>.generate(
      dbEvents.length,
      (index) {
        return Transformer.dbEventToEntity(dbEvents[index]);
      },
    );
    return events;
  }

  @override
  Future<void> updateEvent(Event event) async =>
      _provider.updateEvent(Transformer.eventToModel(event));

  @override
  Future<void> addEvent(Event event) async {
    await _provider.addEvent(Transformer.eventToModel(event));
  }

  @override
  Future<void> deleteEvent(Event event) async =>
      _provider.deleteEvent(Transformer.eventToModel(event));
}
