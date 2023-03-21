import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class StorageProvider {
  final User? user;
  final _storageInstance = FirebaseStorage.instance;

  StorageProvider({required this.user});

  Future<void> uploadFromFile({
    required String filename,
    required File file,
    String directory = 'images',
  }) async {
    final ref = _storageInstance.ref('${user?.uid}/$directory/$filename');
    await ref.putFile(file);
  }

  Future<void> uploadFromMemory({
    required String filename,
    required Uint8List data,
    String directory = 'images',
  }) async {
    final ref = _storageInstance.ref('${user?.uid}/$directory/$filename');
    await ref.putData(data);
  }

  Future<void> uploadFromBase64({
    required String filename,
    required String base64,
    String directory = 'images',
  }) async {
    final ref = _storageInstance.ref('${user?.uid}/$directory/$filename');
    await ref.putString(base64);
  }

  Future<Uint8List> download({
    required String filename,
    String directory = 'images',
  }) async {
    final ref = _storageInstance.ref('${user?.uid}/$directory/$filename');

    const oneMegabyte = 1024 * 1024;
    final data = await ref.getData(oneMegabyte);

    return data ?? Uint8List(0);
  }

  Future<void> delete({
    required String filename,
    String directory = 'images',
  }) async {
    await _storageInstance.ref('${user?.uid}/$directory/$filename').delete();
  }
}