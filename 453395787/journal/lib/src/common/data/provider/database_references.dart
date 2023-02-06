import 'package:firebase_database/firebase_database.dart';

mixin ChatsDatabaseReference {
  DatabaseReference chatsRef(String userId) =>
      FirebaseDatabase.instance.ref('users/$userId/chats');
}

mixin MessagesDatabaseReference {
  DatabaseReference messagesRef(String userId) =>
      FirebaseDatabase.instance.ref('users/$userId/messages');
}
