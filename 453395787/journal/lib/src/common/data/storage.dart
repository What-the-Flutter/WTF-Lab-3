import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../api/provider/storage_provider_api.dart';
import '../utils/typedefs.dart';

class Storage extends StorageProviderApi {
  static Id _userId = '';

  static final maxDownloadSize = 5 * 1024 * 1024;

  Storage({required String userId}) {
    _userId = userId;
  }

  @override
  Future<File> load(Id id) async {
    final saveDirectory = await getSaveDirectory();
    final filePath = join(saveDirectory.path, id);

    if (await File(filePath).exists()) {
      return File(filePath);
    }

    final file = File(filePath);
    await _ref.child(id).writeToFile(file);
    return file;
  }

  @override
  Future<void> save(File file) async {
    final saveDirectory = await getSaveDirectory();
    final filename = basename(file.path);
    final filePath = join(saveDirectory.path, filename);

    await file.copy(filePath);

    try {
      await _ref.child(filename).putFile(file);
    } on FirebaseException catch (error, stack) {
      Logger().e('Save error', error, stack);
    }
  }

  @override
  Future<void> remove(Id id) async {
    final saveDirectory = await getSaveDirectory();
    final filePath = join(saveDirectory.path, id);

    await File(filePath).delete();
    await _ref.child(id).delete();
  }

  Future<Directory> getSaveDirectory() async {
    return getApplicationDocumentsDirectory();
  }

  Reference get _ref {
    return FirebaseStorage.instance.ref('users/$_userId');
  }
}
