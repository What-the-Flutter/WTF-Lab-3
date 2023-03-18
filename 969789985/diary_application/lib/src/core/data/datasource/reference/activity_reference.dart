import 'package:firebase_database/firebase_database.dart';

import '../../../util/typedefs.dart';

abstract class ActivityReference {
  FId get firebaseUserId;

  DatabaseReference get activityReference =>
      FirebaseDatabase.instance.ref('users/$firebaseUserId/activity');
}