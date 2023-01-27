import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../api/provider/storage_provider_api.dart';
import '../../utils/app_logger.dart';
import '../../utils/typedefs.dart';

class StorageProvider extends StorageProviderApi with AppLogger {
  static Id _userId = '';

  StorageProvider({required String userId}) {
    _userId = userId;
  }

  @override
  Future<File> load(String filename) async {
    final filePath = await _getFilePath(filename);
    final file = File(filePath);

    if (await file.exists()) {
      return file;
    }

    await _ref.child(filename).writeToFile(file);
    return file;
  }

  @override
  Future<void> save(File file) async {
    final filename = basename(file.path);
    final filePath = await _getFilePath(filename);

    await file.copy(filePath);

    try {
      await _ref.child(filename).putFile(file);
    } on FirebaseException catch (error, stack) {
      log.e('Save error', error, stack);
    }
  }

  @override
  Future<void> remove(String filename) async {
    final filePath = await _getFilePath(filename);

    await File(filePath).delete();
    await _ref.child(filename).delete();
  }

  Future<String> _getFilePath(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return join(directory.path, filename);
  }

  Reference get _ref {
    return FirebaseStorage.instance.ref('users/$_userId');
  }
}
