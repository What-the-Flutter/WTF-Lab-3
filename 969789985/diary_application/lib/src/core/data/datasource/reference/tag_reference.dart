import 'package:firebase_database/firebase_database.dart';

import '../../../util/typedefs.dart';

abstract class TagReference {
  FId get firebaseUserId;

  DatabaseReference get tagsReference =>
      FirebaseDatabase.instance.ref('users/$firebaseUserId/tags');
}