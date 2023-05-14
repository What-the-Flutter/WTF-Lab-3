import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataBaseService {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
  final Reference _storageRef = FirebaseStorage.instance.ref();

  Future<void> insertChat(Map<String, dynamic> row) async {
    databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('chats')
        .push()
        .set(row);
  }

  Future<void> updateChat(String id, Map<String, dynamic> newValue) async {
    databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('chats')
        .child(id)
        .update({
      'name': newValue['name'],
      'is_pinned': newValue['is_pinned'],
      'page_icon': newValue['page_icon'],
    });
  }

  Future<void> deleteChat(String id) async {
    databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('chats')
        .child(id)
        .remove(); //TODO delete all events from this chat
  }

  Future<List<Map<String, dynamic>>> queryAllChats(List<String> keys) async {
    final rawData = await databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('chats')
        .get();
    final listData = <Map<String, dynamic>>[];
    for (final chatElement in rawData.children) {
      final map = Map<String, dynamic>.from(chatElement.value as Map);
      listData.add(map);
      keys.add(chatElement.key.toString());
    }
    return listData;
  }

  Future<void> insertEvent(Map<String, dynamic> row) async {
    databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('events')
        .push()
        .set(row);
  }

  Future<String> loadImage(File imageFile) async {
    final uploadTask = await _storageRef
        .child(fireBaseAuth.currentUser!.uid)
        .putFile(imageFile);
    final downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> updateEvent(String id, Map<String, dynamic> newValue) async {
    databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('events')
        .child(id)
        .update({
      'chat_id': newValue['chat_id'],
      'text_data': newValue['text_data'],
      'is_done': newValue['is_done'],
      'is_favorite': newValue['is_favorite'],
    });
  }

  Future<void> deleteEvent(String id) async {
    databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('events')
        .child(id)
        .remove();
  }

  Future<List<Map<String, dynamic>>> queryAllEventsForChat(
      String chatId, List<String> keys) async {
    final rawData = await databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('events')
        .orderByChild('chat_id')
        .equalTo(chatId)
        .get();
    final listData = <Map<String, dynamic>>[];
    for (final eventElement in rawData.children) {
      final map = Map<String, dynamic>.from(eventElement.value as Map);
      listData.add(map);
      keys.add(eventElement.key.toString());
    }
    return listData;
  }

  Future<List<Map<String, dynamic>>> queryAllEventsForTimeLine(
      List<String> keys) async {
    final rawData = await databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('events')
        .get();
    final listData = <Map<String, dynamic>>[];
    for (final eventElement in rawData.children) {
      final map = Map<String, dynamic>.from(eventElement.value as Map);
      listData.add(map);
      keys.add(eventElement.key.toString());
    }
    return listData;
  }

  Future<void> insertTag(Map<String, dynamic> row) async {
    databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('tags')
        .push()
        .set(row);
  }

  Future<void> deleteTag(String id) async {
    databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('tags')
        .child(id)
        .remove();
  }

  Future<List<Map<String, dynamic>>> queryAllTags(List<String> keys) async {
    final rawData = await databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('tags')
        .get();
    final listData = <Map<String, dynamic>>[];
    for (final tagElement in rawData.children) {
      final map = Map<String, dynamic>.from(tagElement.value as Map);
      listData.add(map);
      keys.add(tagElement.key.toString());
    }
    return listData;
  }

  Future<StreamSubscription> initListenerEvents(String chatId) async {
    return databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('events')
        .orderByChild('chat_id')
        .equalTo(chatId)
        .onValue
        .listen(
          (event) {},
        );
  }

  Future<StreamSubscription> initListenerChats() async {
    return databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('chats')
        .onValue
        .listen(
          (event) {},
        );
  }

  Future<StreamSubscription> initListenerTags() async {
    return databaseRef
        .child(fireBaseAuth.currentUser!.uid)
        .child('tags')
        .onValue
        .listen(
          (tag) {},
        );
  }
}
