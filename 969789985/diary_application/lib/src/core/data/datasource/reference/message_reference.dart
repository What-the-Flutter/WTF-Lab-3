import 'package:firebase_database/firebase_database.dart';

import '../../../util/typedefs.dart';

abstract class MessageReference {
  FId get firebaseUserId;

  DatabaseReference get messagesReference =>
      FirebaseDatabase.instance.ref('users/$firebaseUserId/messages');
}