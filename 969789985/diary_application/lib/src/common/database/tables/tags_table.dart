import 'package:drift/drift.dart';

class TagsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get tagTitle => text()();

  IntColumn get tagIcon => integer()();
}