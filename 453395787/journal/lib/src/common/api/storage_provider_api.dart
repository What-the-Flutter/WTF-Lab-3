import 'dart:io';

import 'package:rxdart/rxdart.dart';

import '../utils/typedefs.dart';

abstract class StorageProviderApi {
  Future<Id> save(File file);

  ValueStream<File> load(Id id);

  Future<void> remove(Id id);
}
