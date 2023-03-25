import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/firestore_constants.dart';
import '../models/models.dart';

class MessageProvider {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  MessageProvider({required this.firebaseFirestore,
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

  Future<void> updateMessage(String currentUserId, String chatId, String id,
      String text) async {
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

  Future<void> pinMessage(String currentUserId, String chatId, String id,
      bool isPinned) async {
    final DocumentReference _documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .doc(id);

    final _data = <String, dynamic>{FirestoreConstants.isPinned: !isPinned};

    await _documentReferencer
        .update(_data)
        .whenComplete(() =>
        print(isPinned
            ? 'Сообщение успешно откреплено'
            : 'Сообщение успешно закреплено'))
        .catchError(print);
  }

  Future<void> deleteMessage(String currentUserId, String chatId,
      String id) async {
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

  Stream<QuerySnapshot> getMessageStream(String currentUserId, String chatId,
      int limit, String? search) {
    if(search?.isNotEmpty == true){
      return firebaseFirestore
          .collection(FirestoreConstants.pathMessageCollection)
          .doc(currentUserId)
          .collection(chatId)
          .orderBy(FirestoreConstants.timestamp, descending: true)
          .limit(limit)
          .where(FirestoreConstants.content, isEqualTo: search)
          .snapshots();
    }
    else{return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();}
  }

  void sendMessage(String content, int type, String chatId,
      String currentUserId) {
    final DocumentReference _documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(chatId)
        .doc(DateTime
        .now()
        .millisecondsSinceEpoch
        .toString());

    final _messageChat = Message(
        chatId: chatId,
        timestamp: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
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


  int compare(dynamic a, dynamic b) {
    if (a.isPinned) {
      if (b.isPinned) {
        return 0;
      } else {
        return -1;
      }
    } else if (b.isPinned) {
      return 1;
    }
    return 0;
  }
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
}
