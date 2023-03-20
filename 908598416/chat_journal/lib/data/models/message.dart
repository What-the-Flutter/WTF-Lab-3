import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_constants.dart';

class Message {
  final String chatId;
  final String timestamp;
  final String content;
  final int type;
  final bool isPinned;

  Message(
      {required this.chatId,
      required this.timestamp,
      required this.content,
      required this.type,
      required this.isPinned});

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.chatId: chatId,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
      FirestoreConstants.isPinned: isPinned
    };
  }

  factory Message.fromDocument(DocumentSnapshot doc) {
    final String chatId = doc.get(FirestoreConstants.chatId);
    final String timestamp = doc.get(FirestoreConstants.timestamp);
    final String content = doc.get(FirestoreConstants.content);
    final int type = doc.get(FirestoreConstants.type);
    final bool isPinned = doc.get(FirestoreConstants.isPinned);
    return Message(
        chatId: chatId,
        timestamp: timestamp,
        content: content,
        type: type,
        isPinned: isPinned);
  }
}
