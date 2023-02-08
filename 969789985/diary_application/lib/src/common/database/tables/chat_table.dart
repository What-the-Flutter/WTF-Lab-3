import 'package:drift/drift.dart';

class ChatTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get chatTitle => text()();

  IntColumn get chatIcon => integer()();

  BoolColumn get isPinned => boolean()();

  BoolColumn get isArchive => boolean()();

  DateTimeColumn get creationDate => dateTime()();
}