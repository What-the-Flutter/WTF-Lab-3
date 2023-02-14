import 'package:cloud_firestore/cloud_firestore.dart';

import '/constants/constants.dart';

class ChatUser {
  String id;
  String nickname;

  ChatUser({required this.id, required this.nickname});

  Map<String, String> toJson() {
    return {FirestoreConstants.nickname: nickname};
  }

  factory ChatUser.fromDocument(DocumentSnapshot doc) {
    var nickname = '';
    try {
      nickname = doc.get(FirestoreConstants.nickname);
    } catch (e) {}
    return ChatUser(
      id: doc.id,
      nickname: nickname,
    );
  }
}
