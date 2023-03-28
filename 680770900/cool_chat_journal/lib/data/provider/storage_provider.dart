import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

class StorageProvider {
  final _storageInstance = FirebaseStorage.instance;

  Future<void> upload({
    required String filename,
    required Uint8List data,
    String directory = 'images',
  }) async {
    final ref =
        _storageInstance.ref('${GetIt.I<User>().uid}/$directory/$filename');
    await ref.putData(data);
  }

  Future<Uint8List> download({
    required String filename,
    String directory = 'images',
  }) async {
    final ref =
        _storageInstance.ref('${GetIt.I<User>().uid}/$directory/$filename');

    const oneMegabyte = 1024 * 1024;
    final data = await ref.getData(oneMegabyte);

    return data ?? Uint8List(0);
  }

  Future<void> delete({
    required String filename,
    String directory = 'images',
  }) async {
    try {
      await _storageInstance
          .ref('${GetIt.I<User>().uid}/$directory/$filename')
          .delete();
    } on FirebaseException catch (_) {
      print("Storage hasn't images");
    }
  }
}
