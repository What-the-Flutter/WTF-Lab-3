import 'package:firebase_database/firebase_database.dart';

import '../../utils/typedefs.dart';

abstract class BaseProvider {
  Id get userId;

  DatabaseReference get usersRef {
    return FirebaseDatabase.instance.ref('users/$userId');
  }

  DatabaseReference get chatsRef {
    return FirebaseDatabase.instance.ref('users/$userId/chats');
  }

  DatabaseReference get tagsRef {
    return FirebaseDatabase.instance.ref('users/$userId/tags');
  }

  DatabaseReference get messagesRef {
    return FirebaseDatabase.instance.ref('users/$userId/messages');
  }
}
