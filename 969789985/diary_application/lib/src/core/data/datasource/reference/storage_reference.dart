import 'package:firebase_storage/firebase_storage.dart';

import '../../../util/typedefs.dart';

abstract class StorageReference {
  FId get firebaseUserId;

  Reference get storageReference =>
      FirebaseStorage.instance.ref('users/$firebaseUserId');
}
