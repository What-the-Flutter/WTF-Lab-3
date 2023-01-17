part of '../chat_database.dart';

class MessageTable extends Table {
  IntColumn get uid => integer().autoIncrement()();

  TextColumn get content => text()();

  DateTimeColumn get creationDate => dateTime()();

  BoolColumn get isFavorite => boolean()();
}
