import 'dart:async';
import 'dart:io';

import 'package:diary_application/data/entities/chat_db.dart';
import 'package:diary_application/data/entities/event_db.dart';
import 'package:diary_application/data/entities/tag_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'api_firebase_provider.dart';

class FirebaseProvider extends ApiDataProvider {
  final User? _user;
  final DatabaseReference _ref;
  final Reference _storage;
  late final Stream<DatabaseEvent> _dbTagStream;
  late final Stream<DatabaseEvent> _dbEventStream;
  late final Stream<DatabaseEvent> _dbChatStream;

  static final String chatsFolder = 'chats';
  static final String eventsFolder = 'events';
  static final String tagsFolder = 'tags';

  FirebaseProvider({required User? user})
      : _ref = FirebaseDatabase.instance.ref(user?.uid ?? ''),
        _user = user,
        _storage = FirebaseStorage.instance.ref(user?.uid ?? '') {
    _init();
  }

  void _init() {
    _dbChatStream = _ref.child(chatsFolder).onValue;
    _dbEventStream = _ref.child(eventsFolder).onValue;
    _dbTagStream = _ref.child(tagsFolder).onValue;
  }

  @override
  Stream<List<ChatDB>> get chatsStream =>
      _dbChatStream.map<List<ChatDB>>(_db2Chats);

  List<ChatDB> _db2Chats(DatabaseEvent data) {
    final list = <ChatDB>[];
    for (final dbChat in data.snapshot.children) {
      final map = dbChat.value as Map<dynamic, dynamic>;
      list.add(ChatDB.map2Json(map));
    }
    return list;
  }

  @override
  Future<String> addChat(ChatDB chat) async {
    final ref = _ref.child(chatsFolder).push();
    await ref.set(chat.copyWith(id: ref.key!).map);
    return ref.key!;
  }

  @override
  Future<List<ChatDB>> get chats async {
    final result = <ChatDB>[];
    final dbChats = await _ref.child(chatsFolder).once();
    for (final dbChat in dbChats.snapshot.children) {
      final map = dbChat.value as Map<dynamic, dynamic>;
      result.add(ChatDB.map2Json(map));
    }
    return result;
  }

  @override
  Future<void> deleteChat(ChatDB chat) async {
    await _ref.child('$chatsFolder/${chat.id}').remove();
  }

  @override
  Future<ChatDB> getChat(String id) async {
    final dbChat =
        await _ref.child(chatsFolder).orderByChild('id').equalTo(id).once();
    final map = dbChat.snapshot.children.first.value as Map<dynamic, dynamic>;
    return ChatDB.map2Json(map);
  }

  @override
  Future<void> updateChat(ChatDB chat) async {
    await _ref.child('$chatsFolder/${chat.id}').update(chat.map);
  }

  @override
  Stream<List<EventDB>> get eventsStream =>
      _dbEventStream.map<List<EventDB>>(_transformToListEvents);

  List<EventDB> _transformToListEvents(DatabaseEvent data) {
    final result = <EventDB>[];
    for (final dbEvent in data.snapshot.children) {
      final map = dbEvent.value as Map<dynamic, dynamic>;
      result.add(EventDB.map2Json(map));
    }
    return result;
  }

  @override
  Future<String> addEvent(EventDB event) async {
    final ref = _ref.child(eventsFolder).push();
    EventDB newEvent;
    newEvent = event.copyWith(id: ref.key);

    if (newEvent.photoPath.isNotEmpty) {
      await _storage
          .child('$eventsFolder/${newEvent.id}')
          .putFile(File(newEvent.photoPath));
      final path =
          await _storage.child('$eventsFolder/${newEvent.id}').getDownloadURL();
      newEvent = newEvent.copyWith(photoPath: path);
    }

    await ref.set(newEvent.map);
    return ref.key!;
  }

  @override
  Future<void> deleteEvent(EventDB event) async {
    await _ref.child('$eventsFolder/${event.id}').remove();
  }

  @override
  Future<List<EventDB>> get events async {
    final result = <EventDB>[];
    final dbEvents = await _ref.child(eventsFolder).once();
    for (final dbEvent in dbEvents.snapshot.children) {
      final map = dbEvent.value as Map<dynamic, dynamic>;
      result.add(EventDB.map2Json(map));
    }
    return result;
  }

  @override
  Future<void> updateEvent(EventDB event) async {
    await _ref.child('$eventsFolder/${event.id}').update(event.map);
  }

  @override
  Stream<List<TagDB>> get tagsStream =>
      _dbEventStream.map<List<TagDB>>(_transformToListTags);

  List<TagDB> _transformToListTags(DatabaseEvent data) {
    final result = <TagDB>[];
    for (final dbTag in data.snapshot.children) {
      final map = dbTag.value as Map<dynamic, dynamic>;
      result.add(TagDB.map2Json(map));
    }
    return result;
  }

  @override
  Future<String> addTag(TagDB tag) async {
    final ref = _ref.child(tagsFolder).push();
    await ref.set(tag.copyWith(id: ref.key!).map);
    return ref.key!;
  }

  @override
  Future<List<TagDB>> get tags async {
    final result = <TagDB>[];
    final dbTags = await _ref.child(tagsFolder).once();
    for (final dbTag in dbTags.snapshot.children) {
      final map = dbTag.value as Map<dynamic, dynamic>;
      result.add(TagDB.map2Json(map));
    }
    return result;
  }

  @override
  Future<void> deleteTag(TagDB tag) =>
      _ref.child('$tagsFolder/${tag.id}').remove();

  @override
  Future<void> updateTag(TagDB tag) =>
      _ref.child('$tagsFolder/${tag.id}').update(tag.map);
}
