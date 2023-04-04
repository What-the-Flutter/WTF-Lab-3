import 'dart:typed_data';

import 'package:cool_chat_journal/data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'events_repository_test.mocks.dart';

@GenerateMocks([DatabaseProvider, StorageProvider, TagsRepository])
void main() {
  group('EventsRepository', () {
    group('readImage', () {
      test('load image from storage', () async {
        final databaseProvider = MockDatabaseProvider();
        final storageProvider = MockStorageProvider();
        final tagsRepository = TagsRepository(databaseProvider);

        final testedImage = Uint8List(42);
        final testedEvent = Event(
          isFavorite: false,
          changeTime: DateTime.now(),
          chatId: 'random_id',
          categoryId: null,
        );

        when(storageProvider.download(filename: testedEvent.id))
          .thenAnswer((_) => Future(() => testedImage));

        final eventsRepository = 
          EventsRepository(databaseProvider, storageProvider, tagsRepository);

        expect(await eventsRepository.readImage(testedEvent), testedImage);
      });

      test('load image from cache', () async {
        final databaseProvider = MockDatabaseProvider();
        final storageProvider = MockStorageProvider();
        final tagsRepository = TagsRepository(databaseProvider);

        final testedImage = Uint8List(64);
        final testedEvent = Event(
          isFavorite: false,
          changeTime: DateTime.now(),
          chatId: 'random_id',
          categoryId: null,
        );

        when(storageProvider.download(filename: testedEvent.id))
          .thenAnswer((_) => Future(() => testedImage));

        final eventsRepository = 
          EventsRepository(databaseProvider, storageProvider, tagsRepository);

        await eventsRepository.readImage(testedEvent);
        expect(await eventsRepository.readImage(testedEvent), testedImage);
      });
    });
  });
}