part of '../chat_database.dart';

class ImageTable extends Table {
  IntColumn get uid => integer().autoIncrement()();

  TextColumn get path => text()();
}
