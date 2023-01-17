part of '../chat_database.dart';

class ImageToMessageTable extends Table {
  IntColumn get uid => integer().autoIncrement()();

  IntColumn get messageId => integer()();

  IntColumn get imageId => integer()();
}
