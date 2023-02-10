import 'package:drift/drift.dart';

import '../images_converter.dart';
import '../tags_converter.dart';

class MessageTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get messageText => text()();

  DateTimeColumn get sendDate => dateTime()();

  TextColumn get imagePaths => text().map(const ImagesConverter())();

  TextColumn get tags => text().map(const TagsConverter())();

  BoolColumn get isFavorite => boolean()();
}