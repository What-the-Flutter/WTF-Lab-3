import '../../domain/entities/event.dart';
import '../../domain/repositories/api_event_repository.dart';
import '../models/db_event.dart';
import '../provider/chat_provider.dart';
import '../transfromer/transformer.dart';

class EventRepository extends ApiEventRepository {
  final provider = DataProvider();
  static final eventsId = <int>{};

  @override
  Future<List<Event>> getEvents(int parentId) async {
    var dbEvents = await provider.events;
    _setIds(dbEvents);
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

  void _setIds(List<DBEvent> events) {
    for (final event in events) {
      print('${event.text}: ${event.parentId}');
      eventsId.add(event.id);
    }
  }

  @override
  Future<void> updateEvent(Event event) async =>
      provider.updateEvent(Transformer.eventToModel(event));

  @override
  Future<void> addEvent(Event event) async {
    var id = 0;
    while (eventsId.contains(id)) {
      id++;
    }
    eventsId.add(id);
    await provider.addEvent(Transformer.eventToModel(event.copyWith(id: id)));
  }

  @override
  Future<void> deleteEvent(Event event) async =>
      provider.deleteEvent(Transformer.eventToModel(event));
}
