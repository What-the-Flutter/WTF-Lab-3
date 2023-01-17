part of '../chat_database.dart';

class ChatTable extends Table {
  IntColumn get uid => integer().autoIncrement()();

  TextColumn get name => text()();

  IntColumn get icon => integer()();

  BoolColumn get isPinned => boolean()();

  DateTimeColumn get creationDate => dateTime()();
}
