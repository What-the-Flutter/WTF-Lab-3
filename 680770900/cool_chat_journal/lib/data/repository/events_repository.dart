import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';
import '../provider/database_provider.dart';
import '../provider/storage_provider.dart';

class EventsRepository {
  final DatabaseProvider _databaseProvider;
  final StorageProvider _storageProvider;

  EventsRepository({required User? user}) 
    : _databaseProvider = DatabaseProvider(user: user),
      _storageProvider = StorageProvider(user: user);

  Future<List<Event>> readEvents(String chatId) async {
    final jsonEvents = await _databaseProvider.read<Event>(
      tableName: '${DatabaseProvider.eventsRoot}/$chatId',
    );

    final allEvents = jsonEvents.map(Event.fromJson);

    final images = allEvents.where((event) => event.content == null);
    final events = allEvents.where((event) => event.content != null).toList();

    for (final imageEvent in images) {
      final image = await _storageProvider
        .download(filename: '${imageEvent.chatId}/${imageEvent.id}');

      events.add(imageEvent.copyWith(
        image: NullWrapper<Uint8List?>(image),
      ));
    }

    return events;
  }

  Future<void> addEvent(Event event) async {
    await _databaseProvider.add(
      json: event.toJson(),
      tableName: '${DatabaseProvider.eventsRoot}/${event.chatId}',
    );

    if (event.image != null) {
      await _storageProvider.uploadFromMemory(
        filename: '${event.chatId}/${event.id}',
        data: event.image!,
      );
    }
  }
    

  Future<void> deleteEvent(Event event) async {
    if (event.image != null) {
      await _storageProvider.delete(filename: '${event.chatId}/${event.id}');
    }

    await _databaseProvider.delete(
      id: event.id,
      tableName: '${DatabaseProvider.eventsRoot}/${event.chatId}',
    );
  }
    

  Future<void> updateEvent(Event event) async {
    if (event.image != null) {
      await _storageProvider.uploadFromMemory(
        filename: '${event.chatId}/${event.id}',
        data: event.image!,
      );
    }

    await _databaseProvider.delete(
      id: event.id,
      tableName: '${DatabaseProvider.eventsRoot}/${event.chatId}',  
    );
    await _databaseProvider.add(
      json: event.toJson(),
      tableName: '${DatabaseProvider.eventsRoot}/${event.chatId}',
    );
  }

  Future<void> deleteEventsFromChat(String chatId) async {
    await _storageProvider.delete(
      filename: chatId,
    );

    await _databaseProvider.delete(
      id: chatId,
      tableName: DatabaseProvider.eventsRoot,
    );
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
}
