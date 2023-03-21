import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_constants.dart';

class AppUser {
  final String id;
  final String nickname;

  AppUser({required this.id, required this.nickname});

  Map<String, String> toJson() {
    return {FirestoreConstants.nickname: nickname};
  }

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    var nickname = '';
    try {
      nickname = doc.get(FirestoreConstants.nickname);
    } catch (e) {
      print(e);
    }
    return AppUser(
      id: doc.id,
      nickname: nickname,
    );
  }
}
