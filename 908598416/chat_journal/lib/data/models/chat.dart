import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/firestore_constants.dart';

class Chat {
  final String chatId;
  final String userId;
  final String name;
  final bool isPinned;
  final String creationDate;
  final int iconIndex;

  Chat(
      {required this.chatId,
      required this.name,
      required this.userId,
      required this.isPinned,
      required this.creationDate,
      required this.iconIndex});

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.chatId: chatId,
      FirestoreConstants.name: name,
      FirestoreConstants.id: userId,
      FirestoreConstants.isPinned: isPinned,
      FirestoreConstants.creationDate: creationDate,
      FirestoreConstants.iconIndex: iconIndex
    };
  }

  factory Chat.fromDocument(DocumentSnapshot doc) {
    final String name = doc.get(FirestoreConstants.name);
    final String userId = doc.get(FirestoreConstants.id);
    final bool isPinned = doc.get(FirestoreConstants.isPinned);
    final String creationDate = doc.get(FirestoreConstants.creationDate);
    final int iconIndex = doc.get(FirestoreConstants.iconIndex);
    return Chat(chatId: doc.id, userId: userId, name: name, isPinned: isPinned, creationDate: creationDate, iconIndex: iconIndex);
  }

}
