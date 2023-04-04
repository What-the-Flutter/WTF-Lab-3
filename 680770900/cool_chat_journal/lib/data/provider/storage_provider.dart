import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider {
  final _storageInstance = FirebaseStorage.instance;

  final User user;

  StorageProvider({
    required this.user,
  });

  Future<void> upload({
    required String filename,
    required Uint8List data,
    String directory = 'images',
  }) async {
    final ref = _storageInstance.ref('${user.uid}/$directory/$filename');
    await ref.putData(data);
  }

  Future<Uint8List> download({
    required String filename,
    String directory = 'images',
  }) async {
    final ref = _storageInstance.ref('${user.uid}/$directory/$filename');

    const oneMegabyte = 1024 * 1024;
    final data = await ref.getData(oneMegabyte);

    return data ?? Uint8List(0);
  }

  Future<void> delete({
    required String filename,
    String directory = 'images',
  }) async {
    try {
      await _storageInstance.ref('${user.uid}/$directory/$filename').delete();
    } on FirebaseException catch (_) {
      print("Storage hasn't images");
    }
  }
}
