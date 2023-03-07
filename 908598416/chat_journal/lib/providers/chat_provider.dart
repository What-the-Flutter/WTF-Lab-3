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

  String? getPref(String key) {
    return prefs.getString(key);
  }

  UploadTask uploadFile(File image, String fileName) {
    var reference = firebaseStorage.ref().child(fileName);
    var uploadTask = reference.putFile(image);
    return uploadTask;
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
    DocumentReference documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .doc(id);

    var data = <String, dynamic>{'content': text};

    await documentReferencer
        .update(data)
        .whenComplete(() => print('Сообщение успешно обновлено'))
        .catchError(print);
  }

  Future<void> pinMessage(
      String currentUserId, String chatId, String id, bool isFavorite) async {
    DocumentReference documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .doc(id);

    var data = <String, dynamic>{'isFavorite': !isFavorite};

    await documentReferencer
        .update(data)
        .whenComplete(() => print(isFavorite
            ? 'Сообщение успешно откреплено'
            : 'Сообщение успешно закреплено'))
        .catchError(print);
  }

  Future<void> deleteMessage(
      String currentUserId, String chatId, String id) async {
    DocumentReference documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .doc(id);

    await documentReferencer
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
    DocumentReference documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    var messageChat = Message(
        chatId: chatId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type,
        isFavorite: false);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }

  void addChat(String name, String currentUserId) {
    var chatId = name.hashCode.toString();
    DocumentReference documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(currentUserId)
        .collection(currentUserId)
        .doc(chatId);

    final chat = Chat(
        chatId: chatId,
        name: name,
        userId: currentUserId,
        isPinned: false,
        creationDate: DateTime.now().toLocal().toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        chat.toJson(),
      );
    });
  }

  Future<void> deleteChat(String currentUserId, String chatId) async {
    DocumentReference chat = firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(currentUserId)
        .collection(currentUserId)
        .doc(chatId);

    var messages = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId);

    await chat
        .delete()
        .whenComplete(() => print('Чат удален!'))
        .catchError(print);

    await messages.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future<void> updateChat(
      String currentUserId, String chatId, String text) async {
    DocumentReference documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(currentUserId)
        .collection(currentUserId)
        .doc(chatId);

    var data = <String, dynamic>{'name': text};

    await documentReferencer
        .update(data)
        .whenComplete(() => print('Чат успешно обновлен'))
        .catchError(print);
  }

  Future<void> pinChat(String currentUserId, String chatId) async {
    late bool isPinned;
    DocumentReference documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(currentUserId)
        .collection(currentUserId)
        .doc(chatId);

    await documentReferencer
        .get()
        .then((value) => {isPinned = value.get('isPinned')});

    var data = <String, dynamic>{'isPinned': !isPinned};

    await documentReferencer
        .update(data)
        .whenComplete(() =>
            print(isPinned ? 'Чат успешно откреплен' : 'Чат успешно закреплен'))
        .catchError(print);
  }

  Future<void> getInfo(
      BuildContext context, String userId, String chatId) async {
    var createdAt = '';
    await firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(userId)
        .collection(userId)
        .doc(chatId)
        .get()
        .then(
            (value) => createdAt = value.get(FirestoreConstants.creationDate));

    return showDialog<void>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('info about chat'),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('it was created at: $createdAt'),
              )
            ],
          );
        });
  }
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
}
