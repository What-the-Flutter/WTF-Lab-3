import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../models/models.dart';
import '../provider/database_provider.dart';
import '../provider/storage_provider.dart';

class EventsRepository {
  final DatabaseProvider _databaseProvider;
  final StorageProvider _storageProvider;

  final imageCache = <String, Uint8List>{};
  final _eventsSubject = BehaviorSubject<List<Event>>();

  EventsRepository({required User? user})
      : _databaseProvider = DatabaseProvider(user: user),
        _storageProvider = StorageProvider(user: user);

  Stream<List<Event>> get eventsStream => _databaseProvider.eventsStream;

  Future<Uint8List> readImage(Event event) async {
    if (imageCache.keys.contains(event.id)) {
      return imageCache[event.id]!;
    } else {
      final image = await _storageProvider.download(
          filename: _generateImagePath(event));
      imageCache[event.id] = image;

      return image;
    }
  }

  Future<void> addEvent(Event event) async {
    await _databaseProvider.add(
      json: event.toJson(),
      tableName: '${DatabaseProvider.eventsRoot}',
    );

    if (event.image != null) {
      await _storageProvider.upload(
        filename: _generateImagePath(event),
        data: event.image!,
      );
    }
  }

  Future<void> deleteEvent(Event event) async {
    if (event.image != null) {
      await _storageProvider.delete(filename: _generateImagePath(event));
    }

    await _databaseProvider.delete(
      id: event.id,
      tableName: _generateEventPath(event),
    );
  }

  Future<void> updateEvent(Event event) async {
    if (event.image != null) {
      await _storageProvider.upload(
        filename: _generateImagePath(event),
        data: event.image!,
      );
    }

    await _databaseProvider.add(
      json: event.toJson(),
      tableName: _generateEventPath(event),
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

  Future<void> deleteEventsFromChat(String chatId) async {
    final events = await _databaseProvider.eventsStream.last;
    final deletedEvents = events.where((event) => event.chatId == chatId);

    for (final event in deletedEvents) {
      await deleteEvent(event);
    }
  }

  String _generateImagePath(Event event) {
    return event.id;
  }

  String _generateEventPath(Event event) {
    return '${DatabaseProvider.eventsRoot}';
  }
}
