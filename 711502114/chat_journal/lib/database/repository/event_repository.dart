import '../../models/event.dart';
import '../converter/converter_db.dart';
import '../provider/data_provider.dart';
import 'event_repository_api.dart';

class EventRepository extends EventRepositoryApi {
  final provider = DataProvider();

  @override
  Future<void> addEvent(Event event) async {
    final eventDB = ConverterDB.event2Entity(event);
    await provider.addEvent(eventDB);
  }

  @override
  Future<void> changeEvent(Event event) async {
    final eventDB = ConverterDB.event2Entity(event);
    await provider.updateEvent(eventDB);
  }

  @override
  Future<void> deleteEvent(Event event) async {
    final eventDB = ConverterDB.event2Entity(event);
    await provider.deleteEvent(eventDB);
  }

  @override
  Future<List<Event>> getEvents() async {
    final eventsDB = await provider.events;
    eventsDB.sort((a, b) => a.creationTime.compareTo(b.creationTime));
    return List<Event>.generate(eventsDB.length, (index) {
      return ConverterDB.entity2Event(eventsDB[index]);
    });
  }
}
