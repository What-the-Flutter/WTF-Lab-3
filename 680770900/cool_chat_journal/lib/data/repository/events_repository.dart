import 'dart:typed_data';

import 'package:hashtagable/functions.dart';

import '../models/models.dart';
import '../provider/provider.dart';
import 'tags_repository.dart';

class EventsRepository {
  final _imageCache = <String, Uint8List>{};

  final DatabaseProvider databaseProvider;
  final StorageProvider storageProvider;
  final TagsRepository tagsRepository;

  EventsRepository({
    required this.databaseProvider,
    required this.storageProvider,
    required this.tagsRepository,
  });

  Stream<List<Event>> get eventsStream =>
      databaseProvider.eventsStream;

  Future<Uint8List> readImage(Event event) async {
    if (_imageCache.keys.contains(event.id)) {
      return _imageCache[event.id]!;
    } else {
      final image = await storageProvider
          .download(filename: _generateImagePath(event));
      _imageCache[event.id] = image;

      return image;
    }
  }

  Future<void> addEvent(Event event) async {
    await databaseProvider.add(
      json: event.toJson(),
      tableName: '${DatabaseProvider.eventsRoot}',
    );

    if (event.image != null) {
      await storageProvider.upload(
        filename: _generateImagePath(event),
        data: event.image!,
      );
    }

    if (event.content != null) {
      final tags = extractHashTags(event.content!);

      for (final tag in tags) {
        await tagsRepository.addTag(tag);
      }
    }
  }

  Future<void> deleteEvent(Event event) async {
    if (event.image != null) {
      await storageProvider
          .delete(filename: _generateImagePath(event));
    }

    if (event.content != null) {
      final tags = extractHashTags(event.content!);

      for (final tag in tags) {
        await tagsRepository.deleteLink(tag.substring(1));
      }
    }

    await databaseProvider.delete(
      id: event.id,
      tableName: _generateEventPath(event),
    );
  }

  Future<void> updateEvent(Event event) async {
    if (event.image != null) {
      await storageProvider.upload(
        filename: _generateImagePath(event),
        data: event.image!,
      );
    }

    await databaseProvider.add(
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
    final jsonEvents = await databaseProvider.read<Event>(
      tableName: DatabaseProvider.eventsRoot,
    );

    final deletedEvents = jsonEvents
        .map(Event.fromJson)
        .where((event) => event.chatId == chatId)
        .toList();

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
