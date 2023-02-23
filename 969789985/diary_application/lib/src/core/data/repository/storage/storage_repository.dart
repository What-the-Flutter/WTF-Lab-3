import 'dart:io';

import '../../../domain/api/storage/api_storage_provider.dart';
import '../../../domain/api/storage/api_storage_repository.dart';

class StorageRepository extends ApiStorageRepository {
  final ApiStorageProvider _provider;

  StorageRepository({required ApiStorageProvider provider})
      : _provider = provider;

  @override
  Future<File> loadImage(String filename) async =>
      await _provider.loadImage(filename);

  @override
  Future<void> saveImage(File file) async => await _provider.saveImage(file);

  @override
  Future<void> removeImage(String filename) async =>
      await _provider.removeImage(filename);
}
