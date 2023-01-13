part of '../chat_database.dart';

class TagToMessageTable extends Table {
  IntColumn get uid => integer().autoIncrement()();

  IntColumn get messageId => integer()();

  IntColumn get tagId => integer()();
}
