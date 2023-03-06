import 'dart:developer' as dev;
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../domain/provider/storage/api_storage_provider.dart';
import '../../../util/typedefs.dart';
import '../reference/storage_reference.dart';

class StorageSource extends StorageReference implements ApiStorageProvider {
  static FId _firebaseUserId = '';

  StorageSource({required FId firebaseUserId}) {
    _firebaseUserId = firebaseUserId;
  }

  @override
  FId get firebaseUserId => _firebaseUserId;

  @override
  Future<File> loadImage(String filename) async {
    final path = await filenamePath(filename);
    final file = File(path);

    if (await file.exists()) {
      return file;
    }

    await storageReference.child(path).writeToFile(file);
    return file;
  }

  @override
  Future<void> saveImage(File file) async {
    final filename = basename(file.path);
    final path = await filenamePath(filename);

    await file.copy(path);

    try {
      await storageReference.child(path).putFile(file);
    } on FirebaseException catch (err, stackTrace) {
      _logger(
        'Firebase exception (saving error): $err, $stackTrace',
        'Firebase_exception',
      );
    }
  }

  @override
  Future<void> removeImage(String filename) async {
    final path = await filenamePath(filename);

    await File(path).delete();
    await storageReference.child(path).delete();
  }

  @override
  Future<String> filenamePath(String filename) async {
    final path = await getApplicationDocumentsDirectory();
    return join(path.path, filename);
  }

  void _logger(String msg, String tag) => dev.log(msg, name: tag);
}
