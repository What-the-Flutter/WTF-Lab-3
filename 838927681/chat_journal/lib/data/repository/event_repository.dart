import 'dart:async';

import '../../domain/entities/event.dart';
import '../../domain/repositories/api_event_repository.dart';
import '../models/db_event.dart';
import '../transformer/transformer.dart';
import 'api_provider/api_data_provider.dart';

class EventRepository extends ApiEventRepository {
  final ApiDataProvider provider;
  final eventStreamController = StreamController<List<Event>>();
  late final StreamSubscription<List<DBEvent>> eventStreamSubscription;

  EventRepository({required this.provider}) {
    eventStreamSubscription = provider.eventsStream.listen(
      (dbEvents) {
        final events = <Event>[];
        for (final dbEvent in dbEvents) {
          events.add(Transformer.dbEventToEntity(dbEvent));
        }
        eventStreamController.add(events);
      },
    );
  }

  @override
  Stream<List<Event>> get eventStream => eventStreamController.stream;

  @override
  Future<List<Event>> getEvents(String parentId) async {
    var dbEvents = await provider.events;
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
  Future<void> updateEvent(Event event) async =>
      provider.updateEvent(Transformer.eventToModel(event));

  @override
  Future<void> addEvent(Event event) async {
    await provider.addEvent(Transformer.eventToModel(event));
  }

  @override
  Future<void> deleteEvent(Event event) async =>
      provider.deleteEvent(Transformer.eventToModel(event));
}
