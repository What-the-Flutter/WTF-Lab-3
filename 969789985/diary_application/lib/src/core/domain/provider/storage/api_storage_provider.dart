import 'dart:io';

abstract class ApiStorageProvider {
  Future<File> loadImage(String filename);

  Future<void> saveImage(File file);

  Future<void> removeImage(String filename);

  Future<String> filenamePath(String filename);
}