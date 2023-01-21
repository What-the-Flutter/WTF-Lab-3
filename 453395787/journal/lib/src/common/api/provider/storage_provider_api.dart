import 'dart:io';

import '../../utils/typedefs.dart';

abstract class StorageProviderApi {
  Future<void> save(File file);

  Future<File> load(String filename);

  Future<void> remove(String filename);
}
