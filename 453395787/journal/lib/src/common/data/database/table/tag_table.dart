part of '../chat_database.dart';

class TagTable extends Table {
  IntColumn get uid => integer().autoIncrement()();

  TextColumn get content => text()();

  IntColumn get color => integer()();
}
