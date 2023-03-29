/*
final eventTable = 'Event';
final chatTable = 'Chat';
*/

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/event.dart';

class DatabaseProvider {
  final DatabaseReference _databaseReference;
  final Reference _storageRef;

  DatabaseProvider()
      : _databaseReference = FirebaseDatabase.instance.ref('users'),
        _storageRef = FirebaseStorage.instance.ref('users');

  User? get user => FirebaseAuth.instance.currentUser;

  Stream<DatabaseEvent> get chatsStream =>
      _databaseReference.child('${user!.uid}').child('chats').onValue;

  Stream<DatabaseEvent> get eventsStream =>
      _databaseReference.child('${user!.uid}').child('events').onValue;

  Future<String> uploadImage(File file) async {
    if (user != null) {
      final fileName = '${DateTime.now().toString()}.jpg';
      final reference = _storageRef.child('${user!.uid}').child(fileName);
      final metadata = SettableMetadata(contentType: 'image/jpeg');
      final uploadTask = reference.putFile(file, metadata);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<DataSnapshot> queryAllChats() async {
    if (user != null) {
      final snapshot =
          await _databaseReference.child('${user!.uid}').child('chats').get();
      return snapshot;
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> insertChat(Map<String, dynamic> chat) async {
    if (user != null) {
      final chatsReference =
          _databaseReference.child('${user!.uid}').child('chats');
      final chatIdRef = chatsReference.push();
      final id = chatIdRef.key;
      chat['id'] = id;
      await chatIdRef.set(chat);
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> updateChat(Map<String, dynamic> chat) async {
    if (user != null) {
      final chatReference =
          _databaseReference.child('${user!.uid}').child('chats/${chat['id']}');
      await chatReference.update(chat);
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> deleteChat(String chatId) async {
    if (user != null) {
      final chatReference =
          _databaseReference.child('${user!.uid}').child('chats/$chatId');
      await chatReference.remove();

      final pathToEvents = '${user!.uid}/events';
      final updates = <String, dynamic>{};
      final events = await queryChatEvents(chatId);
      for (var element in events.children) {
        final event = Event.fromDatabaseMap(
            Map<String, dynamic>.from(element.value as Map));
        updates['$pathToEvents/${event.id}'] = null;
      }
      _databaseReference.update(updates);
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> updateChatLastEvent(String chatId) async {
    final snapshot = await queryChatEvents(chatId);
    final updates = <String, dynamic>{};
    if (snapshot.exists) {
      final events = snapshot.children
          .map((event) => Event.fromDatabaseMap(
              Map<String, dynamic>.from(event.value as Map)))
          .toList()
        ..sort((a, b) => a.time.compareTo(b.time));

      if (events.isNotEmpty) {
        final lastEvent = events.last;
        updates['last_event_title'] = lastEvent.title;
        updates['last_event_time'] = lastEvent.time.toString();
      }
    } else {
      updates['last_event_title'] = 'No events. Click here to create one.';
      updates['last_event_time'] = null;
    }

    final chatReference =
        _databaseReference.child('${user!.uid}').child('chats/$chatId');

    await chatReference.update(updates);
  }

  Future<DataSnapshot> queryAllEvents() async {
    if (user != null) {
      final snapshot =
          await _databaseReference.child('${user!.uid}').child('events').get();
      return snapshot;
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<DataSnapshot> queryChatEvents(String chatId) async {
    if (user != null) {
      final snapshot = await _databaseReference
          .child('${user!.uid}')
          .child('events')
          .orderByChild('chat_id')
          .equalTo(chatId)
          .get();
      return snapshot;
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> insertEvent(Event event) async {
    if (user != null) {
      final eventsReference =
          _databaseReference.child('${user!.uid}').child('events');
      final eventIdRef = eventsReference.push();
      final id = eventIdRef.key;
      if (event.imagePath != null) {
        final url = await uploadImage(File(event.imagePath!));

        await eventIdRef.set(event
            .copyWith(
              newImagePath: url,
              newId: id,
            )
            .toDatabaseMap());
      } else {
        await eventIdRef.set(event
            .copyWith(
              newId: id,
            )
            .toDatabaseMap());
      }
      await updateChatLastEvent(event.chatId);
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> updateEvent(Map<String, dynamic> event) async {
    if (user != null) {
      final eventReference = _databaseReference
          .child('${user!.uid}')
          .child('events/${event['id']}');
      await eventReference.update(event);
      await updateChatLastEvent(event['chat_id']);
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> deleteEvent(Event event) async {
    if (user != null) {
      final eventReference =
          _databaseReference.child('${user!.uid}').child('events/${event.id}');
      await eventReference.remove();
      await updateChatLastEvent(event.chatId);
    } else {
      throw Exception('Not signed in!!!');
    }
  }
}
