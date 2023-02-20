import 'package:firebase_database/firebase_database.dart';

import '../../../util/typedefs.dart';

abstract class ChatReference {
  FId get firebaseUserId;

  DatabaseReference get chatsReference =>
      FirebaseDatabase.instance.ref('users/$firebaseUserId/chats');
}