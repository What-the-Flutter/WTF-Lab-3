import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/constants.dart';

class Chat {
  String chatId;
  String userId;
  String name;

  Chat({required this.chatId, required this.name, required this.userId});

  Map<String, String> toJson() {
    return {FirestoreConstants.name: name};
  }

  factory Chat.fromDocument(DocumentSnapshot doc) {
    var name = '';
    var userId = '';
    try {
      name = doc.get(FirestoreConstants.name);
      userId = doc.get(FirestoreConstants.id);
    } catch (e) {}
    return Chat(
      chatId: doc.id,
      userId: userId,
      name: name,
    );
  }
}
