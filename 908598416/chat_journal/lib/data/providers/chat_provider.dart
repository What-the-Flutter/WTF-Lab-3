import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/firestore_constants.dart';
import '../models/chat.dart';

class ChatProvider {
  final FirebaseFirestore firebaseFirestore;

  ChatProvider({required this.firebaseFirestore});

  Future<void> updateDataFirestore(
      String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getStreamFireStore(
      String pathCollection, int limit, String userId, String? search) {

    if(search?.isNotEmpty == true){
      return firebaseFirestore
          .collection(pathCollection)
          .doc(userId)
          .collection(userId)
          .limit(limit)
          .where(FirestoreConstants.name, isEqualTo: search)
          .snapshots();
    }else{
      return firebaseFirestore
          .collection(pathCollection)
          .doc(userId)
          .collection(userId)
          .limit(limit)
          .snapshots();
    }
  }

  void addChat(String name, String currentUserId, int iconIndex) {
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
      creationDate: DateTime.now().toLocal().toString(),
      iconIndex: iconIndex,
    );

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
      String currentUserId, String chatId, String name, int iconIndex) async {
    final DocumentReference _documentReferencer = firebaseFirestore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(currentUserId)
        .collection(currentUserId)
        .doc(chatId);

    final _data = <String, dynamic>{FirestoreConstants.name : name, FirestoreConstants.iconIndex: iconIndex };

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
