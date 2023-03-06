import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/constants.dart';

class Message {
  final String chatId;
  final String timestamp;
  final String content;
  final int type;
  final bool isFavorite;

  Message({
    required this.chatId,
    required this.timestamp,
    required this.content,
    required this.type,
    required this.isFavorite
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.chatId: chatId,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
      FirestoreConstants.isFavorite: isFavorite
    };
  }

  factory Message.fromDocument(DocumentSnapshot doc) {
    final String chatId = doc.get(FirestoreConstants.chatId);
    final String timestamp = doc.get(FirestoreConstants.timestamp);
    final String content = doc.get(FirestoreConstants.content);
    final int type = doc.get(FirestoreConstants.type);
    final bool isFavorite = doc.get(FirestoreConstants.isFavorite);
    return Message(chatId: chatId, timestamp: timestamp, content: content, type: type, isFavorite: isFavorite);
  }
}