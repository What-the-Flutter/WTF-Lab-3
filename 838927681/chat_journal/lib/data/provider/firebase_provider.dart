import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/db_chat.dart';
import '../models/db_event.dart';
import '../repository/api_provider/api_data_provider.dart';

class FirebaseProvider extends ApiDataProvider {
  final _database = FirebaseDatabase.instance;
  final _ref = FirebaseDatabase.instance.ref();
  final _storage = FirebaseStorage.instance.ref();
  final User? user;
  late final StreamSubscription dbEventsSubscription;
  late final StreamSubscription dbChatsSubscription;
  final dbChatStreamController = StreamController<List<DBChat>>();
  final dbEventStreamController = StreamController<List<DBEvent>>();

  FirebaseProvider({required this.user}) {
    _init();
  }

  void _init() {
    dbEventsSubscription =
        _ref.child(user?.uid ?? '').child('events').onValue.listen(
      (data) {
        var result = <DBEvent>[];
        for (final dbEvent in data.snapshot.children) {
          final map = dbEvent.value as Map<dynamic, dynamic>;
          result.add(DBEvent.fromJson(map));
        }
        dbEventStreamController.add(result);
      },
    );
    dbChatsSubscription =
        _ref.child(user?.uid ?? '').child('chats').onValue.listen(
      (data) {
        var result = <DBChat>[];
        for (final dbChat in data.snapshot.children) {
          final map = dbChat.value as Map<dynamic, dynamic>;
          result.add(DBChat.fromJson(map));
        }
        dbChatStreamController.add(result);
      },
    );
  }

  @override
  Stream<List<DBChat>> get chatsStream => dbChatStreamController.stream;

  @override
  Stream<List<DBEvent>> get eventsStream => dbEventStreamController.stream;

  @override
  Future<String> addChat(DBChat chat) async {
    final ref = _ref.child(user?.uid ?? '').child('chats').push();
    await ref.set(chat.copyWith(id: ref.key!).toMap());
    return ref.key!;
  }

  @override
  Future<String> addEvent(DBEvent event) async {
    final ref = _ref.child(user?.uid ?? '').child('events').push();
    final DBEvent newEvent;
    if (event.imagePath != '') {
      await _storage
          .child(user?.uid ?? '')
          .child('events/${event.id}')
          .putFile(File(event.imagePath));
      final newPath = await _storage
          .child(user?.uid ?? '')
          .child('events/${event.id}')
          .getDownloadURL();
      newEvent = event.copyWith(imagePath: newPath, id: ref.key);
    } else {
      newEvent = event.copyWith(id: ref.key);
    }
    await ref.set(newEvent.toMap());
    return ref.key!;
  }

  @override
  Future<List<DBChat>> get chats async {
    var result = <DBChat>[];
    final dbChats = await _ref.child(user?.uid ?? '').child('chats').once();
    for (final dbChat in dbChats.snapshot.children) {
      final map = dbChat.value as Map<dynamic, dynamic>;
      result.add(DBChat.fromJson(map));
    }
    return result;
  }

  @override
  Future<void> deleteChat(DBChat chat) async {
    await _ref.child(user?.uid ?? '').child('chats/${chat.id}').remove();
  }

  @override
  Future<void> deleteEvent(DBEvent event) async {
    await _ref.child(user?.uid ?? '').child('events/${event.id}').remove();
  }

  @override
  Future<List<DBEvent>> get events async {
    var result = <DBEvent>[];
    final dbEvents = await _ref.child(user?.uid ?? '').child('events').once();
    for (final dbEvent in dbEvents.snapshot.children) {
      final map = dbEvent.value as Map<dynamic, dynamic>;
      result.add(DBEvent.fromJson(map));
    }
    return result;
  }

  @override
  Future<DBChat> getChat(String id) async {
    final dbChat = await _ref
        .child(user?.uid ?? '')
        .child('chats')
        .orderByChild('id')
        .equalTo(id)
        .once();
    final map = dbChat.snapshot.children.first.value as Map<dynamic, dynamic>;
    return DBChat.fromJson(map);
  }

  @override
  Future<void> updateChat(DBChat chat) async {
    await _ref
        .child(user?.uid ?? '')
        .child('chats/${chat.id}')
        .update(chat.toMap());
  }

  @override
  Future<void> updateEvent(DBEvent event) async {
    await _ref
        .child(user?.uid ?? '')
        .child('events/${event.id}')
        .update(event.toMap());
  }
}
