import 'dart:typed_data';

import 'package:hashtagable/functions.dart';

import '../models/models.dart';
import '../provider/provider.dart';
import 'tags_repository.dart';

class EventsRepository {
  final _imageCache = <String, Uint8List>{};
  final DatabaseProvider _databaseProvider;
  final StorageProvider _storageProvider;
  final TagsRepository _tagsRepository;

  EventsRepository(
    this._databaseProvider,
    this._storageProvider,
    this._tagsRepository,
  );

  Stream<List<Event>> get eventsStream => _databaseProvider.eventsStream;

  Future<Uint8List> readImage(Event event) async {
    if (_imageCache.keys.contains(event.id)) {
      return _imageCache[event.id]!;
    } else {
      final image =
          await _storageProvider.download(filename: _generateImagePath(event));
      _imageCache[event.id] = image;

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

    if (event.content != null) {
      final tags = extractHashTags(event.content!);

      for (final tag in tags) {
        await _tagsRepository.addTag(tag);
      }
    }
  }

  Future<void> deleteEvent(Event event) async {
    if (event.image != null) {
      await _storageProvider.delete(filename: _generateImagePath(event));
    }

    if (event.content != null) {
      final tags = extractHashTags(event.content!);

      for (final tag in tags) {
        await _tagsRepository.deleteLink(tag.substring(1));
      }
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

  Future<void> addEvents(List<Event> events) async {
    for (final event in events) {
      await addEvent(event);
    }
  }

  Future<void> updateEvents(List<Event> events) async {
    for (final event in events) {
      await updateEvent(event);
    }
  }

  Future<void> deleteEventsFromChat(String chatId) async {
    final jsonEvents = await _databaseProvider.read<Event>(
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
