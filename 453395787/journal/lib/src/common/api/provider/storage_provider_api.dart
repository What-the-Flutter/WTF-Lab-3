import 'dart:io';

import 'package:rxdart/rxdart.dart';

import '../../utils/typedefs.dart';

abstract class StorageProviderApi {
  Future<void> save(File file);

  Future<File> load(Id id);

  Future<void> remove(Id id);
}
