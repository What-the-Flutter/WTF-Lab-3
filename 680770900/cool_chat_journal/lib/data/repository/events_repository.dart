import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';
import '../provider/firebase_provider.dart';

class EventsRepository {
  final FirebaseProvider _firebaseProvider;

  EventsRepository({required User? user}) 
    : _firebaseProvider = FirebaseProvider(user: user);

  Future<List<Event>> readEvents(String chatId) async {
    final jsonEvents = await _firebaseProvider.read<Event>(
      tableName: '${FirebaseProvider.eventsRoot}/$chatId',
    );

    return jsonEvents.map(Event.fromJson).toList();
  }

  Future<void> addEvents(Iterable<Event> events) async {
    for (final event in events) {
      await addEvent(event);
    }
  }

  Future<void> updateEvents(Iterable<Event> events) async {
    for (final event in events) {
      await updateEvent(event);
    }
  }

  Future<void> addEvent(Event event) async =>
    await _firebaseProvider.add(
      json: event.toJson(),
      tableName: '${FirebaseProvider.eventsRoot}/${event.chatId}',
    );

  Future<void> deleteEvent(Event event) async =>
    await _firebaseProvider.delete(
      id: event.id,
      tableName: '${FirebaseProvider.eventsRoot}/${event.chatId}',
    );

  Future<void> updateEvent(Event event) async {
    await _firebaseProvider.delete(
      id: event.id,
      tableName: '${FirebaseProvider.eventsRoot}/${event.chatId}',  
    );
    await _firebaseProvider.add(
      json: event.toJson(),
      tableName: '${FirebaseProvider.eventsRoot}/${event.chatId}',
    );
  }

  Future<void> deleteEventsFromChat(String chatId) async {
     await _firebaseProvider.delete(
      id: chatId,
      tableName: FirebaseProvider.eventsRoot,
    );
  }
}
