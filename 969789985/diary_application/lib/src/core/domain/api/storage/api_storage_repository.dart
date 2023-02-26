import 'dart:io';

abstract class ApiStorageRepository {
  Future<File> loadImage(String filename);

  Future<void> saveImage(File file);

  Future<void> removeImage(String filename);
}