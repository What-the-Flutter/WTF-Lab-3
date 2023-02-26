import 'package:firebase_database/firebase_database.dart';

import '../../../util/typedefs.dart';

abstract class UserReference {
  FId get firebaseUserId;

  DatabaseReference get userReference =>
      FirebaseDatabase.instance.ref('users/$firebaseUserId');
}