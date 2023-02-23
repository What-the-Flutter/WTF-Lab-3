import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/constants.dart';

class MessageChat {
  String chatId;
  String timestamp;
  String content;
  int type;

  MessageChat({
    required this.chatId,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.chatId: chatId,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    String chatId = doc.get(FirestoreConstants.chatId);
    String timestamp = doc.get(FirestoreConstants.timestamp);
    String content = doc.get(FirestoreConstants.content);
    int type = doc.get(FirestoreConstants.type);
    return MessageChat(chatId: chatId, timestamp: timestamp, content: content, type: type);
  }
}