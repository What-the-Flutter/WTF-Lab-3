import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../api/storage_provider_api.dart';
import '../utils/typedefs.dart';

class Storage extends StorageProviderApi {
  static Id _userId = '';

  static final maxDownloadSize = 5 * 1024 * 1024;

  Storage({required String userId}) {
    _userId = userId;
  }

  @override
  ValueStream<File> load(Id id) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<Id> save(File file) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<void> remove(Id id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  Reference get _ref {
    return FirebaseStorage.instance.ref('users/$_userId');
  }
}
