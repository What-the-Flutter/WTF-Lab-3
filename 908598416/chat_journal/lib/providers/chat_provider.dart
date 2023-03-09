import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../models/models.dart';

class ChatProvider {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider(
      {required this.firebaseFirestore,
      required this.prefs,
      required this.firebaseStorage});

  UploadTask uploadFile(File image, String fileName) {
    final _reference = firebaseStorage.ref().child(fileName);
    final _uploadTask = _reference.putFile(image);
    return _uploadTask;
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Future<void> updateMessage(
      String currentUserId, String chatId, String id, String text) async {
    final DocumentReference documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .doc(id);

    final _data = <String, dynamic>{'content': text};

    await documentReferencer
        .update(_data)
        .whenComplete(() => print('Сообщение успешно обновлено'))
        .catchError(print);
  }

  Future<void> pinMessage(
      String currentUserId, String chatId, String id, bool isPinned) async {
    final DocumentReference _documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .doc(id);

    final _data = <String, dynamic>{FirestoreConstants.isPinned: !isPinned};

    await _documentReferencer
        .update(_data)
        .whenComplete(() => print(isPinned
            ? 'Сообщение успешно откреплено'
            : 'Сообщение успешно закреплено'))
        .catchError(print);
  }

  Future<void> deleteMessage(
      String currentUserId, String chatId, String id) async {
    final DocumentReference _documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .doc(id);

    await _documentReferencer
        .delete()
        .whenComplete(() => print('сообщение удалено!'))
        .catchError(print);
  }

  Stream<QuerySnapshot> getChatStream(
      String currentUserId, String chatId, int limit) {
    return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(
      String content, int type, String chatId, String currentUserId) {
    final DocumentReference _documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    final _messageChat = Message(
        chatId: chatId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type,
        isPinned: false);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        _documentReference,
        _messageChat.toJson(),
      );
    });
  }

  void addChat(String name, String currentUserId) {
    final _chatId = name.hashCode.toString();
    final DocumentReference _documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(currentUserId)
        .collection(currentUserId)
        .doc(_chatId);

    final _chat = Chat(
        chatId: _chatId,
        name: name,
        userId: currentUserId,
        isPinned: false,
        creationDate: DateTime.now().toLocal().toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        _documentReference,
        _chat.toJson(),
      );
    });
  }

  Future<void> deleteChat(String currentUserId, String chatId) async {
    final DocumentReference _chat = firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(currentUserId)
        .collection(currentUserId)
        .doc(chatId);

    final _messages = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId);

    await _chat
        .delete()
        .whenComplete(() => print('Чат удален!'))
        .catchError(print);

    await _messages.get().then((snapshot) {
      for (final DocumentSnapshot _ds in snapshot.docs) {
        _ds.reference.delete();
      }
    });
  }

  Future<void> updateChat(
      String currentUserId, String chatId, String text) async {
    final DocumentReference _documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(currentUserId)
        .collection(currentUserId)
        .doc(chatId);

    final _data = <String, dynamic>{'name': text};

    await _documentReferencer
        .update(_data)
        .whenComplete(() => print('Чат успешно обновлен'))
        .catchError(print);
  }

  Future<void> pinChat(String currentUserId, String chatId) async {
    late final bool isPinned;
    DocumentReference _documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(currentUserId)
        .collection(currentUserId)
        .doc(chatId);

    await _documentReferencer
        .get()
        .then((value) => {isPinned = value.get('isPinned')});

    final _data = <String, dynamic>{'isPinned': !isPinned};

    await _documentReferencer
        .update(_data)
        .whenComplete(() =>
            print(isPinned ? 'Чат успешно откреплен' : 'Чат успешно закреплен'))
        .catchError(print);
  }

  Future<void> getInfo(
      BuildContext context, String userId, String chatId) async {
    late var _createdAt = '';
    await firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(userId)
        .collection(userId)
        .doc(chatId)
        .get()
        .then(
            (value) => _createdAt = value.get(FirestoreConstants.creationDate));

    return showDialog<void>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('info about chat'),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('it was created at: $_createdAt'),
              )
            ],
          );
        });
  }

  int compare(dynamic a, dynamic b) {
    if(a.isPinned){
      if(b.isPinned){
        return 0;
      }
      else {
        return -1;
      }
    }
    else if(b.isPinned){
      return 1;
    }
    return 0;
  }
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
}
