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
  final User? _user;

  DatabaseProvider()
      : _databaseReference = FirebaseDatabase.instance.ref('users'),
        _user = FirebaseAuth.instance.currentUser,
        _storageRef = FirebaseStorage.instance.ref('users');

  Stream<DatabaseEvent> get chatsStream =>
      _databaseReference.child('${_user!.uid}').child('chats').onValue;

  Stream<DatabaseEvent> get eventsStream =>
      _databaseReference.child('${_user!.uid}').child('events').onValue;

  Future<String> uploadImage(File file) async {
    if (_user != null) {
      final fileName = '${DateTime.now().toString()}.jpg';
      final reference = _storageRef.child('${_user!.uid}').child(fileName);
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
    if (_user != null) {
      final snapshot =
          await _databaseReference.child('${_user!.uid}').child('chats').get();
      return snapshot;
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> insertChat(Map<String, dynamic> chat) async {
    if (_user != null) {
      final chatsReference =
          _databaseReference.child('${_user!.uid}').child('chats');
      final chatIdRef = chatsReference.push();
      final id = chatIdRef.key;
      chat['id'] = id;
      await chatIdRef.set(chat);
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> updateChat(Map<String, dynamic> chat) async {
    if (_user != null) {
      final chatReference = _databaseReference
          .child('${_user!.uid}')
          .child('chats/${chat['id']}');
      await chatReference.update(chat);
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> deleteChat(String chatId) async {
    if (_user != null) {
      final chatReference =
          _databaseReference.child('${_user!.uid}').child('chats/$chatId');
      await chatReference.remove();

      final pathToEvents = '${_user!.uid}/events';
      final updates = <String, dynamic>{};
      final events = await queryAllEvents(chatId);
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

  Future<DataSnapshot> queryAllEvents(String chatId) async {
    if (_user != null) {
      final snapshot = await _databaseReference
          .child('${_user!.uid}')
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
    if (_user != null) {
      final eventsReference =
          _databaseReference.child('${_user!.uid}').child('events');
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
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> updateEvent(Map<String, dynamic> event) async {
    if (_user != null) {
      final eventReference = _databaseReference
          .child('${_user!.uid}')
          .child('events/${event['id']}');
      await eventReference.update(event);
    } else {
      throw Exception('Not signed in!!!');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    if (_user != null) {
      final eventReference =
          _databaseReference.child('${_user!.uid}').child('events/$eventId');
      await eventReference.remove();
    } else {
      throw Exception('Not signed in!!!');
    }
  }
}
