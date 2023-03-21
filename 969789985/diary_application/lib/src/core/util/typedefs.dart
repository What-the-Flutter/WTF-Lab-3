import 'dart:io';

import '../domain/models/local/tag/tag_model.dart';

typedef FId = String;

typedef FutureVoidCallback = Future<void> Function();

typedef FileFromFuture = Future<File> Function(String filename);
typedef TagFromFirebase = TagModel Function(FId);

